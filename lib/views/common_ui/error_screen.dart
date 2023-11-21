import 'package:flutter/material.dart';
import 'package:mini_funda/views/common_ui/text_style.dart';

import 'spacer.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.onTryAgain,
    this.errorMessage = "Something went wrong!",
    super.key,
  });

  factory ErrorScreen.houseCouldBeSold(VoidCallback onTryAgain) => ErrorScreen(
        onTryAgain: onTryAgain,
        errorMessage:
            "Something went wrong please try again \n the house could be sold!",
      );

  final VoidCallback onTryAgain;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error),
          HorizontalSpacer.xs(),
           Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: MiniFundaTextTheme.h1,
          ),
          TextButton(
            onPressed: onTryAgain,
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
}
