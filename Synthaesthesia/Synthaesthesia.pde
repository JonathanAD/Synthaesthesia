//Synthesthesia
//MIDI music visualizer
//By Jonathan Arias
//MIDIBus by sparks        - http://www.smallbutdigital.com/themidibus.php
//Starfield 3D by JimBrown - https://www.processing.org/discourse/beta/num_1209965886.html

//Import libraries
import themidibus.*;  //MIDI interface bridge
import queasycam.* ;  //Free view camera
import camera3D.generators.util.*;
import camera3D.generators.*;
import camera3D.*;

//Create instances
  //General
  Debug                  debug                 ;  //Debug
  Background             background            ;  //Background
  MidiBus                myBus                 ;  //MIDIBus
  QueasyCam              cam                   ;  //Dynamic camera
  Camera3D               camera3D              ;  //3D stereoscopic camera
  //Instrument graphics
  PianoGFX               pianogfx              ;  //Piano graphics
  ChromaticPercussionGFX chromaticpercussiongfx;  //Chromatic Percussion graphics
  OrganGFX               organgfx              ;  //Organ graphics
  GuitarGFX              guitargfx             ;  //Guitar graphics        
  BassGFX                bassgfx               ;  //Bass graphics      
  StringsGFX             stringsgfx            ;  //Strings graphics         
  EnsembleGFX            ensemblegfx           ;  //Ensemble graphics          
  //BrassGFX               brassgfx              ;  //Brass graphics       
  //ReedGFX                reedgfx               ;  //Reed graphics      
  //PipeGFX                pipegfx               ;  //Pipe graphics      
  //SynthLeadGFX           synthleadgfx          ;  //Synth Lead graphics           
  //SynthPadGFX            synthpadgfx           ;  //Synth Pad graphics          
  //SynthEffectsGFX        ethnicgfx       ;  //Synth Effects graphics              
  //EthnicGFX              ethnicgfx             ;  //Ethnic graphics        
  //PercussiveGFX          percussivegfx         ;  //Percussive graphics            
  //SoundEffectsGFX        soundeffectsgfx       ;  //Sound effects graphics              
  //PercussionGFX          percussiongfx         ;  //Percussion graphics            

//Instrument IDs
  int PianoChannelID               =  0; // Piano                - Channel #1
  int ChromaticPercussionChannelID =  1; // Chromatic Percussion - Channel #2
  int OrganChannelID               =  2; // Organ                - Channel #3
  int GuitarChannelID              =  3; // Guitar               - Channel #4
  int BassChannelID                =  4; // Bass                 - Channel #5
  int StringsChannelID             =  5; // Strings              - Channel #6
  int EnsembleChannelID            =  6; // Ensemble             - Channel #7
  int BrassChannelID               =  7; // Brass                - Channel #8
  int ReedChannelID                =  8; // Reed                 - Channel #9
  int PipeChannelID                = 10; // Pipe                 - Channel #11
  int SynthLeadChannelID           = 11; // Synth Lead           - Channel #12
  int SynthPadChannelID            = 12; // Synth Pad            - Channel #13
  int SynthEffectsChannelID        = 13; // Synth Effects        - Channel #14
  int EthnicChannelID              = 14; // Ethnic               - Channel #15
  int PercussiveChannelID          = 15; // Percussive           - Channel #16
  int SoundEffectsChannelID        = -1; // Sound effects        - N/A
  int PercussionChannelID          =  9; // Percussion           - Channel #10

//Global switches
  int[]             Widths = {950, 1280, 1920}; //1/4 1080p [0] | 720p [1] | 1080p [2]
  int[]            Heights = {501,  720, 1080}; //1/4 1080p [0] | 720p [1] | 1080p [2]
  int                Width =         Widths[2]; //Window width
  int               Height =        Heights[1]; //Window height
  boolean         EnableAA =             false; //Anti-aliasing
  boolean     Enable120FPS =             false; //120 frames per second
  boolean         Enable3D =             true; //Stereoscopic 3D
  int         Divergence3D =                 2; //3D focus point
  boolean EnableFreeCamera =             false; //Mouse-controlled camera     


