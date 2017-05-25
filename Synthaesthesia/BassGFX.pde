class BassGFX {
  float  BX ;
  float  BY ;
  float  BZ ;
  float  BW ;
  float  BH ;
  float  BD ;
  float  BHu;
  float  BS ;
  float  BB ;
  float  BA ;
  float  BV ;
  float  BAm;
  PImage BT ;
  
  BassGFX (
    float BassX, 
    float BassY, 
    float BassZ, 
    float BassWidth, 
    float BassHeight, 
    float BassDepth, 
    float BassHue, 
    float BassSaturation, 
    float BassBrightness, 
    float BassAlpha, 
    float BassVibration, 
    float BassAmplitude, 
    PImage BassTexture) {
      BX  = BassX;
      BY  = BassY;
      BZ  = BassZ;
      BW  = BassWidth;
      BH  = BassHeight;
      BD  = BassDepth;
      BHu = BassHue;
      BS  = BassSaturation;
      BB  = BassBrightness;
      BA  = BassAlpha;
      BV  = BassVibration;
      BT  = BassTexture; 
      BAm = BassAmplitude;
  }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(BHu, BS, BB, BA);
      translate(BX-256, height, 512+BZ+BA*DepthRate);
      calcWave();
      renderWave();
    popMatrix();

    //Reset
    blendMode(BLEND);
  }

  void calcWave() {
    theta += BV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*BA*BAm*4;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float bassStroke = map(BV, VibrationUnit, PitchVibration[127], 128, 1);
    rotateY(radians(90));
    rotateX(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing*8, height/2+yvalues[x], 0);
        rotateY(radians(45));
          beginShape();
            texture(BT);
            vertex(-bassStroke*3, -bassStroke*3, 0,   0,   0);
            vertex( bassStroke*3, -bassStroke*3, 0, 512,   0);
            vertex( bassStroke*3,  bassStroke*3, 0, 512, 512);
            vertex(-bassStroke*3,  bassStroke*3, 0,   0, 512);
          endShape();
        rotateY(radians(-45));
      translate(-(x*xspacing*8), -(height/2+yvalues[x]), 0);
    }
    rotateX(radians(-90));
    rotateY(radians(-90));
  }
}
