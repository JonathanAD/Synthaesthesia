class SynthEffectsGFX {
  float SEX ;
  float SEY ;
  float SEZ ;
  float SEW ;
  float SEH ;
  float SED ;
  float SEHu;
  float SES ;
  float SEB ;
  float SEA ;
  PImage SET ;
  
  SynthEffectsGFX (float SynthEffectsX, float SynthEffectsY, float SynthEffectsZ, float SynthEffectsWidth, float SynthEffectsHeight, float SynthEffectsDepth, float SynthEffectsHue, float SynthEffectsSaturation, float SynthEffectsBrightness, float SynthEffectsAlpha, PImage SynthEffectsTexture) {
    SEX  = SynthEffectsX;
    SEY  = SynthEffectsY;
    SEZ  = SynthEffectsZ;
    SEW  = SynthEffectsWidth;
    SEH  = SynthEffectsHeight;
    SED  = SynthEffectsDepth;
    SEHu = SynthEffectsHue;
    SES  = SynthEffectsSaturation;
    SEB  = SynthEffectsBrightness;
    SEA  = SynthEffectsAlpha;
    SET  = SynthEffectsTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, SEA); 
  translate(SEX, SEY, SEZ);
  beginShape();
    texture(SET);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-SEX, -SEY, -SEZ);
  blendMode(BLEND);
  }
}
