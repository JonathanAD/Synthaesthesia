class BrassGFX {
  float  BrX ;
  float  BrY ;
  float  BrZ ;
  float  BrW ;
  float  BrH ;
  float  BrD ;
  float  BrHu;
  float  BrS ;
  float  BrB ;
  float  BrA ;
  PImage BrT ;
  int    BrO ;
  
  BrassGFX (
    float BrassX, 
    float BrassY, 
    float BrassZ, 
    float BrassWidth, 
    float BrassHeight, 
    float BrassDepth, 
    float BrassHue, 
    float BrassSaturation, 
    float BrassBrightness, 
    float BrassAlpha, 
    PImage BrassTexture,
    int    BrassOffset) {
      BrX  = BrassX;
      BrY  = BrassY;
      BrZ  = BrassZ;
      BrW  = BrassWidth;
      BrH  = BrassHeight;
      BrD  = BrassDepth;
      BrHu = BrassHue;
      BrS  = BrassSaturation;
      BrB  = BrassBrightness;
      BrA  = BrassAlpha;
      BrT  = BrassTexture;
      BrO  = BrassOffset;
  }
  
  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(BrHu, BrS, BrB, BrA);
      translate(BrX, BrY+200, BrZ+(BrA*DepthRate));
      rotateX(radians(180));
      rotateZ(radians(180));
      drawBrass(72, BrA*3, 50, 750);
      drawBrass(72, BrA*3, 50 , 750);
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
  
  void drawBrass( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw sides
    beginShape(TRIANGLE_STRIP);
    texture(BrT);
    for (int i = 0; i < sides + 1; i++) {
        float x1 = cos( radians( i * angle ) ) * r1;
        float y1 = sin( radians( i * angle ) ) * r1;
        float x2 = cos( radians( i * angle ) ) * r2;
        float y2 = sin( radians( i * angle ) ) * r2;
        float u = BrT.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, BrO+u,          0);
          vertex( x2, y2,  halfHeight, BrO+u, BrT.height);    
    }
    endShape(CLOSE);
}
}



