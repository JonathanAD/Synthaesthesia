class EthnicGFX {
  float  EtX ;
  float  EtY ;
  float  EtZ ;
  float  EtW ;
  float  EtH ;
  float  EtD ;
  float  EtHu;
  float  EtS ;
  float  EtB ;
  float  EtA ;
  float  EtV ;
  float  EtAm;
  PImage EtT ;
  
  EthnicGFX (
    float EthnicX, 
    float EthnicY, 
    float EthnicZ, 
    float EthnicWidth, 
    float EthnicHeight, 
    float EthnicDepth, 
    float EthnicHue, 
    float EthnicSaturation, 
    float EthnicBrightness, 
    float EthnicAlpha, 
    float EthnicVibration, 
    float EthnicAmplitude, 
    PImage EthnicTexture) {
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
      EtV  = EthnicVibration;
      EtT  = EthnicTexture; 
      EtAm = EthnicAmplitude;
  }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(EtHu, EtS, EtB, EtA);
      translate(EtX-256, -height/4, EtZ+EtA*DepthRate);
      calcWave();
      renderWave();
      rotateZ(radians(180));
      translate(-1024, 0, 0);
      renderWave();
    popMatrix();

    //Reset
    blendMode(BLEND);
  }

  void calcWave() {
    theta += EtV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*EtA*EtAm*4;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float bassStroke = map(EtV, VibrationUnit, PitchVibration[127], 128, 1);
    rotateY(radians(90));
    rotateX(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing*8, height/2+yvalues[x], 0);
        rotateY(radians(90));
          beginShape();
            texture(EtT);
            vertex(-bassStroke*2, -bassStroke*2, 0,   0,   0);
            vertex( bassStroke*2, -bassStroke*2, 0, 512,   0);
            vertex( bassStroke*2,  bassStroke*2, 0, 512, 512);
            vertex(-bassStroke*2,  bassStroke*2, 0,   0, 512);
          endShape();
        rotateY(radians(-90));
      translate(-(x*xspacing*8), -(height/2+yvalues[x]), 0);
    }
    rotateX(radians(-90));
    rotateY(radians(-90));
  }
}
