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
    game.canvas.onMouseMove.listen((MouseEvent e) {
      x = e.pageX;
      y = e.pageY;
    });

    window.onMouseDown.listen((MouseEvent e) {
      // If the key is not set yet, set it with a timestamp.
      if (!_keys.containsKey(e.button))
        _keys[e.button] = e.timeStamp;
    });

    window.onMouseUp.listen((MouseEvent e) {
      _keys.remove(e.button);
    });
  }

  /**
   * Check if the given button is pressed.
   */
  isPressed(int button) => _keys.containsKey(button);
}