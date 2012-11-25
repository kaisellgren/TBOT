part of tbot;

class Soldier extends Entity {
  bool canControl = false;
  double speed = 2.0;

  Soldier(game) : super(game);

  update() {
    // This soldier is under player's control.
    if (canControl) {
      // Look towards the mouse.
      rotation = getPointDirection(x + originX, y + originY, game.mouse.x, game.mouse.y);

      var distance = getDistanceToPoint(x + originX, y + originY, game.mouse.x, game.mouse.y);

      // Move forward
      if (game.keyboard.isPressed(KeyCode.W)) {
        if (distance > 16) {
          // Sprinting.
          var sprint = game.keyboard.isPressed(KeyCode.SHIFT) ? 2 : 1;

          x += cos(rotation) * speed * sprint;
          y += sin(rotation) * speed * sprint;
        }
      }

      // Move backwards.
      if (game.keyboard.isPressed(KeyCode.S)) {
        if (distance > 16) {
          x -= cos(rotation) * speed / 2;
          y -= sin(rotation) * speed / 2;
        }
      }

      // Strafe left.
      if (game.keyboard.isPressed(KeyCode.A)) {
        if (distance > 16) {
          x += cos(rotation - degToRad(90.0)) * speed / 2;
          y += sin(rotation - degToRad(90.0)) * speed / 2;
        }
      }

      // Strafe right.
      if (game.keyboard.isPressed(KeyCode.D)) {
        if (distance > 16) {
          x += cos(rotation + degToRad(90.0)) * speed / 2;
          y += sin(rotation + degToRad(90.0)) * speed / 2;
        }
      }
    }
  }
}