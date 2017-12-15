

PoolTable thePoolTable;
PoolBall thePoolBalls;


void setup() {
  size(800, 800);
  
  
  thePoolTable = new PoolTable(width, height/2);
  
  thePoolBalls = new PoolBall(width, height/2);
  
 
}

void draw(){
  background(255);
  thePoolTable.display();
  thePoolBalls.shotAiming();
  thePoolBalls.updateBalls();
  
  
  
}