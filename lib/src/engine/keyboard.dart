part of tbot;

class Keyboard {
  Game game;
  HashMap<int, int> _keys = new HashMap<int, int>();

  Keyboard(this.game) {
    window.on.keyDown.add((KeyboardEvent e) {
      // If the key is not set yet, set it with a timestamp.
      if (!_keys.containsKey(e.keyCode))
        _keys[e.keyCode] = e.timeStamp;
    });

    window.on.keyUp.add((KeyboardEvent e) {
      _keys.remove(e.keyCode);
    });
  }

  /**
   * Check if the given key code is pressed. You should use the [KeyCode] class.
   */
  isPressed(int keyCode) => _keys.containsKey(keyCode);

  getDurationKeyIsPressedFor(int keyCode) => _keys[keyCode];
}