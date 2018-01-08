class PoolBall {
  //does this still work
  int numberOfBalls = 1;

  float ballDiam = width/50;
  PVector ballLocations[], ballVelocity[], ballAcceleration[];

  PVector mouse, targetLocation;


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


    for (int i=0; i<ballVelocity.length; i++) {
      ballVelocity[i] = new PVector(0, 0);
    }

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;

    //for (int i = 0; i< ballLocations.length; i++) {
    //ballLocations[i] = new PVector(random(width/4 + ballDiam, (width - width/4) - ballDiam ),     randm starting location for testing
    //    random(height/4 + ballDiam, height - height/4 - ballDiam));
    //}
    ballLocations[0] = new PVector(width/2, height/2);
  }

  void handleKeyPressed() {
    //if (key ==  '1') { 

    //  ballVelocity[0] = new PVector(0, -1);
    //} 
    //else if (key ==  '2') { 

    //  ballVelocity[0] = new PVector(0, -2);
    //} 
    //else if (key ==  '3') { 

    //  ballVelocity[0] = new PVector(0,-8);
    //}
    //else {
    //  ballVelocity[0] = new PVector(0 , -1.5);
    //}



    shootBall = true;
  }



  void updateBalls() {
    if (mousePressed == true && shootBall == false) {

      clickedMouseX = mouseX;
      clickedMouseY = mouseY;


    }

    fill(255, 0, 0);
    //targetLocation = new PVector(clickedMouseX, clickedMouseY);
    ellipse(clickedMouseX, clickedMouseY, ballDiam/2, ballDiam/2);


    if (shootBall == true)  {



      //bounceBalls();
      for (int i=0; i<numberOfBalls; i++) {
        if (i == 0) {
          PVector mouse = new PVector(clickedMouseX, clickedMouseY);
          PVector dir = PVector.sub(mouse, ballLocations[i]);

          ballVelocity[0] = new PVector(clickedMouseX, clickedMouseY);
          if (isRotatingNecessary == true){
            ballVelocity[0].rotate(angleBetween(ballLocations[0], mouse));
            println(ballVelocity[0]);
            println("rotated");
            isRotatingNecessary = false;
          }
                        
                        if (abs(ballVelocity[0].x) <= 0.1 && abs(ballVelocity[0].y) <= 0.1){
                         shootBall = false; 
                         println("done");
                        }
                       ballVelocity[0].normalize();
            ballVelocity[0].div(1.0001);
            ballLocations[0].add(ballVelocity[0]);
            
            //println(ballLocations[0]);




//          pushMatrix();
//          //if (isRotatingNecessary == true){
          
          
          
//          //isRotatingNecessary = false;
//          //}

//          translate(ballLocations[0].x, ballLocations[0].y);
          
//          println(dir.heading());
//          rotate(dir.heading());

//          //fill(255, 0, 0);
//          //ellipse(50, 20, 60, 60);
//          if (abs(ballVelocity[0].y) > 0.1 ) {
            //ballVelocity[0].rotate(dir.heading());

            //ballLocations[0].add(ballVelocity[0]);
            //ballVelocity[0].mult(0.97);
            //println(ballVelocity[0]);
            //println(ballLocations[0]);

//            //ballLocations[0] = ballLocations[0].add(0, testingspeed);
//            //testingspeed = testingspeed * 0.9;
//          }

//          if (abs(ballVelocity[0].y) <= 0.1 ) {
//            shootBall = false;
//            isRotatingNecessary = true;
//          }
//          popMatrix();











          //          println(targetLocation);
          //          println();
          //          println(ballLocations[0]);

          //          if (targetLocation.dist( ballLocations[0]) <= 0.1) {
          //            shootBall = false;
          //          }


          //          if (key ==  '1') { 
          //            dir.mult(.07);
          //          } else if (key ==  '2') { 
          //            dir.mult(.15);
          //          } else if (key ==  '3') { 
          //            dir.mult(.25);
          //          } else {
          //            dir.mult(0.1);
          //          }


          //          ballLocations[i].add(dir);

          //          if ((ballLocations[i].x == clickedMouseX) &&  (ballLocations[i].y == clickedMouseY)) {   
          //            dir.mult(0);
          //            shootBall = false;
          //          }
        }
      }
    }
    //    //bounceOffWall();

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