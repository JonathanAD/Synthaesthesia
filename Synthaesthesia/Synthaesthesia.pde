

//Synthesthesia
//MIDI music visualizer
//By Jonathan Arias

//Import libraries
import themidibus.*; // MIDI interface bridge
import queasycam.*;  // Free view camera

//Create instances
Debug debug;                                    // Debug
Background background;                          // Background
QueasyCam cam; //Dynamic camera
MidiBus myBus;                                  // MIDIBus
PianoGFX pianogfx;                              // Piano graphics
ChromaticPercussionGFX chromaticpercussiongfx;  // Chromatic Percussion graphics
OrganGFX organgfx;                              // Organ graphics

//Declare global Arrays
int[] Channels           = new int[128];
int[] Pitches            = new int[128]; //***Uninitialized***
int[] Velocities         = new int[128]; //***Uninitialized***
int[] PitchHues          = new int[12];
int[] OctaveSaturations  = new int[11];
int[] OctaveBrightnesses = new int[11];

//Declare and initialize global Variables
float Depth = -500; // 3D object starting position
float Tempo =  120; // Speed at which objects will move towards the camera
int Channel  =  -1; // Global Channel
int Pitch    =  -1; // Global Pitch
int Velocity =  -1; // Global Velocity
float PitchX         = 0; // Note pitch mapped to window width
float VelocityY      = 0; // Note velocity mapped to window height
float PitchScaleX    = 0; // Note pitch mapped to X scale
float VelocityScaleY = 0; // Note velocity mapped to window height
float PitchHue       = 0; // Note pitch mapped to color hue (0-255)
float VelocityAlpha  = 100; // Note intensity mapped to transparency

//Shapes
//Sky dome
PImage sky;
PShape dome;
float sphereRotateX = 0;
float sphereRotateY = 1;
float sphereRotateZ = 0;
int cX = width/2;   //Display center X-Axis
int cY = height/2;  //Display center Y-Axis
int mX = mouseX;    //Mouse position X-Axis
int mY = mouseY;    //Mouse position Y-Axis
//Grid
PShape Line1;
PShape Line2;
PShape Line3;
PShape Line4;
int Line1Z = -1024;
int Line2Z = -256;
int Line3Z = -384;
int Line4Z = -512;

