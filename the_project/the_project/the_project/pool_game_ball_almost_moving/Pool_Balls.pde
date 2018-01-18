class PoolBall {
  //variable setup
  int numberOfBalls = 16;
  int numberOfBallsMoving;

  PVector ballLocations[], ballVelocity[], ballAcceleration[], thrust[], dir[];

  float ballDiam = width/60;
  float ballRadius = ballDiam/2;
  float aimingX, aimingY;

  boolean shootBall[];
  boolean showAimingLine = true;
  boolean displayBall[];
  boolean areThereBallsMoving = false;
  boolean cueBallPlaced = true;
  boolean eightBallSunk = false;
  boolean cueBallInHand = false;

  //constructor
  PoolBall() {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];
    dir = new PVector[numberOfBalls];
    thrust = new PVector[numberOfBalls];
    shootBall = new boolean[numberOfBalls];
    displayBall = new boolean[numberOfBalls];



    for (int i=0; i<numberOfBalls; i++) {
      ballVelocity[i] = new PVector(0, 0);
      ballAcceleration[i] = new PVector(0, 0);
      dir[i] = new PVector(0, 0);
      shootBall[i]= false;
      displayBall[i] = true;
    }



    //determines the starting location of all 16 balls
    ballLocations[0] = new PVector(width/8+ width/4, height/2);
    ballLocations[1] = new PVector(width/8+ width/2, height/2);
    ballLocations[2] = new PVector(width/8 + width/2 + ballDiam+1, height/2+ ballRadius+1);
    ballLocations[3] = new PVector(width/8 + width/2 + ballDiam+1, height/2- ballRadius-1);
    ballLocations[4] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2);
    ballLocations[5] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2 + ballDiam+1);
    ballLocations[6] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2- ballDiam-1);
    ballLocations[7] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2+ ballRadius+1);
    ballLocations[8] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2- ballRadius-1);
    ballLocations[9] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2+ (3*ballRadius)+2);
    ballLocations[10] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2- (3*ballRadius)-2);
    ballLocations[11] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2);
    ballLocations[12] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2 + ballDiam+1);
    ballLocations[13] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2- ballDiam-1);
    ballLocations[14] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2 + (2*ballDiam)+2);
    ballLocations[15] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2- (2*ballDiam)-2);
  }

  //behavior
  void handleKeyPressed() {

    if (areThereBallsMoving == false) { 
      if (displayBall[0] == true) {

        PVector mouse = new PVector(mouseX-ballLocations[0].x, mouseY-ballLocations[0].y);

        dir[0] = mouse;
        thrust[0] = dir[0].copy();
        thrust[0].normalize();

        if (key == ' ') {//the thrust is set to zero here so the cue ball doesnt move as soon as the game is started
          thrust[0].mult(0);
        }

        if (key == '0') {//this allows the player to cheat and pickup the cue ball
          thrust[0].mult(0);
          cueBallInHand = true;
          displayBall[0] = false;
          cueBallPlaced = false;
        }

        if (key == 'r' || key == 'R') {//allows the player to reset the game by pressing the r key

          resetBalls();
          thrust[0].mult(0);
        }

        if (key == '1') {//these are all of the different strengths of shots the higher the number pressed the harder the shot will be
          thrust[0].mult(1);
        } else if (key == '2') {
          thrust[0].mult(2);
        } else if (key == '3') {
          thrust[0].mult(3);
        } else if (key == '4') {
          thrust[0].mult(4);
        } else if (key == '5') {
          thrust[0].mult(5);
        } else if (key == '6') {
          thrust[0].mult(6);
        } else if (key == '7') {
          thrust[0].mult(7);
        } else if (key == '8') {
          thrust[0].mult(8);
        } else if (key == '9') {
          thrust[0].mult(9);
        } else {
          thrust[0].mult(0);
        }

        ballAcceleration[0] = thrust[0];

        shootBall[0] = true;
      }
    }
  }

  void updateBalls() {
    for (int i=0; i<numberOfBalls; i++) {//loops through all the balls and moves them if the require moving

      if (shootBall[i] == true && displayBall[i] == true) {

        ballVelocity[i].add(ballAcceleration[i]);
        ballLocations[i].add(ballVelocity[i]);
        ballAcceleration[i].set(0, 0);
        ballVelocity[i].div(1.009);//friction to prevent the balls from rolling for an infinite amount of time

        if (abs(ballVelocity[i].x) <= 0.08 && abs(ballVelocity[i].y) <= 0.08) {
          shootBall[i] = false;
        }
      }
    }

    displayBalls();
  }

  void shotAiming() {//draws the purple dot on the screen to help the player aim their shot
    if (areThereBallsMoving == false && displayBall[0]== true) {

      if (showAimingLine == true) {

        fill(181, 18, 168);
        ellipse(mouseX, mouseY, ballDiam, ballDiam);
      }
    }
  }

  void bounceOffBall() {//collision detection between balls

    for (int a=0; a<numberOfBalls; a++) {
      for (int b=0; b<numberOfBalls; b++) {

        if (displayBall[a] == true && displayBall[b] == true) {
          if (a != b) {

            if (ballLocations[a].dist(ballLocations[b]) <= ballDiam) {//if the distance between two balls centers in less than the diameter of one ball they have made contact

              dir[b] = ballLocations[a].copy();

              if (ballLocations[a].x < ballLocations[b].x) {

                dir[b].x = dir[b].x * (-1);
              }

              if (ballLocations[a].y < ballLocations[b].y) {

                dir[b].y = dir[b].y *(-1);
              }

              thrust[b] = dir[b].copy();
              thrust[b].mult(.008);
              thrust[b] = thrust[b].mult(-0.2);
              thrust[b].normalize();

              ballAcceleration[b] = thrust[b];

              shootBall[b] = true;
              shootBall[a] = true;
            }
          }
        }
      }
    }
  }

  void bounceOffWall() {//collision between a ball and the side of the table
    for (int i=0; i<numberOfBalls; i++) {
      if (displayBall[i] == true) {
        if (ballLocations[i].y < height/4 + ballRadius) {//top of table
          ballVelocity[i].y = ballVelocity[i].y * -1;
        } else if (ballLocations[i].y > height - height/4 - ballRadius) {//bottom of table
          ballVelocity[i].y = ballVelocity[i].y * -1;
        } else if (ballLocations[i].x < width/4 + ballRadius) {//left side of table
          ballVelocity[i].x = ballVelocity[i].x * -1;
        } else if (ballLocations[i].x > width - width/4  - ballRadius) {//right side of table 
          ballVelocity[i].x = ballVelocity[i].x * -1;
        }
      }
    }
  }

  void displayBalls() {
    for (int i=0; i<ballLocations.length; i++) {
      if (displayBall[i] == true) {
        //colours some balls red 
        if (i% 2 == 0 || i == 15) {
          fill(255, 0, 0);
        } 
        //colours some balls blue
        else {
          fill(0, 0, 255);
        }
        //displays the blue and red balls
        ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);

        //displays the white cue ball
        if (i == 0) {
          fill(255);
          ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
        }

        //displays the black ball(8 ball)
        if (i == 4) {
          fill(0);
          ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
        }
      }
    }
  }

  void ballInPocket(PoolTable thePoolTable) {//detects if a ball has fallen into one of the six pockets
    for (int b=0; b<ballLocations.length; b++) {
      for (int p=0; p<thePoolTable.pocket.length; p++) {
        if (ballLocations[b].dist(thePoolTable.pocket[p]) <= thePoolTable.pocketSize/2) {
          displayBall[b] = false;
          shootBall[b] = false;
          
          ballLocations[b].set(0, 0);
          
           


          if (b == 4) {//if the black (8) ball goes into a pocket the game is able to be reset
            eightBallSunk = true;
          }
        }
      }
    }
  }

  void checkForMotion() {//makes sure there are no balls moving before the player can take another shot
    numberOfBallsMoving = 0;
    for (int i=0; i<shootBall.length; i++) {//loops through all the balls and counts the number that are still moving
      if (shootBall[i] == true) {
        numberOfBallsMoving = numberOfBallsMoving + 1;
      }
    }
    if (numberOfBallsMoving == 0) {//the balls have stopped moving
      areThereBallsMoving = false; 
      isTheCueBallInAPocket();
    } else {//if this happens balls must still be moving
      numberOfBallsMoving = 0;
      areThereBallsMoving = true;
    }
  }

  void isTheCueBallInAPocket() {//determines if the cue ball is still on te table
    if (displayBall[0] == false) {
      cueBallPlaced = false;
    }
    if (cueBallPlaced == false) {//if the cue ball is not on the table it is able to be put back on the table
      ballLocations[0].set(0, 0);
      fill(10, 70, 40);
      textAlign(CENTER);
      textSize(width/25);
      text("Click on the board to replace the cue ball", width/2, height/10);

      PVector newCueBall;
      int newCueBallTouching;
      boolean goodPlacement = false;

      newCueBall = new PVector(mouseX, mouseY);

      if (newCueBall.x > width/4 + ballRadius  && newCueBall.x < width - width/4 - ballRadius &&
        newCueBall.y > height/4 + ballRadius  && newCueBall.y < height - height/4 - ballRadius) {//prevents the player from placing the cue ball in an area not on the table
        newCueBallTouching = 0;
        for (int i=1; i<ballLocations.length; i++) {
          if (ballLocations[i].dist(newCueBall) <= ballDiam) {// prevents the player from placing the cue ball on top of another ball

            newCueBallTouching = newCueBallTouching + 1;
          }
        }
        if (newCueBallTouching == 0) {
          goodPlacement = true;
        } else {
          goodPlacement = false;
        }

        if (goodPlacement == true) {

          fill(255);
          if (mousePressed == true) {// if the ball is in an acceptable location and the mouse is clicked the ball will be set down
            ballLocations[0].set(newCueBall.copy());
            ballVelocity[0].set(0, 0);

            displayBall[0] = true;
            cueBallPlaced = true;
          }
        }
      } 

      if (goodPlacement == false) {
        fill(255, 0, 0);
      }

      ellipse(newCueBall.x, newCueBall.y, ballDiam, ballDiam);
    }
  }

  void resetBalls() {//this occurs when the player pressed the r button, it returns all balls to their starting positions

    ballLocations[0] = new PVector(width/8+ width/4, height/2);
    ballLocations[1] = new PVector(width/8+ width/2, height/2);
    ballLocations[2] = new PVector(width/8 + width/2 + ballDiam+1, height/2+ ballRadius+1);
    ballLocations[3] = new PVector(width/8 + width/2 + ballDiam+1, height/2- ballRadius-1);
    ballLocations[4] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2);
    ballLocations[5] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2 + ballDiam+1);
    ballLocations[6] = new PVector((width/8+ width/2 + (2* ballDiam)) + 1, height/2- ballDiam-1);
    ballLocations[7] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2+ ballRadius+1);
    ballLocations[8] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2- ballRadius-1);
    ballLocations[9] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2+ (3*ballRadius)+2);
    ballLocations[10] = new PVector(width/8 + width/2 + (3*ballDiam)+1, height/2- (3*ballRadius)-2);
    ballLocations[11] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2);
    ballLocations[12] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2 + ballDiam+1);
    ballLocations[13] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2- ballDiam-1);
    ballLocations[14] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2 + (2*ballDiam)+2);
    ballLocations[15] = new PVector((width/8+ width/2 + (4* ballDiam)) + 1, height/2- (2*ballDiam)-2);
    cueBallPlaced = true;
    eightBallSunk = false;

    for (int i=0; i<ballLocations.length; i++) {
      displayBall[i] = true;
      shootBall[i] = false;
    }
  }
}