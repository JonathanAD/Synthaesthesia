class SynthPadGFX {
  float  SPX ;
  float  SPY ;
  float  SPZ ;
  float  SPW ;
  float  SPH ;
  float  SPD ;
  float  SPHu;
  float  SPS ;
  float  SPB ;
  float  SPA ;
  float  SPTh;
  PImage SPT ;
  PImage SPT2 ;
  int    SPO ;

  SynthPadGFX (
    float SynthPadX, 
    float SynthPadY, 
    float SynthPadZ, 
    float SynthPadWidth, 
    float SynthPadHeight, 
    float SynthPadDepth, 
    float SynthPadHue, 
    float SynthPadSaturation, 
    float SynthPadBrightness, 
    float SynthPadAlpha, 
    float SynthPadThickness, 
    PImage SynthPadTexture,
    PImage SynthPadTexture2,
    int SynthPadOffset) {
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
      SPTh = SynthPadThickness;
      SPT  = SynthPadTexture;
      SPT2 = SynthPadTexture2;
      SPO  = SynthPadOffset;
    }

  void display() {
    //Setup
    blendMode(ADD);     //Additive blending mode
    
    
    //Shapes
    //Front
    pushMatrix();  //Local transformation group
      tint(SPHu, SPS, SPB, SPA/2); 
      rotateX(radians(45));
      translate(SPX, -1024, -512);
        beginShape();
          texture(SPT);
          vertex(-1024, -2048, 0, 0,    0);
          vertex( 1024, -2048, 0, 512,  0);
          vertex( 1024,  2048, 0, 512,512);
          vertex(-1024,  2048, 0, 0,  512);
        endShape();
    popMatrix();
    //Alpha
    pushMatrix();  //Local transformation group
      rotateX(radians(45));
      translate(SPX, -1024, -512);
      beginShape();
        texture(SPT2);
        vertex(-1024, -2048, 0, 0,  SPO-  0);
        vertex( 1024, -2048, 0, 512,SPO-  0);
        vertex( 1024,  2048, 0, 512,SPO-512);
        vertex(-1024,  2048, 0, 0,  SPO-512);
      endShape();
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
}

