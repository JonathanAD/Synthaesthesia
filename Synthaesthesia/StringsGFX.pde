class StringsGFX {
  float  SX ;
  float  SY ;
  float  SZ ;
  float  SW ;
  float  SH ;
  float  SD ;
  float  SHu;
  float  SS ;
  float  SB ;
  float  SA ;
  PImage ST ;
  int    SO ;

  StringsGFX (
    float StringsX, 
    float StringsY, 
    float StringsZ, 
    float StringsWidth, 
    float StringsHeight, 
    float StringsDepth, 
    float StringsHue, 
    float StringsSaturation, 
    float StringsBrightness, 
    float StringsAlpha, 
    PImage StringsTexture,
    int    StringsOffset) {
      SX  = StringsX;
      SY  = StringsY;
      SZ  = StringsZ;
      SW  = StringsWidth;
      SH  = StringsHeight;
      SD  = StringsDepth;
      SHu = StringsHue;
      SS  = StringsSaturation;
      SB  = StringsBrightness;
      SA  = StringsAlpha;
      ST  = StringsTexture;
      SO  = StringsOffset;
  }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(SHu, SS, SB, SA*0.75);
      translate(SX, height/2.5, 0);
//      beginShape();
//        texture(ST);
//        vertex(-384*SW, -512*SH*2, 0, 0,     0);
//        vertex( 384*SW, -512*SH*2, 0, 512,   0);
//        vertex( 384*SW,  512*SH*2, 0, 512, 512);
//        vertex(-384*SW,  512*SH*2, 0, 0,   512);
//      endShape();
//      beginShape();
//        texture(ST);
//        vertex(-384*SW, -512*SH*2, 0, 0,     0);
//        vertex( 384*SW, -512*SH*2, 0, 512,   0);
//        vertex( 384*SW,  512*SH*2, 0, 512, 512);
//        vertex(-384*SW,  512*SH*2, 0, 0,   512);
//      endShape();
     rotateX(radians(90));
      drawStrings(36, 128, 256, height*2);
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
  
   void drawStrings( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw sides
    beginShape(TRIANGLE_STRIP);
      texture(ST);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = ST.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, SO+0);
          vertex( x2, y2,  halfHeight, u, SO+ST.height);    
          println(SO);
    }
    endShape(CLOSE);
  }
}

