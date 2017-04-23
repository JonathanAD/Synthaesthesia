class GuitarGFX {
  float  GX ;
  float  GY ;
  float  GZ ;
  float  GW ;
  float  GH ;
  float  GD ;
  float  GHu;
  float  GS ;
  float  GB ;
  float  GA ;
  PImage GT ;
  
  GuitarGFX (float GuitarX, float GuitarY, float GuitarZ, float GuitarWidth, float GuitarHeight, float GuitarDepth, float GuitarHue, float GuitarSaturation, float GuitarBrightness, float GuitarAlpha, PImage GuitarTexture) {
    GX  = GuitarX;
    GY  = GuitarY;
    GZ  = GuitarZ;
    GW  = GuitarWidth;
    GH  = GuitarHeight;
    GD  = GuitarDepth;
    GHu = GuitarHue;
    GS  = GuitarSaturation;
    GB  = GuitarBrightness;
    GA  = GuitarAlpha;
    GT  = GuitarTexture; 
  }
  void display() {
  
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, GA);  
  translate(GX, GY, GZ);
  beginShape();
    texture(GT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-GX, -GY, -GZ);
  blendMode(BLEND);
  }
}
