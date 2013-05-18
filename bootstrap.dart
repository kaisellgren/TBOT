import 'dart:html';
import 'lib/game.dart';

main() {
  CanvasElement canvas = query('#game');

  // Make canvas always as big as possible.
  maximizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }

  window.onResize.listen((e) => maximizeCanvas());

  maximizeCanvas();

  // Run the game.
  new Game(canvas);
}