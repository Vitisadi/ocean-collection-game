class Star{
  int x;
  int y;
  int w;
  int h;
  int fallingSpeed;
  
  Star(int x, int y, int fallingSpeed){
    this.x = x;
    this.y = y;
    this.w = 100;
    this.h = 100;
    this.fallingSpeed = fallingSpeed;
  }
  
  void moveDown() {
    y += fallingSpeed;
  }
  
  void display (){
    image(star, x, y, w, h);
  }
  
  void checkBoundry () {
    if (y >= height){
      y = int(random(-500,-h));
      x = int(random(0,width));
      fallingSpeed ++;
    }
  }
  
  void checkCollision() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y+h){ //check mouse and star collision
      amountStarsCollected ++;
      y = int(random(-500,-h));
      x = int(random(0,width));
      starSF.play();
    }
    for (int i = 0; i < sharks.length; i++) {   //check shark and star collision
      if(int(dist(x,y,sharks[i].x,sharks[i].y)) < sharks[i].w){
        y = int(random(-500,-h));
        x = int(random(0,width));
        amountStarHitShark ++;
        collisionSF.play();
      }
    }
  }
  
}
