class PercussiveGFX {
  float PeX ;
  float PeY ;
  float PeZ ;
  float PeW ;
  float PeH ;
  float PeD ;
  float PeHu;
  float PeS ;
  float PeB ;
  float PeA ;
  PImage PeT ;
  
  PercussiveGFX (float PercussiveX, float PercussiveY, float PercussiveZ, float PercussiveWidth, float PercussiveHeight, float PercussiveDepth, float PercussiveHue, float PercussiveSaturation, float PercussiveBrightness, float PercussiveAlpha, PImage PercussiveTexture) {
    PeX  = PercussiveX;
    PeY  = PercussiveY;
    PeZ  = PercussiveZ;
    PeW  = PercussiveWidth;
    PeH  = PercussiveHeight;
    PeD  = PercussiveDepth;
    PeHu = PercussiveHue;
    PeS  = PercussiveSaturation;
    PeB  = PercussiveBrightness;
    PeA  = PercussiveAlpha;
    PeT  = PercussiveTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, PeA); 
  translate(PeX, PeY, PeZ);
  beginShape();
    texture(PeT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PeX, -PeY, -PeZ);
  blendMode(BLEND);
  }
}
