part of tbot;

/**
 * Handles mouse related activity.
 */
class Mouse {
  Game game;
  var x = 0, y = 0;

  Mouse(this.game) {
    // Listen to mouse movements and update x and y.
    game.canvas.on.mouseMove.add((MouseEvent e) {
      x = e.pageX;
      y = e.pageY;
    });
  }
}