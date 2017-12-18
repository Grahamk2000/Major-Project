class PoolBall {

  int numberOfBalls = 1;

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

    if (keyPressed == true) {
      if (key ==  '1'){
        
          //bounceBalls();
      for (int i=0; i<numberOfBalls; i++) {
        if (i == 0) {
          PVector mouse = new PVector(mouseX, mouseY);
          PVector dir = PVector.sub(mouse, ballLocations[i]);

          //dir.normalize();
          dir.mult(.1);
          ballAcceleration[i] = dir;
          ballVelocity[i].limit(5);
          ballVelocity[i].add(ballAcceleration[i]);
          ballLocations[i].add(ballVelocity[i]);

          if (ballLocations[i] == mouse) {   
            ballVelocity[i].x = 0;
            ballVelocity[i].y = 0;
          }
        }
        }
      }
    }
    //bounceOffWall();

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

  void bounceBalls() {
    for (int a=0; a<numberOfBalls; a++) {
      for (int b=0; b<numberOfBalls; b++) {
        if (a != b) {
          float distanceBetweenBalls = PVector.dist(ballLocations[a], ballLocations[b]); 
          if (distanceBetweenBalls < ballDiam) {

            ballLocations[a].x = ballLocations[b].y ; 
            ballLocations[a].y = ballLocations[b].x ;

            PVector dir = PVector.sub(ballLocations[a], ballLocations[b]);

//            dir.normalize();



            dir.mult(.1);
            ballAcceleration[b]  = dir;
            ballVelocity[b].limit(5);
            ballVelocity[b].add(ballAcceleration[b]);
            ballLocations[b].add(ballVelocity[b]);
          }
        }
      }
    }
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
}