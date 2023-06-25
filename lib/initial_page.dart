import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(0, 0, 0, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'COMICS',
                style: TextStyle(
                  fontFamily: 'NetflixFont',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(219, 0, 0, 1.0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(219, 0, 0, 1.0),
                ),
                child: Text('Seguir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
