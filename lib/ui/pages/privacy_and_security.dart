import 'package:flutter/material.dart';

class PrivacyAndSecurity extends StatelessWidget {
  const PrivacyAndSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Security'),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    PrivacyPolicyContent(
                        title: 'Privacy Policy for Snuggle Tales',
                        content:
                            'Welcome to Snuggle Tales! Your privacy matters to us. Here\'s a simple rundown of how we handle your information.'),
                    PrivacyPolicyContent(
                        title: "Log Files",
                        content:
                            "When you use Snuggle Tales, we keep track of some basic info like your device type, how you use the app, and when you use it. We don't link this info to anything personal. It helps us see what you like and improve the app."),
                    PrivacyPolicyContent(
                        title: "Cookies and Web Beacons",
                        content:
                            "Think of cookies like helpful notes your device takes about your preferences. We use them to make Snuggle Tales work better for you."),
                    PrivacyPolicyContent(
                        title: "Privacy Policies of Third-Party Services",
                        content:
                            "Sometimes, we use tools from other companies to make Snuggle Tales awesome. Check out their privacy policies to know more about what they do."),
                    PrivacyPolicyContent(
                        title: "Children's Information",
                        content:
                            "Snuggle Tales is for everyone, especially kids! We never collect personal info from kids under 13. If you think we have something we shouldn't, let us know, and we'll fix it."),
                    PrivacyPolicyContent(
                        title: "Online Privacy Policy Only",
                        content:
                            "This policy is just for using Snuggle Tales. Anything offline or on other platforms has its own rules."),
                    PrivacyPolicyContent(
                        title: "Consent",
                        content:
                            "By using Snuggle Tales, you agree to these rules. If you're a paying user, you also agree to our Cancellation Policy. Any questions? Feel free to ask!"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Text(content, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
      ],
    );
  }
}
