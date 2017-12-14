class PoolBall {

  int numberOfBalls = 10;

  float ballDiam = width/30;
  PVector ballLocations[], ballVelocity[], ballAcceleration[];


  float tableWidth, tableHeight;




  PoolBall(int _tableWidth, int _tableHeight) {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];


    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;

    for (int i = 0; i< ballLocations.length; i++) {
      ballLocations[i] = new PVector(random(ballDiam, width - ballDiam ), 
        random(height/4 + ballDiam, height - height/4 - ballDiam));
    }
  }



  void updateBalls() {

    if (mousePressed == true) {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector dir = PVector.sub(mouse, ballLocations);
      
      
      
      
      
      
    }









    displayBalls();
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