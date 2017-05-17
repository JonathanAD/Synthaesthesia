class PercussionGFX {
  float PerX ;
  float PerY ;
  float PerZ ;
  float PerW ;
  float PerH ;
  float PerD ;
  float PerHu;
  float PerS ;
  float PerB ;
  float PerA ;
  PImage PerT ;
  
  PercussionGFX (float PercussionX, float PercussionY, float PercussionZ, float PercussionWidth, float PercussionHeight, float PercussionDepth, float PercussionHue, float PercussionSaturation, float PercussionBrightness, float PercussionAlpha, PImage PercussionTexture) {
    PerX  = PercussionX;
    PerY  = PercussionY;
    PerZ  = PercussionZ;
    PerW  = PercussionWidth;
    PerH  = PercussionHeight;
    PerD  = PercussionDepth;
    PerHu = PercussionHue;
    PerS  = PercussionSaturation;
    PerB  = PercussionBrightness;
    PerA  = PercussionAlpha;
    PerT  = PercussionTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, PerA); 
  translate(PerX, PerY, PerZ);
  beginShape();
    texture(PerT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PerX, -PerY, -PerZ);
  blendMode(BLEND);
  }
}
