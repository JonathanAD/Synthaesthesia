class OrganGFX {
  float  OX ;
  float  OY ;
  float  OZ ;
  float  OW ;
  float  OH ;
  float  OD ;
  float  OHu;
  float  OS ;
  float  OB ;
  float  OA ;
  PImage OT ;
  int    OO ;

  OrganGFX (
    float  OrganX, 
    float  OrganY, 
    float  OrganZ, 
    float  OrganWidth, 
    float  OrganHeight, 
    float  OrganDepth, 
    float  OrganHue, 
    float  OrganSaturation, 
    float  OrganBrightness, 
    float  OrganAlpha, 
    PImage OrganTexture,
    int    OrganOffset) {
      OX  = OrganX;
      OY  = OrganY;
      OZ  = OrganZ;
      OW  = OrganWidth;
      OH  = OrganHeight;
      OD  = OrganDepth;
      OHu = OrganHue;
      OS  = OrganSaturation;
      OB  = OrganBrightness;
      OA  = OrganAlpha;
      OT  = OrganTexture;
      OO  = OrganOffset;
  }

  void display() {
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(OHu, OS, OB, OA); 
      rotateX(radians(45));
      translate(OX, (height/4) + OY, -250+(OZ+(OA*DepthRate)));
      beginShape(QUAD_STRIP);
        texture(OT);
        for (int i = 0; i < GeometryDetail; i++) {
          float x = (OrganCylinderX[i] * 200*OW);
          float z = OrganCylinderY[i] * 200*OW;
          float u = OT.width / GeometryDetail * i;
          vertex(x, -800*OH, z, u, OO+0        );
          vertex(x,  800*OH, z, u, OO+OT.height);
        }
      endShape();
    popMatrix();
    
    //Reset
    blendMode(BLEND);
  }
}
   
