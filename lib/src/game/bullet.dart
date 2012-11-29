part of tbot;

class Bullet extends Entity {
  int zIndex = -5;
  double speed = 16.0;
  int width = 4, height = 4;

  Bullet({game, rotation, x, y}) : super(game) {
    var r = new Random();

    speed -= r.nextDouble();
    speed += r.nextDouble();

    rotation += degToRad(r.nextInt(5));
    rotation -= degToRad(r.nextInt(5));

    this.rotation = rotation;
    this.x = x;
    this.y = y;
  }

  update() {
    super.update();

    x += cos(rotation) * speed;
    y += sin(rotation) * speed;

    // Check if we hit anything!
    game._components.forEach((c) {
      if (c is Soldier) {
        if (collidesWith(c)) {
          c.health -= (15 + game.random.nextInt(5));
          game.removeComponent(this);
        }
      }
    });
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