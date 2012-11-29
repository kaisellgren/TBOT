part of tbot;

class Clouds extends DrawableComponent {
  int zIndex = 10000;
  double speed = 0.5;
  double x = 0.0, y = 0.0;
  ImageElement model;

  double alpha = 0.0;
  int alphaDirection = 1;

  Clouds(game) : super(game);

  update() {
    x += speed;
    y += speed;

    if (x > model.width)
      x = 0.0;

    if (y > model.height)
      y = 0.0;

    if (alphaDirection == 1)
      alpha += 0.0002;
    else
      alpha -= alpha > 0 ? 0.0001 : 0.0003;

    if (alpha >= 1)
      alphaDirection = 0;
    else if (alpha <= -1)
      alphaDirection = 1;
  }

  draw() {
    if (alpha > 0) {
      game.context.globalAlpha = alpha;

      for (var x = -model.width; x < game.width; x += model.width) {
        for (var y = -model.height; y < game.height; y += model.height) {
          game.context.drawImage(model, x + this.x, y + this.y);
        }
      }

      game.context.globalAlpha = 1;
    }
  }
}