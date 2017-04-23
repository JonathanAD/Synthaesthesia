class SynthPadGFX {
  float SPX ;
  float SPY ;
  float SPZ ;
  float SPW ;
  float SPH ;
  float SPD ;
  float SPHu;
  float SPS ;
  float SPB ;
  float SPA ;
  PImage SPT ;
  
  SynthPadGFX (float SynthPadX, float SynthPadY, float SynthPadZ, float SynthPadWidth, float SynthPadHeight, float SynthPadDepth, float SynthPadHue, float SynthPadSaturation, float SynthPadBrightness, float SynthPadAlpha, PImage SynthPadTexture) {
    SPX  = SynthPadX;
    SPY  = SynthPadY;
    SPZ  = SynthPadZ;
    SPW  = SynthPadWidth;
    SPH  = SynthPadHeight;
    SPD  = SynthPadDepth;
    SPHu = SynthPadHue;
    SPS  = SynthPadSaturation;
    SPB  = SynthPadBrightness;
    SPA  = SynthPadAlpha;
    SPT  = SynthPadTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, SPA); 
  translate(SPX, SPY, SPZ);
  beginShape();
    texture(SPT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-SPX, -SPY, -SPZ);
  blendMode(BLEND);
  }
}
