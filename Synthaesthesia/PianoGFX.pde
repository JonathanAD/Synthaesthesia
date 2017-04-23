class PianoGFX {
  float  PX ;
  float  PY ;
  float  PZ ;
  float  PW ;
  float  PH ;
  float  PD ;
  float  PHu;
  float  PS ;
  float  PB ;
  float  PA ;
  PImage PT ;
  PImage PT2;
  
  PianoGFX (float PianoX, float PianoY, float PianoZ, float PianoWidth, float PianoHeight, float PianoDepth, float PianoHue, float PianoSaturation, float PianoBrightness, float PianoAlpha, PImage PianoTexture, PImage PianoTexture2) {
    PX  = PianoX;
    PY  = PianoY;
    PZ  = PianoZ;
    PW  = PianoWidth;
    PH  = PianoHeight;
    PD  = PianoDepth;
    PHu = PianoHue;
    PS  = PianoSaturation;
    PB  = PianoBrightness;
    PA  = PianoAlpha;
    PT  = PianoTexture; 
    PT2  = PianoTexture2; 
  }
  void display() {
    
  //Mask
  blendMode(ADD);
  
  //Object
  tint(255, 255, 255, PA);  
  translate(PX, PY, PZ);
  beginShape();
    texture(PT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();

  scale(0.8, 0.8, 1);
  translate(0, 0, -100);
  rotateX(radians(-90));
  rotateY(radians(PianoSpinY));
  beginShape(QUAD_STRIP);
  texture(PT2);
  for (int i = 0; i < GeometryDetail; i++) {
    float x = tubeX[i] * 100;
    float z = tubeY[i] * 100;
    float u = PT2.width / GeometryDetail * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, PT2.height);
  }
  endShape();
  rotateX(radians(90));
  rotateY(radians(-PianoSpinY));
  translate(0, 0, 100);
  scale(1.25, 1.25, 1);
  
  //Increase variable values
//    PianoSpinY = PianoSpinY - 3;
    
  //Reset
  translate(-PX, -PY, -PZ);
  blendMode(BLEND);
  }
}
