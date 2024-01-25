import 'package:flutter/cupertino.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the disclaimer text.'),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              child: const Text('I Agree'),
            ),
          ],
        ),
      ),
    );
  }
}
