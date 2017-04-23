class PipeGFX {
  float PiX ;
  float PiY ;
  float PiZ ;
  float PiW ;
  float PiH ;
  float PiD ;
  float PiHu;
  float PiS ;
  float PiB ;
  float PiA ;
  PImage PiT ;
  
  PipeGFX (float PipeX, float PipeY, float PipeZ, float PipeWidth, float PipeHeight, float PipeDepth, float PipeHue, float PipeSaturation, float PipeBrightness, float PipeAlpha, PImage PipeTexture) {
    PiX  = PipeX;
    PiY  = PipeY;
    PiZ  = PipeZ;
    PiW  = PipeWidth;
    PiH  = PipeHeight;
    PiD  = PipeDepth;
    PiHu = PipeHue;
    PiS  = PipeSaturation;
    PiB  = PipeBrightness;
    PiA  = PipeAlpha;
    PiT  = PipeTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, PiA); 
  translate(PiX, PiY, PiZ);
  beginShape();
    texture(PiT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PiX, -PiY, -PiZ);
  blendMode(BLEND);
  }
}
