class PipeGFX {
  float  PiX ;
  float  PiY ;
  float  PiZ ;
  float  PiW ;
  float  PiH ;
  float  PiD ;
  float  PiHu;
  float  PiS ;
  float  PiB ;
  float  PiA ;
  PImage PiT ;
  float  PiSp;

  PipeGFX (float PipeX, float PipeY, float PipeZ, float PipeWidth, float PipeHeight, float PipeDepth, float PipeHue, float PipeSaturation, float PipeBrightness, float PipeAlpha, PImage PipeTexture, float PipeSpin) {
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
    PiSp = PipeSpin;
  }
  
  void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, PiA); 
  translate(PiX, 360, PiZ+(PiA*DepthRate));
    rotateY(radians(PiSp));
      beginShape(QUAD_STRIP);
        texture(PiT);
        for (int i = 0; i < GeometryDetail; i++) {
          float x = PipeCylinderX[i] * 100*PiW;
          float z = PipeCylinderY[i] * 100*PiW;
          float u = PiT.width / GeometryDetail * i;
          vertex(x, -600*PiH, z, u, 0);
          vertex(x, 600*PiH, z, u, PiT.height);
        }
      endShape();
    rotateY(radians(-PiSp));
  translate(-PiX, -360, -PiZ-(PiA*DepthRate));
  blendMode(BLEND);
  }
}

