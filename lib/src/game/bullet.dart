part of tbot;

class Bullet extends Entity {
  double speed = 8.0;

  Bullet(game) : super(game);

  update() {
    super.update();

    x += cos(rotation) * speed;
    y += sin(rotation) * speed;
  }

  draw() {
    super.draw();

    game.context.fillStyle = 'black';
    game.context.beginPath();
    game.context.arc(x, y, 2.5, 0, 360, false);
    game.context.closePath();
    game.context.fill();
  }
}