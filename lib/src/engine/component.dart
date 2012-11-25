part of tbot;

/**
 * Represents an updatable game component.
 *
 * All game components need to be added to the Game class' "components" -collection.
 */
abstract class Component {
  Game game;
  bool disabled = false;

  void update();

  Component(this.game);
}