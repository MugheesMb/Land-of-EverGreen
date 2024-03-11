import 'dart:io';
import 'dart:html' as html;
import 'package:add_to_google_wallet/add_to_google_wallet.dart';
import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ever_green/routes/trash_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../game/game.dart';
import 'GamePlay.dart';
import 'MainMenu.dart';

class LevComplete extends StatelessWidget {

  final MyGame gameRef;

  LevComplete({

    required this.gameRef,
    super.key,
    this.onNextPressed,
  });

  static const id = 'LevComplete';



  final VoidCallback? onNextPressed;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(210, 229, 238, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Level Completed',
              style: TextStyle(fontSize: 30),
            ),

            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: () {
                  var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                  if(gameplay != null) {
                    gameRef.startLevel(gameplay.currentLevel);
                    gameRef.resumeEngine();
                  }
                },
                child: const Text('Retry'),
              ),
            ),
            
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed:(){
                  gameRef.resumeEngine();
                  gameRef.popRoute();

                  gameRef.router.pushReplacementNamed(MainMenu.id);
                },
                child: const Text('Exit'),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () {
                  gameRef.resumeEngine();
                  gameRef.popRoute();
                  gameRef.router.pushReplacementNamed(TrashScreen.id);
                  // var gameplay = gameRef.findByKeyName<GamePlay>(GamePlay.id);
                  // if(gameplay != null) {
                  //   gameRef.startLevel(gameplay.currentLevel);
                  //   gameRef.resumeEngine();
                  // }
                },
                child: const Text('View Your Collection'),
              ),
            ),
            const SizedBox(height: 10,),
            //isAndroid()
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text("Add your Eco Balls to you Google Wallet"),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/images/eco.png"))
                  ],
                ),
                const SizedBox(width: 50,),
                InkWell(
                  onTap:(){_savePassBrowser();},
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/images/wallet.png"))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


// PlatformType getPlatformType() {
//   if (html.window != null && html.document != null) {
//     return PlatformType.web;
//   } else {
//     return PlatformType.unknown;
//   }
// }
//   Widget isAndroid(){
//     if(Platform.isAndroid){
//       return AddToGoogleWalletButton(
//             pass: _examplePass,
//             onSuccess: () => print('Success!'),  
//             onCanceled: () => print('Canceled!'),
//             onError: (Object error) {
//               print(error);
//               print('Error: $error');},
//             locale: const Locale.fromSubtags(
//               languageCode: 'en',
//               countryCode: 'US',
//             ),
//           );
//     }else{
//       return InkWell(
//               onTap:(){_savePassBrowser();},
//               child: SizedBox(
//                 height: 250,
//                 width: 250,
//                 child: Image.asset("assets/images/wallet.png"))
//             );
//     }
//   }


 final Map<int, String> jwts = {
    100:
        "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS4xMDAxMDAiLCJjbGFzc0lkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS5lY29zaGlmdCIsImxvZ28iOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vZmlyZWJhc2VzdG9yYWdlLmdvb2dsZWFwaXMuY29tL3YwL2IvZmZ0ZXN0LWQzNmZhLmFwcHNwb3QuY29tL28vRWFydGgucG5nP2FsdD1tZWRpYSZ0b2tlbj1jMTAyMjk4MC0zYmM0LTRjYzQtODU4Ni1hNjZkMDFmOTI5YjAifSwiY29udGVudERlc2NyaXB0aW9uIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJFYXJ0aCJ9fX0sImNhcmRUaXRsZSI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWNvU2hpZnQgQ2hyb25pY2xlcyJ9fSwiaGVhZGVyIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJBIHBlcmZlY3QgMTAwISJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJpZCI6InNjb3JlIiwiaGVhZGVyIjoiU0NPUkUiLCJib2R5IjoiMTAwIn0seyJpZCI6InJlc3VsdCIsImhlYWRlciI6IlJFU1VMVCIsImJvZHkiOiJJbmNyZWRpYmxlISBZb3UgYWNoaWV2ZWQgYSBwZXJmZWN0IDEwMCEgWW91IHdlcmUgdGhlIHVud2F2ZXJpbmcgY2hhbXBpb24gb2YgRWNvVmlsbGUhIn1dLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjZjllZGFhIiwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL2Vjb1NoaWZ0VGl0bGVDcm9wcGVkLnBuZz9hbHQ9bWVkaWEmdG9rZW49MmNjNWNlYTItZmM5OS00N2E0LTk5YWMtNGM2ZTM3MDhiODY1In0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWNvU2hpZnQgQ2hyb25pY2xlcyJ9fX19XX0sImlhdCI6MTcwODQyMjE3N30.M-yt24VqpXYlUGL5sk6sTpFqTmU6TWsCmM7kzmmozox15aFf9Ku47vY_k69aTSzVODv_9jtrOSoqiDv1gGmtm8A9qWzv8xTYL2SegoE6BrprxMx8p1Ne27rcpDmvzzFMo4zh47Yd0nq8ksqwchiHbMtdczu1I5w7Kbambx0jm4ziYZ1EJQkeA4lize4zKAMxe-MIl7eJPEkKl_esSaRD4KvqJYCoualsRq1f_EQ-7PwYnX7x1WNEzQhmxwgRbcUmlNFEqk6emRCzgXOKmQBRdTKq4Fs8MlIZF_OoCWakAZ7arbNCXl_qIM6adnul23W2gvORJZPJc3lfa8pBMxxo_g",
    80: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS44MDgwIiwiY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIzMTA3NTEuZWNvc2hpZnQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL0VhcnRoLnBuZz9hbHQ9bWVkaWEmdG9rZW49YzEwMjI5ODAtM2JjNC00Y2M0LTg1ODYtYTY2ZDAxZjkyOWIwIn0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWFydGgifX19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiR3JlYXQgSm9iISJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJpZCI6InNjb3JlIiwiaGVhZGVyIjoiU0NPUkUiLCJib2R5IjoiODAifSx7ImlkIjoicmVzdWx0IiwiaGVhZGVyIjoiUkVTVUxUIiwiYm9keSI6IkdyZWF0IEpvYiEgWW91ciBlY28tZnJpZW5kbHkgYWN0aW9ucyBzaWduaWZpY2FudGx5IGJlbmVmaXRlZCB0aGUgZWNvc3lzdGVtIG9mIEVjb1ZpbGxlLiJ9XSwiaGV4QmFja2dyb3VuZENvbG9yIjoiIzY5OWMyMCIsImhlcm9JbWFnZSI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9maXJlYmFzZXN0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vdjAvYi9mZnRlc3QtZDM2ZmEuYXBwc3BvdC5jb20vby9lY29TaGlmdFRpdGxlQ3JvcHBlZC5wbmc_YWx0PW1lZGlhJnRva2VuPTJjYzVjZWEyLWZjOTktNDdhNC05OWFjLTRjNmUzNzA4Yjg2NSJ9LCJjb250ZW50RGVzY3JpcHRpb24iOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX19fV19LCJpYXQiOjE3MDg0MjU1NTl9.GarSUKoTbtsiYNT2nY4L-Lh6rbn3OrntqjN8f6klgocmSZFN9JtSpaujYhNXrZ9NwimTo_Ofme-kyctZUPH1npqU8qBqIpDicw4bSjBSvh-3-l3K-pO74OBVw4Yv6I0kPbzoVsE6lxw6VkQBxsCi1-i-n-eagMqIq5D_7rNmtWSkUxoyuHRjThLz2VzhsP5ET8-uDdZY5Y2cDyqshH9CRJ55udKeyZTkyzW7Gbk437fgNfVUwfz25GKVPRRKJXWQ6Kd8hSLiCBsB7Dgak8gWubhZfTY57ZYWJMlqOdwBKYRTS3nSsiH2RBjbxWtGBds1nhrC-i4OSX69O6lenbOY_Q",
    60: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS42MDYwIiwiY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIzMTA3NTEuZWNvc2hpZnQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL0VhcnRoLnBuZz9hbHQ9bWVkaWEmdG9rZW49YzEwMjI5ODAtM2JjNC00Y2M0LTg1ODYtYTY2ZDAxZjkyOWIwIn0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWFydGgifX19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiQ2FuIGRvIGJldHRlciEifX0sInRleHRNb2R1bGVzRGF0YSI6W3siaWQiOiJzY29yZSIsImhlYWRlciI6IlNDT1JFIiwiYm9keSI6IjYwIn0seyJpZCI6InJlc3VsdCIsImhlYWRlciI6IlJFU1VMVCIsImJvZHkiOiJUaGVyZSB3YXMgcm9vbSBmb3IgaW1wcm92ZW1lbnQuIEVjb1ZpbGxlJ3MgZmF0ZSBkZXBlbmRlZCBvbiB5b3VyIGRlZGljYXRpb24hIn1dLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjNTRiZTM3IiwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL2Vjb1NoaWZ0VGl0bGVDcm9wcGVkLnBuZz9hbHQ9bWVkaWEmdG9rZW49MmNjNWNlYTItZmM5OS00N2E0LTk5YWMtNGM2ZTM3MDhiODY1In0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWNvU2hpZnQgQ2hyb25pY2xlcyJ9fX19XX0sImlhdCI6MTcwODQyNTkyNH0.iqdadP0fBZvgvLPamKkheTFB0jnMkKyDWfv88C1BDjylekGPs32gWZ2zkoSqWnPL3LOAZCSqGbauXGb3kIqtVdL4Ntb5T7HfWIGPIBbycxQvL1oqTKvxWwsPxbrzKZR_lpuPGCeH6fNKA7zShV6yW1jErR51xde7iGB2FrCDlnrMaCteY8xvfjOEc3-HpVrt_4FCnVCBj39qkXMjEaDlBMXHYrbjis1UyppLm0t1f26R9wi5o2EAGt8SXG33HYkA7uCiBl0PiBCnOMFiCP5mLojp9WcaSyuLLts7V9_ecEIoMCSct3fP1Zx7lRBUBvxLAWu-rgbtAoNVWBu_zoNgow",
    40: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS40MDQwIiwiY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIzMTA3NTEuZWNvc2hpZnQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL0VhcnRoLnBuZz9hbHQ9bWVkaWEmdG9rZW49YzEwMjI5ODAtM2JjNC00Y2M0LTg1ODYtYTY2ZDAxZjkyOWIwIn0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWFydGgifX19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiQ2FuIGRvIG11Y2ggYmV0dGVyISJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJpZCI6InNjb3JlIiwiaGVhZGVyIjoiU0NPUkUiLCJib2R5IjoiNDAifSx7ImlkIjoicmVzdWx0IiwiaGVhZGVyIjoiUkVTVUxUIiwiYm9keSI6IllvdSBoYWQgc29tZSB3b3JrIHRvIGRvLiBNYWtpbmcgZ3JlZW5lciBjaG9pY2VzIHdvdWxkIGhhdmUgdHVybmVkIHRoaW5ncyBhcm91bmQgZm9yIEVjb1ZpbGxlISJ9XSwiaGV4QmFja2dyb3VuZENvbG9yIjoiI2YxYTQ1NCIsImhlcm9JbWFnZSI6eyJzb3VyY2VVcmkiOnsidXJpIjoiaHR0cHM6Ly9maXJlYmFzZXN0b3JhZ2UuZ29vZ2xlYXBpcy5jb20vdjAvYi9mZnRlc3QtZDM2ZmEuYXBwc3BvdC5jb20vby9lY29TaGlmdFRpdGxlQ3JvcHBlZC5wbmc_YWx0PW1lZGlhJnRva2VuPTJjYzVjZWEyLWZjOTktNDdhNC05OWFjLTRjNmUzNzA4Yjg2NSJ9LCJjb250ZW50RGVzY3JpcHRpb24iOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX19fV19LCJpYXQiOjE3MDg0MjYzMzd9.hVjbSJyAHeM-WGTH2wtvmHbjWUum2f5d6t_CDCWd0HhRr9C0BFrqIa2qMmPIpyDrKeIwDe8YN0tnwGIg5YfHXtQzK3htcf9efNkJIDkFLDV_vl8W2G1SrsxNLFdlr9yG_p6wWlri6Locw0MUrLJ5zvcUncsasz1ZFmo9oVBxV_8z1OMLkLdxphfhww6k6dTn255ErJQFzFVZVokzD4361er6zR0c_1nY4Avexi9yEvNUf-dwupdh9lv9W0LoQnZPiTPn9QVKBPk9jebGys_Q-2FQu9hzBlXSpULJQFgFiUGgHu0YzxtGv3asIVCFAMQ7qKNYjF3C4qRL5sCUfU_Jlw",
    20: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS4yMDIwIiwiY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIzMTA3NTEuZWNvc2hpZnQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL0VhcnRoLnBuZz9hbHQ9bWVkaWEmdG9rZW49YzEwMjI5ODAtM2JjNC00Y2M0LTg1ODYtYTY2ZDAxZjkyOWIwIn0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWFydGgifX19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiTmV2ZXIgdG9vIGxhdGUgdG8gY2hhbmdlISJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJpZCI6InNjb3JlIiwiaGVhZGVyIjoiU0NPUkUiLCJib2R5IjoiMjAifSx7ImlkIjoicmVzdWx0IiwiaGVhZGVyIjoiUkVTVUxUIiwiYm9keSI6Ikl0IHdhcyBuZXZlciB0b28gbGF0ZSB0byBjaGFuZ2UhIEV2ZXJ5IHBvc2l0aXZlIGNob2ljZSBjb3VudGVkIHRvd2FyZHMgYSBoZWFsdGhpZXIgZW52aXJvbm1lbnQuIn1dLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjYWIzODJjIiwiaGVyb0ltYWdlIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL2Vjb1NoaWZ0VGl0bGVDcm9wcGVkLnBuZz9hbHQ9bWVkaWEmdG9rZW49MmNjNWNlYTItZmM5OS00N2E0LTk5YWMtNGM2ZTM3MDhiODY1In0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWNvU2hpZnQgQ2hyb25pY2xlcyJ9fX19XX0sImlhdCI6MTcwODQyNjUyNn0.UfncEoBsT6vbkWFUuGd0U8n8Xoz6YfcEN5dPdLT3nYArU6PAU_9inOyS4Lt7w0XTOu9T00h4zGSdpmJ3vOK9Qxe0lg0bL-UszzjF7cfkvUZ4bS_hdRxdsrT46ZoSTN535j5wbwq6AnmUKEkUl4IH0Jv8pzB2EEXHw7kvorui5gk9KpCugRYfFDVh3MGJWzuU1y8NLLZMTf0wx0WFqMHenDY3Ssv4DKbWu6LhweT0p-_jzf_Nbp8Pp-bm2GbeYzmFvQX-NTKEC7O4q0IUAYKHUtgxpzGEpgYY0fOzsWhijoNFpOryQbT57qux23wGy9cTayH6CDgYsL-HKG7z4EGcuQ",
    0: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnZW5lcmljLXBhc3NAZWNvc2hpZnQtNDE0ODE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6W10sInR5cCI6InNhdmV0b3dhbGxldCIsInBheWxvYWQiOnsiZ2VuZXJpY09iamVjdHMiOlt7ImlkIjoiMzM4ODAwMDAwMDAyMjMxMDc1MS4wMDAwIiwiY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIzMTA3NTEuZWNvc2hpZnQiLCJsb2dvIjp7InNvdXJjZVVyaSI6eyJ1cmkiOiJodHRwczovL2ZpcmViYXNlc3RvcmFnZS5nb29nbGVhcGlzLmNvbS92MC9iL2ZmdGVzdC1kMzZmYS5hcHBzcG90LmNvbS9vL0VhcnRoLnBuZz9hbHQ9bWVkaWEmdG9rZW49YzEwMjI5ODAtM2JjNC00Y2M0LTg1ODYtYTY2ZDAxZjkyOWIwIn0sImNvbnRlbnREZXNjcmlwdGlvbiI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiRWFydGgifX19LCJjYXJkVGl0bGUiOnsiZGVmYXVsdFZhbHVlIjp7Imxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkVjb1NoaWZ0IENocm9uaWNsZXMifX0sImhlYWRlciI6eyJkZWZhdWx0VmFsdWUiOnsibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiTmV2ZXIgdG9vIGxhdGUgdG8gY2hhbmdlISJ9fSwidGV4dE1vZHVsZXNEYXRhIjpbeyJpZCI6InNjb3JlIiwiaGVhZGVyIjoiU0NPUkUiLCJib2R5IjoiMCJ9LHsiaWQiOiJyZXN1bHQiLCJoZWFkZXIiOiJSRVNVTFQiLCJib2R5IjoiSXQgd2FzIG5ldmVyIHRvbyBsYXRlIHRvIGNoYW5nZSEgRXZlcnkgcG9zaXRpdmUgY2hvaWNlIGNvdW50ZWQgdG93YXJkcyBhIGhlYWx0aGllciBlbnZpcm9ubWVudC4ifV0sImhleEJhY2tncm91bmRDb2xvciI6IiMxMTI1MzUiLCJoZXJvSW1hZ2UiOnsic291cmNlVXJpIjp7InVyaSI6Imh0dHBzOi8vZmlyZWJhc2VzdG9yYWdlLmdvb2dsZWFwaXMuY29tL3YwL2IvZmZ0ZXN0LWQzNmZhLmFwcHNwb3QuY29tL28vZWNvU2hpZnRUaXRsZUNyb3BwZWQucG5nP2FsdD1tZWRpYSZ0b2tlbj0yY2M1Y2VhMi1mYzk5LTQ3YTQtOTlhYy00YzZlMzcwOGI4NjUifSwiY29udGVudERlc2NyaXB0aW9uIjp7ImRlZmF1bHRWYWx1ZSI6eyJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJFY29TaGlmdCBDaHJvbmljbGVzIn19fX1dfSwiaWF0IjoxNzA4NDI2NjcwfQ.qppAu8l1JH41T6zp7ilLJB68IVKCmrorgTUekEU_QIA8VCics9SggTOBg5VCTIKXesQZfoMoKafa6HoLqNW3wKCitmgomxCHybGsMbDLBMVdr55Nmj3ZnaWqugW6V8DCxZxkrt7oEQ2iOxngJg57-ZHijkB1aOZmyWT93HUaLiwnkwOLg3egbU9KnoWtnEfnr_v9-_EX52BGlEkvaBArEmoKjYrvHrb_5X5dY3hhe3aWOjc2dmqVvZcoVSrrT0AuJiPkuoKSEh9KI9bNdC6tIYSd_w0Wz93Tlf7N8YoPZIYiIur3DsJx4p40yxZfcXeKEcVBWMdiAKz1YouEe6HZtw",
  };
    _savePassBrowser() async {
    String url = "https://pay.google.com/gp/v/save/${jwts[100]}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open Google Wallet via web';
    }
  }
  String createSignedJWT() {
  const privateKey = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8qTt/8StCS9sq\nLpDNauY50S/WiJXnq3QikqMTwJK1q3CMPl8vZnL/Hu1MI1yunSM3fR6bp8CnAUiI\nKMvYoYObvtsqKQ0F/371XxiKrSgfwo+2tW+8vV3pDY/6rqXkZ+CbP8uDbWwIPnI1\n16qi5+WUTrH18BieicGlmS/ER8bzVetvSSZmKYJDl2pkVFkf2A/mxFa/FMVtfZgP\nsURuwU/f22WkhtaGyuYdokJp3zMMawNNMomYFjXvsdMmpAVPvcPTXE8B8cxievCt\n0Q/SZbgVr/pUCTh/BEY6XrfD7S5ukqmNCPKbIbKbQ+W5dUXju3XWu7f/l/pniR37\n6JPGus3ZAgMBAAECggEAIbj0UD3JGDwb7FHPg1BY37vTG7tlZDhC9Y0VhknVT5DZ\n+M+LTxs2cgDStNnbTsD60wfT6UnWh2OU1fXI3iucrUGzxjj5QXm2dWCur9ccxXSP\nIL8Uvn1w5GAOvOXr9ERXIxkHpTHxbhXPb21h7GWcJWLdr5Lfq7L/AL09iw2zc7o4\nxiqDgzOhaK4wLug8YsPsvG2CaRKmmJhWix1S820qCVpjzfJyRK+w5ulNNX3kgAfd\nkD2+tK2op+IVRJ6iHm7W0Jdidfeh80cySv1iE+Fl/FkS1FKik8nxDr8Apl8c6BaW\nT8hF208iLjMUWUfxQQaiZC7uGqXn+CTMT79ud6HBgwKBgQDm6r6n3Aw7fVdDjk7Z\n5hY8JoxhIEzRCszw3B3A3j/YdZkT0vTTman/F1/SBVRj6IPKxSCqW4SX/GBzUyUN\nNAcCUTy49SXRPFrcv5bqSPq0GbPYy6Av90g1V4bRpGP9VaFtL+ldiBQiN/BTj4ou\nnYixKGUcouv0KjmNeWMp1fny1wKBgQDRJ3NkOTXhfRsJc8VfhDnr9OEsOs/fbECW\nKvrYexN61bD4Wt5wQVdIR7dthge2LLDvbhcpYunPN7w2K169x8xdBIGplECPHon8\n9W9TNxu2h+6OZaoU7DRfGxIKsoau+o41vr1yfWbu4pgaChf3P7twvFbXSvh5tgW5\nKrWeDx/ezwKBgQDTpa0B5apAjG2DOdgD1+PhVeOs0hIWN7QHv3h14j7ag06+4MgN\nefZaHG5y7PegaukA3RVHj4JEW8l7amW3aExUT2k8jVUQJiWR1vjX2/QNRtGUj25P\nCHNikMq9M9OByw6eKR/X3nW1t1fK/vFEMJes6L1kNd/Wdy0xAmVlXv4tGQKBgEVI\n+lLDGPQ/i0tQTJvdo4pkrosGWII8zBBy4HICI2vXii5be8BYBN/u0fa4JanVmC9Y\nmtec6rM4VWLkbxgTLcHKkmFouRIwHansbBp28PlAgmgtiXAw5xByWUGt7ivc2Gs5\namyY2hZcfeJyYYoIVMF9wo7DSRiYkcDLQyq+++HFAoGBAL6qNb79/liwcyz3LsnQ\njLTpeuxnju3O3RpD1SB5bOXr+1UqNKoksDu+uOVnQ3rDV/4yX7hD51Ut0kYbmqU7\nXG6kg2RO3QF7mUVBLJw4UvBHPrqzi3WGEGJIyoOg7QEtylgxtHgZldElvgBvdSHr\no7+WEOFLFJA0EhVG/ABi/sma\n-----END PRIVATE KEY-----\n";
  
//   """-----BEGIN PRIVATE KEY-----
// MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8qTt/8StCS9sq
// LpDNauY50S/WiJXnq3QikqMTwJK1q3CMPl8vZnL/Hu1MI1yunSM3fR6bp8CnAUiI
// KMvYoYObvtsqKQ0F/371XxiKrSgfwo+2tW+8vV3pDY/6rqXkZ+CbP8uDbWwIPnI1
// 16qi5+WUTrH18BieicGlmS/ER8bzVetvSSZmKYJDl2pkVFkf2A/mxFa/FMVtfZgP
// sURuwU/f22WkhtaGyuYdokJp3zMMawNNMomYFjXvsdMmpAVPvcPTXE8B8cxievCt
// 0Q/SZbgVr/pUCTh/BEY6XrfD7S5ukqmNCPKbIbKbQ+W5dUXju3XWu7f/l/pniR37
// 6JPGus3ZAgMBAAECggEAIbj0UD3JGDwb7FHPg1BY37vTG7tlZDhC9Y0VhknVT5DZ
// +M+LTxs2cgDStNnbTsD60wfT6UnWh2OU1fXI3iucrUGzxjj5QXm2dWCur9ccxXSP
// IL8Uvn1w5GAOvOXr9ERXIxkHpTHxbhXPb21h7GWcJWLdr5Lfq7L/AL09iw2zc7o4
// xiqDgzOhaK4wLug8YsPsvG2CaRKmmJhWix1S820qCVpjzfJyRK+w5ulNNX3kgAfd
// kD2+tK2op+IVRJ6iHm7W0Jdidfeh80cySv1iE+Fl/FkS1FKik8nxDr8Apl8c6BaW
// T8hF208iLjMUWUfxQQaiZC7uGqXn+CTMT79ud6HBgwKBgQDm6r6n3Aw7fVdDjk7Z
// 5hY8JoxhIEzRCszw3B3A3j/YdZkT0vTTman/F1/SBVRj6IPKxSCqW4SX/GBzUyUN
// NAcCUTy49SXRPFrcv5bqSPq0GbPYy6Av90g1V4bRpGP9VaFtL+ldiBQiN/BTj4ou
// nYixKGUcouv0KjmNeWMp1fny1wKBgQDRJ3NkOTXhfRsJc8VfhDnr9OEsOs/fbECW
// KvrYexN61bD4Wt5wQVdIR7dthge2LLDvbhcpYunPN7w2K169x8xdBIGplECPHon8
// 9W9TNxu2h+6OZaoU7DRfGxIKsoau+o41vr1yfWbu4pgaChf3P7twvFbXSvh5tgW5
// KrWeDx/ezwKBgQDTpa0B5apAjG2DOdgD1+PhVeOs0hIWN7QHv3h14j7ag06+4MgN
// efZaHG5y7PegaukA3RVHj4JEW8l7amW3aExUT2k8jVUQJiWR1vjX2/QNRtGUj25P
// CHNikMq9M9OByw6eKR/X3nW1t1fK/vFEMJes6L1kNd/Wdy0xAmVlXv4tGQKBgEVI
// +lLDGPQ/i0tQTJvdo4pkrosGWII8zBBy4HICI2vXii5be8BYBN/u0fa4JanVmC9Y
// mtec6rM4VWLkbxgTLcHKkmFouRIwHansbBp28PlAgmgtiXAw5xByWUGt7ivc2Gs5
// amyY2hZcfeJyYYoIVMF9wo7DSRiYkcDLQyq+++HFAoGBAL6qNb79/liwcyz3LsnQ
// jLTpeuxnju3O3RpD1SB5bOXr+1UqNKoksDu+uOVnQ3rDV/4yX7hD51Ut0kYbmqU7
// XG6kg2RO3QF7mUVBLJw4UvBHPrqzi3WGEGJIyoOg7QEtylgxtHgZldElvgBvdSHr
// o7+WEOFLFJA0EhVG/ABi/sma
// -----END PRIVATE KEY-----""";

  final jwt = JWT(
   {
  "sub": "Green Pass",
  "name": "Abdullah Ayaz",
  "admin": true,
  "iat": DateTime.now()
},
    issuer: 'my-wallet-service@ivory-signer-368814.iam.gserviceaccount.com',
  );

  // Sign the JWT
  final token = jwt.sign(RSAPrivateKey(privateKey), algorithm: JWTAlgorithm.RS256);

  return token;
}
}
final String _passId = const Uuid().v4();
const String _passClass = 'test-id';
const String _issuerId = '3388000000022325840';
const String _issuerEmail = 'abdullahayaz529@gmail.com';
final String _examplePass = 
// """
// {
//   "aud": "google",
//   "origins": [
//     "https://localhost:8080"
//   ],
//   "iss": "177146692044@developer.gserviceaccount.com",
//   "iat": 1389816895,
//   "typ": "savetowallet",
//   "payload": {
//     "loyaltyObjects": [
//       {
//         "barcode": {
//           "alternateText": "12345",
//           "type": "qrCode",
//           "value": "28343E3"
//         },
//         "linksModuleData": {
//           "uris": [
//             {
//               "kind": "walletobjects#uri",
//               "uri": "https://www.baconrista.com/myaccount?id=1234567890",
//               "description": "My Baconrista Account"
//             }
//           ]
//         },
//         "infoModuleData": {
//           "labelValueRows": [
//             {
//               "columns": [
//                 {
//                   "value": "Jane Doe",
//                   "label": "Member Name"
//                 },
//                 {
//                   "value": "1234567890",
//                   "label": "Membership #"
//                 }
//               ]
//             },
//             {
//               "columns": [
//                 {
//                   "value": "2 coffees",
//                   "label": "Next Reward in"
//                 },
//                 {
//                   "value": "01/15/2013",
//                   "label": "Member Since"
//                 }
//               ]
//             }
//           ],
//           "showLastUpdateTime": "true"
//         },
//         "id": "2956054058108947698.LoyaltyObjectPython10",
//         "loyaltyPoints": {
//           "balance": {
//             "string": "500"
//           },
//           "label": "Points"
//         },
//         "accountId": "1234567890",
//         "classId": "2956054058108947698.LoyaltyClassPython10",
//         "accountName": "Jane Doe",
//         "state": "active",
//         "version": 1,
//         "textModulesData": [
//           {
//             "body": "You are 5 coffees away from receiving a free bacon fat latte. ",
//             "header": "Jane's Baconrista Rewards"
//           }
//         ]
//       }
//     ]
//   }
// }""";

""" 
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#008000",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Global Gamers Challenge"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Add your Green Card to your Google Wallet"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Abdullah Ayaz"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
enum PlatformType { android, iOS, web, unknown }