//Declare and initialize global variable arrays
  //MIDI channel state
    boolean[] ChannelIsActive                   = new boolean[128];
    boolean[] PianoPitchIsActive                = new boolean[128];
    boolean[] ChromaticPercussionPitchIsActive  = new boolean[128];
    boolean[] OrganPitchIsActive                = new boolean[128];
    boolean[] GuitarPitchIsActive               = new boolean[128];
    boolean[] BassPitchIsActive                 = new boolean[128];
    boolean[] StringsPitchIsActive              = new boolean[128];
    boolean[] EnsemblePitchIsActive             = new boolean[128];
    //boolean[] BrassPitchIsActive                = new boolean[128];
    //boolean[] ReedPitchIsActive                 = new boolean[128];
    //boolean[] PipePitchIsActive                 = new boolean[128];
    //boolean[] SynthLeadPitchIsActive            = new boolean[128];
    //boolean[] SynthPadPitchIsActive             = new boolean[128];
    //boolean[] SynthEffectsPitchIsActive         = new boolean[128];
    //boolean[] EthnicPitchIsActive               = new boolean[128];
    //boolean[] PercussivePitchIsActive           = new boolean[128];
    //boolean[] SoundEffectsPitchIsActive         = new boolean[128];
    //boolean[] PercussionPitchIsActive           = new boolean[128];
  //MIDI variables mapped to attributes
    int[] PitchHues                             = new int[128]; //Note pitch mapped to hue
    int[] OctaveSaturations                     = new int[128]; //Note pitch mapped to saturation
    int[] OctaveBrightnesses                    = new int[128]; //Note pitch mapped to brightness
  //MIDI instrument note pitches mapped to coordinates
    //Note pitch to X coordinates
      float[] PianoPitchX                       = new float[128];
      float[] ChromaticPercussionPitchX         = new float[128];
      float[] OrganPitchX                       = new float[128];
      float[] GuitarPitchX                      = new float[128];
      float[] BassPitchX                        = new float[128];
      float[] StringsPitchX                     = new float[128];
      float[] EnsemblePitchX                    = new float[128];
      //float[] BrassPitchX                       = new float[128];
      //float[] ReedPitchX                        = new float[128];
      //float[] PipePitchX                        = new float[128];
      //float[] SynthLeadPitchX                   = new float[128];
      //float[] SynthPadPitchX                    = new float[128];
      //float[] SynthEffectsPitchX                = new float[128];
      //float[] EthnicPitchX                      = new float[128];
      //float[] PercussivePitchX                  = new float[128];
      //float[] SoundEffectsPitchX                = new float[128];
      //float[] PercussionPitchX                  = new float[128];
    //Note velocity to Y coordinates
      float[] PianoVelocityY                    = new float[128];
      float[] ChromaticPercussionVelocityY      = new float[128];
      float[] OrganVelocityY                    = new float[128];
      float[] GuitarVelocityY                   = new float[128];
      float[] BassVelocityY                     = new float[128];
      float[] StringsVelocityY                  = new float[128];
      float[] EnsembleVelocityY                 = new float[128];
      //float[] BrassVelocityY                    = new float[128];
      //float[] ReedVelocityY                     = new float[128];
      //float[] PipeVelocityY                     = new float[128];
      //float[] SynthLeadVelocityY                = new float[128];
      //float[] SynthPadVelocityY                 = new float[128];
      //float[] SynthEffectsVelocityY             = new float[128];
      //float[] EthnicVelocityY                   = new float[128];
      //float[] PercussiveVelocityY               = new float[128];
      //float[] SoundEffectsVelocityY             = new float[128];
      //float[] PercussionVelocityY               = new float[128];
    //Note velocity to transparency
      float[] PianoVelocityAlpha                = new float[128];
      float[] ChromaticPercussionVelocityAlpha  = new float[128];
      float[] OrganVelocityAlpha                = new float[128];
      float[] OrganPitchThickness               = new float[128];
      float[] GuitarVelocityAlpha               = new float[128];
      float[] BassVelocityAlpha                 = new float[128];
      float[] StringsVelocityAlpha              = new float[128];
      float[] StringsPitchThickness             = new float[128];
      float[] EnsembleVelocityAlpha             = new float[128];
      float[] EnsemblePitchThickness            = new float[128];
      //float[] BrassVelocityAlpha                = new float[128];
      //float[] ReedVelocityAlpha                 = new float[128];
      //float[] PipeVelocityAlpha                 = new float[128];
      //float[] SynthLeadVelocityAlpha            = new float[128];
      //float[] SynthPadVelocityAlpha             = new float[128];
      //float[] SynthEffectsVelocityAlpha         = new float[128];
      //float[] EthnicVelocityAlpha               = new float[128];
      //float[] PercussiveVelocityAlpha           = new float[128];
      //float[] SoundEffectsVelocityAlpha         = new float[128];
      //float[] PercussionVelocityAlpha           = new float[128];
    //Note pitch to vibration
      float[] PitchVibration                    = new float[128];
  //Declare and initialize global Variables
    //MIDI
      int Channel          =         -1; //Global Channel
      int Pitch            =         -1; //Global Pitch
      int Velocity         =         -1; //Global Velocity
      float PitchScaleX    =          0; //Note pitch mapped to window width
      float PitchScaleY    =          0; //Note pitch mapped to window height
      float VelocityScaleX =          0; //Note velocity mapped to window width
      float VelocityScaleY =          0; //Note velocity mapped to window height
    //Playback       
      float Tempo          =        120; //Speed at which objects will move towards the camera
    //3D       
      float Depth          =       -750; //3D object starting position
      int   GeometryDetail =         36; //Resolution of 3D objects
    //Constants
      float VibrationUnit  = 0.0009765625; // 1 divided by 128
    //Piano graphics
      float[] tubeX           = new float[GeometryDetail];
      float[] tubeY           = new float[GeometryDetail];
      float PianoSpinY        = 0;
    //Color textures
      PImage[] PianoNoteColor               = new PImage[128];
      PImage[] PianoNoteColorSide           = new PImage[128];
      PImage[] ChromaticPercussionNoteColor = new PImage[128];
      PImage[] OrganNoteColor               = new PImage[128];
      PImage[] GuitarNoteColor              = new PImage[128];
      PImage[] BassNoteColor                = new PImage[128];
      PImage[] StringsNoteColor             = new PImage[128];
      PImage[] EnsembleNoteColor            = new PImage[128];
      //PImage[] BrassNoteColor               = new PImage[128];
      //PImage[] ReedNoteColor                = new PImage[128];
      //PImage[] PipeNoteColor                = new PImage[128];
      //PImage[] SynthLeadNoteColor           = new PImage[128];
      //PImage[] SynthPadNoteColor            = new PImage[128];
      //PImage[] SynthEffectsNoteColor        = new PImage[128];
      //PImage[] EthnicNoteColor              = new PImage[128];
      //PImage[] PercussiveNoteColor          = new PImage[128];
      //PImage[] SoundEffectsNoteColor        = new PImage[128];
      //PImage[] PercussionNoteColor          = new PImage[128];
    //Instrument masks
    PImage PianoMask;
    PImage PianoMaskSide;
    PImage ChromaticPercussionMask;
    PImage[] OrganMask                    = new PImage[60];
    PImage GuitarMask;
    PImage BassMask;
    PImage[] StringsMask                  = new PImage[60];
    PImage[] EnsembleMask                 = new PImage[60];
    //PImage BrassMask;
    //PImage ReedMask;
    //PImage PipeMask;
    //PImage SynthLeadMask;
    //PImage SynthPadMask;
    //PImage SynthEffectsMask;
    //PImage EthnicMask;
    //PImage PercussiveMask;
    //PImage SoundEffectsMask;
    //PImage PercussionMask;

  //Animation
    //Vibration
      float SineDiameter      = 10            ;
      float SineAngleConstant = 0.03125       ; 
      float SineAngle[]       = new float[128];
      float SineDepth[]       = new float[128];
    //Frame sequence
      int MaskOrganFrame    = 0;
      int MaskStringsFrame  = 0;
      int MaskEnsembleFrame = 0;
    //Fade out
      float PianoSustainAlpha               = 2;
      float ChromaticPercussionSustainAlpha = 2;
    //Amplitude decay
      float GuitarAmplitudeDecay = 0.99;
      float BassAmplitudeDecay   = 0.99;
    //Sine wave
      int xspacing = 8                                     ; //How far apart should each horizontal location be spaced
      int w = 2048                                         ; //Width of entire wave
      float theta = 0.0                                    ; //Start angle at 0
      float period = 500.0                                 ; //How many pixels before the wave repeats
      float dx = (TWO_PI / period) * xspacing              ; //Value for incrementing X, a function of period and xspacing
      float[] yvalues = new float[w/xspacing]              ; //Using an array to store height values for the wave
      float BeginningAmplitude                          = 4;
      float[] GuitarAmplitude = new float[128];            ; //Height of wave
      float[] BassAmplitude   = new float[128];            ; //Height of wave
    //Strings bowing orientation
      int StringsBowOrientation = 1                        ; //Bowing orientation. 1=Up | -1=Down

  //Shapes
    //Sky dome
      PImage sky;
      PShape dome;
      float sphereRotateX = 0;
      float sphereRotateY = 1;
      float sphereRotateZ = 0;
      int cX = width/2;   //Display center X-Axish
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
    //3D Starfield
      int numstars=400;
      final int SPREAD=64;
      int CX,CY;
      final float SPEED=1.9;
      Star[] s = new Star[numstars];
  
