class PoolBall {
  float ballDiam = width/30;

  ArrayList<Point> ballLocations = new ArrayList<Point>();
  float tableWidth, tableHeight;

  PoolBall(int _tableWidth, int _tableHeight) {

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;

    //for (int i = 0; i< 5; i++) {
    //  for (int d = 0; d < 100; d += ballDiam) {
    fill(0);
    ballLocations.add( new Point(tableWidth/10, tableHeight ) );
    ballLocations.add( new Point(tableWidth/2, tableHeight ) );
    //}
    //}
  }



  void updateBalls() {


    if (mousePressed == true) {


    }


    displayBalls();
  }

  void displayBalls() {
    for (int i=1; i<ballLocations.size(); i++) {


      fill(255, 255, 0);
      ellipse(ballLocations.get(i).x, ballLocations.get(i).y, ballDiam, ballDiam);
    }
    fill(255);
    ellipse(ballLocations.get(0).x, ballLocations.get(0).y, ballDiam, ballDiam);
  }
}