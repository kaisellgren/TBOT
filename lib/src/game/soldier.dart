part of tbot;

class Soldier extends Entity {
  bool canControl = false;

  Soldier(game) : super(game);

  update() {
    // This soldier is under player's control.
    if (canControl) {
      // Look towards the mouse.
      rotation = getPointDirection(x + originX, y + originY, game.mouse.x, game.mouse.y);
    }
  }
}