//Setup
void setup() {
  //General
    size(Width, Height, P3D);
    if (EnableAA     == true) {     smooth(8);}
    if (Enable120FPS == true) {frameRate(120);}
    hint(DISABLE_DEPTH_TEST); //Fixes Z-fighting and alpha overlapping
    
  //Camera
    //Free
    if (EnableFreeCamera == true){
      cam = new QueasyCam(this);
      cam.speed = 2;             //Default is 2
      cam.sensitivity = 0.25;    //Default is 0.25
    }
    //3D
    if (Enable3D == true) {
      camera3D = new Camera3D(this);
      camera3D.renderSplitFrameSideBySide().setDivergence(Divergence3D);
    }
    
  //3D
    lights();
  
  //Background - Black
    background(0);
  
  //MIDI data
    MidiBus.list();                     //List available Midi devices
    myBus = new MidiBus(this, 0, -1);   //Create a new MidiBus using the device names to select the Midi input and output devices respectively.

//Shapes
  //Sky dome
    dome = createShape(SPHERE, 2500);
    sky  = loadImage("sky.jpg");
    dome.setTexture(sky);
  
  //Starfield
  CX=width/2 ; CY=height/2;
  //s = new Star[numstars];
  for(int i=0;i<numstars;i++){
    s[i]=new Star();
    s[i].SetPosition();
  }
  
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

//Shape variables
  //Piano graphics
    float CylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      tubeX[i] = cos(radians(i * CylinderAngle));
      tubeY[i] = sin(radians(i * CylinderAngle));
    }

  //Vibration variables
  for (int i = 0; i < 128; i++) {PitchVibration[i] = VibrationUnit*i;}
  for (int i = 0; i < 128; i++) {GuitarAmplitude[i] = 1;} //Initialize amplitude array
  for (int i = 0; i < 128; i++) {BassAmplitude[i]   = 1;} //Initialize amplitude array

  //Call variable methods
  OctaveVariables();
  ColorTextures();
  ColorTexturesMasks();
}

//Draw
void draw() {
  debug = new Debug();
// debug.framerate();
  debug.clickToPrintVariables();

  // //Sky
  noStroke();
  rotateY(radians(sphereRotateY));
  noStroke();
  shape(dome);
 // sphereRotateY = sphereRotateY+0.05; //Animation/Gyro drift fix
  
// //Starfield
// for(int i=0;i<numstars;i++){
//   s[i].DrawStar();
// }
  
  //Grids
// translate(0, 0, Line1Z);
// shape(Line1);
// translate(0, 0, Line2Z);
// shape(Line2);
// translate(0, 0, Line3Z);
// shape(Line3);
// translate(0, 0, Line4Z); 
// shape(Line4);
// if (Line1Z < 2048) {
//   Line1Z = Line1Z + 2;
// }
// else if (Line1Z >= 0) {
//   Line1Z = -250;
// }
  
//Animation
    //Sine wave depth vibration
    for (int i = 0; i < 128; i++) {
      // line(30, i, 80, i);
      SineDepth[i] = 200 + (sin(SineAngle[i] + PI) * SineDiameter/2) + SineDiameter/2; SineAngle[i] +=  SineAngleConstant*i;
    }

    //Call Instrument GFX methods
    PianoGFXDisplay();
    ChromaticPercussionGFXDisplay();
    OrganGFXDisplay();
    GuitarGFXDisplay();
    BassGFXDisplay();
    StringsGFXDisplay();
    EnsembleGFXDisplay();
    //BrassGFXDisplay();
    //ReedGFXDisplay();
    //PipeGFXDisplay();
    //SynthLeadGFXDisplay();
    //SynthPadGFXDisplay();
    //SynthEffectsGFXDisplay();
    //EthnicGFXDisplay();
    //PercussiveGFXDisplay();
    //SoundEffectsGFXDisplay();
    //PercussionGFXDisplay();
//Animation
  //Fade out
    for (int i = 0; i < 128; i++) {PianoVelocityAlpha[i]               = PianoVelocityAlpha[i]               - PianoSustainAlpha              ;} //#Piano
    for (int i = 0; i < 128; i++) {ChromaticPercussionVelocityAlpha[i] = ChromaticPercussionVelocityAlpha[i] - ChromaticPercussionSustainAlpha;} //#Chromatic Percussion  
  //Mask animation
    //#Organ
    if (MaskOrganFrame >= 0 && MaskOrganFrame < 59) {MaskOrganFrame++;} else {MaskOrganFrame = 0;}
    for (int i = 0; i < 128; i++) {OrganNoteColor[i].mask(OrganMask[MaskOrganFrame]);}
    //#Ensemble
    if (MaskEnsembleFrame >= 0 && MaskEnsembleFrame < 59) {MaskEnsembleFrame++;} else {MaskEnsembleFrame = 0;}
    for (int i = 0; i < 128; i++) {EnsembleNoteColor[i].mask(EnsembleMask[MaskEnsembleFrame]);}
  //StringsBowOrientation
    //#Strings
      if (StringsBowOrientation ==   1) {if (MaskStringsFrame == 59) {MaskStringsFrame = 0;} MaskStringsFrame++;} //If StringsBowOrientation equals  1, texture moves upwards
      if (StringsBowOrientation ==  -1) {if (MaskStringsFrame == 0) {MaskStringsFrame = 59;} MaskStringsFrame--;} //If StringsBowOrientation equals -1, texture moves downwards
      for (int i = 0; i < 128; i++) {StringsNoteColor[i].mask(StringsMask[MaskStringsFrame]);}
  //Decrease sine wave amplitude
    for (int i = 0; i < 128; i++) {GuitarAmplitude[i] = GuitarAmplitude[i]*GuitarAmplitudeDecay;} //#Guitar
    for (int i = 0; i < 128; i++) {BassAmplitude[i]   = BassAmplitude[i]  *BassAmplitudeDecay;}   //#Bass
}

