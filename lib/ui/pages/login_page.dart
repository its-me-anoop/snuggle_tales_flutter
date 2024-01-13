import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:snuggle_tales/bloc/login_cubit/login_cubit.dart';
import 'package:snuggle_tales/repositories/authentication_repository.dart';
import 'package:snuggle_tales/ui/pages/sign_up_page.dart';
import 'package:snuggle_tales/utils/custom_button.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          } else if (state.status.isSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                BlocBuilder<LoginCubit, LoginState>(
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
                          context.read<LoginCubit>().emailChanged(email),
                      keyboardType: TextInputType.emailAddress,
                    );
                  },
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.password != current.password,
                  builder: (context, state) {
                    return TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        onChanged: (password) => context
                            .read<LoginCubit>()
                            .passwordChanged(password));
                  },
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return state.status.isInProgress
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            onPressed: state.isValid
                                ? () => context
                                    .read<LoginCubit>()
                                    .logInWithCredentials()
                                : null,
                            text: 'Log In',
                          );
                  },
                ),
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RepositoryProvider(
                              create: (context) => AuthenticationRepository(),
                              child: const SignUpPage(),
                            )),
                  ),
                  child: const Text('Sign Up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
