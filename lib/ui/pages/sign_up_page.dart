import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:snuggle_tales/bloc/sign_up_cubit/sign_up_cubit.dart';
import 'package:snuggle_tales/utils/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Navigator.of(context).pop();
          } else if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ?? 'Sign Up Failure')),
              );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        previous.name != current.name,
                    builder: (context, state) {
                      return TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        onChanged: (name) =>
                            context.read<SignUpCubit>().nameChanged(name),
                        keyboardType: TextInputType.name,
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        previous.email != current.email,
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: state.email.displayError != null
                              ? 'invalid email'
                              : null,
                        ),
                        onChanged: (email) =>
                            context.read<SignUpCubit>().emailChanged(email),
                        keyboardType: TextInputType.emailAddress,
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        previous.password != current.password,
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: state.password.displayError != null
                                ? 'invalid password'
                                : null),
                        obscureText: true,
                        onChanged: (password) => context
                            .read<SignUpCubit>()
                            .passwordChanged(password),
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        previous.password != current.password ||
                        previous.confirmedPassword != current.confirmedPassword,
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            errorText:
                                state.confirmedPassword.displayError != null
                                    ? 'passwords do not match'
                                    : null),
                        obscureText: true,
                        onChanged: (confirmPassword) => context
                            .read<SignUpCubit>()
                            .confirmedPasswordChanged(confirmPassword),
                      );
                    },
                  ),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    builder: (context, state) {
                      return state.status.isInProgress
                          ? const CircularProgressIndicator()
                          : CustomButton(
                              onPressed: state.isValid
                                  ? () => context
                                      .read<SignUpCubit>()
                                      .signUpFormSubmitted()
                                  : null,
                              text: 'Sign Up',
                            );
                    },
                  ),
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Log In'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