//Note on event
void noteOn(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel  = channel;
  Pitch    = pitch;
  Velocity = velocity;

  VelocityScaleX = map(velocity, 0, 127, 0, width);
  VelocityScaleY = map(velocity, 0, 127, 0, height);
  PitchScaleX    = map(pitch, 0, 127, 0, width);
  PitchScaleY    = map(pitch, 0, 127, 0, height);
  
  //Update instrument variables
  if (channel == StringsChannelID) {StringsBowOrientation = -StringsBowOrientation;} //Inverts the value of StringsBowOrientation upon each Strings note on event
  
  //Print global variables
  debug = new Debug();
  debug.noteOnReturn();
  
  //Call Instrument Note On variable update methods
  PianoChannelNoteOn();
  ChromaticPercussionChannelNoteOn();
  OrganChannelNoteOn();
  GuitarChannelNoteOn();
  BassChannelNoteOn();
  StringsChannelNoteOn();
  EnsembleChannelNoteOn();
  //BrassChannelNoteOn();
  //ReedChannelNoteOn();
  //PipeChannelNoteOn();
  //SynthLeadChannelNoteOn();
  //SynthPadChannelNoteOn();
  //SynthEffectsChannelNoteOn();
  //EthnicChannelNoteOn();
  //PercussiveChannelNoteOn();
  //SoundEffectsChannelNoteOn();
  //PercussionChannelNoteOn();
}

//Note off event
void noteOff(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel  = channel;
  Pitch    = pitch;
  Velocity = velocity;
  
  VelocityScaleX = 1;
  VelocityScaleY = 1;
  PitchScaleX    = 1;
  PitchScaleY    = 1;

  debug = new Debug();
  debug.noteOffReturn();

  //Call Instrument Note Off variable update methods
  PianoChannelNoteOff();
  ChromaticPercussionChannelNoteOff();
  OrganChannelNoteOff();
  GuitarChannelNoteOff();
  BassChannelNoteOff();
  StringsChannelNoteOff();
  EnsembleChannelNoteOff();
  //BrassChannelNoteOff();
  //ReedChannelNoteOff();
  //PipeChannelNoteOff();
  //SynthLeadChannelNoteOff();
  //SynthPadChannelNoteOff();
  //SynthEffectsChannelNoteOff();
  //EthnicChannelNoteOff();
  //PercussiveChannelNoteOff();
  //SoundEffectsChannelNoteOff();
  //PercussionChannelNoteOff();
}

void OctaveVariables(){
  //Note-to-color correspondence (In degrees, out of 360)
  PitchHues[0]  =   0; //C  - Red
  PitchHues[1]  = 210; //C# - Blue-Cyan
  PitchHues[2]  =  60; //D  - Yellow
  PitchHues[3]  = 270; //D# - Blue-Magenta
  PitchHues[4]  = 120; //E  - Green
  PitchHues[5]  = 330; //F  - Red-Magenta
  PitchHues[6]  = 180; //F# - Cyan
  PitchHues[7]  =  30; //G  - Orange
  PitchHues[8]  = 240; //G# - Blue
  PitchHues[9]  =  90; //A  - Yellow-Green
  PitchHues[10] = 300; //A# - Magenta
  PitchHues[11] = 150; //B  - Green-Cyans
  for (int i = 11; i < 128; i = i+1) {PitchHues[i]  =  PitchHues[i-11];} //Loop and copy values from 0-10 into 11-128
  //Octave-to-saturation correspondence (out of 100)
  OctaveSaturations[0]  =  95; //Octave -1 saturation
  OctaveSaturations[1]  = 127; //Octave  0 saturation
  OctaveSaturations[2]  = 159; //Octave  1 saturation
  OctaveSaturations[3]  = 191; //Octave  2 saturation
  OctaveSaturations[4]  = 223; //Octave  3 saturation
  OctaveSaturations[5]  = 255; //Octave  4 saturation
  OctaveSaturations[6]  = 191; //Octave  5 saturation
  OctaveSaturations[7]  = 127; //Octave  6 saturation
  OctaveSaturations[8]  =  63; //Octave  7 saturation
  OctaveSaturations[9]  =   0; //Octave  8 saturation
  OctaveSaturations[10] =   0; //Octave  9 saturation
  for (int i = 11; i < 128; i = i+1) {OctaveSaturations[i]  =  OctaveSaturations[i-11];} //Loop and copy values from 0-10 into 11-128
  //Octave-to-brightness correspondence (out of 100)
  OctaveBrightnesses[0]  =   0; //Octave -1 brightness
  OctaveBrightnesses[1]  =   0; //Octave  0 brightness
  OctaveBrightnesses[2]  =  31; //Octave  1 brightness
  OctaveBrightnesses[3]  =  63; //Octave  2 brightness
  OctaveBrightnesses[4]  =  95; //Octave  3 brightness
  OctaveBrightnesses[5]  = 127; //Octave  4 brightness
  OctaveBrightnesses[6]  = 191; //Octave  5 brightness
  OctaveBrightnesses[7]  = 255; //Octave  6 brightness
  OctaveBrightnesses[8]  = 255; //Octave  7 brightness
  OctaveBrightnesses[9]  = 255; //Octave  8 Brightness
  OctaveBrightnesses[10] = 255; //Octave  9 brightness
  for (int i = 11; i < 128; i = i+1) {OctaveBrightnesses[i]  =  OctaveBrightnesses[i-11];} //Loop and copy values from 0-10 into 11-128
}

