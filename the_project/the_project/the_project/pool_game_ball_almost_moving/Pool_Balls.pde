class PoolBall {
  //does this still work


  //save test
  int numberOfBalls = 16;

  float ballDiam = width/60;
  float ballRadius = ballDiam/2;
  PVector ballLocations[], ballVelocity[], ballAcceleration[], thrust[], dir[];
  //PVector newCueBall;

  //PVector mouse, targetLocation;


  float tableWidth, tableHeight;
  float aimingX, aimingY;
  float clickedMouseX, clickedMouseY;
  boolean shootBall[];
  int state[];
  //boolean isRotatingNecessary = true;
  boolean showAimingLine = true;
  //boolean bounceBall[] ;
  //float rotation[];
  boolean displayBall[];
  boolean areThereBallsMoving = false;
  boolean cueBallPlaced = true;
  int numberOfBallsMoving;



  PoolBall(int _tableWidth, int _tableHeight) {

    ballLocations = new PVector[numberOfBalls];
    ballVelocity = new PVector[numberOfBalls];
    ballAcceleration = new PVector[numberOfBalls];
    //mouse = new PVector(mouseX, mouseY);
    dir = new PVector[numberOfBalls];
    thrust = new PVector[numberOfBalls];
    shootBall = new boolean[numberOfBalls];
    //bounceBall= new boolean[numberOfBalls] ;
    //rotation= new float[numberOfBalls];
    displayBall = new boolean[numberOfBalls];



    for (int i=0; i<numberOfBalls; i++) {
      ballVelocity[i] = new PVector(0, 0);
      ballAcceleration[i] = new PVector(0, 0);
      dir[i] = new PVector(0.01, 0.01);
      shootBall[i]= false;
      displayBall[i] = true;
    }

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;


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

    //ballAcceleration[0] = new PVector(0, 0);
    //ballVelocity[0] = new PVector(0, 0);
  }

  void handleMousePressed() {

    clickedMouseX = mouseX;
    clickedMouseY = mouseY;
  }

  void handleKeyPressed() {
    if (areThereBallsMoving == false) {    

      for (int i=0; i<numberOfBalls; i++) {


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
          thrust[0].mult(2);
        } else if (key == '2') {
          thrust[0].mult(3);
        } else if (key == '3') {
          thrust[0].mult(4);
        } else if (key == '4') {
          thrust[0].mult(7);
        } 

        if (key == '5') {
          thrust[0].mult(9);
        } else {
          thrust[0].mult(1.5);
        }




        ballAcceleration[0] = thrust[0];


        shootBall[0] = true;
      }
    }
  }


  void updateBalls() {
    for (int i=0; i<numberOfBalls; i++) {


      if (shootBall[i] == true && displayBall[i] == true) {
        //println("the velocity is" + ballVelocity[0]);

        ballVelocity[i].add(ballAcceleration[i]);

        ballLocations[i].add(ballVelocity[i]);

        ballAcceleration[i].set(0, 0);
        ballVelocity[i].div(1.008);
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
    if (areThereBallsMoving == false && cueBallPlaced == true) {

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
        fill(181, 18, 168);

        ellipse(clickedMouseX, clickedMouseY, ballDiam, ballDiam);
        fill(181, 18, 168);
        ellipse(mouseX, mouseY, ballDiam, ballDiam);
      }
    }
  }

  void bounceOffBall() {

    for (int a=0; a<numberOfBalls; a++) {
      for (int b=0; b<numberOfBalls; b++) {
        //int a = 0;
        //if (a == true && b == true){
        if (displayBall[a] == true && displayBall[b] == true) {
          if (a != b) {





            if (ballLocations[a].dist(ballLocations[b]) <= ballDiam) {
              println("bounce needed");





              dir[b] = ballLocations[a].copy();

              if (ballLocations[a].x < ballLocations[b].x) {

                dir[b].x = dir[b].x * (-1);
              }

              if (ballLocations[a].y < ballLocations[b].y) {

                dir[b].y = dir[b].y *(-1);
              }
              println("this happened");






              thrust[b] = dir[b].copy();

              thrust[b].mult(.01);


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


  void bounceOffWall() {
    for (int i=0; i<numberOfBalls; i++) {
      if (displayBall[i] == true) {
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
  }

  void displayBalls() {
    for (int i=0; i<ballLocations.length; i++) {
      if (displayBall[i] == true) {

        if (i% 2 == 0) {
          fill(255, 0, 0);
        } else {
          fill(0, 0, 255);
        }


        ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);

        if (i == 0) {
          fill(255);
          ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
        }
        if (i == 4) {
          fill(0);
          ellipse(ballLocations[i].x, ballLocations[i].y, ballDiam, ballDiam);
        }
      }
    }
  }
  void ballInPocket(PoolTable thePoolTable) {
    for (int b=0; b<ballLocations.length; b++) {
      for (int p=0; p<thePoolTable.pocket.length; p++) {
        if (ballLocations[b].dist(thePoolTable.pocket[p]) <= thePoolTable.pocketSize/2) {
          displayBall[b] = false;
          shootBall[b] = false;
        }
      }
    }
  }

  void checkForMotion() {
    numberOfBallsMoving = 0;
    for (int i=0; i<shootBall.length; i++) {
      if (shootBall[i] == true) {
        //println(shootBall[i]);
        numberOfBallsMoving = numberOfBallsMoving + 1;
      }
    }
    if (numberOfBallsMoving == 0) {
      areThereBallsMoving = false; 
      isTheCueBallInAPocket();
      println("this happened");
    } else {
      numberOfBallsMoving = 0;
      areThereBallsMoving = true;

      println("moving");
    }
  }

  void isTheCueBallInAPocket() {
    if (displayBall[0] == false) {
      cueBallPlaced = false;
    }
    if (cueBallPlaced == false) {
      textAlign(CENTER);
      text("click on the board to replace the cue ball", width/2, height/10);

      PVector newCueBall;
      int newCueBallTouching;
      boolean goodPlacement = false;

      newCueBall = new PVector();
      newCueBall.x = mouseX;
      newCueBall.y = mouseY;

      //constrain(newCueBallX, width/4, width- width/4);
      //constrain(newCueBallY, height/4, height- height/4);




      if (newCueBall.x > width/4 + ballRadius  && newCueBall.x < width - width/4 - ballRadius &&
        newCueBall.y > height/4 + ballRadius  && newCueBall.y < height - height/4 - ballRadius) {
        newCueBallTouching = 0;
        for (int i=0; i<ballLocations.length; i++) {
          if (ballLocations[i].dist(newCueBall) <= ballDiam) {
            
            
            newCueBallTouching = newCueBallTouching + 1;
            println("touch");
          }
        }
        if(newCueBallTouching == 0){
          goodPlacement = true;
          println("i hope i see this");
          
          
        }
        
        else{
         goodPlacement = false; 
          
        }
        
        
        if(goodPlacement == true){
          
          
          fill(255);
          if (mousePressed == true){
            ballLocations[0] = (newCueBall);
            displayBall[0] = true;
            cueBallPlaced = true;
            
          }
          
          
        }
        

        
      } 
      
      if (goodPlacement == false){
        fill(255, 0, 0);
      }

      ellipse(newCueBall.x, newCueBall.y, ballDiam, ballDiam);
    }
  }
}