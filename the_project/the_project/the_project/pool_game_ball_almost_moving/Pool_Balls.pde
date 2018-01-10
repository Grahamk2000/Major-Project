class PoolBall {
  //does this still work
  int numberOfBalls = 1;

  float ballDiam = width/50;
  float ballRadius = ballDiam/2;
  PVector ballLocations[], ballVelocity[], ballAcceleration[], thrust[];

  PVector mouse, targetLocation, dir;


  float tableWidth, tableHeight;
  float aimingX, aimingY;
  float clickedMouseX, clickedMouseY;
  boolean shootBall = false;
  int state[];
  boolean isRotatingNecessary = true;
  boolean showAimingLine = true;
  //float testingspeed = -50;



  PoolBall(int _tableWidth, int _tableHeight) {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];
    mouse = new PVector(mouseX, mouseY);
    dir = new PVector(1, 0);


    for (int i=0; i<ballVelocity.length; i++) {
      ballVelocity[i] = new PVector(0, 0);
    }

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;


    ballLocations[0] = new PVector(width/2, height/2);
    ballAcceleration[0] = new PVector(0, 0);
    ballVelocity[0] = new PVector(0, 0);
  }

  void handleMousePressed() {

    clickedMouseX = mouseX;
    clickedMouseY = mouseY;
  }

  void handleKeyPressed() {
    if (shootBall == false) {
      //clickedMouseX = mouseX;
      //clickedMouseY = mouseY;

      PVector mouse = new PVector(clickedMouseX-ballLocations[0].x, clickedMouseY-ballLocations[0].y);
      println(clickedMouseX, clickedMouseY);

      dir = mouse;
      float rotationAmount = PVector.angleBetween(dir, mouse);
      dir.rotate(rotationAmount);



      thrust = new PVector[numberOfBalls];
      thrust[0] = dir.copy();
      thrust[0].normalize();

      if (key == '1') {
        thrust[0].mult(2.5);
      } else if (key == '2') {
        thrust[0].mult(4);
      } else if (key == '3') {
        thrust[0].mult(5);
      } else if (key == '4') {
        thrust[0].mult(25);
      } else {
        thrust[0].mult(2.5);
      }




      ballAcceleration[0] = thrust[0];


      shootBall = true;
    }
  }


  void updateBalls() {

    if (shootBall == true) {
      ballLocations[0].add(ballVelocity[0]);
      ballVelocity[0].add(ballAcceleration[0]);
      ballAcceleration[0].set(0, 0);
      ballVelocity[0].div(1.01);
      //println(ballVelocity[0]);

      if (abs(ballVelocity[0].x) <= 0.08 && abs(ballVelocity[0].y) <= 0.08) {
        shootBall = false;
        println("done");
      }
    }

    displayBalls();
  }



  void shotAiming() {
    if (showAimingLine == true) {
      if (mouseY < height/4) {
        aimingY = height/4;
        aimingX = mouseX;
      } else if (mouseY > height/4 + tableHeight) {
        aimingY = int( height/4 +  tableHeight);
        aimingX = mouseX;
      } else {
        aimingX = mouseX;
        aimingY = mouseY;
      }

      line(aimingX, aimingY, ballLocations[0].x, ballLocations[0].y);
      fill(255, 0, 0);

      ellipse(clickedMouseX, clickedMouseY, ballDiam/2, ballDiam/2);
    }
  }

  void bounceBalls() {
    for (int a=0; a<numberOfBalls; a++) {
      for (int b=0; b<numberOfBalls; b++) {
      }
    }
  }

  void bounceOffWall() {
    for (int i=0; i<numberOfBalls; i++) {
      if (ballLocations[i].y < height/4 + ballRadius) {//top of table
        println("bounce");
        ballVelocity[0].y = ballVelocity[0].y * -1;
      } 
      else if (ballLocations[i].y > height - height/4 - ballRadius) {//bottom of table
        println("bounce");
        ballVelocity[0].y = ballVelocity[0].y * -1;
      } 
      else if (ballLocations[i].x < width/4 + ballRadius) {//left side of table
        println("bounce");
        ballVelocity[0].x = ballVelocity[0].x * -1;
      }
      else if (ballLocations[i].x > width - width/4  - ballRadius) {//left side of table 
        println("bounce");
        ballVelocity[0].x = ballVelocity[0].x * -1;
      }
      
    }
  }

  void displayBalls() {
    for (int i=1; i<ballLocations.length; i++) {
      fill(255, 255, 0);


      ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
    }

    fill(255);
    ellipse(ballLocations[0].x, ballLocations[0].y, ballDiam, ballDiam);
  }

  void ballInPocket() {
    //for (int i=1; i<ballLocations.length; i++) {
    //  if (ballLocations[i].dist()){
    //  }
  }
}