//Setup
void setup() {
//  size(950, 540);        // 1/4 1080p
//  size(950, 540, P3D);     // 1/4 1080p 3D
//  size(1280, 720);       // 720p 2D
  size(1280, 720, P3D);  // 720p 3D
  smooth(8);             // 8X Antialiasing
  
  //Camera
//  cam = new QueasyCam(this);
//  cam.speed = 2;                    //Default is 2
//  cam.sensitivity = 0.25;              //Default is 0.25
  
//Initialize variables
  //MIDI channels
  Channels[0]  = -1;
  Channels[1]  = -1;
  Channels[2]  = -1;
  Channels[3]  = -1;
  Channels[4]  = -1;
  Channels[5]  = -1;
  Channels[6]  = -1;
  Channels[7]  = -1;
  Channels[8]  = -1;
  Channels[9]  = -1;
  Channels[10] = -1;
  Channels[11] = -1;
  Channels[12] = -1;
  Channels[13] = -1;
  Channels[14] = -1;
  Channels[15] = -1;
  Channels[16] = -1;
  Pitches[0]   = -1;
  Pitches[1]   = -1;
  Pitches[2]   = -1;
  Pitches[3]   = -1;
  Pitches[4]   = -1;
  Pitches[5]   = -1;
  Pitches[6]   = -1;
  Pitches[7]   = -1;
  Pitches[8]   = -1;
  Pitches[9]   = -1;
  Pitches[10]  = -1;
  Pitches[11]  = -1;
  Pitches[12]  = -1;
  Pitches[13]  = -1;
  Pitches[14]  = -1;
  Pitches[15]  = -1;
  Pitches[16]  = -1;
  Pitches[17]  = -1;
  Pitches[18]  = -1;
  Pitches[19]  = -1;
  Pitches[20]  = -1;
  Pitches[21]  = -1;
  Pitches[22]  = -1;
  Pitches[23]  = -1;
  Pitches[24]  = -1;
  Pitches[25]  = -1;
  Pitches[26]  = -1;
  Pitches[27]  = -1;
  Pitches[28]  = -1;
  Pitches[29]  = -1;
  Pitches[30]  = -1;
  Pitches[31]  = -1;
  Pitches[32]  = -1;
  Pitches[33]  = -1;
  Pitches[34]  = -1;
  Pitches[35]  = -1;
  Pitches[36]  = -1;
  Pitches[37]  = -1;
  Pitches[38]  = -1;
  Pitches[39]  = -1;
  Pitches[40]  = -1;
  Pitches[41]  = -1;
  Pitches[42]  = -1;
  Pitches[43]  = -1;
  Pitches[44]  = -1;
  Pitches[45]  = -1;
  Pitches[46]  = -1;
  Pitches[47]  = -1;
  Pitches[48]  = -1;
  Pitches[49]  = -1;
  Pitches[50]  = -1;
  Pitches[51]  = -1;
  Pitches[52]  = -1;
  Pitches[53]  = -1;
  Pitches[54]  = -1;
  Pitches[55]  = -1;
  Pitches[56]  = -1;
  Pitches[57]  = -1;
  Pitches[58]  = -1;
  Pitches[59]  = -1;
  Pitches[60]  = -1;
  Pitches[61]  = -1;
  Pitches[62]  = -1;
  Pitches[63]  = -1;
  Pitches[64]  = -1;
  Pitches[65]  = -1;
  Pitches[66]  = -1;
  Pitches[67]  = -1;
  Pitches[68]  = -1;
  Pitches[69]  = -1;
  Pitches[70]  = -1;
  Pitches[71]  = -1;
  Pitches[72]  = -1;
  Pitches[73]  = -1;
  Pitches[74]  = -1;
  Pitches[75]  = -1;
  Pitches[76]  = -1;
  Pitches[77]  = -1;
  Pitches[78]  = -1;
  Pitches[79]  = -1;
  Pitches[80]  = -1;
  Pitches[81]  = -1;
  Pitches[82]  = -1;
  Pitches[83]  = -1;
  Pitches[84]  = -1;
  Pitches[85]  = -1;
  Pitches[86]  = -1;
  Pitches[87]  = -1;
  Pitches[88]  = -1;
  Pitches[89]  = -1;
  Pitches[90]  = -1;
  Pitches[91]  = -1;
  Pitches[92]  = -1;
  Pitches[93]  = -1;
  Pitches[94]  = -1;
  Pitches[95]  = -1;
  Pitches[96]  = -1;
  Pitches[97]  = -1;
  Pitches[98]  = -1;
  Pitches[99]  = -1;
  Pitches[100] = -1;
  Pitches[101] = -1;
  Pitches[102] = -1;
  Pitches[103] = -1;
  Pitches[104] = -1;
  Pitches[105] = -1;
  Pitches[106] = -1;
  Pitches[107] = -1;
  Pitches[108] = -1;
  Pitches[109] = -1;
  Pitches[110] = -1;
  Pitches[111] = -1;
  Pitches[112] = -1;
  Pitches[113] = -1;
  Pitches[114] = -1;
  Pitches[115] = -1;
  Pitches[116] = -1;
  Pitches[117] = -1;
  Pitches[118] = -1;
  Pitches[119] = -1;
  Pitches[120] = -1;
  Pitches[121] = -1;
  Pitches[122] = -1;
  Pitches[123] = -1;
  Pitches[124] = -1;
  Pitches[125] = -1;
  Pitches[126] = -1;
  Pitches[127] = -1;
  //Note-to-color correspondence (/360)
  PitchHues[0]  =   0; // C  - Red
  PitchHues[1]  = 210; // C# - Blue-Cyan
  PitchHues[2]  =  60; // D  - Yellow
  PitchHues[3]  = 270; // D# - Blue-Magenta
  PitchHues[4]  = 120; // E  - Green
  PitchHues[5]  = 330; // F  - Red-Magenta
  PitchHues[6]  = 180; // F# - Cyan
  PitchHues[7]  =  30; // G  - Orange
  PitchHues[8]  = 240; // G# - Blue
  PitchHues[9]  =  90; // A  - Yellow-Green
  PitchHues[10] = 300; // A# - Magenta
  PitchHues[11] = 150; // B  - Green-Cyans
  //Octave-to-saturation correspondence (/100)
  OctaveSaturations[0]  =  95; // Octave -1 saturation
  OctaveSaturations[1]  = 127; // Octave 0 saturation
  OctaveSaturations[2]  = 159; // Octave 1 saturation
  OctaveSaturations[3]  = 191; // Octave 2 saturation
  OctaveSaturations[4]  = 223; // Octave 3 saturation
  OctaveSaturations[5]  = 255; // Octave 4 saturation
  OctaveSaturations[6]  = 191; // Octave 5 saturation
  OctaveSaturations[7]  = 127; // Octave 6 saturation
  OctaveSaturations[8]  =  63; // Octave 7 saturation
  OctaveSaturations[9]  =   0; // Octave 8 saturation
  OctaveSaturations[10] =   0; // Octave 9 saturation
  //Octave-to-brightness correspondence (/100)
  OctaveBrightnesses[0]  =   0; // Octave -1 brightness
  OctaveBrightnesses[1]  =   0; // Octave 0 brightness
  OctaveBrightnesses[2]  =  31; // Octave 1 brightness
  OctaveBrightnesses[3]  =  63; // Octave 2 brightness
  OctaveBrightnesses[4]  =  95; // Octave 3 brightness
  OctaveBrightnesses[5]  = 127; // Octave 4 brightness
  OctaveBrightnesses[6]  = 191; // Octave 5 brightness
  OctaveBrightnesses[7]  = 255; // Octave 6 brightness
  OctaveBrightnesses[8]  = 255; // Octave 7 brightness
  OctaveBrightnesses[9]  = 255; // Octave 8 brightness
  OctaveBrightnesses[10] = 255; // Octave 9 brightness
  
  //MIDI data
  MidiBus.list();                     // List available Midi devices
  myBus = new MidiBus(this, 0, -1);   // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  
  //Sphere - Inner (Sky dome)
  dome = createShape(SPHERE, 2500);
  sky = loadImage("sky.jpg");
  dome.setTexture(sky);
  
  //Grid
  Line1 = createShape();
    Line1.beginShape(LINES);
      Line1.stroke(255);
      Line1.vertex(width, height, 0);
      Line1.vertex(0, height, 0);      
    Line1.endShape();

  Line2 = createShape();
    Line2.beginShape(LINES);
      Line2.stroke(127);
      Line2.vertex(width, height, 0);
      Line2.vertex(0, height, 0);      
    Line2.endShape();

  Line3 = createShape();
    Line3.beginShape(LINES);
      Line3.stroke(127);
      Line3.vertex(width, height, 0);
      Line3.vertex(0, height, 0);      
    Line3.endShape();

  Line4 = createShape();
    Line4.beginShape(LINES);
      Line4.stroke(127);
      Line4.vertex(width, height, 0);
      Line4.vertex(0, height, 0);      
    Line4.endShape(); 
}

