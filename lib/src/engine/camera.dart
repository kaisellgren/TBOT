part of tbot;

class Camera {
  
  Game game;
  int width;
  int height;
  int realCurrentWidth = 0;
  int realCurrentTopHeight = 0;
  int scrollSpeed = 7;
  
  Camera(this.game) {
    
  }
  
  update() {
    
    
  }
  
  follow() {
    //X coordinate
    if( this.game.mouse.x >= 1200 && this.game.mouse.x <= this.game.width ) {
      this.game.context.translate(-scrollSpeed,0);
      realCurrentWidth += scrollSpeed;
    }
    else if( this.game.mouse.x <= 0 && realCurrentWidth != 0 ) {
      this.game.context.translate(scrollSpeed, 0);
      realCurrentWidth -= scrollSpeed;
    }
    
    //Y Coordinate
    if( this.game.mouse.y >= 700 && this.game.mouse.y <= this.game.height) {
      this.game.context.translate(0,-scrollSpeed);  
      realCurrentTopHeight += scrollSpeed;
    }
    else if( this.game.mouse.y <= realCurrentTopHeight) {
      this.game.context.translate(0,scrollSpeed);  
      realCurrentTopHeight -= scrollSpeed;  
    }
  }
  
}
