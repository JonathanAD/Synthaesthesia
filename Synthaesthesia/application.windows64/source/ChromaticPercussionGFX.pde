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

//Mask
  //Blending mode
  //Color
  tint(255, 255, 255, CPA); 
  //General translation
  translate(CPX, CPY, CPZ);
  
  //Front face
  beginShape();
    texture(CPT);
    vertex(-50, -200, 0, 0,   0);
    vertex( 50, -200, 0, 512, 0);
    vertex( 50,  200, 0, 512, 512);
    vertex(-50,  200, 0, 0,   512);
  endShape();
  
//  translate(0, 0, -100);
//  beginShape();
//    texture(CPT);
//    vertex(-100, -100, 0, 0,   0);
//    vertex( 100, -100, 0, 512, 0);
//    vertex( 100,  100, 0, 512, 512);
//    vertex(-100,  100, 0, 0,   512);
//  endShape();
//  translate(0, 0, 100);

  beginShape();
    texture(CPT);
    vertex(-50, -200, -100, 0,   0);
    vertex( 50, -200, -100, 512, 0);
    vertex( 50,  200, -100, 512, 512);
    vertex(-50,  200, -100, 0,   512);
  endShape();
  
//  rotateX(radians(90));
//  beginShape();
//    texture(CPT);
//    vertex(-100, -100, 0, 0,   0);
//    vertex( 100, -100, 0, 512, 0);
//    vertex( 100,  100, 0, 512, 512);
//    vertex(-100,  100, 0, 0,   512);
//  endShape();
//  rotateX(radians(90));
  
  translate(-CPX, -CPY, -CPZ);
  }
}
