class PoolTable{
  
  float tableWidth, tableHeight, pocketSize;
  
  PoolTable(int _tableWidth, int _tableHeight) {
 
    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;
    pocketSize = width/20;
    
  }
  
  void display(){
     fill(#415F20);
     rect(width/4 , height/4, tableWidth, tableHeight);
     
     //pockets
     fill(0);
     ellipse(width/2, height/4, pocketSize, pocketSize); // top Middle
     
     ellipse(width/4, height/4, pocketSize, pocketSize);//top Left
     
     ellipse(width - width/4, height/4, pocketSize, pocketSize);
     
     ellipse(width/2, height/4 + tableHeight, pocketSize, pocketSize);
     
     ellipse(width/4, height/4 + tableHeight, pocketSize, pocketSize);
     
     ellipse(width - width/4, height/4 + tableHeight,pocketSize, pocketSize);
    
  }
  
  
}