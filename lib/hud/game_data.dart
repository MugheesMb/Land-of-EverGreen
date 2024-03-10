import 'package:flutter/foundation.dart';

class PlayData {
  final score = ValueNotifier<int>(0);
  final health = ValueNotifier<int>(5);
  final plastic = ValueNotifier<int>(0);
}
