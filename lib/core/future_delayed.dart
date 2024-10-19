import 'dart:ui';

Future<void> futureDelayed(int duration, VoidCallback callback) {
  return Future.delayed(Duration(milliseconds: duration), () {
    callback();
  });
}
