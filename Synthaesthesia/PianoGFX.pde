class PianoGFX {
  float PX ;
  float PY ;
  float PZ ;
  float PW ;
  float PH ;
  float PD ;
  float PHu;
  float PS ;
  float PB ;
  float PA ;
  
  PianoGFX (float PianoX, float PianoY, float PianoZ, float PianoWidth, float PianoHeight, float PianoDepth, float PianoHue, float PianoSaturation, float PianoBrightness, float PianoAlpha) {
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
  }
  void display() {
//    noStroke();              // 2D
//    colorMode(HSB);          // 2D
//    fill(PHu, PS, PB);       // 2D
//    ellipse(PX, PY, PW, PH); // 2D
    
    lights();
    colorMode(HSB, 360, 100, 100, 100);
    fill(PHu, PS, PB, PA);
//    noFill();
//    stroke(PHu, PS, PB);
    noStroke();
    translate(PX, PY, PD);
    sphereDetail(16);
    sphere(PW);
  }
}
