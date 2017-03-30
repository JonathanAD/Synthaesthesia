class Star { 
  float x=0,y=0,z=0,sx=0,sy=0;
  void SetPosition(){
    z=(float) random(200,255);
    x=(float) random(-1000,1000);
    y=(float) random(-1000,1000);
  }
  void DrawStar(){
    if (z<SPEED){
  this.SetPosition();
    }
    z-=SPEED;
    sx=(x*SPREAD)/(z)+CX;
    sy=(y*SPREAD)/(4+z)+CY;
    if (sx<0 | sx>width){
  this.SetPosition();
    }
    if (sy<0 | sy>height){
  this.SetPosition();
    }
    fill(color(255 - (int) z,255 - (int) z,255 - (int) z));
//    fill(random(255),random(255),random(255));
    rect( (int) sx,(int) sy,2,3);
  }
}
