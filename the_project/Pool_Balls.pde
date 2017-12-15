class PoolBall {

  int numberOfBalls = 10;

  float ballDiam = width/30;
  PVector ballLocations[], ballVelocity[], ballAcceleration[];

  PVector mouse;


  float tableWidth, tableHeight;
  float aimingX, aimingY;




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

    for (int i = 0; i< ballLocations.length; i++) {
      ballLocations[i] = new PVector(random(ballDiam, width - ballDiam ), 
        random(height/4 + ballDiam, height - height/4 - ballDiam));
    }
  }



  void updateBalls() {

    if (mousePressed == true) {

      for (int i=0; i<1; i++) {

        PVector mouse = new PVector(mouseX, mouseY);
        PVector dir = PVector.sub(mouse, ballLocations[i]);

        //dir.normalize();
        dir.mult(.1);
        ballAcceleration[i] = dir;


        ballVelocity[i].limit(5);

        println(ballVelocity[i]);
        println(ballAcceleration[i]);

        ballVelocity[i].add(ballAcceleration[i]);
        ballLocations[i].add(ballVelocity[i]);
        
        if (ballLocations[i] == mouse){   
          ballVelocity[i].x = 0;
          ballVelocity[i].y = 0;
        }
        
        }
    }
    displayBalls();
  }


  void shotAiming() {
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


  void displayBalls() {
    for (int i=1; i<ballLocations.length; i++) {
      fill(255, 255, 0);


      ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
    }

    fill(255);
    ellipse(ballLocations[0].x, ballLocations[0].y, ballDiam, ballDiam);
  }
}