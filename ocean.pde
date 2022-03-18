import processing.sound.*;

SoundFile backgroundMusic;
SoundFile starSF;
SoundFile collisionSF;
SoundFile lifeSF;

int amountStarsCollected;
int amountStarHitShark;
int amountLives =3;
int timePostCollision = millis();

PImage seaFloor;
PImage barrel;
PImage bottle;
PImage shark;
PImage star;

boolean gamePlaying = false;
String objective = "Your Objective:\nMove your mouse to collect as many stars as you can\nEvery star you collect grants you 1 point\nBe aware of the creatures and debrees floating around\nIf you hit them, you lose 1 life\nThe greedy sharks also want stars\nEvery time a shark hits a star you lose a point\nPress your mouse to begin";

Barrel [] barrels;
Bottle [] bottles;
Shark [] sharks;
Star [] stars;

void setup() {
  size(1600,1200);
  fill(255);
  noStroke();
  seaFloor = loadImage("seaFloor.jpg");
  barrel = loadImage("barrel.png");
  bottle = loadImage("bottle.png");
  shark = loadImage("shark.png");
  star = loadImage("star.png");
  
  backgroundMusic = new SoundFile(this, "Spongebob.mp3");
  starSF = new SoundFile (this, "achievement.mp3");
  collisionSF = new SoundFile (this, "buzzer.mp3");
  lifeSF = new SoundFile(this, "loseLife.mp3");

  barrels = new Barrel [6];
  for (int i = 0; i < barrels.length; i++) {
    barrels [i] = new Barrel (int(random(0,width)), int(random(-1000,-100)), int(random(8,15)));
  }
  bottles = new Bottle [5];
  for (int i = 0; i < bottles.length; i++) {
    bottles [i] = new Bottle (int(random(0,width)), int(random(-1000,-100)), int(random(5,12))); 
  }
  sharks = new Shark [2];
  for (int i = 0; i < sharks.length; i++) {
    sharks [i] = new Shark (int(random(0,width)), int(random(-1000,-100)), int(random(10,17))); 
  }
  stars = new Star [3];
  for (int i = 0; i < stars.length; i++) {
    stars [i] = new Star (int(random(0,width)), int(random(-1000,-100)), int(random(17,25))); 
  }
}

void draw() {
  if (!backgroundMusic.isPlaying()){
    backgroundMusic.play();
  }
  if (!gamePlaying){
    drawTitleScreen();
    return;
  }
  
  image (seaFloor, 0,0, width, height);
  fill(222, 81, 81);
  textSize(100);
  textAlign(LEFT);
  text(amountStarsCollected - amountStarHitShark + " Points", 100, 100);
  text(amountLives + " Lives", 100, 250);

  for (int i = 0; i < barrels.length; i++) {
    barrels[i].checkBoundry();
    barrels[i].display();
    barrels[i].moveDown();
    barrels[i].checkCollision();
    
  }
  for (int i = 0; i < bottles.length; i++) {
    bottles[i].checkBoundry();
    bottles[i].display();
    bottles[i].moveDown();
    bottles[i].checkCollision();

  }
  for (int i = 0; i < sharks.length; i++) {
    sharks[i].checkBoundry();
    sharks[i].display();
    sharks[i].moveDown();
    sharks[i].checkCollision();
  }
  for (int i = 0; i < stars.length; i++) {
    stars[i].checkBoundry();
    stars[i].display();
    stars[i].moveDown();
    stars[i].checkCollision();
  }
  
}

void drawTitleScreen() {
  background(0);
  fill(255,255, 100);
  textAlign(CENTER);
  textSize(50);
  text(objective, width/2, 450);
  fill(255);
  textSize(100);
  text("Collect those Stars!!!", width/2, 250);
  fill(255, 0, 0);
  text(amountStarsCollected - amountStarHitShark + " Points", width/2, 375);
}

void mousePressed() {
  
  if (!gamePlaying){
    amountStarsCollected = 0;
    amountStarHitShark = 0;
    
    for (int i = 0; i < barrels.length; i++) {
      barrels[i].x = int(random(0,width));
      barrels[i].y = int(random(-1000,-100));
      barrels[i].fallingSpeed = int(random(8,15));
    }
    for (int i = 0; i < bottles.length; i++) {
      bottles[i].x = int(random(0,width));
      bottles[i].y = int(random(-1000,-100));
      bottles[i].fallingSpeed = int(random(5,12));
    }
    for (int i = 0; i < sharks.length; i++) {
      sharks[i].x = int(random(0,width));
      sharks[i].y = int(random(-1000,-100));
      sharks[i].fallingSpeed = int(random(10,17));
    }
    for (int i = 0; i < stars.length; i++) {
      stars[i].x = int(random(0,width));
      stars[i].y = int(random(-1000,-100));
      stars[i].fallingSpeed = int(random(17,25));
    }
    amountLives = 3;
    gamePlaying = true;
  }
  
}

void hitObject() {
  if (timePostCollision +1000 < millis()){
    lifeSF.play();
    amountLives --;
    timePostCollision = millis();
  }
  
  if (amountLives == 0){
    gamePlaying = false;
  }
}
