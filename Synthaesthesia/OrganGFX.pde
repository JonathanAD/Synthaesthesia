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
  float  OTh;
  PImage OT ;

  OrganGFX (float OrganX, float OrganY, float OrganZ, float OrganWidth, float OrganHeight, float OrganDepth, float OrganHue, float OrganSaturation, float OrganBrightness, float OrganAlpha, float OrganThickness, PImage OrganTexture) {
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
    OTh = OrganThickness;
    OT  = OrganTexture;

  }
  void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, OA); 
  translate(OX, 360, OZ);
  beginShape();
    texture(OT);
    vertex(-128*OTh, -720, 0, 0,     0);
    vertex( 128*OTh, -720, 0, 512,   0);
    vertex( 128*OTh,  720, 0, 512, 512);
    vertex(-128*OTh,  720, 0, 0,   512);
  endShape();
  translate(-OX, -360, -OZ);
  blendMode(BLEND);
  }
}

