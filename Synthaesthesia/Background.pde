class Background {
  float BX ;
  float BY ;
  float BZ ;
  float BW ;
  float BH ;
  float BD ;
  float BHu;
  float BS ;
  float BB ;
  float BA ;
  
  Background (float BackgroundX, float BackgroundY, float BackgroundZ, float BackgroundWidth, float BackgroundHeight, float BackgroundDepth, float BackgroundHue, float BackgroundSaturation, float BackgroundBrightness, float BackgroundAlpha) {
    BX  = BackgroundX;
    BY  = BackgroundY;
    BZ  = BackgroundZ;
    BW  = BackgroundWidth;
    BH  = BackgroundHeight;
    BD  = BackgroundDepth;
    BHu = BackgroundHue;
    BS  = BackgroundSaturation;
    BB  = BackgroundBrightness;
    BA  = BackgroundAlpha;
  }
  
  void display() {
    strokeWeight(2);
    stroke(127);
    noFill();
    translate(width/2,height/2,-250);
    box(BX,BY,BZ);
  }
  
  void fadeOut() {
    noStroke();
    colorMode(HSB, 255, 100, 100, 150);
    fill(BHu, BS, BB, BA);
    rectMode(CENTER);
    rect(0, 0, BX*2, BY*2);
  }
  
  void gray() {
    background(127);           // Black Background
}
  void black() {
    background(0);           // Black Background
  }
}