//Draw
void draw() {
  debug = new Debug();
//  debug.framerate();
  debug.clickToPrintVariables();
  
  background = new Background(width, height, 500, width, height, 500, PitchHue, 50, 15, 25);
  background.black();

//  //Sky
  noStroke();
//  translate(width/2,-100,-100);
  rotateY(radians(sphereRotateY));
  noStroke();
  shape(dome);
//  sphereRotateY = sphereRotateY+0.05; //Animation/Gyro drift fix
  
  //Grid
//  translate(0, 0, Line1Z);
//  shape(Line1);
//  translate(0, 0, Line2Z);
//  shape(Line2);
//  translate(0, 0, Line3Z);
//  shape(Line3);
//  translate(0, 0, Line4Z);
//  shape(Line4);
//  if (Line1Z < 2048) {
//    Line1Z = Line1Z + 2;
//  }
//  else if (Line1Z >= 0) {
//    Line1Z = -250;
//  }

  //Piano
if (Channels[0] == 0) { // Piano Channel graphics      X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha
  if (Pitches[0]   ==   0) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[1]   ==   1) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[2]   ==   2) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[3]   ==   3) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[4]   ==   4) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[5]   ==   5) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[6]   ==   6) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[7]   ==   7) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[8]   ==   8) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[9]   ==   9) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[10]  ==  10) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[11]  ==  11) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  100); pianogfx.display();}
  if (Pitches[12]  ==  12) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[13]  ==  13) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[14]  ==  14) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[15]  ==  15) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[16]  ==  16) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[17]  ==  17) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[18]  ==  18) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[19]  ==  19) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[20]  ==  20) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[21]  ==  21) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[22]  ==  22) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[23]  ==  23) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],  100); pianogfx.display();}
  if (Pitches[24]  ==  24) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[25]  ==  25) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[26]  ==  26) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[27]  ==  27) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[28]  ==  28) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[29]  ==  29) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[30]  ==  30) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[31]  ==  31) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[32]  ==  32) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[33]  ==  33) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[34]  ==  34) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[35]  ==  35) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],  100); pianogfx.display();}
  if (Pitches[36]  ==  36) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[37]  ==  37) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[38]  ==  38) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[39]  ==  39) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[40]  ==  40) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[41]  ==  41) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[42]  ==  42) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[43]  ==  43) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[44]  ==  44) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[45]  ==  45) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[46]  ==  46) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[47]  ==  47) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],  100); pianogfx.display();}
  if (Pitches[48]  ==  48) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[49]  ==  49) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[50]  ==  50) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[51]  ==  51) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[52]  ==  52) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[53]  ==  53) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[54]  ==  54) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[55]  ==  55) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[56]  ==  56) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[57]  ==  57) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[58]  ==  58) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[59]  ==  59) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],  100); pianogfx.display();}
  if (Pitches[60]  ==  60) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[61]  ==  61) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[62]  ==  62) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[63]  ==  63) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[64]  ==  64) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[65]  ==  65) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[66]  ==  66) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[67]  ==  67) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[68]  ==  68) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[69]  ==  69) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[70]  ==  70) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[71]  ==  71) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],  100); pianogfx.display();}
  if (Pitches[72]  ==  72) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[73]  ==  73) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[74]  ==  74) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[75]  ==  75) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[76]  ==  76) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[77]  ==  77) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[78]  ==  78) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[79]  ==  79) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[80]  ==  80) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[81]  ==  81) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[82]  ==  82) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[83]  ==  83) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],  100); pianogfx.display();}
  if (Pitches[84]  ==  84) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[85]  ==  85) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[86]  ==  86) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[87]  ==  87) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[88]  ==  88) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[89]  ==  89) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[90]  ==  90) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[91]  ==  91) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[92]  ==  92) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[93]  ==  93) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[94]  ==  94) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[95]  ==  95) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],  100); pianogfx.display();}
  if (Pitches[96]  ==  96) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[97]  ==  97) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[98]  ==  98) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[99]  ==  99) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[100] == 100) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[101] == 101) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[102] == 102) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[103] == 103) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[104] == 104) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[105] == 105) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[106] == 106) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[107] == 107) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],  100); pianogfx.display();}
  if (Pitches[108] == 108) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[109] == 109) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[110] == 110) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[111] == 111) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[112] == 112) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[113] == 113) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[114] == 114) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[115] == 115) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[116] == 116) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[117] == 117) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[118] == 118) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[119] == 119) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],  100); pianogfx.display();}
  if (Pitches[120] == 120) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[121] == 121) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[122] == 122) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[123] == 123) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[124] == 124) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[125] == 125) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[126] == 126) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
  if (Pitches[127] == 127) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10], 100); pianogfx.display();}
}

  //Chromatic Percussion
