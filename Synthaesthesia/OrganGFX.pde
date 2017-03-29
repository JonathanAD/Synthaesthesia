class OrganGFX {
  float OX ;
  float OY ;
  float OZ ;
  float OW ;
  float OH ;
  float OD ;
  float OHu;
  float OS ;
  float OB ;
  float OA ;
  
  OrganGFX (float OrganX, float OrganY, float OrganZ, float OrganWidth, float OrganHeight, float OrganDepth, float OrganHue, float OrganSaturation, float OrganBrightness, float OrganAlpha) {
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
  }
  void display() {
//    noStroke();
//    colorMode(HSB);
//    fill(OHu, OS, OB);
//    ellipse(OX, OY, OW, OH);

//    translate(width/2, height/2, 0); 
//    rotateY(0.5);
//    colorMode(HSB);
//    fill(200, 200, 200);
//    box(100);

    lights();
    translate(OX, OY, OZ); 
    colorMode(HSB);
    fill(OHu, OS, OB);
    noStroke();
    sphere(OW);
  }
}