void ColorTextures(){
//Color textures 
  //Piano
  for (int i = 0; i < 128; i++) {
    PianoNoteColor[i]               = loadImage("NoteColor_" + i + ".png");
    PianoNoteColorSide[i]           = loadImage("NoteColor_" + i + ".png");
    ChromaticPercussionNoteColor[i] = loadImage("NoteColor_" + i + ".png");
    OrganNoteColor[i]               = loadImage("NoteColor_" + i + ".png");
    GuitarNoteColor[i]              = loadImage("NoteColor_" + i + ".png");
    BassNoteColor[i]                = loadImage("NoteColor_" + i + ".png");
    StringsNoteColor[i]             = loadImage("NoteColor_" + i + ".png");
    EnsembleNoteColor[i]            = loadImage("NoteColor_" + i + ".png");
    // BrassNoteColor[i]               = loadImage("NoteColor_" + i + ".png");
    // ReedNoteColor[i]                = loadImage("NoteColor_" + i + ".png");
    // PipeNoteColor[i]                = loadImage("NoteColor_" + i + ".png");
    // SynthLeadNoteColor[i]           = loadImage("NoteColor_" + i + ".png");
    // SynthPadNoteColor[i]            = loadImage("NoteColor_" + i + ".png");
    // SynthEffectsNoteColor[i]        = loadImage("NoteColor_" + i + ".png");
    // EthnicNoteColor[i]              = loadImage("NoteColor_" + i + ".png");
    // PercussiveNoteColor[i]          = loadImage("NoteColor_" + i + ".png");
    // PercussionNoteColor[i]          = loadImage("NoteColor_" + i + ".png");
  }
}

void ColorTexturesMasks(){
  //Load alpha mask files
  PianoMask               = loadImage("Mask-Piano.png");
  PianoMaskSide           = loadImage("Mask-Piano-Side.png");
  ChromaticPercussionMask = loadImage("Mask-ChromaticPercussion.png");
  GuitarMask              = loadImage("Mask-Guitar.png");
  BassMask                = loadImage("Mask-Bass.png");
  // BrassMask               = loadImage("Mask-Brass.png");
  // ReedMask                = loadImage("Mask-Reed.png");
  // PipeMask                = loadImage("Mask-Pipe.png");
  // SynthLeadMask           = loadImage("Mask-SynthLead.png");
  // SynthPadMask            = loadImage("Mask-SynthPad.png");
  // SynthEffectsMask        = loadImage("Mask-SynthEffects.png");
  // EthnicMask              = loadImage("Mask-Ethnic.png");
  // PercussiveMask          = loadImage("Mask-Percussive.png");
  // SoundEffectsMask        = loadImage("Mask-SoundEffects.png");
  // PercussionMask          = loadImage("Mask-Percussion.png");
  //Load alpha mask frame sequence
  for (int i = 0; i < 60; i = i+1) {
    OrganMask[i]    = loadImage("Mask-Organ_"    + nf(i, 2) + ".png");
    StringsMask[i]  = loadImage("Mask-Strings_"  + nf(i, 2) + ".png");
    EnsembleMask[i] = loadImage("Mask-Ensemble_" + nf(i, 2) + ".png");
  }
  
  //Colors
  for (int i = 0; i < 128; i++) {
    PianoNoteColor[i].mask              (PianoMask);
    PianoNoteColorSide[i].mask          (PianoMaskSide);
    ChromaticPercussionNoteColor[i].mask(ChromaticPercussionMask);
    GuitarNoteColor[i].mask             (GuitarMask);
    BassNoteColor[i].mask               (BassMask);
    // BrassNoteColor[i].mask              (BrassMask);
    // ReedNoteColor[i].mask               (ReedMask);
    // SynthLeadNoteColor[i].mask          (SynthLeadMask);
    // SynthPadNoteColor[i].mask           (SynthPadMask);
    // SynthEffectsNoteColor[i].mask       (SynthEffectsMask);
    // EthnicNoteColor[i].mask             (EthnicMask);
    // PercussiveNoteColor[i].mask         (PercussiveMask);
    // PercussionNoteColor[i].mask         (PercussionMask);
  }
}

