class PoolBall {
  //does this still work
  int numberOfBalls = 3;

  float ballDiam = width/50;
  float ballRadius = ballDiam/2;
  PVector ballLocations[], ballVelocity[], ballAcceleration[], thrust[], dir[];

  PVector mouse, targetLocation;


  float tableWidth, tableHeight;
  float aimingX, aimingY;
  float clickedMouseX, clickedMouseY;
  boolean shootBall[];
  int state[];
  boolean isRotatingNecessary = true;
  boolean showAimingLine = true;
  boolean bounceBall[] ;
  float rotation[];
  //float testingspeed = -50;



  PoolBall(int _tableWidth, int _tableHeight) {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];
    mouse = new PVector(mouseX, mouseY);
    dir = new PVector[numberOfBalls];
    thrust = new PVector[numberOfBalls];
    shootBall = new boolean[numberOfBalls];
    bounceBall= new boolean[numberOfBalls] ;
    rotation= new float[numberOfBalls];



    for (int i=0; i<numberOfBalls; i++) {
      ballVelocity[i] = new PVector(0, 0);
      ballAcceleration[i] = new PVector(0, 0);
      dir[i] = new PVector(1, 1);
      shootBall[i]= false;
    }

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;


    ballLocations[0] = new PVector(width/2, height/2);
    ballLocations[1] = new PVector(width/3, height/2);
    ballLocations[2] = new PVector(2*(width/3) , height/3);
    //ballAcceleration[0] = new PVector(0, 0);
    //ballVelocity[0] = new PVector(0, 0);
  }

  void handleMousePressed() {

    clickedMouseX = mouseX;
    clickedMouseY = mouseY;
  }

  void handleKeyPressed() {
    for (int i=0; i<numberOfBalls; i++) {
      if (shootBall[0] == false) {

        //clickedMouseX = mouseX;
        //clickedMouseY = mouseY;

        PVector mouse = new PVector(clickedMouseX-ballLocations[0].x, clickedMouseY-ballLocations[0].y);
        println(clickedMouseX, clickedMouseY);

        dir[0] = mouse;
        //float rotationAmount = PVector.angleBetween(dir[0], mouse);
        //dir[0].rotate(rotationAmount);



        //thrust = new PVector[numberOfBalls];
        thrust[0] = dir[0].copy();
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


        shootBall[0] = true;
      }
    }
  }


  void updateBalls() {
    for (int i=0; i<numberOfBalls; i++) {


      if (shootBall[i] == true) {
        //println("the velocity is" + ballVelocity[0]);

        ballVelocity[i].add(ballAcceleration[i]);

        ballLocations[i].add(ballVelocity[i]);

        ballAcceleration[i].set(0, 0);
        ballVelocity[i].div(1.01);
        //println(ballVelocity[0]);

        if (abs(ballVelocity[i].x) <= 0.08 && abs(ballVelocity[i].y) <= 0.08) {
          shootBall[i] = false;
          println("done");
        }
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

  void bounceOffBall() {

    //for (int a=0; a<numberOfBalls; a++) {
    for (int b=0; b<numberOfBalls; b++) {
      int a = 0;
      if (a != b) {

        if (shootBall[0] == true) {
          if (ballLocations[0].dist(ballLocations[b]) <= ballDiam) {
            println("bounce needed");
            shootBall[0] = false;



            //            //pushMatrix();
            //            translate(ballLocations[0].x, ballLocations[0].y);
            //            rotation[b] =  degrees(atan2(ballLocations[b].x, ballLocations[b].y));

            //            println("rotation" + rotation[b]);
            dir[b] = ballLocations[0].copy();

            if (ballLocations[0].x < ballLocations[b].x) {

              dir[b].x = dir[b].x * (-1);
            }

            if (ballLocations[0].y < ballLocations[b].y) {

              dir[b].y = dir[b].y *(-1);
            }
            println("this happened");
            //            dir[b].rotate(rotation[b]);
            //            //popMatrix();





            thrust[b] = dir[b].copy();
            thrust[b] = thrust[b].mult(-1);
            thrust[b].normalize();

            ballAcceleration[b] = thrust[b];

            shootBall[b] = true;
            shootBall[0] = false;
            ballVelocity[0] = ballVelocity[0].mult(0);
          }
          //ballVelocity[b] = ballVelocity[b];

          //ballLocations[b].add(ballVelocity[b]);
          //ballVelocity[b].add(ballAcceleration[b]);
          //ballAcceleration[b].set(0, 0);
          //ballVelocity[b].div(1.01);
          //println(ballVelocity[0]);

          //if (abs(ballVelocity[b].x) <= 0.08 && abs(ballVelocity[b].y) <= 0.08) {
          //  shootBall[b] = false;
          //  println("done");
          //}
        }
      }
    }
  }

  void bounceOffWall() {
    for (int i=0; i<numberOfBalls; i++) {
      if (ballLocations[i].y < height/4 + ballRadius) {//top of table
        println("bounce");
        ballVelocity[i].y = ballVelocity[i].y * -1;
      } else if (ballLocations[i].y > height - height/4 - ballRadius) {//bottom of table
        println("bounce");
        ballVelocity[i].y = ballVelocity[i].y * -1;
      } else if (ballLocations[i].x < width/4 + ballRadius) {//left side of table
        println("bounce");
        ballVelocity[i].x = ballVelocity[i].x * -1;
      } else if (ballLocations[i].x > width - width/4  - ballRadius) {//left side of table 
        println("bounce");
        ballVelocity[i].x = ballVelocity[i].x * -1;
      }
    }
  }

  void displayBalls() {
    for (int i=0; i<ballLocations.length; i++) {
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