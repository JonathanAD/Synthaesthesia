class PercussionGFX {
  float  PnX ;
  float  PnY ;
  float  PnZ ;
  float  PnW ;
  float  PnH ;
  float  PnD ;
  float  PnHu;
  float  PnS ;
  float  PnB ;
  float  PnA ;
  PImage PnT ;
  PImage PnT2;
  
  PercussionGFX (
    float PercussionX, 
    float PercussionY, 
    float PercussionZ, 
    float PercussionWidth, 
    float PercussionHeight, 
    float PercussionDepth, 
    float PercussionHue, 
    float PercussionSaturation, 
    float PercussionBrightness, 
    float PercussionAlpha, 
    PImage PercussionTexture, 
    PImage PercussionTexture2) {
      PnX  = PercussionX;
      PnY  = PercussionY;
      PnZ  = PercussionZ;
      PnW  = PercussionWidth;
      PnH  = PercussionHeight;
      PnD  = PercussionDepth;
      PnHu = PercussionHue;
      PnS  = PercussionSaturation;
      PnB  = PercussionBrightness;
      PnA  = PercussionAlpha;
      PnT  = PercussionTexture; 
      PnT2 = PercussionTexture2; 
  }

  void display() {
        //Setup
    blendMode(ADD);  //Additive blending mode
    
        //Shapes
    //Front
    pushMatrix();  //Local transformation group
      tint(PnHu, PnS, PnB, PnA*4);  
      translate(PnX, height/2, 500+PnZ-(PnA*(DepthRate/4)-256));
     beginShape();
       texture(PnT);
       vertex(-PnA*4, -PnA*4, 0, 0,   0);
       vertex( PnA*4, -PnA*4, 0, 512, 0);
       vertex( PnA*4,  PnA*4, 0, 512, 512);
       vertex(-PnA*4,  PnA*4, 0, 0,   512);
     endShape();
     beginShape();
     popMatrix();
     //Rim
     pushMatrix();  //Local transformation group
      tint(PnHu, PnS, PnB, PnA*4);  
      translate(PnX, height/2, PnZ-(PnA*(DepthRate/4)-256));
     beginShape();
       texture(PnT2);
       vertex(-PnA*8, -PnA*8, 0, 0,   0);
       vertex( PnA*8, -PnA*8, 0, 512, 0);
       vertex( PnA*8,  PnA*8, 0, 512, 512);
       vertex(-PnA*8,  PnA*8, 0, 0,   512);
     endShape();
     beginShape();
     popMatrix();

    //Reset
    blendMode(BLEND);
  }
}
