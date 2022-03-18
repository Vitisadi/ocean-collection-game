class Barrel{
  int x;
  int y;
  int w;
  int h;
  int fallingSpeed;
  
  Barrel(int x, int y, int fallingSpeed){
    this.x = x;
    this.y = y;
    this.w = 200;
    this.h = 200;
    this.fallingSpeed = fallingSpeed;
  }
  
  void moveDown() {
    y += fallingSpeed;
  }
  
  void display (){
    image(barrel, x, y, w, h);
  } 
  
  void checkBoundry () {
    if (y >= height){
      y = int(random(-500,-h));
      x = int(random(0,width));
      fallingSpeed ++;
    }
  }
  
  void checkCollision() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y+h){
      hitObject();
    }
  }
}
