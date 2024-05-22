import 'package:flutter/material.dart';
import 'package:remote_kitchen_assessment_app/screens/new_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
                onPressed: () {
                  // The Navigator manages the stack of screens in a Flutter app.
                  // Get the current Navigator object using the context
                  Navigator.of(context).push(
                    // Push a new MaterialPageRoute onto the navigation stack
                    MaterialPageRoute(
                      // Return an instance of the AnotherScreen widget
                      builder: (context) => const NewScreen(),
                    ),
                  );
                },
                child: const Text('Navigate to A New Screen')),
          ],
        ),
      ),
    );
  }
}
