part of tbot;

class Clouds extends DrawableComponent {
  double speed = 0.5;
  double x = 0.0, y = 0.0;
  ImageElement model;
  ImageElement modelShadow;

  Clouds(game) : super(game);

  update() {
    x += speed;
    y += speed;

    if (x > model.width)
      x = 0.0;

    if (y > model.height)
      y = 0.0;
  }

  draw() {
    game.context.globalAlpha = 0.25;

    for (var x = -model.width; x < game.width; x += model.width) {
      for (var y = -model.height; y < game.height; y += model.height) {
        game.context.drawImage(modelShadow, x + this.x, y + this.y);
      }
    }

    game.context.globalAlpha = 1;
  }
}