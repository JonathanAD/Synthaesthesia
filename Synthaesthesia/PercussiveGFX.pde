class PercussiveGFX {
  float  PvX ;
  float  PvY ;
  float  PvZ ;
  float  PvW ;
  float  PvH ;
  float  PvD ;
  float  PvHu;
  float  PvS ;
  float  PvB ;
  float  PvA ;
  PImage PvT ;
  PImage PvT2;
  
  PercussiveGFX (
    float PercussiveX, 
    float PercussiveY, 
    float PercussiveZ, 
    float PercussiveWidth, 
    float PercussiveHeight, 
    float PercussiveDepth, 
    float PercussiveHue, 
    float PercussiveSaturation, 
    float PercussiveBrightness, 
    float PercussiveAlpha, 
    PImage PercussiveTexture, 
    PImage PercussiveTexture2) {
      PvX  = PercussiveX;
      PvY  = PercussiveY;
      PvZ  = PercussiveZ;
      PvW  = PercussiveWidth;
      PvH  = PercussiveHeight;
      PvD  = PercussiveDepth;
      PvHu = PercussiveHue;
      PvS  = PercussiveSaturation;
      PvB  = PercussiveBrightness;
      PvA  = PercussiveAlpha;
      PvT  = PercussiveTexture; 
      PvT2 = PercussiveTexture2; 
  }

  void display() {
        //Setup
    blendMode(ADD);  //Additive blending mode
    
    //Shapes
    //Front
    pushMatrix();  //Local transformation group
      tint(PvHu, PvS, PvB, PvA);  
      translate(PvX, (height/2)+PvY*2, 500+PvZ-(PvA*(DepthRate/4)-256));
     beginShape();
       texture(PvT);
       vertex(-PvA*4, -PvA*4, 0, 0,   0);
       vertex( PvA*4, -PvA*4, 0, 512, 0);
       vertex( PvA*4,  PvA*4, 0, 512, 512);
       vertex(-PvA*4,  PvA*4, 0, 0,   512);
     endShape();
     beginShape();
     popMatrix();
     //Rim
     pushMatrix();  //Local transformation group
      tint(PvHu, PvS, PvB, PvA);  
      translate(PvX, (height/2)+PvY*2, PvZ-(PvA*(DepthRate/4)-256));
     beginShape();
       texture(PvT2);
       vertex(-PvA*8, -PvA*8, 0, 0,   0);
       vertex( PvA*8, -PvA*8, 0, 512, 0);
       vertex( PvA*8,  PvA*8, 0, 512, 512);
       vertex(-PvA*8,  PvA*8, 0, 0,   512);
     endShape();
     beginShape();
     popMatrix();

    //Reset
    blendMode(BLEND);
  }
}
