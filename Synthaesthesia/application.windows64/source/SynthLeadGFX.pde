class SynthLeadGFX {
  float SLX ;
  float SLY ;
  float SLZ ;
  float SLW ;
  float SLH ;
  float SLD ;
  float SLHu;
  float SLS ;
  float SLB ;
  float SLA ;
  PImage SLT ;
  
  SynthLeadGFX (float SynthLeadX, float SynthLeadY, float SynthLeadZ, float SynthLeadWidth, float SynthLeadHeight, float SynthLeadDepth, float SynthLeadHue, float SynthLeadSaturation, float SynthLeadBrightness, float SynthLeadAlpha, PImage SynthLeadTexture) {
    SLX  = SynthLeadX;
    SLY  = SynthLeadY;
    SLZ  = SynthLeadZ;
    SLW  = SynthLeadWidth;
    SLH  = SynthLeadHeight;
    SLD  = SynthLeadDepth;
    SLHu = SynthLeadHue;
    SLS  = SynthLeadSaturation;
    SLB  = SynthLeadBrightness;
    SLA  = SynthLeadAlpha;
    SLT  = SynthLeadTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, SLA); 
  translate(SLX, SLY, SLZ);
  beginShape();
    texture(SLT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-SLX, -SLY, -SLZ);
  blendMode(BLEND);
  }
}
