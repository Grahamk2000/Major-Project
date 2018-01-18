//Pool Game Major Project
//Graham Kelly
//Computer Science 30 - Mr.Schellenberg
//January 18, 2018
//
//Instructions:
//aim using the mouse
//when you have the mouse in the spot you want it hold it there
//choose the power of your shot by using the numbers 1 - 9 higher number = harder shot
//you must wait for all balls to stop moving before taking another shot
//
//pressing the space key will allow you to replace the cue ball if you feel like cheating
//the R key will reset all balls back to their original positions
//
//Extra for experts: 
//Making this game was by far the most difficult project this semester
//the collision detection is fairly advanced except for the balls bouncing more than they would in the real world
//
//Areas for improvement:
//I would like to make the interactions between the balls a little more realistic
//Add rules into the game that would ensure the player struck their own ball before their opponents


//setting up classes
PoolTable thePoolTable;
PoolBall thePoolBalls;

int gameState = 1;

void setup() {
  size(1200, 600);

  thePoolTable = new PoolTable(width/2, height/2);
  thePoolBalls = new PoolBall();
}

void draw() {
  noStroke();
  textAlign(CENTER);
  background(150, 150, 150, 100);

  if (gameState == 1 && keyPressed) {//exits the home screen and starts the game
    if (key == ' '){
    gameState = 2;
    }
  }

  if (thePoolBalls.eightBallSunk == true) {//allows the player to reset the game if they sink the eight ball
    textAlign(CENTER);
    textSize(width/25);
    text("Press R To Reset", width/2, height - height/10);
  }



  if (gameState == 1) {// the home screen
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


  if (gameState == 2) {//this is the state the game is in while playing pool
    thePoolTable.display();
    thePoolBalls.shotAiming();
    thePoolBalls.updateBalls();
    thePoolBalls.bounceOffWall();
    thePoolBalls.bounceOffBall();
    thePoolBalls.ballInPocket(thePoolTable);
    thePoolBalls.checkForMotion();

    if (thePoolBalls.cueBallInHand == true) {
      thePoolBalls.isTheCueBallInAPocket();
    }
  }
}

void keyPressed() {//determines if you have pressed a key at an appropriate time
  if (gameState == 2) {
    thePoolBalls.handleKeyPressed() ;
  }
}