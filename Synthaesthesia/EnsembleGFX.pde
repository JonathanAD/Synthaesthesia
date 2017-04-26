class EnsembleGFX {
  float  EX ;
  float  EY ;
  float  EZ ;
  float  EW ;
  float  EH ;
  float  ED ;
  float  EHu;
  float  ES ;
  float  EB ;
  float  EA ;
  float  ETh;
  PImage ET ;

  EnsembleGFX (float EnsembleX, float EnsembleY, float EnsembleZ, float EnsembleWidth, float EnsembleHeight, float EnsembleDepth, float EnsembleHue, float EnsembleSaturation, float EnsembleBrightness, float EnsembleAlpha, float EnsembleThickness, PImage EnsembleTexture) {
    EX  = EnsembleX;
    EY  = EnsembleY;
    EZ  = EnsembleZ;
    EW  = EnsembleWidth;
    EH  = EnsembleHeight;
    ED  = EnsembleDepth;
    EHu = EnsembleHue;
    ES  = EnsembleSaturation;
    EB  = EnsembleBrightness;
    EA  = EnsembleAlpha;
    ETh = EnsembleThickness;
    ET  = EnsembleTexture;

  }
  void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, EA/2); 
  translate(EX, 360, EZ);
  beginShape();
    texture(ET);
    vertex(-512, -720, 0, 0,     0);
    vertex( 512, -720, 0, 512,   0);
    vertex( 512,  720, 0, 512, 512);
    vertex(-512,  720, 0, 0,   512);
  endShape();
  rotateZ(radians(180));
    beginShape();
    texture(ET);
    vertex(-512, -720, -100, 0,     0);
    vertex( 512, -720, -100, 512,   0);
    vertex( 512,  720, -100, 512, 512);
    vertex(-512,  720, -100, 0,   512);
  endShape();
  rotateZ(radians(-180));
  translate(-EX, -360, -EZ);
  blendMode(BLEND);
  }
}

