part of tbot;

class Entity extends DrawableComponent {
  double x, y;
  double originX, originY;

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

    context.translate(x + originX, y + originY);
    context.rotate(rotation);
    context.drawImage(game.content.resources['soldier'], -originX, -originY);
    context.rotate(-rotation);
    context.translate(-x - originX, -y - originY);
  }
}