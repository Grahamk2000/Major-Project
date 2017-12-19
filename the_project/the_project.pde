

PoolTable thePoolTable;
PoolBall thePoolBalls;


void setup() {
  size(1600, 800);
  
  
  thePoolTable = new PoolTable(width/2, height/2);
  
  thePoolBalls = new PoolBall(width/2, height/2);
  
 
}

void draw(){
  background(255);
  thePoolTable.display();
  thePoolBalls.shotAiming();
  thePoolBalls.updateBalls();
  
  
  
}