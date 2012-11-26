part of tbot;

/**
 * Handles mouse related activity.
 */
class Mouse {
  Game game;
  int x = 0, y = 0;
  HashMap<int, int> _keys = new HashMap<int, int>();

  Mouse(this.game) {
    // Listen to mouse movements and update x and y.
    game.canvas.on.mouseMove.add((MouseEvent e) {
      x = e.pageX;
      y = e.pageY;
    });

    window.on.mouseDown.add((MouseEvent e) {
      // If the key is not set yet, set it with a timestamp.
      if (!_keys.containsKey(e.button))
        _keys[e.button] = e.timeStamp;
    });

    window.on.mouseUp.add((MouseEvent e) {
      _keys.remove(e.button);
    });
  }

  /**
   * Check if the given button is pressed.
   */
  isPressed(int button) => _keys.containsKey(button);
}