//D#Piano
void PianoGFXDisplay(){//Piano
  if (ChannelIsActive[PianoChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (PianoPitchIsActive[i] == true) 
      {pianogfx = new PianoGFX (
        PianoPitchX[i]        , //X coordinate
        PianoVelocityY[i]     , //Y coordinate
        Depth+SineDepth[i]    , //Z coordinate
        VelocityScaleX        , //Width
        VelocityScaleY        , //Height
        VelocityScaleY        , //Depth
        PitchHues[i]          , //Hue
        OctaveSaturations[i]  , //Saturation
        OctaveBrightnesses[i] , //Brightness
        PianoVelocityAlpha[i] , //Alpha
        PianoNoteColor[i]     , //Texture
        PianoNoteColorSide[i]); //Texture 2
        pianogfx.display()    ; //Display graphics   
      }
    }
  }
}


//D#Chromatic Percussion
void ChromaticPercussionGFXDisplay(){
  if (ChannelIsActive[ChromaticPercussionChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (ChromaticPercussionPitchIsActive[i] == true) 
      {chromaticpercussiongfx = new ChromaticPercussionGFX (
        ChromaticPercussionPitchX[i]       , //X coordinate
        ChromaticPercussionVelocityY[i]    , //Y coordinate 
        Depth+SineDepth[i]                 , //Z coordinate 
        VelocityScaleX                     , //Width 
        VelocityScaleY                     , //Height 
        VelocityScaleY                     , //Depth  
        PitchHues[i]                       , //Hue 
        OctaveSaturations[i]               , //Saturation  
        OctaveBrightnesses[i]              , //Brightness  
        ChromaticPercussionVelocityAlpha[i], //Alpha 
        ChromaticPercussionNoteColor[i])   ; //Texture 
        chromaticpercussiongfx.display()   ; //Display graphics
      }
    }
  }
}

