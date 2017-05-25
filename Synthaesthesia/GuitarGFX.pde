class GuitarGFX {
  float  GX ;
  float  GY ;
  float  GZ ;
  float  GW ;
  float  GH ;
  float  GD ;
  float  GHu;
  float  GS ;
  float  GB ;
  float  GA ;
  float  GV ;
  float  GAm;
  PImage GT ;
  float  GSp;
  
  GuitarGFX (
    float GuitarX, 
    float GuitarY, 
    float GuitarZ, 
    float GuitarWidth, 
    float GuitarHeight, 
    float GuitarDepth, 
    float GuitarHue, 
    float GuitarSaturation, 
    float GuitarBrightness, 
    float GuitarAlpha, 
    float GuitarVibration, 
    float GuitarAmplitude, 
    float GuitarSpin,
    PImage GuitarTexture) {
      GX  = GuitarX;
      GY  = GuitarY;
      GZ  = GuitarZ;
      GW  = GuitarWidth;
      GH  = GuitarHeight;
      GD  = GuitarDepth;
      GHu = GuitarHue;
      GS  = GuitarSaturation;
      GB  = GuitarBrightness;
      GA  = GuitarAlpha;
      GV  = GuitarVibration;
      GAm = GuitarAmplitude; 
      GSp = GuitarSpin;
      GT  = GuitarTexture;
    }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes

    pushMatrix();  //Local transformation group
      tint(GHu, GS, GB, GA);
      scale(1, 2, 0);
      rotateZ(radians(90));
      translate(0, -GX-512, -5000+GZ+GA*DepthRate*3);
      calcWave();
      renderWave();
    popMatrix();
    //Reset
    blendMode(BLEND);
  }

  void calcWave() {
    theta += GV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta*2;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*GA*GAm;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float guitarStroke = map(GV, VibrationUnit, PitchVibration[127], 64, 0.015625);
//    rotateX(radians(-90));
//    rotateY(radians(-90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing, height/2+yvalues[x], 0);
//      rotateX(radians(90));
      beginShape();
        texture(GT);
        vertex(-guitarStroke*2, -guitarStroke, 0,   0,   0);
        vertex( guitarStroke*2, -guitarStroke, 0, 512,   0);
        vertex( guitarStroke*2,  guitarStroke, 0, 512, 512);
        vertex(-guitarStroke*2,  guitarStroke, 0,   0, 512);
      endShape();
//      rotateX(radians(-90));
      translate(-(x*xspacing), -(height/2+yvalues[x]), 0);
    }
//    rotateY(radians(90));
//    rotateX(radians(90));
  }
}


