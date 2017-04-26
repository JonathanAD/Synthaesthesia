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
  
  BassGFX (float BassX, float BassY, float BassZ, float BassWidth, float BassHeight, float BassDepth, float BassHue, float BassSaturation, float BassBrightness, float BassAlpha, float BassVibration, float BassAmplitude, PImage BassTexture) {
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

    //Mask
    blendMode(ADD);
    translate(BX-256, BY+512, BZ+256);

    calcWave();
    renderWave();
    
    //Reset
    translate(-BX+256, -BY-512, -BZ-256);
    blendMode(BLEND);

  }

  void calcWave() {
    theta += BV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*BA*BAm;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float bassStroke = map(BV, VibrationUnit, PitchVibration[127], 64, 0.015625);
    rotateY(radians(90));
    rotateX(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing, height/2+yvalues[x], 0);
        rotateY(radians(90));
          beginShape();
            texture(BT);
            vertex(-bassStroke, -bassStroke, 0,   0,   0);
            vertex( bassStroke, -bassStroke, 0, 512,   0);
            vertex( bassStroke,  bassStroke, 0, 512, 512);
            vertex(-bassStroke,  bassStroke, 0,   0, 512);
          endShape();
        rotateY(radians(-90));
      translate(-(x*xspacing), -(height/2+yvalues[x]), 0);
    }
    rotateX(radians(-90));
    rotateY(radians(-90));
  }
}


