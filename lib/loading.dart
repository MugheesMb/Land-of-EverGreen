import 'package:ever_green/utils/constants.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Loading Asssets :)',
            style: TextStyles.buttonSmall,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: const LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}