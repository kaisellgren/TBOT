part of tbot;

class Soldier extends Entity {
  bool canControl = false;
  double speed = 1.5;

  var aiChangeDirectionIn = 0;
  var aiCurrentDirection = 0;
  var aiIsStanding = 0;

  Soldier(game) : super(game);

  initialize() {
    originX = 15.0;
    originY = 30.0;
  }

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

    // I am an AI! Let's move.
    else {
      if (aiChangeDirectionIn < 0) {
        if (aiIsStanding < 0)
          aiChangeDirectionIn = 50;
        else
          aiChangeDirectionIn = 250;

        if (aiIsStanding < 0 && game.random.nextInt(10) == 0)
          aiIsStanding = 200;

        if (game.random.nextBool())
          aiCurrentDirection = 0;
        else
          aiCurrentDirection = 1;
      }

      aiChangeDirectionIn--;

      if (aiIsStanding < 0) {
        if (aiCurrentDirection == 0)
          rotation += degToRad(game.random.nextInt(3));
        else
          rotation -= degToRad(game.random.nextInt(3));
      } else {
        if (aiCurrentDirection == 0)
          rotation += degToRad(0.5);
        else
          rotation -= degToRad(0.5);
      }

      if (aiIsStanding < 0) {
        x += cos(rotation) * speed;
        y += sin(rotation) * speed;
      }

      aiIsStanding--;
    }
  }
}