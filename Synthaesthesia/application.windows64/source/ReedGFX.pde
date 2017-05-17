class ReedGFX {
  float RX ;
  float RY ;
  float RZ ;
  float RW ;
  float RH ;
  float RD ;
  float RHu;
  float RS ;
  float RB ;
  float RA ;
  PImage RT ;
  
  ReedGFX (float ReedX, float ReedY, float ReedZ, float ReedWidth, float ReedHeight, float ReedDepth, float ReedHue, float ReedSaturation, float ReedBrightness, float ReedAlpha, PImage ReedTexture) {
    RX  = ReedX;
    RY  = ReedY;
    RZ  = ReedZ;
    RW  = ReedWidth;
    RH  = ReedHeight;
    RD  = ReedDepth;
    RHu = ReedHue;
    RS  = ReedSaturation;
    RB  = ReedBrightness;
    RA  = ReedAlpha;
    RT  = ReedTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, RA); 
  translate(RX, RY, RZ);
  beginShape();
    texture(RT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-RX, -RY, -RZ);
  blendMode(BLEND);
  }
}
