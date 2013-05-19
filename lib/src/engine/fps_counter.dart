part of tbot;

class FpsCounter extends DrawableComponent {
  int lastTime = new DateTime.now().millisecondsSinceEpoch;
  int ticks = 30;
  int fps = 0;

  FpsCounter(game) : super(game);

  update() {

  }

  draw() {
    ticks++;
    if (ticks > 30) {
      var now = new DateTime.now().millisecondsSinceEpoch;

      var result = ((now - lastTime) ~/ 30);
      if (result > 0)
        fps = 1000 ~/ result;

      ticks = 0;
      lastTime = now;
    }

    game.context.fillStyle = 'white';
    game.context.font = '24pt bold Segoe UI, Arial';
    game.context.fillText('FPS: $fps (${game.componentCount} components)', game.camera.x + 32, game.camera.y + 32);
    game.context.fillText('Team 1: ${game.team0players} units', game.camera.x + 32, game.camera.y + 68);
    game.context.fillText('Team 2: ${game.team1players} units', game.camera.x + 32, game.camera.y + 102);
  }
}