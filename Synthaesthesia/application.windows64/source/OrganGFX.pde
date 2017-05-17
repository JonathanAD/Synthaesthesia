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

  OrganGFX (float OrganX, float OrganY, float OrganZ, float OrganWidth, float OrganHeight, float OrganDepth, float OrganHue, float OrganSaturation, float OrganBrightness, float OrganAlpha, PImage OrganTexture) {
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

  }
  void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, OA); 
  translate(OX, 360, OZ+(OA*DepthRate));
  beginShape(QUAD_STRIP);
    texture(OT);
    for (int i = 0; i < GeometryDetail; i++) {
      float x = (PipeCylinderX[i] * 100*OW);
      float z = PipeCylinderY[i] * 100*OW;
      float u = OT.width / GeometryDetail * i;
      vertex(x, -600*OH, z, u, 0);
      vertex(x, 600*OH, z, u, OT.height);
    }
  endShape();


  translate(-OX, -360, -OZ-(OA*DepthRate));
  blendMode(BLEND);
  }
}

