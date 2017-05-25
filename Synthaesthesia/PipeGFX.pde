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
  int    PiO ;

  PipeGFX (
    float PipeX, 
    float PipeY, 
    float PipeZ, 
    float PipeWidth, 
    float PipeHeight, 
    float PipeDepth, 
    float PipeHue, 
    float PipeSaturation, 
    float PipeBrightness, 
    float PipeAlpha, 
    PImage PipeTexture, 
    float PipeSpin,
    int   PipeOffset) {
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
      PiO  = PipeOffset;
  }
  
  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(PiHu, PiS, PiB); 
      translate(PiX, height/2, PiZ+(PiA*DepthRate)-500);
//      sphereDetail(36);
//      sphere(200);
  
      rotateX(radians(90));
      rotateZ(radians(PiSp/2));
//      beginShape(QUAD_STRIP);
//        texture(PiT);
//        for (int i = 0; i < GeometryDetail; i++) {
//          float x = PipeCylinderX[i] * 200*PiW;
//          float z = PipeCylinderY[i] * 200*PiW;
//          float u = PiT.width / GeometryDetail * i;
//          vertex(x, -1000*PiH, z, u, 0);
//          vertex(x, 1000*PiH, z, u, PiT.height);
//        }
//      endShape();
    drawPipe(36, 100, 100, height*2);
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
  
  void drawPipe( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw sides
    beginShape(TRIANGLE_STRIP);
      texture(PiT);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = PiT.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, 0);
          vertex( x2, y2,  halfHeight, u, PiT.height);    
    }
    endShape(CLOSE);
  }
}

