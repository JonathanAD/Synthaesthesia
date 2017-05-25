class ReedGFX {
  float  RX ;
  float  RY ;
  float  RZ ;
  float  RW ;
  float  RH ;
  float  RD ;
  float  RHu;
  float  RS ;
  float  RB ;
  float  RA ;
  PImage RT ;
  float  RSp;
  int    RO ;

  ReedGFX (
    float ReedX, 
    float ReedY, 
    float ReedZ, 
    float ReedWidth, 
    float ReedHeight, 
    float ReedDepth, 
    float ReedHue, 
    float ReedSaturation, 
    float ReedBrightness, 
    float ReedAlpha, 
    PImage ReedTexture, 
    float ReedSpin,
    int   ReedOffset) {
      RX  = ReedX;
      RY  = ReedY;
      RZ  = ReedZ;
      RW  = ReedWidth;
      RH  = ReedHeight;
      RD  = ReedDepth;
      RHu = ReedHue;
      RS  = ReedSaturation;
      RB  = ReedBrightness;
      RA  = ReedAlpha;
      RT  = ReedTexture;
      RSp = ReedSpin;
      RO  = ReedOffset;
  }
  
  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(RHu, RS, RB); 
      translate(RX, (height/2)+RY, RZ+(RA*DepthRate)-500);
      rotateZ(radians(RSp/2));
      drawReed(36, 200, 300, 1000);
      rotateZ(-(radians(RSp/2)));
      drawReed2(36, 200, 0, 1000);
      println(RY);
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
  void drawReed( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw sides
    beginShape(TRIANGLE_STRIP);
      texture(RT);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = RT.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, 0);
          vertex( x2, y2,  halfHeight, u, RT.height);    
    }
    endShape(CLOSE);
  }
  
    void drawReed2( int sides, float r1, float r2, float h)
  {
    float angle = 360 / sides;
    float halfHeight = h / 2;

    // draw sides
    beginShape(TRIANGLE_STRIP);
      texture(RT);
      for (int i = 0; i < sides + 1; i++) {
          float x1 = cos( radians( i * angle ) ) * r1;
          float y1 = sin( radians( i * angle ) ) * r1;
          float x2 = cos( radians( i * angle ) ) * r2;
          float y2 = sin( radians( i * angle ) ) * r2;
          float u = RT.width / GeometryDetail * i;
          vertex( x1, y1, -halfHeight, u, RO+0);
          vertex( x2, y2,  halfHeight, u, RO+RT.height);    
    }
    endShape(CLOSE);
  }
}


