class PoolTable {
  
//variable setup
  float tableWidth, tableHeight, pocketSize;
  PVector pocket[];

//constructor
  PoolTable(int _tableWidth, int _tableHeight) {

    tableWidth =  _tableWidth;
    tableHeight = _tableHeight;
    pocketSize = width/20;
    pocket = new PVector[6];
    // order of pockets 0  1  2
    //                  3  4  5
  }

  void display() {
    //draws the table
    noStroke();
    fill(60);
    rect(width/4 - pocketSize/2, height/4 - pocketSize/2, tableWidth + pocketSize, tableHeight + pocketSize);
    fill(#415F20);
    rect(width/4, height/4, tableWidth, tableHeight);

    //below are the 6 pockets on the edges o the pool table
    fill(0);

    pocket[0] = new PVector(width/4, height/4);
    ellipse(width/4, height/4, pocketSize, pocketSize);//top Left

    pocket[1] = new PVector(width/2, height/4);
    ellipse(width/2, height/4, pocketSize, pocketSize); // top Middle

    pocket[2] = new PVector(width - width/4, height/4);
    ellipse(width - width/4, height/4, pocketSize, pocketSize);

    pocket[3] = new PVector(width/4, height/4 + tableHeight);
    ellipse(width/4, height/4 + tableHeight, pocketSize, pocketSize);

    pocket[4] = new PVector(width/2, height/4 + tableHeight);
    ellipse(width/2, height/4 + tableHeight, pocketSize, pocketSize);

    pocket[5] = new PVector(width - width/4, height/4 + tableHeight);
    ellipse(width - width/4, height/4 + tableHeight, pocketSize, pocketSize);
  }
}