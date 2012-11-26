part of tbot;

class Entity extends DrawableComponent {
  double x = 0.0, y = 0.0;
  double originX = 0.0, originY = 0.0;
  double speed = 0.0;

  /**
   * Rotation in radians.
   */
  double rotation = 0.0;

  ImageElement _model;

  get model => _model;
  set model(model) {
    _model = model;
    originX = _model.width / 2;
    originY = _model.height / 2;
  }

  Entity(game) : super(game);

  draw() {
    // TODO: Finish the Service system at some point...
    //CanvasRenderingContext2D context = game.services.get('context');
    var context = game.context;

    // Draw model if set.
    if (_model != null) {
      context.translate(x + originX, y + originY);
      context.rotate(rotation);
      context.drawImage(_model, -originX, -originY);
      context.rotate(-rotation);
      context.translate(-x - originX, -y - originY);
    }
  }

  update() {

  }

  initialize() {

  }
}