if (Channels[1] == 1) { // Chromatic Percussion Channel graphics                   X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha
  if (Pitches[0]   ==   0) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[1]   ==   1) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[2]   ==   2) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[3]   ==   3) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[4]   ==   4) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[5]   ==   5) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[6]   ==   6) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[7]   ==   7) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[8]   ==   8) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[9]   ==   9) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[10]  ==  10) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[11]  ==  11) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  100); chromaticpercussiongfx.display();}
  if (Pitches[12]  ==  12) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[13]  ==  13) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[14]  ==  14) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[15]  ==  15) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[16]  ==  16) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[17]  ==  17) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[18]  ==  18) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[19]  ==  19) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[20]  ==  20) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[21]  ==  21) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[22]  ==  22) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[23]  ==  23) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],  100); chromaticpercussiongfx.display();}
  if (Pitches[24]  ==  24) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[25]  ==  25) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[26]  ==  26) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[27]  ==  27) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[28]  ==  28) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[29]  ==  29) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[30]  ==  30) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[31]  ==  31) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[32]  ==  32) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[33]  ==  33) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[34]  ==  34) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[35]  ==  35) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],  100); chromaticpercussiongfx.display();}
  if (Pitches[36]  ==  36) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[37]  ==  37) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[38]  ==  38) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[39]  ==  39) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[40]  ==  40) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[41]  ==  41) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[42]  ==  42) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[43]  ==  43) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[44]  ==  44) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[45]  ==  45) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[46]  ==  46) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[47]  ==  47) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],  100); chromaticpercussiongfx.display();}
  if (Pitches[48]  ==  48) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[49]  ==  49) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[50]  ==  50) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[51]  ==  51) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[52]  ==  52) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[53]  ==  53) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[54]  ==  54) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[55]  ==  55) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[56]  ==  56) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[57]  ==  57) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[58]  ==  58) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[59]  ==  59) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],  100); chromaticpercussiongfx.display();}
  if (Pitches[60]  ==  60) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[61]  ==  61) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[62]  ==  62) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[63]  ==  63) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[64]  ==  64) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[65]  ==  65) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[66]  ==  66) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[67]  ==  67) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[68]  ==  68) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[69]  ==  69) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[70]  ==  70) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[71]  ==  71) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],  100); chromaticpercussiongfx.display();}
  if (Pitches[72]  ==  72) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[73]  ==  73) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[74]  ==  74) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[75]  ==  75) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[76]  ==  76) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[77]  ==  77) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[78]  ==  78) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[79]  ==  79) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[80]  ==  80) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[81]  ==  81) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[82]  ==  82) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[83]  ==  83) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],  100); chromaticpercussiongfx.display();}
  if (Pitches[84]  ==  84) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[85]  ==  85) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[86]  ==  86) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[87]  ==  87) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[88]  ==  88) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[89]  ==  89) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[90]  ==  90) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[91]  ==  91) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[92]  ==  92) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[93]  ==  93) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[94]  ==  94) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[95]  ==  95) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],  100); chromaticpercussiongfx.display();}
  if (Pitches[96]  ==  96) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[97]  ==  97) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[98]  ==  98) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[99]  ==  99) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[100] == 100) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[101] == 101) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[102] == 102) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[103] == 103) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[104] == 104) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[105] == 105) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[106] == 106) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[107] == 107) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],  100); chromaticpercussiongfx.display();}
  if (Pitches[108] == 108) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[109] == 109) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[110] == 110) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[111] == 111) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[112] == 112) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[113] == 113) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[114] == 114) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[115] == 115) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[116] == 116) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[117] == 117) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[118] == 118) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[119] == 119) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],  100); chromaticpercussiongfx.display();}
  if (Pitches[120] == 120) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[121] == 121) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[122] == 122) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[123] == 123) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[124] == 124) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[125] == 125) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[126] == 126) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  if (Pitches[127] == 127) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10], 100); chromaticpercussiongfx.display();}
  }
}

