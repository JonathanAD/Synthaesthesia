class SynthLeadGFX {
  float  SLX ;
  float  SLY ;
  float  SLZ ;
  float  SLW ;
  float  SLH ;
  float  SLD ;
  float  SLHu;
  float  SLS ;
  float  SLB ;
  float  SLA ;
  float  SLV ;
  float  SLSp;
  float  SLAm;
  PImage SLT ;
  
  SynthLeadGFX (
    float SynthLeadX, 
    float SynthLeadY, 
    float SynthLeadZ, 
    float SynthLeadWidth, 
    float SynthLeadHeight, 
    float SynthLeadDepth, 
    float SynthLeadHue, 
    float SynthLeadSaturation, 
    float SynthLeadBrightness, 
    float SynthLeadAlpha, 
    float SynthLeadVibration, 
    float SynthLeadSpin,
    float SynthLeadAmplitude, 
    PImage SynthLeadTexture) {
      SLX  = SynthLeadX;
      SLY  = SynthLeadY;
      SLZ  = SynthLeadZ;
      SLW  = SynthLeadWidth;
      SLH  = SynthLeadHeight;
      SLD  = SynthLeadDepth;
      SLHu = SynthLeadHue;
      SLS  = SynthLeadSaturation;
      SLB  = SynthLeadBrightness;
      SLA  = SynthLeadAlpha;
      SLV  = SynthLeadVibration;
      SLSp = SynthLeadSpin;
      SLAm = SynthLeadAmplitude; 
      SLT  = SynthLeadTexture;
    }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    
    pushMatrix();  //Local transformation group
      tint(SLHu, SLS, SLB, SLA);
      translate(SLX, -height+SLY, 0);
      calcWave();
      renderWave();
      translate(550,550,0);
      rotateZ(radians(90));
      renderWave();
    popMatrix();

    //Reset
    blendMode(BLEND);
  }

  void calcWave() {
    theta += SLV*2;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*SLA;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float SynthLeadStroke = map(SLV, VibrationUnit, PitchVibration[127], 64, 0.015625);
    rotateY(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
//      rotateZ(radians(SLSp)); Scattered spiral
      translate(x*xspacing*16, height/2+yvalues[x], 0);
      rotateY(radians(90));
      beginShape();
        texture(SLT);
        vertex(-SynthLeadStroke*3, -SynthLeadStroke*3, 0,   0,   0);
        vertex( SynthLeadStroke*3, -SynthLeadStroke*3, 0, 512,   0);
        vertex( SynthLeadStroke*3,  SynthLeadStroke*3, 0, 512, 512);
        vertex(-SynthLeadStroke*3,  SynthLeadStroke*3, 0,   0, 512);
      endShape();
      rotateY(radians(-90));
      translate(-(x*xspacing*16), -(height/2+yvalues[x]), 0);
    }
    rotateY(radians(-90));
  }
}


