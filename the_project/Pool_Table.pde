class PoolTable{
  
  float tableWidth, tableHeight;
  
  PoolTable(int _tableWidth, int _tableHeight) {
 
    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;
    
  }
  
  void display(){
     fill(#415F20);
     rect(0, height/4, tableWidth, tableHeight);
    
  }
  
  
}