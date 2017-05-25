class SynthEffectsGFX {
  float  SEX ;
  float  SEY ;
  float  SEZ ;
  float  SEW ;
  float  SEH ;
  float  SED ;
  float  SEHu;
  float  SES ;
  float  SEB ;
  float  SEA ;
  float  SEV ;
  float  SESp;
  float  SEAm;
  PImage SET ;
  
  SynthEffectsGFX (
    float SynthEffectsX, 
    float SynthEffectsY, 
    float SynthEffectsZ, 
    float SynthEffectsWidth, 
    float SynthEffectsHeight, 
    float SynthEffectsDepth, 
    float SynthEffectsHue, 
    float SynthEffectsSaturation, 
    float SynthEffectsBrightness, 
    float SynthEffectsAlpha, 
    float SynthEffectsVibration, 
    float SynthEffectsSpin,
    float SynthEffectsAmplitude, 
    PImage SynthEffectsTexture) {
      SEX  = SynthEffectsX;
      SEY  = SynthEffectsY;
      SEZ  = SynthEffectsZ;
      SEW  = SynthEffectsWidth;
      SEH  = SynthEffectsHeight;
      SED  = SynthEffectsDepth;
      SEHu = SynthEffectsHue;
      SES  = SynthEffectsSaturation;
      SEB  = SynthEffectsBrightness;
      SEA  = SynthEffectsAlpha;
      SEV  = SynthEffectsVibration;
      SESp = SynthEffectsSpin;
      SEAm = SynthEffectsAmplitude; 
      SET  = SynthEffectsTexture;
    }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    
    pushMatrix();  //Local transformation group
      tint(SEHu, SES, SEB, SEA);
      translate(SEX, SEY, -7500);
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
    theta += SEV*2;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*SEA;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float SynthEffectsStroke = map(SEV, VibrationUnit, PitchVibration[127], 64, 0.015625);
    rotateY(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      rotateZ(radians(SESp)/16); //Scattered spiral
      translate(x*xspacing*16, height/2+yvalues[x], 0);
      rotateY(radians(90));
      beginShape();
        texture(SET);
        vertex(-SynthEffectsStroke*24, -SynthEffectsStroke*24, 0,   0,   0);
        vertex( SynthEffectsStroke*24, -SynthEffectsStroke*24, 0, 512,   0);
        vertex( SynthEffectsStroke*24,  SynthEffectsStroke*24, 0, 512, 512);
        vertex(-SynthEffectsStroke*24,  SynthEffectsStroke*24, 0,   0, 512);
      endShape();
      rotateY(radians(-90));
      translate(-(x*xspacing*16), -(height/2+yvalues[x]), 0);
    }
    rotateY(radians(-90));
  }
}


