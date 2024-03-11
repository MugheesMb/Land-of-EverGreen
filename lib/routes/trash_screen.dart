import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:ever_green/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../game/story.dart';
import 'recycle_screen.dart';


class TrashScreen extends StatelessWidget {
  final MyGame gameRef;
  const TrashScreen({super.key, required this.gameRef,});

  static const id = 'TrashScreen';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
           color: Color.fromARGB(210, 229, 238, 238),
            // image: DecorationImage(
            //     image: AssetImage("assets/images/wat3.gif"), fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'You collected',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 20), // Adds space between the text and the images
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                    width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color:Colors.purple,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/star.png',),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${gameRef.plData.score.value}x Coins", style: TextStyle(color: Colors.white, fontSize: 18, ),),
                              ),
                             ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 20), // Adds space between the images
                   Container(
                    height: 200,
                    width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color:Colors.purple,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/cup.png',width:100),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${gameRef.plData.plastic.value}x Plastic", style: TextStyle(color: Colors.white, fontSize: 18, ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:20),
                Container(
                  width: size.width/2,
                  
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          const Text("Learn how can you recycle plastic", style: TextStyle(color: Colors.white, fontSize: 20),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            height: 100,
                            width:100,
                            child: Image.asset("assets/images/recycle.png"))]
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => StepsScreen()));
                        },
                        child: const Text("Learn Now"),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }

}
