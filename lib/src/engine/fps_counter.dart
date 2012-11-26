part of tbot;

class FpsCounter extends DrawableComponent {
  int lastTime = new Date.now().millisecondsSinceEpoch;
  int ticks = 30;
  int fps = 0;

  FpsCounter(game) : super(game);

  update() {

  }

  draw() {
    ticks++;
    if (ticks > 30) {
      var now = new Date.now().millisecondsSinceEpoch;

      var result = ((now - lastTime) ~/ 30);
      if (result > 0)
        fps = 1000 ~/ result;

      ticks = 0;
      lastTime = now;
    }

    game.context.fillStyle = 'white';
    game.context.font = '24pt bold Segoe UI, Arial';
    game.context.fillText('FPS: $fps', 32, 32);
  }
}