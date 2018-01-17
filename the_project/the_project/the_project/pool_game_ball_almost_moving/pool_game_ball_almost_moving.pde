//test

PoolTable thePoolTable;
PoolBall thePoolBalls;





void setup() {
  size(1200, 600);
  
  
  thePoolTable = new PoolTable(width/2, height/2);
  
  thePoolBalls = new PoolBall(width/2, height/2);
  

  
  

 
}

void draw(){
  background(255);
  thePoolTable.display();
  thePoolBalls.shotAiming();
  thePoolBalls.updateBalls();
  thePoolBalls.bounceOffWall();
  thePoolBalls.bounceOffBall();
  thePoolBalls.ballInPocket(thePoolTable);
  thePoolBalls.checkForMotion();
  
  
  
}

void mousePressed() {

  thePoolBalls.handleMousePressed();
 
}

void keyPressed() {
 thePoolBalls.handleKeyPressed() ;
}