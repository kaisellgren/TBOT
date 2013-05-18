part of tbot;

class Soldier extends Entity {
  bool canControl = false;
  double speed = 1.5;
  int lastTimeShot = 0;
  double bulletOriginRotation = 0.0;
  int team = -1;

  int _health = 100;
  set health(int health) {
    _health = health;

    // If I'm dead, remove me please!
    if (health <= 0)
      game.removeComponent(this);
  }
  get health => _health;

  // AI-specific.
  var aiChangeDirectionIn = 0;
  var aiCurrentDirection = 0;
  var aiIsStanding = 0;
  var aiTarget = null;

  Soldier(game) : super(game);

  initialize() {
    originX = 15.0;
    originY = 30.0;
    bulletOriginX = 54.0;
    bulletOriginY = 27.0;
    bulletOriginRotation = getPointDirection(originX, originY, bulletOriginX, bulletOriginY);
  }

  update() {
    // This soldier is under player's control.
    if (canControl) {
      // Look towards the mouse.
      rotation = getPointDirection(x + originX, y + originY, game.mouse.x, game.mouse.y);

      var distance = getDistanceToPoint(x + originX, y + originY, game.mouse.x, game.mouse.y);

      // Shoot upon left click.
      if (game.mouse.isPressed(0)) {
        // Only shoot once in 500ms.
        var now = new DateTime.now().millisecondsSinceEpoch;
        if (now - lastTimeShot > 500) {
          var b = new Bullet(
            game: game,
            rotation: rotation,
            //x: x + originX + (bulletOriginX/* - originX*/) * cos(rotation - bulletOriginRotation),
            //y: y + originY + (bulletOriginY/* - originY*/) * sin(rotation - bulletOriginRotation)
            x: x + originX + bulletOriginX * cos(rotation),
            y: y + originY + bulletOriginY * sin(rotation)
          );

          game.addComponent(b);

          lastTimeShot = now;
        }
      }

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
      // Detect others.
      if (aiTarget == null) {
        game._components.forEach((Component c) {
          if (c is Soldier && c != this) {
            // Attack only enemies.
            if (c.team != team) {
              var distance = getDistanceToPoint(x + originX, y + originY, c.x + c.originX, c.y + c.originY);

              if (distance < 512) {
                aiTarget = c;
              }
            }
          }
        });

        // Change direction.
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

        // Rotate.
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

        // Move.
        if (aiIsStanding < 0) {
          x += cos(rotation) * speed;
          y += sin(rotation) * speed;
        }

        aiIsStanding--;
      }

      // Shoot targets!
      if (aiTarget != null) {
        if (aiTarget.health <= 0)
          aiTarget = null;
        else {
          rotation = getPointDirection(x + originX, y + originY, aiTarget.x + aiTarget.originX, aiTarget.y + aiTarget.originY);

          // Only shoot once in 500ms.
          var now = new DateTime.now().millisecondsSinceEpoch;
          if (now - lastTimeShot > 500) {
            var b = new Bullet(
              game: game,
              rotation: rotation,
              //x: x + originX + (bulletOriginX/* - originX*/) * cos(rotation - bulletOriginRotation),
              //y: y + originY + (bulletOriginY/* - originY*/) * sin(rotation - bulletOriginRotation)
              x: x + originX + bulletOriginX * cos(rotation),
              y: y + originY + bulletOriginY * sin(rotation)
            );

            game.addComponent(b);

            lastTimeShot = now;
          }
        }
      }
    }
  }

  draw() {
    if (canControl || team == 0) {
      game.context.beginPath();
      game.context.arc(x + originX, y + originY, width, 0, 2 * PI, false);

      // Change health "bar" (circle) color according to health.
      int red, green;
      if (health > 80) {
        red = 168;
        green = 255;
      } else if (health > 60) {
        red = 210;
        green = 255;
      } else if (health > 40) {
        red = 255;
        green = 245;
      } else if (health > 20) {
        red = 255;
        green = 190;
      } else {
        red = 255;
        green = 128;
      }

      var gradient = game.context.createRadialGradient(x + originX, y + originY, 1, x + originX, y + originY, width);
      gradient.addColorStop(0, 'rgba($red, $green, 0, 1)');
      gradient.addColorStop(0.2, 'rgba($red, $green, 0, 0.75)');
      gradient.addColorStop(0.9, 'rgba($red, $green, 0, 0.1)');
      gradient.addColorStop(1, 'rgba($red, $green, 0, 0)');

      game.context.fillStyle = gradient;
      game.context.fill();
      game.context.closePath();
    }

    super.draw();
  }
}