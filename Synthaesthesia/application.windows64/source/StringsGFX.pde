class StringsGFX {
  float  SX ;
  float  SY ;
  float  SZ ;
  float  SW ;
  float  SH ;
  float  SD ;
  float  SHu;
  float  SS ;
  float  SB ;
  float  SA ;
  PImage ST ;

  StringsGFX (float StringsX, float StringsY, float StringsZ, float StringsWidth, float StringsHeight, float StringsDepth, float StringsHue, float StringsSaturation, float StringsBrightness, float StringsAlpha, PImage StringsTexture) {
    SX  = StringsX;
    SY  = StringsY;
    SZ  = StringsZ;
    SW  = StringsWidth;
    SH  = StringsHeight;
    SD  = StringsDepth;
    SHu = StringsHue;
    SS  = StringsSaturation;
    SB  = StringsBrightness;
    SA  = StringsAlpha;
    ST  = StringsTexture;

  }
  void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, SA); 
  translate(SX, 360, SZ+SA*DepthRate);
  beginShape();
    texture(ST);
    vertex(-256*SW, -512*SH, 0, 0,     0);
    vertex( 256*SW, -512*SH, 0, 512,   0);
    vertex( 256*SW,  512*SH, 0, 512, 512);
    vertex(-256*SW,  512*SH, 0, 0,   512);
  endShape();
  translate(-SX, -360, -SZ-SA*DepthRate);
  blendMode(BLEND);
  }
}

