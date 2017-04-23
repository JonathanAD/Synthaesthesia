class BassGFX {
  float  BX ;
  float  BY ;
  float  BZ ;
  float  BW ;
  float  BH ;
  float  BD ;
  float  BHu;
  float  BS ;
  float  BB ;
  float  BA ;
  PImage BT ;
  
  BassGFX (float BassX, float BassY, float BassZ, float BassWidth, float BassHeight, float BassDepth, float BassHue, float BassSaturation, float BassBrightness, float BassAlpha, PImage BassTexture) {
    BX  = BassX;
    BY  = BassY;
    BZ  = BassZ;
    BW  = BassWidth;
    BH  = BassHeight;
    BD  = BassDepth;
    BHu = BassHue;
    BS  = BassSaturation;
    BB  = BassBrightness;
    BA  = BassAlpha;
    BT  = BassTexture; 
  }
  void display() {
  
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, BA);  
  translate(BX, BY, BZ);
  beginShape();
    texture(BT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-BX, -BY, -BZ);
  blendMode(BLEND);
  }
}