//D#Organ
void OrganGFXDisplay(){
  if (ChannelIsActive[OrganChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (OrganPitchIsActive[i] == true) 
      {organgfx = new OrganGFX (
        OrganPitchX[i]        , //X coordinate 
        OrganVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]    , //Z coordinate  
        PitchScaleX           , //Width  
        PitchScaleY           , //Height  
        VelocityScaleY        , //Depth    
        PitchHues[i]          , //Hue  
        OctaveSaturations[i]  , //Saturation    
        OctaveBrightnesses[i] , //Brightness    
        OrganVelocityAlpha[i] , //Alpha  
        OrganPitchThickness[i], //Thickness
        OrganNoteColor[i]    ); //Texture  
        organgfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Guitar
void GuitarGFXDisplay(){
  if (ChannelIsActive[GuitarChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (GuitarPitchIsActive[i] == true) 
      {guitargfx = new GuitarGFX (
        GuitarPitchX[i]       , //X coordinate  
        GuitarVelocityY[i]    , //Y coordinate   
        Depth+SineDepth[i]    , //Z coordinate   
        VelocityScaleX        , //Width   
        VelocityScaleY        , //Height   
        VelocityScaleY        , //Depth      
        PitchHues[i]          , //Hue   
        OctaveSaturations[i]  , //Saturation      
        OctaveBrightnesses[i] , //Brightness      
        GuitarVelocityAlpha[i], //Alpha   
        PitchVibration[i]     , //Vibration 
        GuitarAmplitude[i]    , //Amplitude
        GuitarNoteColor[i]   ); //Texture   
        guitargfx.display()   ; //Display graphics 
      } 
    }
  }
}

//D#Bass
void BassGFXDisplay(){
  if (ChannelIsActive[BassChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (BassPitchIsActive[i] == true) 
      {bassgfx = new BassGFX (
        BassPitchX[i]         , //X coordinate  
        BassVelocityY[i]      , //Y coordinate   
        Depth+SineDepth[i]    , //Z coordinate   
        VelocityScaleX        , //Width   
        VelocityScaleY        , //Height   
        VelocityScaleY        , //Depth      
        PitchHues[i]          , //Hue   
        OctaveSaturations[i]  , //Saturation      
        OctaveBrightnesses[i] , //Brightness      
        BassVelocityAlpha[i]  , //Alpha   
        PitchVibration[i]     , //Vibration 
        BassAmplitude[i]      , //Amplitude
        BassNoteColor[i]     ); //Texture   
        bassgfx.display()     ; //Display graphics 
      } 
    }
  }
}

//D#Strings
void StringsGFXDisplay(){
  if (ChannelIsActive[StringsChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (StringsPitchIsActive[i] == true) 
      {stringsgfx = new StringsGFX (
        StringsPitchX[i]        , //X coordinate 
        StringsVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]      , //Z coordinate  
        PitchScaleX             , //Width  
        PitchScaleY             , //Height  
        VelocityScaleY          , //Depth    
        PitchHues[i]            , //Hue  
        OctaveSaturations[i]    , //Saturation    
        OctaveBrightnesses[i]   , //Brightness    
        StringsVelocityAlpha[i] , //Alpha  
        StringsPitchThickness[i], //Thickness
        StringsNoteColor[i]    ); //Texture  
        stringsgfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Ensemble
void EnsembleGFXDisplay(){
  if (ChannelIsActive[EnsembleChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (EnsemblePitchIsActive[i] == true) 
      {ensemblegfx = new EnsembleGFX (
        EnsemblePitchX[i]        , //X coordinate 
        EnsembleVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]       , //Z coordinate  
        PitchScaleX              , //Width  
        PitchScaleY              , //Height  
        VelocityScaleY           , //Depth    
        PitchHues[i]             , //Hue  
        OctaveSaturations[i]     , //Saturation    
        OctaveBrightnesses[i]    , //Brightness    
        EnsembleVelocityAlpha[i] , //Alpha  
        EnsemblePitchThickness[i], //Thickness
        EnsembleNoteColor[i]    ); //Texture  
        ensemblegfx.display()    ; //Display graphics 
      }
    }
  }
}

// //D#Brass
// void BrassGFXDisplay(){
//   if (ChannelIsActive[BrassChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (BrassPitchIsActive[i] == true) 
//       {brassgfx = new BrassGFX (
//         BrassPitchX[i]       , //X coordinate  
//         BrassVelocityY[i]    , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         BrassVelocityAlpha[i], //Alpha   
//         BrassNoteColor[i]   ); //Texture   
//         brassgfx.display()   ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Reed
// void ReedGFXDisplay(){
//   if (ChannelIsActive[ReedChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (ReedPitchIsActive[i] == true) 
//       {reedgfx = new ReedGFX (
//         ReedPitchX[i]       , //X coordinate  
//         ReedVelocityY[i]    , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         ReedVelocityAlpha[i], //Alpha   
//         ReedNoteColor[i]   ); //Texture   
//         reedgfx.display()   ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Pipe
// void PipeGFXDisplay(){
//   if (ChannelIsActive[PipeChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (PipePitchIsActive[i] == true) 
//       {pipegfx = new PipeGFX (
//         PipePitchX[i]        , //X coordinate  
//         PipeVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         PipeVelocityAlpha[i] , //Alpha   
//         PipeNoteColor[i]    ); //Texture   
//         pipegfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Synth Lead
// void SynthLeadGFXDisplay(){
//   if (ChannelIsActive[SynthLeadChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (SynthLeadPitchIsActive[i] == true) 
//       {synthleadgfx = new SynthLeadGFX (
//         SynthLeadPitchX[i]        , //X coordinate  
//         SynthLeadVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         SynthLeadVelocityAlpha[i] , //Alpha   
//         SynthLeadNoteColor[i]    ); //Texture   
//         synthleadgfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Synth Pad
// void SynthPadGFXDisplay(){
//   if (ChannelIsActive[SynthPadChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (SynthPadPitchIsActive[i] == true) 
//       {synthpadgfx = new SynthPadGFX (
//         SynthPadPitchX[i]        , //X coordinate  
//         SynthPadVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         SynthPadVelocityAlpha[i] , //Alpha   
//         SynthPadNoteColor[i]    ); //Texture   
//         synthpadgfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Synth Effects
// void SynthEffectsGFXDisplay(){
//   if (ChannelIsActive[SynthEffectsChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (SynthEffectsPitchIsActive[i] == true) 
//       {ethnicgfx = new SynthEffectsGFX (
//         SynthEffectsPitchX[i]        , //X coordinate  
//         SynthEffectsVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         SynthEffectsVelocityAlpha[i] , //Alpha   
//         SynthEffectsNoteColor[i]    ); //Texture   
//         ethnicgfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Ethnic
// void EthnicGFXDisplay(){
//   if (ChannelIsActive[EthnicChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (EthnicPitchIsActive[i] == true) 
//       {ethnicgfx = new EthnicGFX (
//         EthnicPitchX[i]        , //X coordinate  
//         EthnicVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         EthnicVelocityAlpha[i] , //Alpha   
//         EthnicNoteColor[i]    ); //Texture   
//         ethnicgfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Percussive
// void PercussiveGFXDisplay(){
//   if (ChannelIsActive[PercussiveChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (PercussivePitchIsActive[i] == true) 
//       {percussivegfx = new PercussiveGFX (
//         PercussivePitchX[i]        , //X coordinate  
//         PercussiveVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         PercussiveVelocityAlpha[i] , //Alpha   
//         PercussiveNoteColor[i]    ); //Texture   
//         percussivegfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

// //D#Percussion
// void PercussionGFXDisplay(){
//   if (ChannelIsActive[PercussionChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (PercussionPitchIsActive[i] == true) 
//       {percussiongfx = new PercussionGFX (
//         PercussionPitchX[i]        , //X coordinate  
//         PercussionVelocityY[i]     , //Y coordinate   
//         Depth+SineDepthm1    , //Z coordinate   
//         VelocityScaleX       , //Width   
//         VelocityScaleY       , //Height   
//         VelocityScaleY       , //Depth      
//         PitchHues[i]         , //Hue   
//         OctaveSaturations[i] , //Saturation      
//         OctaveBrightnesses[i], //Brightness      
//         PercussionVelocityAlpha[i] , //Alpha   
//         PercussionNoteColor[i]    ); //Texture   
//         percussiongfx.display()    ; //Display graphics 
//       }
//     }
//   }
// }

//MIDI note on events
  //N#Piano
  void PianoChannelNoteOn(){
    if (Channel == PianoChannelID) {
      ChannelIsActive[PianoChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PianoPitchIsActive[i] = true;
          PianoPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
          PianoVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
          PianoVelocityAlpha[i] = Velocity*2;
        }
      }
    }
  }
  //N#Chromatic Percussion
  void ChromaticPercussionChannelNoteOn(){
    if (Channel == ChromaticPercussionChannelID) {
      ChannelIsActive[ChromaticPercussionChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          ChromaticPercussionPitchIsActive[i] = true; 
          ChromaticPercussionPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
          ChromaticPercussionVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
          ChromaticPercussionVelocityAlpha[i] = Velocity*2;
        }
      }
    }
  }
  //N#Organ
  void OrganChannelNoteOn(){
    if (Channel == OrganChannelID) {
      ChannelIsActive[OrganChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          OrganPitchIsActive[i]  = true; 
          OrganPitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          OrganVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          OrganVelocityAlpha[i]  = Velocity*2; 
          OrganPitchThickness[i] = map(Pitch, 0, 127, 1, 0.125);
        }
      }
    }
  }
  //N#Guitar
  void GuitarChannelNoteOn(){
    if (Channel == GuitarChannelID) {
      ChannelIsActive[GuitarChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          GuitarPitchIsActive[i] = true; 
          GuitarPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
          GuitarVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
          GuitarVelocityAlpha[i] = Velocity*2;
          GuitarAmplitude[i]     = BeginningAmplitude;
        }
      }
    }
  }
  //N#Bass
  void BassChannelNoteOn(){
    if (Channel == BassChannelID) {
      ChannelIsActive[BassChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          BassPitchIsActive[i] = true; 
          BassPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
          BassVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
          BassVelocityAlpha[i] = Velocity*2;
          BassAmplitude[i]     = BeginningAmplitude;
        }
      }
    }
  }
  //N#Strings
  void StringsChannelNoteOn(){
    if (Channel == StringsChannelID) {
      ChannelIsActive[StringsChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          StringsPitchIsActive[i]  = true; 
          StringsPitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          StringsVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          StringsVelocityAlpha[i]  = Velocity*2; 
          StringsPitchThickness[i] = map(Pitch, 0, 127, 1, 0.125);
        }
      }
    }
  }
  //N#Ensemble
  void EnsembleChannelNoteOn(){
    if (Channel == EnsembleChannelID) {
      ChannelIsActive[EnsembleChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          EnsemblePitchIsActive[i]  = true; 
          EnsemblePitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          EnsembleVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          EnsembleVelocityAlpha[i]  = Velocity*2; 
          EnsemblePitchThickness[i] = map(Pitch, 0, 127, 1, 0.125);
        }
      }
    }
  }
  // //N#Brass
  // void BrassChannelNoteOn(){
  //   if (Channel == BrassChannelID) {
  //     ChannelIsActive[BrassChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         BrassPitchIsActive[i] = true; 
  //         BrassPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         BrassVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         BrassVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Reed
  // void ReedChannelNoteOn(){
  //   if (Channel == ReedChannelID) {
  //     ChannelIsActive[ReedChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         ReedPitchIsActive[i] = true; 
  //         ReedPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         ReedVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         ReedVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Pipe
  // void PipeChannelNoteOn(){
  //   if (Channel == PipeChannelID) {
  //     ChannelIsActive[PipeChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PipePitchIsActive[i] = true; 
  //         PipePitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         PipeVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         PipeVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Synth Lead
  // void SynthLeadChannelNoteOn(){
  //   if (Channel == SynthLeadChannelID) {
  //     ChannelIsActive[SynthLeadChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthLeadPitchIsActive[i] = true; 
  //         SynthLeadPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         SynthLeadVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         SynthLeadVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Synth Pad
  // void SynthPadChannelNoteOn(){
  //   if (Channel == SynthPadChannelID) {
  //     ChannelIsActive[SynthPadChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthPadPitchIsActive[i] = true; 
  //         SynthPadPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         SynthPadVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         SynthPadVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Synth Effects
  // void SynthEffectsChannelNoteOn(){
  //   if (Channel == SynthEffectsChannelID) {
  //     ChannelIsActive[SynthEffectsChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthEffectsPitchIsActive[i] = true; 
  //         SynthEffectsPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         SynthEffectsVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         SynthEffectsVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Ethnic
  // void EthnicChannelNoteOn(){
  //   if (Channel == EthnicChannelID) {
  //     ChannelIsActive[EthnicChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         EthnicPitchIsActive[i] = true; 
  //         EthnicPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         EthnicVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         EthnicVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Percussive
  // void PercussiveChannelNoteOn(){
  //   if (Channel == PercussiveChannelID) {
  //     ChannelIsActive[PercussiveChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PercussivePitchIsActive[i] = true; 
  //         PercussivePitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         PercussiveVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         PercussiveVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }
  // //N#Percussion
  // void PercussionChannelNoteOn(){
  //   if (Channel == PercussionChannelID) {
  //     ChannelIsActive[PercussionChannelID] = true;
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PercussionPitchIsActive[i] = true; 
  //         PercussionPitchX[i]        = map(Pitch, 0, 127, -width, width*2); 
  //         PercussionVelocityY[i]     = map(Velocity, 0, 127, height, 0);  
  //         PercussionVelocityAlpha[i] = Velocity*2;
  //       }
  //     }
  //   }
  // }

