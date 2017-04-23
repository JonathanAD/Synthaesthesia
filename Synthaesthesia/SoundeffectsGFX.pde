class SoundEffectsGFX {
  float SoEX ;
  float SoEY ;
  float SoEZ ;
  float SoEW ;
  float SoEH ;
  float SoED ;
  float SoEHu;
  float SoES ;
  float SoEB ;
  float SoEA ;
  PImage SoET ;
  
  SoundEffectsGFX (float SoundEffectsX, float SoundEffectsY, float SoundEffectsZ, float SoundEffectsWidth, float SoundEffectsHeight, float SoundEffectsDepth, float SoundEffectsHue, float SoundEffectsSaturation, float SoundEffectsBrightness, float SoundEffectsAlpha, PImage SoundEffectsTexture) {
    SoEX  = SoundEffectsX;
    SoEY  = SoundEffectsY;
    SoEZ  = SoundEffectsZ;
    SoEW  = SoundEffectsWidth;
    SoEH  = SoundEffectsHeight;
    SoED  = SoundEffectsDepth;
    SoEHu = SoundEffectsHue;
    SoES  = SoundEffectsSaturation;
    SoEB  = SoundEffectsBrightness;
    SoEA  = SoundEffectsAlpha;
    SoET  = SoundEffectsTexture;
  }
  void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, SoEA); 
  translate(SoEX, SoEY, SoEZ);
  beginShape();
    texture(SoET);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-SoEX, -SoEY, -SoEZ);
  blendMode(BLEND);
  }
}
