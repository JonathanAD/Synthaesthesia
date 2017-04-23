class EnsembleGFX {
  float EX ;
  float EY ;
  float EZ ;
  float EW ;
  float EH ;
  float ED ;
  float EHu;
  float ES ;
  float EB ;
  float EA ;
  PImage ET ;
  
  EnsembleGFX (float EnsembleX, float EnsembleY, float EnsembleZ, float EnsembleWidth, float EnsembleHeight, float EnsembleDepth, float EnsembleHue, float EnsembleSaturation, float EnsembleBrightness, float EnsembleAlpha, PImage EnsembleTexture) {
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
    ET  = EnsembleTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, EA); 
  translate(EX, EY, EZ);
  beginShape();
    texture(ET);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-EX, -EY, -EZ);
  blendMode(BLEND);
  }
}
