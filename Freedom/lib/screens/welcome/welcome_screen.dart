import 'package:chat/constants.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 2,),
            Image.asset("assets/images/welcome_image.png", height: 200, width: 200),
            Spacer(flex: 3,),
            Text(
              "Welcome to Dash \nMessaging App", 
              textAlign: TextAlign.center, 
              style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold)
            ),
            Spacer(),
            Text(
              "Message anyone in your Mother Tongue",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.64)
              ),
            ),
            Spacer(flex: 3,),
            FittedBox(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => SignInorSignUpScreen()
                  )
                ),
                child: Row(
                  children: [Text(
                    "Skip",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.8)
                    ),
                  ),
                  SizedBox(width: kDefaultPadding/4,),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.8)
                  )
                  ],
                )
              ),
            )
          ],
        ),
      ),  
    );
  }
}