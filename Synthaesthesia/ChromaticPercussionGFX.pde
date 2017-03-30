class ChromaticPercussionGFX {
  float CPX ;
  float CPY ;
  float CPZ ;
  float CPW ;
  float CPH ;
  float CPD ;
  float CPHu;
  float CPS ;
  float CPB ;
  float CPA ;
  PImage CPT ;
  
  ChromaticPercussionGFX (float ChromaticPercussionX, float ChromaticPercussionY, float ChromaticPercussionZ, float ChromaticPercussionWidth, float ChromaticPercussionHeight, float ChromaticPercussionDepth, float ChromaticPercussionHue, float ChromaticPercussionSaturation, float ChromaticPercussionBrightness, float ChromaticPercussionAlpha, PImage ChromaticPercussionTexture) {
    CPX  = ChromaticPercussionX;
    CPY  = ChromaticPercussionY;
    CPZ  = ChromaticPercussionZ;
    CPW  = ChromaticPercussionWidth;
    CPH  = ChromaticPercussionHeight;
    CPD  = ChromaticPercussionDepth;
    CPHu = ChromaticPercussionHue;
    CPS  = ChromaticPercussionSaturation;
    CPB  = ChromaticPercussionBrightness;
    CPA  = ChromaticPercussionAlpha;
    CPT  = ChromaticPercussionTexture;
  }
  void display() {
//    noStroke();
//    colorMode(HSB);
//    fill(CPHu, CPS, CPB);
//    rect(CPX, CPY, CPW, CPH);

//    colorMode(HSB);
////    fill(PHu, PS, PB);
//    noFill();
//    strokeWeight(2);
//    stroke(CPHu, CPS, CPB);
//    translate(CPX, CPY, CPD);
//    box(CPW, CPH, CPD);

//Mask
  blendMode(ADD);
  translate(CPX, CPY, CPZ);
  
  beginShape();
    texture(CPT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-CPX, -CPY, -CPZ);
  blendMode(BLEND);
  }
}
