import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../game/story.dart';


class MainMenu extends StatelessWidget {
  const MainMenu({super.key, this.onPlayPressed , this.onSettingPressed});

  static const id = 'MainMenu';

  final VoidCallback? onPlayPressed;
  final VoidCallback? onSettingPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/MM.gif"), fit: BoxFit.cover),
          ),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Text(
                      'to be decided',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 20.0,
                            color: Colors.white,
                            offset: Offset(0, 0),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the SceneShowcase widget
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SceneShowcase(
                            onGameStart: () {
                              // Pop back to the MainMenu and then invoke the onPlayPressed callback
                              Navigator.of(context).pop();
                              onPlayPressed?.call();
                            },
                          ),
                        ));
                      },
                      child: Text('play'),
                    ),
                    ),

                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      onPressed: onSettingPressed,
                      child: Text('Settings'),
                    ),
                  ),
                ],
              )),
        ));
  }
}
