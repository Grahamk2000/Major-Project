class PoolTable{
  
  float tableWidth, tableHeight;
  
  PoolTable(int _tableWidth, int _tableHeight) {
 
    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;
    
  }
  
  void display(){
     fill(#415F20);
     rect(0, height/4, tableWidth, tableHeight);
     
     //pockets
     fill(0);
     ellipse(width/2, height/4, width/15, width/15);
     ellipse(0, height/4, width/15, width/15);
     ellipse(width, height/4, width/15, width/15);
     ellipse(width/2, height/4 + tableHeight, width/15, width/15);
     ellipse(0, height/4 + tableHeight, width/15, width/15);
     ellipse(width, height/4 + tableHeight, width/15, width/15);
    
  }
  
  
}