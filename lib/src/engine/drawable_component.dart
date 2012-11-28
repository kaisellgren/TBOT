part of tbot;

/**
 * Represents a drawable game component.
 */
abstract class DrawableComponent extends Component {
  bool hidden = false;
  double opacity = 1.0;

  void loadContent();
  void draw();

  DrawableComponent(game) : super(game);
}