//Note on event
void noteOn(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel = channel;
  Pitch = pitch;
  Velocity = velocity;

  //Local variables
  float pitchX      =   map(pitch, 0,   127,  0, width);
  float pitchScaleX =   map(pitch, 0,   127, 50,    10);
  float pitchHue    =   int(map(pitch, 0,  127,  0,    255));
  float velocityY =          map(velocity, 0, 127, height-10, height/8);
  float velocityScaleY =     map(velocity, 0, 127, 5, 20);

  //Update local variables
  PitchX         = pitchX         ;
  PitchScaleX    = pitchScaleX    ;
  PitchHue       = pitchHue       ;
  VelocityY      = velocityY      ;
  VelocityScaleY = velocityScaleY*4 ;

  //Print global variables
  debug = new Debug();
  debug.noteOnReturn();
  
  if (channel ==   0) {Channels[0] = channel;}
  if (channel ==   1) {Channels[1] = channel;}
  if (channel ==   2) {Channels[2] = channel;}
  if (channel ==   3) {Channels[3] = channel;}
  if (channel ==   4) {Channels[4] = channel;}
  if (channel ==   5) {Channels[5] = channel;}
  if (channel ==   6) {Channels[6] = channel;}
  if (channel ==   7) {Channels[7] = channel;}
  if (channel ==   8) {Channels[8] = channel;}
  if (channel ==   9) {Channels[9] = channel;}
  if (channel ==  10) {Channels[10] = channel;}
  if (channel ==  11) {Channels[11] = channel;}
  if (channel ==  12) {Channels[12] = channel;}
  if (channel ==  13) {Channels[13] = channel;}
  if (channel ==  14) {Channels[14] = channel;}
  if (channel ==  15) {Channels[15] = channel;}
  if (channel ==  16) {Channels[16] = channel;}

  if (pitch ==   0) {Pitches[0] = pitch;}
  if (pitch ==   1) {Pitches[1] = pitch;}
  if (pitch ==   2) {Pitches[2] = pitch;}
  if (pitch ==   3) {Pitches[3] = pitch;}
  if (pitch ==   4) {Pitches[4] = pitch;}
  if (pitch ==   5) {Pitches[5] = pitch;}
  if (pitch ==   6) {Pitches[6] = pitch;}
  if (pitch ==   7) {Pitches[7] = pitch;}
  if (pitch ==   8) {Pitches[8] = pitch;}
  if (pitch ==   9) {Pitches[9] = pitch;}
  if (pitch ==  10) {Pitches[10] = pitch;}
  if (pitch ==  11) {Pitches[11] = pitch;}
  if (pitch ==  12) {Pitches[12] = pitch;}
  if (pitch ==  13) {Pitches[13] = pitch;}
  if (pitch ==  14) {Pitches[14] = pitch;}
  if (pitch ==  15) {Pitches[15] = pitch;}
  if (pitch ==  16) {Pitches[16] = pitch;}
  if (pitch ==  17) {Pitches[17] = pitch;}
  if (pitch ==  18) {Pitches[18] = pitch;}
  if (pitch ==  19) {Pitches[19] = pitch;}
  if (pitch ==  20) {Pitches[20] = pitch;}
  if (pitch ==  21) {Pitches[21] = pitch;}
  if (pitch ==  22) {Pitches[22] = pitch;}
  if (pitch ==  23) {Pitches[23] = pitch;}
  if (pitch ==  24) {Pitches[24] = pitch;}
  if (pitch ==  25) {Pitches[25] = pitch;}
  if (pitch ==  26) {Pitches[26] = pitch;}
  if (pitch ==  27) {Pitches[27] = pitch;}
  if (pitch ==  28) {Pitches[28] = pitch;}
  if (pitch ==  29) {Pitches[29] = pitch;}
  if (pitch ==  30) {Pitches[30] = pitch;}
  if (pitch ==  31) {Pitches[31] = pitch;}
  if (pitch ==  32) {Pitches[32] = pitch;}
  if (pitch ==  33) {Pitches[33] = pitch;}
  if (pitch ==  34) {Pitches[34] = pitch;}
  if (pitch ==  35) {Pitches[35] = pitch;}
  if (pitch ==  36) {Pitches[36] = pitch;}
  if (pitch ==  37) {Pitches[37] = pitch;}
  if (pitch ==  38) {Pitches[38] = pitch;}
  if (pitch ==  39) {Pitches[39] = pitch;}
  if (pitch ==  40) {Pitches[40] = pitch;}
  if (pitch ==  41) {Pitches[41] = pitch;}
  if (pitch ==  42) {Pitches[42] = pitch;}
  if (pitch ==  43) {Pitches[43] = pitch;}
  if (pitch ==  44) {Pitches[44] = pitch;}
  if (pitch ==  45) {Pitches[45] = pitch;}
  if (pitch ==  46) {Pitches[46] = pitch;}
  if (pitch ==  47) {Pitches[47] = pitch;}
  if (pitch ==  48) {Pitches[48] = pitch;}
  if (pitch ==  49) {Pitches[49] = pitch;}
  if (pitch ==  50) {Pitches[50] = pitch;}
  if (pitch ==  51) {Pitches[51] = pitch;}
  if (pitch ==  52) {Pitches[52] = pitch;}
  if (pitch ==  53) {Pitches[53] = pitch;}
  if (pitch ==  54) {Pitches[54] = pitch;}
  if (pitch ==  55) {Pitches[55] = pitch;}
  if (pitch ==  56) {Pitches[56] = pitch;}
  if (pitch ==  57) {Pitches[57] = pitch;}
  if (pitch ==  58) {Pitches[58] = pitch;}
  if (pitch ==  59) {Pitches[59] = pitch;}
  if (pitch ==  60) {Pitches[60] = pitch;}
  if (pitch ==  61) {Pitches[61] = pitch;}
  if (pitch ==  62) {Pitches[62] = pitch;}
  if (pitch ==  63) {Pitches[63] = pitch;}
  if (pitch ==  64) {Pitches[64] = pitch;}
  if (pitch ==  65) {Pitches[65] = pitch;}
  if (pitch ==  66) {Pitches[66] = pitch;}
  if (pitch ==  67) {Pitches[67] = pitch;}
  if (pitch ==  68) {Pitches[68] = pitch;}
  if (pitch ==  69) {Pitches[69] = pitch;}
  if (pitch ==  70) {Pitches[70] = pitch;}
  if (pitch ==  71) {Pitches[71] = pitch;}
  if (pitch ==  72) {Pitches[72] = pitch;}
  if (pitch ==  73) {Pitches[73] = pitch;}
  if (pitch ==  74) {Pitches[74] = pitch;}
  if (pitch ==  75) {Pitches[75] = pitch;}
  if (pitch ==  76) {Pitches[76] = pitch;}
  if (pitch ==  77) {Pitches[77] = pitch;}
  if (pitch ==  78) {Pitches[78] = pitch;}
  if (pitch ==  79) {Pitches[79] = pitch;}
  if (pitch ==  80) {Pitches[80] = pitch;}
  if (pitch ==  81) {Pitches[81] = pitch;}
  if (pitch ==  82) {Pitches[82] = pitch;}
  if (pitch ==  83) {Pitches[83] = pitch;}
  if (pitch ==  84) {Pitches[84] = pitch;}
  if (pitch ==  85) {Pitches[85] = pitch;}
  if (pitch ==  86) {Pitches[86] = pitch;}
  if (pitch ==  87) {Pitches[87] = pitch;}
  if (pitch ==  88) {Pitches[88] = pitch;}
  if (pitch ==  89) {Pitches[89] = pitch;}
  if (pitch ==  90) {Pitches[90] = pitch;}
  if (pitch ==  91) {Pitches[91] = pitch;}
  if (pitch ==  92) {Pitches[92] = pitch;}
  if (pitch ==  93) {Pitches[93] = pitch;}
  if (pitch ==  94) {Pitches[94] = pitch;}
  if (pitch ==  95) {Pitches[95] = pitch;}
  if (pitch ==  96) {Pitches[96] = pitch;}
  if (pitch ==  97) {Pitches[97] = pitch;}
  if (pitch ==  98) {Pitches[98] = pitch;}
  if (pitch ==  99) {Pitches[99] = pitch;}
  if (pitch == 100) {Pitches[100] = pitch;}
  if (pitch == 101) {Pitches[101] = pitch;}
  if (pitch == 102) {Pitches[102] = pitch;}
  if (pitch == 103) {Pitches[103] = pitch;}
  if (pitch == 104) {Pitches[104] = pitch;}
  if (pitch == 105) {Pitches[105] = pitch;}
  if (pitch == 106) {Pitches[106] = pitch;}
  if (pitch == 107) {Pitches[107] = pitch;}
  if (pitch == 108) {Pitches[108] = pitch;}
  if (pitch == 109) {Pitches[109] = pitch;}
  if (pitch == 110) {Pitches[110] = pitch;}
  if (pitch == 111) {Pitches[111] = pitch;}
  if (pitch == 112) {Pitches[112] = pitch;}
  if (pitch == 113) {Pitches[113] = pitch;}
  if (pitch == 114) {Pitches[114] = pitch;}
  if (pitch == 115) {Pitches[115] = pitch;}
  if (pitch == 116) {Pitches[116] = pitch;}
  if (pitch == 117) {Pitches[117] = pitch;}
  if (pitch == 118) {Pitches[118] = pitch;}
  if (pitch == 119) {Pitches[119] = pitch;}
  if (pitch == 120) {Pitches[120] = pitch;}
  if (pitch == 121) {Pitches[121] = pitch;}
  if (pitch == 122) {Pitches[122] = pitch;}
  if (pitch == 123) {Pitches[123] = pitch;}
  if (pitch == 124) {Pitches[124] = pitch;}
  if (pitch == 125) {Pitches[125] = pitch;}
  if (pitch == 126) {Pitches[126] = pitch;}
  if (pitch == 127) {Pitches[127] = pitch;}
}

