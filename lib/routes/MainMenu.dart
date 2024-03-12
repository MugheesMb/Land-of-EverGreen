// import 'package:ever_green/routes/trash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../game/story.dart';
// import 'recycle_screen.dart';


// class MainMenu extends StatelessWidget {
//   const MainMenu({super.key, this.onPlayPressed , this.onSettingPressed});

//   static const id = 'MainMenu';

//   final VoidCallback? onPlayPressed;
//   final VoidCallback? onSettingPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black.withOpacity(0.5),
//         body: Container(
//           constraints: const BoxConstraints.expand(),
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/images/MM.gif"), fit: BoxFit.cover),
                
//           ),
//           child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                      color: Colors.black.withOpacity(0.2),
//                      borderRadius: BorderRadius.circular(15) 
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10),
//                       child: Text(
//                         'Land of EverGreen',
//                         style: TextStyle(
//                           fontSize: 45.0,
//                           color: Colors.white,
//                           shadows: [
//                             Shadow(
//                               blurRadius: 20.0,
//                               color: Colors.white,
//                               offset: Offset(0, 0),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height:10),
//                   InkWell(
//                     onTap: (){
//                           // Navigate to the SceneShowcase widget
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => SceneShowcase(
//                               onGameStart: () {
//                                 // Pop back to the MainMenu and then invoke the onPlayPressed callback
//                                 Navigator.of(context).pop();
//                                 onPlayPressed?.call();
//                               },
//                             ),
//                           ));
//                     },
//                     child: SizedBox(
//                       width: 200,
//                       child: Image.asset("assets/images/play-btn.png") 
//                       // ElevatedButton(
//                       //   onPressed: () {
                      
//                       //   },
//                       //   child: const Text('play'),
//                       // ),
//                       ),
//                   ),

//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   InkWell(
//                     onTap: onSettingPressed,
//                     child: SizedBox(
//                       width: 200,
//                       child: Image.asset("assets/images/settings.png")
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   InkWell(
//                     onTap: (){
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => StepsScreen(), ));
//                     },
//                     child: SizedBox(
//                       width: 200,
//                       child: Image.asset("assets/images/learn.png")
//                     ),
//                   ),
//                 ],
//               )),
//         ));
//   }
// }

import 'package:ever_green/routes/trash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../game/game.dart';
import '../game/story.dart';
import 'recycle_screen.dart';


class MainMenu extends StatelessWidget {
  final MyGame gameRef;
  const MainMenu({super.key, this.onPlayPressed , this.onSettingPressed,required this.gameRef});

  static const id = 'MainMenu';

  final VoidCallback? onPlayPressed;
  final VoidCallback? onSettingPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/MM.gif"), fit: BoxFit.cover),
          ),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Text(
                      'Land of EverGreen',
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
                  InkWell(
                    onTap: (){
                          // Navigate to the SceneShowcase widget
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SceneShowcase(
                             
                              onGameStart: () {
                                // Pop back to the MainMenu and then invoke the onPlayPressed callback
                                Navigator.of(context).pop();
                                onPlayPressed?.call();
                              }, gameRef: gameRef,
                            ),
                          ));
                    },
                    child: SizedBox(
                      width: 200,
                      child: Image.asset("assets/images/play-btn.png") 
                      // ElevatedButton(
                      //   onPressed: () {
                      
                      //   },
                      //   child: const Text('play'),
                      // ),
                      ),
                  ),

                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: onSettingPressed,
                    child: SizedBox(
                      width: 200,
                      child: Image.asset("assets/images/settings.png")
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => StepsScreen(), ));
                    },
                    child: SizedBox(
                      width: 200,
                      child: Image.asset("assets/images/learn.png")
                    ),
                  ),
                ],
              )),
        ));
  }
}
