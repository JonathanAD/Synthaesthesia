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
  float  ESp;
  PImage ET ;
  int    EO ;

  EnsembleGFX (
    float EnsembleX, 
    float EnsembleY, 
    float EnsembleZ, 
    float EnsembleWidth, 
    float EnsembleHeight, 
    float EnsembleDepth, 
    float EnsembleHue, 
    float EnsembleSaturation, 
    float EnsembleBrightness, 
    float EnsembleAlpha, 
    float EnsembleThickness, 
    float EnsembleSpin,
    PImage EnsembleTexture,
    int    EnsembleOffset) {
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
      ESp = EnsembleSpin;
      ET  = EnsembleTexture;
      EO  = EnsembleOffset;
    }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(EHu, ES, EB, EA); 
      rotateX(radians(90));
      translate(EX, -1000, EZ+EA*DepthRate);
      drawEnsemble(36, 4000, 4000, height*6);
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
  
    void drawEnsemble( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw sides
    rotateZ(radians(ESp));
    beginShape(TRIANGLE_STRIP);
      texture(ET);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = ET.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, 0);
          vertex( x2, y2, halfHeight, u, ET.height);    
    }
    endShape(CLOSE);
    rotateZ(radians(-ESp));
    beginShape(TRIANGLE_STRIP);
      texture(ET);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = ET.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, 0);
          vertex( x2, y2, halfHeight, u, ET.height);    
    }
    endShape(CLOSE);
  }
}




