  class PianoGFX {
  int    PX ;
  int    PY ;
  float  PZ ;
  int    PW ;
  int    PH ;
  int    PD ;
  int    PHu;
  int    PS ;
  int    PB ;
  int    PA ;
  PImage PT ;
  PImage PT2;
  
  PianoGFX (
    int    PianoX, 
    int    PianoY, 
    float  PianoZ, 
    int    PianoWidth, 
    int    PianoHeight, 
    int    PianoDepth, 
    int    PianoHue, 
    int    PianoSaturation, 
    int    PianoBrightness, 
    int    PianoAlpha, 
    PImage PianoTexture, 
    PImage PianoTexture2) {
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
      PT2 = PianoTexture2; 
  }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      scale(1.5, 1.5, 1);
      tint(PHu, PS, PB, PA);  
      translate(-512+PX, PY, -512+PZ+PA*DepthRate);
      beginShape();
        texture(PT);
        vertex(-200, -200, 0, 0,   0);
        vertex( 200, -200, 0, 512, 0);
        vertex( 200,  200, 0, 512, 512);
        vertex(-200,  200, 0, 0,   512);
      endShape();
      popMatrix();
      

    //      //Sides
//      scale(0.8, 0.8, 1);
//      translate(0, 0, -100);
//      rotateX(radians(-90));
//      rotateY(radians(PianoSpinY));
//      beginShape(QUAD_STRIP);
//      texture(PT2);
//      for (int i = 0; i < GeometryDetail; i++) {
//        float x = PianoCylinderX[i] * 200;
//        float z = PianoCylinderY[i] * 200;
//        float u = PT2.width / GeometryDetail * i;
//        vertex(x, -100, z, u, 0);
//        vertex(x, 100, z, u, PT2.height);
//      }
//      endShape();

    //Reset
    blendMode(BLEND);
  }
  void ripple() {
    //Setup
    blendMode(ADD);  //Additive blending mode

    //Ripple
    pushMatrix();  //Local transformation group
      scale(1.5, 1.5, 1);
      tint(PHu, PS, PB, PA);  
      translate(-512+PX, PY, -1088-(PZ+PA*DepthRate));
      beginShape();
        texture(PT2);
        vertex(-200, -200, 0, 0,   0);
        vertex( 200, -200, 0, 512, 0);
        vertex( 200,  200, 0, 512, 512);
        vertex(-200,  200, 0, 0,   512);
      endShape();
     popMatrix();
     
     //Reset
    blendMode(BLEND);
  }
}
