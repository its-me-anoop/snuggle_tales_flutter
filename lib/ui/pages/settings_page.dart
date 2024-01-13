import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/app/app.dart';
import 'package:snuggle_tales/ui/pages/login_page.dart';
import 'package:snuggle_tales/ui/pages/privacy_and_security.dart';

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return (state.user.isNotEmpty)
                ? ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      // Handle profile tap
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Login / Sign Up'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                  );
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            // Handle notifications tap
          },
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: const Text('Privacy & Security'),
          onTap: () {
            // Handle privacy & security tap
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const PrivacyAndSecurity();
            }));
          },
        ),
        ListTile(
          leading: const Icon(Icons.help),
          title: const Text('Help & Support'),
          onTap: () {
            // Handle help & support tap
          },
        ),
        BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return (state.user.isNotEmpty)
                ? ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle logout tap
                      context.read<AppBloc>().add(const AppLogoutRequested());
                    },
                  )
                : const SizedBox();
          },
        ),
      ],
    );
  }
}
