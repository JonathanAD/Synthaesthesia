class EthnicGFX {
  float EtX ;
  float EtY ;
  float EtZ ;
  float EtW ;
  float EtH ;
  float EtD ;
  float EtHu;
  float EtS ;
  float EtB ;
  float EtA ;
  PImage EtT ;
  
  EthnicGFX (float EthnicX, float EthnicY, float EthnicZ, float EthnicWidth, float EthnicHeight, float EthnicDepth, float EthnicHue, float EthnicSaturation, float EthnicBrightness, float EthnicAlpha, PImage EthnicTexture) {
    EtX  = EthnicX;
    EtY  = EthnicY;
    EtZ  = EthnicZ;
    EtW  = EthnicWidth;
    EtH  = EthnicHeight;
    EtD  = EthnicDepth;
    EtHu = EthnicHue;
    EtS  = EthnicSaturation;
    EtB  = EthnicBrightness;
    EtA  = EthnicAlpha;
    EtT  = EthnicTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, EtA); 
  translate(EtX, EtY, EtZ);
  beginShape();
    texture(EtT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-EtX, -EtY, -EtZ);
  blendMode(BLEND);
  }
}
