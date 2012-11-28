part of tbot;

class Entity extends DrawableComponent {
  double x = 0.0, y = 0.0;
  int width, height;
  double originX = 0.0, originY = 0.0;
  double bulletOriginX = 0.0, bulletOriginY = 0.0;
  double speed = 0.0;

  /**
   * Rotation in radians.
   */
  double rotation = 0.0;

  ImageElement _model;

  get model => _model;
  set model(model) {
    _model = model;
    width = _model.width;
    height = _model.height;
    originX = width / 2;
    originY = height / 2;
  }

  Entity(game) : super(game);

  draw() {
    // TODO: Finish the Service system at some point...
    //CanvasRenderingContext2D context = game.services.get('context');
    var context = game.context;

    // Draw model if set.
    if (_model != null) {
      if (opacity != 1.0)
        context.globalAlpha = opacity;

      context.translate(x + originX, y + originY);
      context.rotate(rotation);
      context.drawImage(_model, -originX, -originY);
      context.rotate(-rotation);
      context.translate(-x - originX, -y - originY);

      if (opacity != 1.0)
        context.globalAlpha = 1;
    }
  }

  update() {

  }

  initialize() {

  }

  /**
   * Checks if this collides with the given entity.
   */
  bool collidesWith(Entity e) {
    // X -match.
    if (e.x <= x && e.x + e.width >= x) {
      // Y -match.
      if (e.y <= y && e.y + e.height >= y) {
        return true;
      }
    }

    return false;
  }
}