class PoolBall {
  //does this still work
  int numberOfBalls = 1;

  float ballDiam = width/50;
  PVector ballLocations[], ballVelocity[], ballAcceleration[], thrust[];

  PVector mouse, targetLocation, dir;


  float tableWidth, tableHeight;
  float aimingX, aimingY;
  float clickedMouseX, clickedMouseY;
  boolean shootBall = false;
  int state[];
  boolean isRotatingNecessary = true;
  //float testingspeed = -50;



  PoolBall(int _tableWidth, int _tableHeight) {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];
    mouse = new PVector(mouseX, mouseY);
    dir = new PVector(0.0000000000000000001, 0.0000000000000000001);


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

    PVector mouse = new PVector(mouseX-ballLocations[0].x, mouseY-ballLocations[0].y);
    float rotationAmount = PVector.angleBetween(dir, mouse);
    dir.rotate(rotationAmount);
  }

  void handleKeyPressed() {
    if (shootBall == false) {
      dir = mouse;

      thrust = new PVector[numberOfBalls];
      thrust[0] = dir.copy();
      thrust[0].normalize();
      thrust[0].mult(2.5);
      ballAcceleration[0] = thrust[0];


      shootBall = true;
    }
  }


  void updateBalls() {
    if (mousePressed == true && shootBall == false) {

      clickedMouseX = mouseX;
      clickedMouseY = mouseY;
    }

    fill(255, 0, 0);
    //targetLocation = new PVector(clickedMouseX, clickedMouseY);
    ellipse(clickedMouseX, clickedMouseY, ballDiam/2, ballDiam/2);


    if (shootBall == true) {
      ballLocations[0].add(ballVelocity[0]);
      ballVelocity[0].add(ballAcceleration[0]);
      ballAcceleration[0].set(0, 0);
      ballVelocity[0].div(1.01);
      println(ballVelocity[0]);
      if (abs(ballVelocity[0].x) <= 0.08 && abs(ballVelocity[0].y) <= 0.08) {
        shootBall = false;
      }
    }

    displayBalls();
  }



  void shotAiming() {
    if (shootBall == false) {
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
    }
  }

  void bounceBalls() {
  }

  void bounceOffWall() {
    for (int i=0; i<numberOfBalls; i++) {
      if (ballLocations[i].y < height/4) {
        mouse.y *= -1;
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