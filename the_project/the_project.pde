PoolTable thePoolTable;
PoolBall thePoolBalls;
Point thePoints;

void setup() {
  size(800, 800);
  
  
  thePoolTable = new PoolTable(width, height/2);
  
  thePoolBalls = new PoolBall(width, height/2);
  
  
}

void draw(){
  background(255);
  thePoolTable.display();
  thePoolBalls.updateBalls();
  
  
  
}