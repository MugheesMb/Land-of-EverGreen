import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


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
                image: AssetImage("assets/images/wat3.gif"), fit: BoxFit.cover),
          ),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Text(
                      'Aqua Vs Alien',
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
                      onPressed: onPlayPressed,
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
