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
  
  GuitarGFX (float GuitarX, float GuitarY, float GuitarZ, float GuitarWidth, float GuitarHeight, float GuitarDepth, float GuitarHue, float GuitarSaturation, float GuitarBrightness, float GuitarAlpha, float GuitarVibration, float GuitarAmplitude, PImage GuitarTexture) {
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
    GT  = GuitarTexture;
    GAm = GuitarAmplitude; 
  }

  void display() {

    //Mask
    blendMode(ADD);
    translate(GX, GY-750, GZ);
    calcWave();
    renderWave();
    
    //Reset
    translate(-GX, -GY+750, -GZ);
    blendMode(BLEND);

  }

  void calcWave() {
    theta += GV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*GA*GAm;
      x+=dx;
    }
  }
  
  void renderWave() {
    noStroke();
    float guitarStroke = map(GV, VibrationUnit, PitchVibration[127], 64, 0.015625);
    rotateY(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing, height/2+yvalues[x], 0);
      rotateY(radians(90));
      beginShape();
        texture(GT);
        vertex(-guitarStroke, -guitarStroke, 0,                0,                0);
        vertex( guitarStroke, -guitarStroke, 0, 512,                0);
        vertex( guitarStroke,  guitarStroke, 0, 512, 512);
        vertex(-guitarStroke,  guitarStroke, 0,                0, 512);
      endShape();
      rotateY(radians(-90));
      translate(-(x*xspacing), -(height/2+yvalues[x]), 0);
    }
    rotateY(radians(-90));
  }
}