//Note off event
void noteOff(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel = channel;
  Pitch = pitch;
  Velocity = velocity;
  
  debug = new Debug();
  debug.noteOffReturn();
 
  if (pitch ==   0) {Pitches[0] = -1;}
  if (pitch ==   1) {Pitches[1] = -1;}
  if (pitch ==   2) {Pitches[2] = -1;}
  if (pitch ==   3) {Pitches[3] = -1;}
  if (pitch ==   4) {Pitches[4] = -1;}
  if (pitch ==   5) {Pitches[5] = -1;}
  if (pitch ==   6) {Pitches[6] = -1;}
  if (pitch ==   7) {Pitches[7] = -1;}
  if (pitch ==   8) {Pitches[8] = -1;}
  if (pitch ==   9) {Pitches[9] = -1;}
  if (pitch ==  10) {Pitches[10] = -1;}
  if (pitch ==  11) {Pitches[11] = -1;}
  if (pitch ==  12) {Pitches[12] = -1;}
  if (pitch ==  13) {Pitches[13] = -1;}
  if (pitch ==  14) {Pitches[14] = -1;}
  if (pitch ==  15) {Pitches[15] = -1;}
  if (pitch ==  16) {Pitches[16] = -1;}
  if (pitch ==  17) {Pitches[17] = -1;}
  if (pitch ==  18) {Pitches[18] = -1;}
  if (pitch ==  19) {Pitches[19] = -1;}
  if (pitch ==  20) {Pitches[20] = -1;}
  if (pitch ==  21) {Pitches[21] = -1;}
  if (pitch ==  22) {Pitches[22] = -1;}
  if (pitch ==  23) {Pitches[23] = -1;}
  if (pitch ==  24) {Pitches[24] = -1;}
  if (pitch ==  25) {Pitches[25] = -1;}
  if (pitch ==  26) {Pitches[26] = -1;}
  if (pitch ==  27) {Pitches[27] = -1;}
  if (pitch ==  28) {Pitches[28] = -1;}
  if (pitch ==  29) {Pitches[29] = -1;}
  if (pitch ==  30) {Pitches[30] = -1;}
  if (pitch ==  31) {Pitches[31] = -1;}
  if (pitch ==  32) {Pitches[32] = -1;}
  if (pitch ==  33) {Pitches[33] = -1;}
  if (pitch ==  34) {Pitches[34] = -1;}
  if (pitch ==  35) {Pitches[35] = -1;}
  if (pitch ==  36) {Pitches[36] = -1;}
  if (pitch ==  37) {Pitches[37] = -1;}
  if (pitch ==  38) {Pitches[38] = -1;}
  if (pitch ==  39) {Pitches[39] = -1;}
  if (pitch ==  40) {Pitches[40] = -1;}
  if (pitch ==  41) {Pitches[41] = -1;}
  if (pitch ==  42) {Pitches[42] = -1;}
  if (pitch ==  43) {Pitches[43] = -1;}
  if (pitch ==  44) {Pitches[44] = -1;}
  if (pitch ==  45) {Pitches[45] = -1;}
  if (pitch ==  46) {Pitches[46] = -1;}
  if (pitch ==  47) {Pitches[47] = -1;}
  if (pitch ==  48) {Pitches[48] = -1;}
  if (pitch ==  49) {Pitches[49] = -1;}
  if (pitch ==  50) {Pitches[50] = -1;}
  if (pitch ==  51) {Pitches[51] = -1;}
  if (pitch ==  52) {Pitches[52] = -1;}
  if (pitch ==  53) {Pitches[53] = -1;}
  if (pitch ==  54) {Pitches[54] = -1;}
  if (pitch ==  55) {Pitches[55] = -1;}
  if (pitch ==  56) {Pitches[56] = -1;}
  if (pitch ==  57) {Pitches[57] = -1;}
  if (pitch ==  58) {Pitches[58] = -1;}
  if (pitch ==  59) {Pitches[59] = -1;}
  if (pitch ==  60) {Pitches[60] = -1;}
  if (pitch ==  61) {Pitches[61] = -1;}
  if (pitch ==  62) {Pitches[62] = -1;}
  if (pitch ==  63) {Pitches[63] = -1;}
  if (pitch ==  64) {Pitches[64] = -1;}
  if (pitch ==  65) {Pitches[65] = -1;}
  if (pitch ==  66) {Pitches[66] = -1;}
  if (pitch ==  67) {Pitches[67] = -1;}
  if (pitch ==  68) {Pitches[68] = -1;}
  if (pitch ==  69) {Pitches[69] = -1;}
  if (pitch ==  70) {Pitches[70] = -1;}
  if (pitch ==  71) {Pitches[71] = -1;}
  if (pitch ==  72) {Pitches[72] = -1;}
  if (pitch ==  73) {Pitches[73] = -1;}
  if (pitch ==  74) {Pitches[74] = -1;}
  if (pitch ==  75) {Pitches[75] = -1;}
  if (pitch ==  76) {Pitches[76] = -1;}
  if (pitch ==  77) {Pitches[77] = -1;}
  if (pitch ==  78) {Pitches[78] = -1;}
  if (pitch ==  79) {Pitches[79] = -1;}
  if (pitch ==  80) {Pitches[80] = -1;}
  if (pitch ==  81) {Pitches[81] = -1;}
  if (pitch ==  82) {Pitches[82] = -1;}
  if (pitch ==  83) {Pitches[83] = -1;}
  if (pitch ==  84) {Pitches[84] = -1;}
  if (pitch ==  85) {Pitches[85] = -1;}
  if (pitch ==  86) {Pitches[86] = -1;}
  if (pitch ==  87) {Pitches[87] = -1;}
  if (pitch ==  88) {Pitches[88] = -1;}
  if (pitch ==  89) {Pitches[89] = -1;}
  if (pitch ==  90) {Pitches[90] = -1;}
  if (pitch ==  91) {Pitches[91] = -1;}
  if (pitch ==  92) {Pitches[92] = -1;}
  if (pitch ==  93) {Pitches[93] = -1;}
  if (pitch ==  94) {Pitches[94] = -1;}
  if (pitch ==  95) {Pitches[95] = -1;}
  if (pitch ==  96) {Pitches[96] = -1;}
  if (pitch ==  97) {Pitches[97] = -1;}
  if (pitch ==  98) {Pitches[98] = -1;}
  if (pitch ==  99) {Pitches[99] = -1;}
  if (pitch == 100) {Pitches[100] = -1;}
  if (pitch == 101) {Pitches[101] = -1;}
  if (pitch == 102) {Pitches[102] = -1;}
  if (pitch == 103) {Pitches[103] = -1;}
  if (pitch == 104) {Pitches[104] = -1;}
  if (pitch == 105) {Pitches[105] = -1;}
  if (pitch == 106) {Pitches[106] = -1;}
  if (pitch == 107) {Pitches[107] = -1;}
  if (pitch == 108) {Pitches[108] = -1;}
  if (pitch == 109) {Pitches[109] = -1;}
  if (pitch == 110) {Pitches[110] = -1;}
  if (pitch == 111) {Pitches[111] = -1;}
  if (pitch == 112) {Pitches[112] = -1;}
  if (pitch == 113) {Pitches[113] = -1;}
  if (pitch == 114) {Pitches[114] = -1;}
  if (pitch == 115) {Pitches[115] = -1;}
  if (pitch == 116) {Pitches[116] = -1;}
  if (pitch == 117) {Pitches[117] = -1;}
  if (pitch == 118) {Pitches[118] = -1;}
  if (pitch == 119) {Pitches[119] = -1;}
  if (pitch == 120) {Pitches[120] = -1;}
  if (pitch == 121) {Pitches[121] = -1;}
  if (pitch == 122) {Pitches[122] = -1;}
  if (pitch == 123) {Pitches[123] = -1;}
  if (pitch == 124) {Pitches[124] = -1;}
  if (pitch == 125) {Pitches[125] = -1;}
  if (pitch == 126) {Pitches[126] = -1;}
  if (pitch == 127) {Pitches[127] = -1;}
}
