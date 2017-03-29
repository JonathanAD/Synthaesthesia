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
  
  ChromaticPercussionGFX (float ChromaticPercussionX, float ChromaticPercussionY, float ChromaticPercussionZ, float ChromaticPercussionWidth, float ChromaticPercussionHeight, float ChromaticPercussionDepth, float ChromaticPercussionHue, float ChromaticPercussionSaturation, float ChromaticPercussionBrightness, float ChromaticPercussionAlpha) {
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
  }
  void display() {
//    noStroke();
//    colorMode(HSB);
//    fill(CPHu, CPS, CPB);
//    rect(CPX, CPY, CPW, CPH);

    colorMode(HSB);
//    fill(PHu, PS, PB);
    noFill();
    strokeWeight(2);
    stroke(CPHu, CPS, CPB);
    translate(CPX, CPY, CPD);
    box(CPW, CPH, CPD);
  }
}