//MIDI note off events
  //F#Piano
  void PianoChannelNoteOff(){
    if (Channel == PianoChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PianoPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#ChromaticPercussion
  void ChromaticPercussionChannelNoteOff(){
    if (Channel == ChromaticPercussionChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          ChromaticPercussionPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Organ
  void OrganChannelNoteOff(){
    if (Channel == OrganChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          OrganPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Guitar
  void GuitarChannelNoteOff(){
    if (Channel == GuitarChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          GuitarPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Bass
  void BassChannelNoteOff(){
    if (Channel == BassChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          BassPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Strings
  void StringsChannelNoteOff(){
    if (Channel == StringsChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          StringsPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Ensemble
  void EnsembleChannelNoteOff(){
    if (Channel == EnsembleChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          EnsemblePitchIsActive[i] = false;
        }
      }
    }
  }
  // //F#Brass
  // void BrassChannelNoteOff(){
  //   if (Channel == BrassChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         BrassPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#Reed
  // void ReedChannelNoteOff(){
  //   if (Channel == ReedChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         ReedPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#Pipe
  // void PipeChannelNoteOff(){
  //   if (Channel == PipeChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PipePitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#SynthLead
  // void SynthLeadChannelNoteOff(){
  //   if (Channel == SynthLeadChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthLeadPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#SynthPad
  // void SynthPadChannelNoteOff(){
  //   if (Channel == SynthPadChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthPadPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#SynthEffects
  // void SynthEffectsChannelNoteOff(){
  //   if (Channel == SynthEffectsChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         SynthEffectsPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#Ethnic
  // void EthnicChannelNoteOff(){
  //   if (Channel == EthnicChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         EthnicPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#Percussive
  // void PercussiveChannelNoteOff(){
  //   if (Channel == PercussiveChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PercussivePitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }
  // //F#Percussion
  // void PercussionChannelNoteOff(){
  //   if (Channel == PercussionChannelID) {
  //     for (int i = 0; i < 128; i++) {
  //       if (Pitch == i) {
  //         PercussionPitchIsActive[i] = false;
  //       }
  //     }
  //   }
  // }


