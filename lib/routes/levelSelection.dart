import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class LevelSelection extends StatelessWidget {
  const LevelSelection({
    super.key,
    this.onLevelSelected,
    this.onBackPressed,
  });

  static const id = 'LevelSelection';

  final ValueChanged<int>? onLevelSelected;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   leading: IconButton(
      //           color: Colors.white, 
      //           onPressed: onBackPressed,
      //           icon: const Icon(Icons.arrow_back_rounded),
      //         ),
      // ),
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            const Text(
              'Select Level',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: size.width,
              child: Center(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    //mainAxisExtent: 150,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => onLevelSelected?.call(index + 1),
                      child: Stack(
                        children: [
                          
                          Column(
                          children: [
                            Container(
                              height: 100,
                              width:100,
                              decoration:const  BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child: Center(child: Text('Level ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),))),
                              RatingBar.builder(
                           initialRating: 3,
                           direction: Axis.horizontal,
                           allowHalfRating: true,
                           itemCount: 3,
                           itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                           itemBuilder: (context, _) => const Icon(
                             Icons.star,
                             size: 15,
                             color: Colors.grey,
                           ),
                           onRatingUpdate: (rating) {
                             print(rating);
                           },
                        ),
                          ],
                        ),
                        index != 0?
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/lock.png")):const SizedBox(),
                        
                        ]
                      ),
                    );
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                ),
              ),
              ),
              const SizedBox(height: 5),
              CircleAvatar(
                child: IconButton(
                  onPressed: onBackPressed,
                  icon:const Icon(Icons.arrow_back, color: Colors.black)
                ),
            ),
            const SizedBox(height: 5),
              
            ],
          ),
            ),
            
          
    );
  }
}
