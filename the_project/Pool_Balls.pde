class PoolBall{
  float ballDiam = width/30;
  
  ArrayList<Point> ballLocations = new ArrayList<Point>();
  float tableWidth, tableHeight;
  
    PoolBall(int _tableWidth, int _tableHeight) {
 
    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;
    
  }
  
  
  
  void updateBalls(){
    
     for(int i = 0; i< 5; i++){
       for(int d = 0; d < 100; d += ballDiam){
         fill(0);
        ballLocations.add( new Point(tableWidth/2 + d, tableHeight/2 + d) );
       }
     }
    
  }
 
  void dispayBalls(){
    for (int i=0; i<ballLocations.size(); i++) {
    
      ellipse(ballLocations.get(i).x, ballLocations.get(i).y, ballDiam, ballDiam);
    }
    
  }
  
  
  
}