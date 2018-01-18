//test

PoolTable thePoolTable;
PoolBall thePoolBalls;





int gameState = 1;
void setup() {
  size(1200, 600);


  thePoolTable = new PoolTable(width/2, height/2);

  thePoolBalls = new PoolBall(width/2, height/2);
}

void draw() {
  noStroke();
  textAlign(CENTER);
  background(150, 150, 150, 100);

  if (gameState == 1 && keyPressed) {
    gameState = 2;
  }

  if (thePoolBalls.eightBallSunk == true) {
    textAlign(CENTER);
    textSize(width/25);
    text("Press R To Reset", width/2, height - height/10);
  }



  if (gameState == 1) {
    fill(0, 0, 0, 100);
    ellipse(width/2, height/2, height, height);
    fill(200, 200, 200, 100);
    ellipse(width/2, height/2, height/2, height/2);
    fill(0, 0, 0, 100);
    textSize(width/6);
    text("8", width/2, height/2 + height/10);



    textSize(width/19);
    fill(10, 70, 40);
    text("Please Press The Space Key To Begin", width/2, height/2);
  }




  if (gameState == 2) {
    thePoolTable.display();
    thePoolBalls.shotAiming();
    thePoolBalls.updateBalls();
    thePoolBalls.bounceOffWall();
    thePoolBalls.bounceOffBall();
    thePoolBalls.ballInPocket(thePoolTable);
    thePoolBalls.checkForMotion();
    
    if(thePoolBalls.cueBallInHand == true){
    thePoolBalls.isTheCueBallInAPocket();
    }
  }
}

//void mousePressed() {
//if(thePoolBalls.displayBall[0] == true){
//  thePoolBalls.handleMousePressed();
//}
//}

void keyPressed() {
  if (gameState == 2) {
    thePoolBalls.handleKeyPressed() ;
  }
}