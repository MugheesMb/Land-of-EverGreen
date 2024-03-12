import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ever_green/game/game.dart';
import 'package:ever_green/loading.dart';
import 'package:ever_green/routes/boot_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();*/
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _loading = true;
  bool _isAssetsPreloaded = false; // Added to prevent multiple preloading

  @override
  void initState() {
    super.initState();
    // Keep this if _preloadGameAssets doesn't depend on MediaQuery or similar
    _preloadGameAssets().then((_) {
      if (!_isAssetsPreloaded) { // Check to prevent setting state if already set
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isAssetsPreloaded) {
      _preloadImages().then((_) {
        // Ensure this logic is correct for your app's flow
        _isAssetsPreloaded = true;
        if (_loading) { // Check to prevent setting state if already set
          setState(() {
            _loading = false;
          });
        }
      });
    }
  }

  Future<void> _preloadImages() async {
    List<String> images = [
      'assets/images/MM.gif',
      'assets/images/m1.gif',
      'assets/images/m2.gif',
      'assets/images/m3.gif',
      // Add more image paths as needed
    ];

    for (var imagePath in images) {
     await precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<void> _preloadGameAssets() async {

    // Example of preloading a specific image
    await Flame.images.loadAll([
        '2.jpeg',
        '3.png',
      '4.png',
      '5.jpeg',
      '6.png',
      '7.png',
      'a.png',
      'b.png',
      'bin.png',
      'SmallHandleFilledGrey.png',
      'Joystick.png',
      'c.png',
      'SmallHandle.png',
      'c1.png',
      'c2.png',
      'c3.png',
      'c4.png',
      'cave.png',
      'cave2.jpeg',
      'cup.png',
      'd.png',
      '3.png',
      'dus.png',
      'e.png',
      'eco.png',
      'f.png',
      'fs.png',
      'g.png',
      'new.png',
      'enemy.png',
      'head.png',
      'her2.png',
      'her3.png',
      'last.png',
      'men2.png',
      'play.png',
      'plt.png',
      'shop.png',
      'sky.jpeg',
      'star.png',
      'stone.png',
      'try.png',
      't2.png',

    ]);
    // Load more images as needed
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Rexlia",
      ),
      debugShowCheckedModeBanner: false,
      home:BootScreen(isLoading: _loading),
    );
  }
}


