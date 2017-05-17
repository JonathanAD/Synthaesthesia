class BrassGFX {
  float BrX ;
  float BrY ;
  float BrZ ;
  float BrW ;
  float BrH ;
  float BrD ;
  float BrHu;
  float BrS ;
  float BrB ;
  float BrA ;
  PImage BrT ;
  
  BrassGFX (float BrassX, float BrassY, float BrassZ, float BrassWidth, float BrassHeight, float BrassDepth, float BrassHue, float BrassSaturation, float BrassBrightness, float BrassAlpha, PImage BrassTexture) {
    BrX  = BrassX;
    BrY  = BrassY;
    BrZ  = BrassZ;
    BrW  = BrassWidth;
    BrH  = BrassHeight;
    BrD  = BrassDepth;
    BrHu = BrassHue;
    BrS  = BrassSaturation;
    BrB  = BrassBrightness;
    BrA  = BrassAlpha;
    BrT  = BrassTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, BrA); 
  translate(BrX, BrY, BrZ);
  beginShape();
    texture(BrT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-BrX, -BrY, -BrZ);
  blendMode(BLEND);
  }
}
