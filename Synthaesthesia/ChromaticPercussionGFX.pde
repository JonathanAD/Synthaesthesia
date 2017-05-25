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
  
  ChromaticPercussionGFX (
    float ChromaticPercussionX, 
    float ChromaticPercussionY, 
    float ChromaticPercussionZ, 
    float ChromaticPercussionWidth, 
    float ChromaticPercussionHeight, 
    float ChromaticPercussionDepth, 
    float ChromaticPercussionHue, 
    float ChromaticPercussionSaturation, 
    float ChromaticPercussionBrightness, 
    float ChromaticPercussionAlpha, 
    PImage ChromaticPercussionTexture) {
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
    //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    pushMatrix();  //Local transformation group
      tint(CPHu, CPS, CPB, CPA); 
      translate(CPX, (height/3)+CPY, -512+CPZ+CPA*DepthRate);
      //Front face
      beginShape();
        texture(CPT);
        vertex(-150, -600, 0, 0,   0);
        vertex( 150, -600, 0, 512, 0);
        vertex( 150,  600, 0, 512, 512);
        vertex(-150,  600, 0, 0,   512);
      endShape();
    popMatrix();
    
    pushMatrix();  //Local transformation group
      //Back face
      tint(CPHu, CPS, CPB, CPA/3); 
      translate(CPX, (height/3)+CPY, -1280-(CPZ+CPA*DepthRate));
      beginShape();
        texture(CPT);
        vertex(-150, -600, -100, 0,   0);
        vertex( 150, -600, -100, 512, 0);
        vertex( 150,  600, -100, 512, 512);
        vertex(-150,  600, -100, 0,   512);
      endShape();
    popMatrix();

    //Reset
    blendMode(BLEND);
  }
}
