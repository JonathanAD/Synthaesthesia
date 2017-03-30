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
  PImage OT;

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
  
//  //Mask
//  blendMode(ADD);
//  translate(OX, OY, OZ);
//  rotateX(PI/8);
//  beginShape();
//    texture(OT);
//    vertex(-100, -100, 0, 0,   0);
//    vertex( 100, -100, 0, 512, 0);
//    vertex( 100,  100, 0, 512, 512);
//    vertex(-100,  100, 0, 0,   512);
//  endShape();
//  blendMode(BLEND);
  }
}

