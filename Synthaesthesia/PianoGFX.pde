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
  
  PianoGFX (float PianoX, float PianoY, float PianoZ, float PianoWidth, float PianoHeight, float PianoDepth, float PianoHue, float PianoSaturation, float PianoBrightness, float PianoAlpha, PImage PianoTexture) {
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
  }
  void display() {
  
  //Mask
  blendMode(ADD);
  translate(PX, PY, PZ);
//  scale(1, 8,1);
  beginShape();
    texture(PT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PX, -PY, -PZ);
  blendMode(BLEND);
  }
}
