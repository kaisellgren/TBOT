part of tbot;

class Camera {
  Game game;

  int x = 0;
  int y = 0;
  int scrollSpeed = 24;
  const int threshold = 64;
  
  Camera(this.game);
  
  update() {
    if ((game.mouse.x >= window.innerWidth - threshold || game.keyboard.isPressed(KeyCode.RIGHT)) && game.width - window.innerWidth >= x + scrollSpeed) {
      game.context.translate(-scrollSpeed, 0);
      x += scrollSpeed;
    } else if ((game.mouse.x <= threshold || game.keyboard.isPressed(KeyCode.LEFT)) && x >= scrollSpeed) {
      game.context.translate(scrollSpeed, 0);
      x -= scrollSpeed;
    }

    if ((game.mouse.y >= window.innerHeight - threshold || game.keyboard.isPressed(KeyCode.DOWN)) && game.height - window.innerHeight >= y + scrollSpeed) {
      game.context.translate(0, -scrollSpeed);
      y += scrollSpeed;
    } else if ((game.mouse.y <= threshold || game.keyboard.isPressed(KeyCode.UP)) && y >= scrollSpeed) {
      game.context.translate(0, scrollSpeed);
      y -= scrollSpeed;
    }
  }

  void goTo(int x, int y) {
    game.context.translate(-x, 0);
    game.context.translate(0, -y);
    this.y += y;
    this.x += x;
  }
}