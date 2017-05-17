import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import themidibus.*; 
import queasycam.*; 
import camera3D.generators.util.*; 
import camera3D.generators.*; 
import camera3D.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Synthaesthesia extends PApplet {

//Synthesthesia
//MIDI music visualizer
//By Jonathan Arias

//Credits:
//MIDIBus                   - by sparks               - http://www.smallbutdigital.com/themidibus.php
//Starfield 3D              - by JimBrown             - https://www.processing.org/discourse/beta/num_1209965886.html
//Textured cylinder formula - Ben Fry and Casey Reas  - https://processing.org/examples/texturecylinder.html
//Sine wave formula         - Ben Fry and Casey Reas  - https://processing.org/examples/sinewave.html
//Smoke texture (Modified)  - by Alexandre W (MorZar) - https://www.flickr.com/photos/morzar/3308117071                - License https://creativecommons.org/licenses/by/2.0/

//Import libraries
  //MIDI interface bridge
  //Free view camera




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
  PipeGFX                pipegfx               ;  //Pipe graphics      
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
  int               Height =        Heights[2]; //Window height
  boolean         EnableAA =             false; //Anti-aliasing
  boolean     Enable120FPS =             false; //120 frames per second
  boolean         Enable3D =             true; //Stereoscopic 3D
  int         Divergence3D =                 2; //3D focus point
  boolean EnableFreeCamera =             false; //Mouse-controlled camera     
  boolean       DumpFrames =             false; //Dump frames to Tiff files


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
    boolean[] PipePitchIsActive                 = new boolean[128];
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
      float[] PipePitchX                        = new float[128];
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
      float[] PipeVelocityY                     = new float[128];
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
      float[] OrganPitchWidth                   = new float[128];
      float[] OrganPitchHeight                  = new float[128];
      float[] GuitarVelocityAlpha               = new float[128];
      float[] BassVelocityAlpha                 = new float[128];
      float[] StringsVelocityAlpha              = new float[128];
      float[] StringsPitchWidth                 = new float[128];
      float[] StringsPitchHeight                = new float[128];
      float[] EnsembleVelocityAlpha             = new float[128];
      float[] EnsemblePitchThickness            = new float[128];
      //float[] BrassVelocityAlpha                = new float[128];
      //float[] ReedVelocityAlpha                 = new float[128];
      float[] PipeVelocityAlpha                 = new float[128];
      float[] PipePitchWidth                    = new float[128];
      float[] PipePitchHeight                   = new float[128];
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
      float Depth          =      -1000; //3D object starting position
      int   GeometryDetail =         36; //Resolution of 3D objects
    //Constants
      float VibrationUnit  = 0.0009765625f; // 1 divided by 128
    //Piano graphics
      float[] PianoCylinderX           = new float[GeometryDetail];
      float[] PianoCylinderY           = new float[GeometryDetail];
      float PianoSpinY        = 0;
    //Organ graphics
      float[] OrganCylinderX           = new float[GeometryDetail];
      float[] OrganCylinderY           = new float[GeometryDetail];
    //Pipe graphics
      float[] PipeCylinderX            = new float[GeometryDetail];
      float[] PipeCylinderY            = new float[GeometryDetail];
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
      PImage[] PipeNoteColor                = new PImage[128];
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
    PImage[] PipeMask                     = new PImage[60];
    //PImage SynthLeadMask;
    //PImage SynthPadMask;
    //PImage SynthEffectsMask;
    //PImage EthnicMask;
    //PImage PercussiveMask;
    //PImage SoundEffectsMask;
    //PImage PercussionMask;

  //Animation
    //Depth
      float DepthRate = 2;
    //Vibration
      float SineDiameter      = 10            ;
      float SineAngleConstant = 0.03125f       ; 
      float SineAngle[]       = new float[128];
      float SineDepth[]       = new float[128];
    //Frame sequence
      int MaskOrganFrame    = 0;
      int MaskStringsFrame  = 0;
      int MaskEnsembleFrame = 0;
      int MaskPipeFrame     = 0;
    //Fade out
      float PianoSustainAlpha               = 2;
      float ChromaticPercussionSustainAlpha = 2;
    //Amplitude decay
      float GuitarAmplitudeDecay = 0.99f;
      float BassAmplitudeDecay   = 0.99f;
    //Sine wave
      int xspacing = 4                                     ; //How far apart should each horizontal location be spaced
      int w = 2048                                         ; //Width of entire wave
      float theta = 0.0f                                    ; //Start angle at 0
      float period = 500.0f                                 ; //How many pixels before the wave repeats
      float dx = (TWO_PI / period) * xspacing              ; //Value for incrementing X, a function of period and xspacing
      float[] yvalues = new float[w/xspacing]              ; //Using an array to store height values for the wave
      float BeginningAmplitude                          = 4;
      float[] GuitarAmplitude = new float[128];            ; //Height of wave
      float[] BassAmplitude   = new float[128];            ; //Height of wave
    //Strings bowing orientation
      int StringsBowOrientation = 1                        ; //Bowing orientation. 1=Up | -1=Down
    //Spin
      int PipeSpin = 0                                     ; //Pipe initial rotation
      int PipeRotationRate = 6                             ; //Pipe rotation speed
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
      final float SPEED=1.9f;
      Star[] s = new Star[numstars];
  
//Setup
public void setup() {
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
      cam.sensitivity = 0.25f;    //Default is 0.25
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
    float PianoCylinderAngle = 370.5f / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PianoCylinderX[i] = cos(radians(i * PianoCylinderAngle));
      PianoCylinderY[i] = sin(radians(i * PianoCylinderAngle));
    }
    //Organ graphics
    float OrganCylinderAngle = 370.5f / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      OrganCylinderX[i] = cos(radians(i * OrganCylinderAngle));
      OrganCylinderY[i] = sin(radians(i * OrganCylinderAngle));
    }
    //Pipe graphics
    float PipeCylinderAngle = 370.5f / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PipeCylinderX[i] = cos(radians(i * PipeCylinderAngle));
      PipeCylinderY[i] = sin(radians(i * PipeCylinderAngle));
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
public void draw() {
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
    PipeGFXDisplay();
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
    //#Pipe
    if (MaskPipeFrame >= 0 && MaskPipeFrame < 59) {MaskPipeFrame++;} else {MaskPipeFrame = 0;}
    for (int i = 0; i < 128; i++) {PipeNoteColor[i].mask(PipeMask[MaskPipeFrame]);}
  //StringsBowOrientation
    //#Strings
      if (StringsBowOrientation ==   1) {if (MaskStringsFrame == 59) {MaskStringsFrame = 0;} MaskStringsFrame++;} //If StringsBowOrientation equals  1, texture moves upwards
      if (StringsBowOrientation ==  -1) {if (MaskStringsFrame == 0) {MaskStringsFrame = 59;} MaskStringsFrame--;} //If StringsBowOrientation equals -1, texture moves downwards
      for (int i = 0; i < 128; i++) {StringsNoteColor[i].mask(StringsMask[MaskStringsFrame]);}
  //Decrease sine wave amplitude
    for (int i = 0; i < 128; i++) {GuitarAmplitude[i] = GuitarAmplitude[i]*GuitarAmplitudeDecay;} //#Guitar
    for (int i = 0; i < 128; i++) {BassAmplitude[i]   = BassAmplitude[i]  *BassAmplitudeDecay;}   //#Bass
  //Spin
    PipeSpin = PipeSpin+PipeRotationRate;
   
  // Saves each frame as screen-0001.tif, screen-0002.tif, etc.
    if (DumpFrames == true) {
      saveFrame("Dump/Synthesthesia-######.png");
    }
}

//Note on event
public void noteOn(int channel, int pitch, int velocity) {
  
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
  PipeChannelNoteOn();
  //SynthLeadChannelNoteOn();
  //SynthPadChannelNoteOn();
  //SynthEffectsChannelNoteOn();
  //EthnicChannelNoteOn();
  //PercussiveChannelNoteOn();
  //SoundEffectsChannelNoteOn();
  //PercussionChannelNoteOn();
}

//Note off event
public void noteOff(int channel, int pitch, int velocity) {
  
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
  PipeChannelNoteOff();
  //SynthLeadChannelNoteOff();
  //SynthPadChannelNoteOff();
  //SynthEffectsChannelNoteOff();
  //EthnicChannelNoteOff();
  //PercussiveChannelNoteOff();
  //SoundEffectsChannelNoteOff();
  //PercussionChannelNoteOff();
}

public void OctaveVariables(){
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

public void ColorTextures(){
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
    PipeNoteColor[i]                = loadImage("NoteColor_" + i + ".png");
    // SynthLeadNoteColor[i]           = loadImage("NoteColor_" + i + ".png");
    // SynthPadNoteColor[i]            = loadImage("NoteColor_" + i + ".png");
    // SynthEffectsNoteColor[i]        = loadImage("NoteColor_" + i + ".png");
    // EthnicNoteColor[i]              = loadImage("NoteColor_" + i + ".png");
    // PercussiveNoteColor[i]          = loadImage("NoteColor_" + i + ".png");
    // PercussionNoteColor[i]          = loadImage("NoteColor_" + i + ".png");
  }
}

public void ColorTexturesMasks(){
  //Load alpha mask files
  PianoMask               = loadImage("Mask-Piano.png");
  PianoMaskSide           = loadImage("Mask-Piano-Side.png");
  ChromaticPercussionMask = loadImage("Mask-ChromaticPercussion.png");
  GuitarMask              = loadImage("Mask-Guitar.png");
  BassMask                = loadImage("Mask-Bass.png");
  // BrassMask               = loadImage("Mask-Brass.png");
  // ReedMask                = loadImage("Mask-Reed.png");
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
    PipeMask[i]     = loadImage("Mask-Pipe_"     + nf(i, 2) + ".png");
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
public void PianoGFXDisplay(){//Piano
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
public void ChromaticPercussionGFXDisplay(){
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
public void OrganGFXDisplay(){
  if (ChannelIsActive[OrganChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (OrganPitchIsActive[i] == true) 
      {organgfx = new OrganGFX (
        OrganPitchX[i]        , //X coordinate 
        OrganVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]   , //Z coordinate  
        OrganPitchWidth[i]    , //Width  
        OrganPitchHeight[i]   , //Height  
        VelocityScaleY       , //Depth    
        PitchHues[i]         , //Hue  
        OctaveSaturations[i] , //Saturation    
        OctaveBrightnesses[i], //Brightness    
        OrganVelocityAlpha[i] , //Alpha  
        OrganNoteColor[i]    ); //Texture  
        organgfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Guitar
public void GuitarGFXDisplay(){
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
public void BassGFXDisplay(){
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
public void StringsGFXDisplay(){
  if (ChannelIsActive[StringsChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (StringsPitchIsActive[i] == true) 
      {stringsgfx = new StringsGFX (
        StringsPitchX[i]        , //X coordinate 
        StringsVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]      , //Z coordinate  
        StringsPitchWidth[i]    , //Width  
        StringsPitchHeight[i]   , //Height  
        VelocityScaleY          , //Depth    
        PitchHues[i]            , //Hue  
        OctaveSaturations[i]    , //Saturation    
        OctaveBrightnesses[i]   , //Brightness    
        StringsVelocityAlpha[i] , //Alpha  
        StringsNoteColor[i]    ); //Texture  
        stringsgfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Ensemble
public void EnsembleGFXDisplay(){
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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

//D#Pipe
public void PipeGFXDisplay(){
  if (ChannelIsActive[PipeChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (PipePitchIsActive[i] == true) 
      {pipegfx = new PipeGFX (
        PipePitchX[i]        , //X coordinate 
        PipeVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]   , //Z coordinate  
        PipePitchWidth[i]    , //Width  
        PipePitchHeight[i]   , //Height  
        VelocityScaleY       , //Depth    
        PitchHues[i]         , //Hue  
        OctaveSaturations[i] , //Saturation    
        OctaveBrightnesses[i], //Brightness    
        PipeVelocityAlpha[i] , //Alpha  
        PipeNoteColor[i]     ,    
        PipeSpin            ); //Texture  
        pipegfx.display()    ; //Display graphics 
      }
    }
  }
}

// //D#Synth Lead
// void SynthLeadGFXDisplay(){
//   if (ChannelIsActive[SynthLeadChannelID] == true) {
//   for (int i = 0; i < 128; i++) {
//     if (SynthLeadPitchIsActive[i] == true) 
//       {synthleadgfx = new SynthLeadGFX (
//         SynthLeadPitchX[i]        , //X coordinate  
//         SynthLeadVelocityY[i]     , //Y coordinate   
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
//         Depth+SineDepth[i]    , //Z coordinate   
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
  public void PianoChannelNoteOn(){
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
  public void ChromaticPercussionChannelNoteOn(){
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
  public void OrganChannelNoteOn(){
    if (Channel == OrganChannelID) {
      ChannelIsActive[OrganChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          OrganPitchIsActive[i]  = true; 
          OrganPitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          OrganVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          OrganVelocityAlpha[i]  = Velocity*2; 
          OrganPitchWidth[i]     = map(Pitch, 0, 127, 1,   0.015625f);
          OrganPitchHeight[i]    = map(Pitch, 0, 127, 0.5f, 1.375f);
        }
      }
    }
  }
  //N#Guitar
  public void GuitarChannelNoteOn(){
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
  public void BassChannelNoteOn(){
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
  public void StringsChannelNoteOn(){
    if (Channel == StringsChannelID) {
      ChannelIsActive[StringsChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          StringsPitchIsActive[i]  = true; 
          StringsPitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          StringsVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          StringsVelocityAlpha[i]  = Velocity*2; 
          StringsPitchWidth[i]     = map(Pitch, 0, 127, 1,   0.125f);
          StringsPitchHeight[i]    = map(Pitch, 0, 127, 0.5f, 1.375f);
        }
      }
    }
  }
  //N#Ensemble
  public void EnsembleChannelNoteOn(){
    if (Channel == EnsembleChannelID) {
      ChannelIsActive[EnsembleChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          EnsemblePitchIsActive[i]  = true; 
          EnsemblePitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          EnsembleVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          EnsembleVelocityAlpha[i]  = Velocity*2; 
          EnsemblePitchThickness[i] = map(Pitch, 0, 127, 1, 0.125f);
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
  //N#Pipe
  public void PipeChannelNoteOn(){
    if (Channel == PipeChannelID) {
      ChannelIsActive[PipeChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PipePitchIsActive[i]  = true; 
          PipePitchX[i]         = map(Pitch, 0, 127, -width, width*2); 
          PipeVelocityY[i]      = map(Velocity, 0, 127, height, 0); 
          PipeVelocityAlpha[i]  = Velocity*2; 
          PipePitchWidth[i]     = map(Pitch, 0, 127, 1,   0.015625f);
          PipePitchHeight[i]    = map(Pitch, 0, 127, 0.5f, 1.375f);
        }
      }
    }
  }
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
  public void PianoChannelNoteOff(){
    if (Channel == PianoChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PianoPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#ChromaticPercussion
  public void ChromaticPercussionChannelNoteOff(){
    if (Channel == ChromaticPercussionChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          ChromaticPercussionPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Organ
  public void OrganChannelNoteOff(){
    if (Channel == OrganChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          OrganPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Guitar
  public void GuitarChannelNoteOff(){
    if (Channel == GuitarChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          GuitarPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Bass
  public void BassChannelNoteOff(){
    if (Channel == BassChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          BassPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Strings
  public void StringsChannelNoteOff(){
    if (Channel == StringsChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          StringsPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Ensemble
  public void EnsembleChannelNoteOff(){
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
  //F#Pipe
  public void PipeChannelNoteOff(){
    if (Channel == PipeChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PipePitchIsActive[i] = false;
        }
      }
    }
  }
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


class Background {
  float BX ;
  float BY ;
  float BZ ;
  float BW ;
  float BH ;
  float BD ;
  float BHu;
  float BS ;
  float BB ;
  float BA ;
  
  Background (float BackgroundX, float BackgroundY, float BackgroundZ, float BackgroundWidth, float BackgroundHeight, float BackgroundDepth, float BackgroundHue, float BackgroundSaturation, float BackgroundBrightness, float BackgroundAlpha) {
    BX  = BackgroundX;
    BY  = BackgroundY;
    BZ  = BackgroundZ;
    BW  = BackgroundWidth;
    BH  = BackgroundHeight;
    BD  = BackgroundDepth;
    BHu = BackgroundHue;
    BS  = BackgroundSaturation;
    BB  = BackgroundBrightness;
    BA  = BackgroundAlpha;
  }
  
  public void display() {
    strokeWeight(2);
    stroke(127);
    noFill();
    translate(width/2,height/2,-250);
    box(BX,BY,BZ);
  }
  
  public void fadeOut() {
    noStroke();
    colorMode(HSB, 255, 100, 100, 150);
    fill(BHu, BS, BB, BA);
    rectMode(CENTER);
    rect(0, 0, BX*2, BY*2);
  }
  
  public void gray() {
    background(127);           // Black Background
}
  public void black() {
    background(0);           // Black Background
  }
}



class BassGFX {
  float  BX ;
  float  BY ;
  float  BZ ;
  float  BW ;
  float  BH ;
  float  BD ;
  float  BHu;
  float  BS ;
  float  BB ;
  float  BA ;
  float  BV ;
  float  BAm;
  PImage BT ;
  
  BassGFX (float BassX, float BassY, float BassZ, float BassWidth, float BassHeight, float BassDepth, float BassHue, float BassSaturation, float BassBrightness, float BassAlpha, float BassVibration, float BassAmplitude, PImage BassTexture) {
    BX  = BassX;
    BY  = BassY;
    BZ  = BassZ;
    BW  = BassWidth;
    BH  = BassHeight;
    BD  = BassDepth;
    BHu = BassHue;
    BS  = BassSaturation;
    BB  = BassBrightness;
    BA  = BassAlpha;
    BV  = BassVibration;
    BT  = BassTexture; 
    BAm = BassAmplitude;
  }

  public void display() {

    //Mask
    blendMode(ADD);
    translate(BX-256, BY+512, BZ+256);

    calcWave();
    renderWave();
    
    //Reset
    translate(-BX+256, -BY-512, -BZ-256);
    blendMode(BLEND);

  }

  public void calcWave() {
    theta += BV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*BA*BAm;
      x+=dx;
    }
  }
  
  public void renderWave() {
    noStroke();
    float bassStroke = map(BV, VibrationUnit, PitchVibration[127], 64, 0.015625f);
    rotateY(radians(90));
    rotateX(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing, height/2+yvalues[x], 0);
        rotateY(radians(90));
          beginShape();
            texture(BT);
            vertex(-bassStroke, -bassStroke, 0,   0,   0);
            vertex( bassStroke, -bassStroke, 0, 512,   0);
            vertex( bassStroke,  bassStroke, 0, 512, 512);
            vertex(-bassStroke,  bassStroke, 0,   0, 512);
          endShape();
        rotateY(radians(-90));
      translate(-(x*xspacing), -(height/2+yvalues[x]), 0);
    }
    rotateX(radians(-90));
    rotateY(radians(-90));
  }
}


class BrassGFX {
  float BrX ;
  float BrY ;
  float BrZ ;
  float BrW ;
  float BrH ;
  float BrD ;
  float BrHu;
  float BrS ;
  float BrB ;
  float BrA ;
  PImage BrT ;
  
  BrassGFX (float BrassX, float BrassY, float BrassZ, float BrassWidth, float BrassHeight, float BrassDepth, float BrassHue, float BrassSaturation, float BrassBrightness, float BrassAlpha, PImage BrassTexture) {
    BrX  = BrassX;
    BrY  = BrassY;
    BrZ  = BrassZ;
    BrW  = BrassWidth;
    BrH  = BrassHeight;
    BrD  = BrassDepth;
    BrHu = BrassHue;
    BrS  = BrassSaturation;
    BrB  = BrassBrightness;
    BrA  = BrassAlpha;
    BrT  = BrassTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, BrA); 
  translate(BrX, BrY, BrZ);
  beginShape();
    texture(BrT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-BrX, -BrY, -BrZ);
  blendMode(BLEND);
  }
}
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
  
  ChromaticPercussionGFX (float ChromaticPercussionX, float ChromaticPercussionY, float ChromaticPercussionZ, float ChromaticPercussionWidth, float ChromaticPercussionHeight, float ChromaticPercussionDepth, float ChromaticPercussionHue, float ChromaticPercussionSaturation, float ChromaticPercussionBrightness, float ChromaticPercussionAlpha, PImage ChromaticPercussionTexture) {
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
  public void display() {

//Mask
  //Blending mode
  //Color
  tint(255, 255, 255, CPA); 
  //General translation
  translate(CPX, CPY, CPZ);
  
  //Front face
  beginShape();
    texture(CPT);
    vertex(-50, -200, 0, 0,   0);
    vertex( 50, -200, 0, 512, 0);
    vertex( 50,  200, 0, 512, 512);
    vertex(-50,  200, 0, 0,   512);
  endShape();
  
//  translate(0, 0, -100);
//  beginShape();
//    texture(CPT);
//    vertex(-100, -100, 0, 0,   0);
//    vertex( 100, -100, 0, 512, 0);
//    vertex( 100,  100, 0, 512, 512);
//    vertex(-100,  100, 0, 0,   512);
//  endShape();
//  translate(0, 0, 100);

  beginShape();
    texture(CPT);
    vertex(-50, -200, -100, 0,   0);
    vertex( 50, -200, -100, 512, 0);
    vertex( 50,  200, -100, 512, 512);
    vertex(-50,  200, -100, 0,   512);
  endShape();
  
//  rotateX(radians(90));
//  beginShape();
//    texture(CPT);
//    vertex(-100, -100, 0, 0,   0);
//    vertex( 100, -100, 0, 512, 0);
//    vertex( 100,  100, 0, 512, 512);
//    vertex(-100,  100, 0, 0,   512);
//  endShape();
//  rotateX(radians(90));
  
  translate(-CPX, -CPY, -CPZ);
  }
}
class Debug {
  public void framerate() {
    println(frameRate); // Return framerate
  }
  public void clickToPrintVariables() {
     if (mousePressed == true) {
    println("---------------- In -----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
    }
  }
  public void noteOnReturn() { //MIDI Note on values
    println("---------------- On -----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
  }
  
  public void noteOffReturn() { //MIDI Note off values
    println("---------------- Off ----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
  }
}

class EnsembleGFX {
  float  EX ;
  float  EY ;
  float  EZ ;
  float  EW ;
  float  EH ;
  float  ED ;
  float  EHu;
  float  ES ;
  float  EB ;
  float  EA ;
  float  ETh;
  PImage ET ;

  EnsembleGFX (float EnsembleX, float EnsembleY, float EnsembleZ, float EnsembleWidth, float EnsembleHeight, float EnsembleDepth, float EnsembleHue, float EnsembleSaturation, float EnsembleBrightness, float EnsembleAlpha, float EnsembleThickness, PImage EnsembleTexture) {
    EX  = EnsembleX;
    EY  = EnsembleY;
    EZ  = EnsembleZ;
    EW  = EnsembleWidth;
    EH  = EnsembleHeight;
    ED  = EnsembleDepth;
    EHu = EnsembleHue;
    ES  = EnsembleSaturation;
    EB  = EnsembleBrightness;
    EA  = EnsembleAlpha;
    ETh = EnsembleThickness;
    ET  = EnsembleTexture;

  }
  public void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, EA/2); 
  translate(EX, 360, EZ+EA*DepthRate);
  beginShape();
    texture(ET);
    vertex(-512, -720, 0, 0,     0);
    vertex( 512, -720, 0, 512,   0);
    vertex( 512,  720, 0, 512, 512);
    vertex(-512,  720, 0, 0,   512);
  endShape();
  rotateZ(radians(180));
    beginShape();
    texture(ET);
    vertex(-512, -720, -100, 0,     0);
    vertex( 512, -720, -100, 512,   0);
    vertex( 512,  720, -100, 512, 512);
    vertex(-512,  720, -100, 0,   512);
  endShape();
  rotateZ(radians(-180));
  translate(-EX, -360, -EZ-(EA*DepthRate));
  blendMode(BLEND);
  }
}

class EthnicGFX {
  float EtX ;
  float EtY ;
  float EtZ ;
  float EtW ;
  float EtH ;
  float EtD ;
  float EtHu;
  float EtS ;
  float EtB ;
  float EtA ;
  PImage EtT ;
  
  EthnicGFX (float EthnicX, float EthnicY, float EthnicZ, float EthnicWidth, float EthnicHeight, float EthnicDepth, float EthnicHue, float EthnicSaturation, float EthnicBrightness, float EthnicAlpha, PImage EthnicTexture) {
    EtX  = EthnicX;
    EtY  = EthnicY;
    EtZ  = EthnicZ;
    EtW  = EthnicWidth;
    EtH  = EthnicHeight;
    EtD  = EthnicDepth;
    EtHu = EthnicHue;
    EtS  = EthnicSaturation;
    EtB  = EthnicBrightness;
    EtA  = EthnicAlpha;
    EtT  = EthnicTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, EtA); 
  translate(EtX, EtY, EtZ);
  beginShape();
    texture(EtT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-EtX, -EtY, -EtZ);
  blendMode(BLEND);
  }
}
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
  float  GV ;
  float  GAm;
  PImage GT ;
  
  GuitarGFX (float GuitarX, float GuitarY, float GuitarZ, float GuitarWidth, float GuitarHeight, float GuitarDepth, float GuitarHue, float GuitarSaturation, float GuitarBrightness, float GuitarAlpha, float GuitarVibration, float GuitarAmplitude, PImage GuitarTexture) {
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
    GV  = GuitarVibration;
    GT  = GuitarTexture;
    GAm = GuitarAmplitude; 
  }

  public void display() {

    //Mask
    blendMode(ADD);
    translate(GX, GY-750, GZ);
    calcWave();
    renderWave();
    
    //Reset
    translate(-GX, -GY+750, -GZ);
    blendMode(BLEND);

  }

  public void calcWave() {
    theta += GV;// Increment theta (try different values for 'angular velocity' here)
    float x = theta;// For every x value, calculate a y value with sine function
    for (int i = 0; i < yvalues.length; i++) {
      yvalues[i] = sin(x)*GA*GAm;
      x+=dx;
    }
  }
  
  public void renderWave() {
    noStroke();
    float guitarStroke = map(GV, VibrationUnit, PitchVibration[127], 64, 0.015625f);
    rotateY(radians(90));
    for (int x = 0; x < yvalues.length; x++) { // A simple way to draw the wave with an ellipse at each location
      translate(x*xspacing, height/2+yvalues[x], 0);
      rotateY(radians(90));
      beginShape();
        texture(GT);
        vertex(-guitarStroke, -guitarStroke, 0,                0,                0);
        vertex( guitarStroke, -guitarStroke, 0, 512,                0);
        vertex( guitarStroke,  guitarStroke, 0, 512, 512);
        vertex(-guitarStroke,  guitarStroke, 0,                0, 512);
      endShape();
      rotateY(radians(-90));
      translate(-(x*xspacing), -(height/2+yvalues[x]), 0);
    }
    rotateY(radians(-90));
  }
}


class OrganGFX {
  float  OX ;
  float  OY ;
  float  OZ ;
  float  OW ;
  float  OH ;
  float  OD ;
  float  OHu;
  float  OS ;
  float  OB ;
  float  OA ;
  PImage OT ;

  OrganGFX (float OrganX, float OrganY, float OrganZ, float OrganWidth, float OrganHeight, float OrganDepth, float OrganHue, float OrganSaturation, float OrganBrightness, float OrganAlpha, PImage OrganTexture) {
    OX  = OrganX;
    OY  = OrganY;
    OZ  = OrganZ;
    OW  = OrganWidth;
    OH  = OrganHeight;
    OD  = OrganDepth;
    OHu = OrganHue;
    OS  = OrganSaturation;
    OB  = OrganBrightness;
    OA  = OrganAlpha;
    OT  = OrganTexture;

  }
  public void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, OA); 
  translate(OX, 360, OZ+(OA*DepthRate));
  beginShape(QUAD_STRIP);
    texture(OT);
    for (int i = 0; i < GeometryDetail; i++) {
      float x = (PipeCylinderX[i] * 100*OW);
      float z = PipeCylinderY[i] * 100*OW;
      float u = OT.width / GeometryDetail * i;
      vertex(x, -600*OH, z, u, 0);
      vertex(x, 600*OH, z, u, OT.height);
    }
  endShape();


  translate(-OX, -360, -OZ-(OA*DepthRate));
  blendMode(BLEND);
  }
}

class PercussionGFX {
  float PerX ;
  float PerY ;
  float PerZ ;
  float PerW ;
  float PerH ;
  float PerD ;
  float PerHu;
  float PerS ;
  float PerB ;
  float PerA ;
  PImage PerT ;
  
  PercussionGFX (float PercussionX, float PercussionY, float PercussionZ, float PercussionWidth, float PercussionHeight, float PercussionDepth, float PercussionHue, float PercussionSaturation, float PercussionBrightness, float PercussionAlpha, PImage PercussionTexture) {
    PerX  = PercussionX;
    PerY  = PercussionY;
    PerZ  = PercussionZ;
    PerW  = PercussionWidth;
    PerH  = PercussionHeight;
    PerD  = PercussionDepth;
    PerHu = PercussionHue;
    PerS  = PercussionSaturation;
    PerB  = PercussionBrightness;
    PerA  = PercussionAlpha;
    PerT  = PercussionTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, PerA); 
  translate(PerX, PerY, PerZ);
  beginShape();
    texture(PerT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PerX, -PerY, -PerZ);
  blendMode(BLEND);
  }
}
class PercussiveGFX {
  float PeX ;
  float PeY ;
  float PeZ ;
  float PeW ;
  float PeH ;
  float PeD ;
  float PeHu;
  float PeS ;
  float PeB ;
  float PeA ;
  PImage PeT ;
  
  PercussiveGFX (float PercussiveX, float PercussiveY, float PercussiveZ, float PercussiveWidth, float PercussiveHeight, float PercussiveDepth, float PercussiveHue, float PercussiveSaturation, float PercussiveBrightness, float PercussiveAlpha, PImage PercussiveTexture) {
    PeX  = PercussiveX;
    PeY  = PercussiveY;
    PeZ  = PercussiveZ;
    PeW  = PercussiveWidth;
    PeH  = PercussiveHeight;
    PeD  = PercussiveDepth;
    PeHu = PercussiveHue;
    PeS  = PercussiveSaturation;
    PeB  = PercussiveBrightness;
    PeA  = PercussiveAlpha;
    PeT  = PercussiveTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, PeA); 
  translate(PeX, PeY, PeZ);
  beginShape();
    texture(PeT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-PeX, -PeY, -PeZ);
  blendMode(BLEND);
  }
}
class PianoGFX {
  float  PX ;
  float  PY ;
  float  PZ ;
  float  PW ;
  float  PH ;
  float  PD ;
  float  PHu;
  float  PS ;
  float  PB ;
  float  PA ;
  PImage PT ;
  PImage PT2;
  
  PianoGFX (float PianoX, float PianoY, float PianoZ, float PianoWidth, float PianoHeight, float PianoDepth, float PianoHue, float PianoSaturation, float PianoBrightness, float PianoAlpha, PImage PianoTexture, PImage PianoTexture2) {
    PX  = PianoX;
    PY  = PianoY;
    PZ  = PianoZ;
    PW  = PianoWidth;
    PH  = PianoHeight;
    PD  = PianoDepth;
    PHu = PianoHue;
    PS  = PianoSaturation;
    PB  = PianoBrightness;
    PA  = PianoAlpha;
    PT  = PianoTexture; 
    PT2  = PianoTexture2; 
  }
  public void display() {
    
  //Mask
  blendMode(ADD);
  
  //Object
  tint(255, 255, 255, PA);  
  translate(PX, PY, PZ+PA*DepthRate);
  beginShape();
    texture(PT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();

  scale(0.8f, 0.8f, 1);
  translate(0, 0, -100);
  rotateX(radians(-90));
  rotateY(radians(PianoSpinY));
  beginShape(QUAD_STRIP);
  texture(PT2);
  for (int i = 0; i < GeometryDetail; i++) {
    float x = PianoCylinderX[i] * 100;
    float z = PianoCylinderY[i] * 100;
    float u = PT2.width / GeometryDetail * i;
    vertex(x, -100, z, u, 0);
    vertex(x, 100, z, u, PT2.height);
  }
  endShape();
  rotateX(radians(90));
  rotateY(radians(-PianoSpinY));
  translate(0, 0, 100);
  scale(1.25f, 1.25f, 1);
  
  //Increase variable values
//    PianoSpinY = PianoSpinY - 3;
    
  //Reset
  translate(-PX, -PY, -PZ-(PA*DepthRate));
  blendMode(BLEND);
  }
}
class PipeGFX {
  float  PiX ;
  float  PiY ;
  float  PiZ ;
  float  PiW ;
  float  PiH ;
  float  PiD ;
  float  PiHu;
  float  PiS ;
  float  PiB ;
  float  PiA ;
  PImage PiT ;
  float  PiSp;

  PipeGFX (float PipeX, float PipeY, float PipeZ, float PipeWidth, float PipeHeight, float PipeDepth, float PipeHue, float PipeSaturation, float PipeBrightness, float PipeAlpha, PImage PipeTexture, float PipeSpin) {
    PiX  = PipeX;
    PiY  = PipeY;
    PiZ  = PipeZ;
    PiW  = PipeWidth;
    PiH  = PipeHeight;
    PiD  = PipeDepth;
    PiHu = PipeHue;
    PiS  = PipeSaturation;
    PiB  = PipeBrightness;
    PiA  = PipeAlpha;
    PiT  = PipeTexture;
    PiSp = PipeSpin;
  }
  
  public void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, PiA); 
  translate(PiX, 360, PiZ+(PiA*DepthRate));
    rotateY(radians(PiSp));
      beginShape(QUAD_STRIP);
        texture(PiT);
        for (int i = 0; i < GeometryDetail; i++) {
          float x = PipeCylinderX[i] * 100*PiW;
          float z = PipeCylinderY[i] * 100*PiW;
          float u = PiT.width / GeometryDetail * i;
          vertex(x, -600*PiH, z, u, 0);
          vertex(x, 600*PiH, z, u, PiT.height);
        }
      endShape();
    rotateY(radians(-PiSp));
  translate(-PiX, -360, -PiZ-(PiA*DepthRate));
  blendMode(BLEND);
  }
}

class ReedGFX {
  float RX ;
  float RY ;
  float RZ ;
  float RW ;
  float RH ;
  float RD ;
  float RHu;
  float RS ;
  float RB ;
  float RA ;
  PImage RT ;
  
  ReedGFX (float ReedX, float ReedY, float ReedZ, float ReedWidth, float ReedHeight, float ReedDepth, float ReedHue, float ReedSaturation, float ReedBrightness, float ReedAlpha, PImage ReedTexture) {
    RX  = ReedX;
    RY  = ReedY;
    RZ  = ReedZ;
    RW  = ReedWidth;
    RH  = ReedHeight;
    RD  = ReedDepth;
    RHu = ReedHue;
    RS  = ReedSaturation;
    RB  = ReedBrightness;
    RA  = ReedAlpha;
    RT  = ReedTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, RA); 
  translate(RX, RY, RZ);
  beginShape();
    texture(RT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-RX, -RY, -RZ);
  blendMode(BLEND);
  }
}
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
  public void display() {

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
class Star { 
  float x=0,y=0,z=0,sx=0,sy=0;
  public void SetPosition(){
    z=(float) random(200,255);
    x=(float) random(-1000,1000);
    y=(float) random(-1000,1000);
  }
  public void DrawStar(){
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
class StringsGFX {
  float  SX ;
  float  SY ;
  float  SZ ;
  float  SW ;
  float  SH ;
  float  SD ;
  float  SHu;
  float  SS ;
  float  SB ;
  float  SA ;
  PImage ST ;

  StringsGFX (float StringsX, float StringsY, float StringsZ, float StringsWidth, float StringsHeight, float StringsDepth, float StringsHue, float StringsSaturation, float StringsBrightness, float StringsAlpha, PImage StringsTexture) {
    SX  = StringsX;
    SY  = StringsY;
    SZ  = StringsZ;
    SW  = StringsWidth;
    SH  = StringsHeight;
    SD  = StringsDepth;
    SHu = StringsHue;
    SS  = StringsSaturation;
    SB  = StringsBrightness;
    SA  = StringsAlpha;
    ST  = StringsTexture;

  }
  public void display() {
  //Mask
  blendMode(ADD);
  tint(255, 255, 255, SA); 
  translate(SX, 360, SZ+SA*DepthRate);
  beginShape();
    texture(ST);
    vertex(-256*SW, -512*SH, 0, 0,     0);
    vertex( 256*SW, -512*SH, 0, 512,   0);
    vertex( 256*SW,  512*SH, 0, 512, 512);
    vertex(-256*SW,  512*SH, 0, 0,   512);
  endShape();
  translate(-SX, -360, -SZ-SA*DepthRate);
  blendMode(BLEND);
  }
}

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
  public void display() {

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
  public void display() {

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
class SynthPadGFX {
  float SPX ;
  float SPY ;
  float SPZ ;
  float SPW ;
  float SPH ;
  float SPD ;
  float SPHu;
  float SPS ;
  float SPB ;
  float SPA ;
  PImage SPT ;
  
  SynthPadGFX (float SynthPadX, float SynthPadY, float SynthPadZ, float SynthPadWidth, float SynthPadHeight, float SynthPadDepth, float SynthPadHue, float SynthPadSaturation, float SynthPadBrightness, float SynthPadAlpha, PImage SynthPadTexture) {
    SPX  = SynthPadX;
    SPY  = SynthPadY;
    SPZ  = SynthPadZ;
    SPW  = SynthPadWidth;
    SPH  = SynthPadHeight;
    SPD  = SynthPadDepth;
    SPHu = SynthPadHue;
    SPS  = SynthPadSaturation;
    SPB  = SynthPadBrightness;
    SPA  = SynthPadAlpha;
    SPT  = SynthPadTexture;
  }
  public void display() {

//Mask
  blendMode(ADD);
  tint(255, 255, 255, SPA); 
  translate(SPX, SPY, SPZ);
  beginShape();
    texture(SPT);
    vertex(-100, -100, 0, 0,   0);
    vertex( 100, -100, 0, 512, 0);
    vertex( 100,  100, 0, 512, 512);
    vertex(-100,  100, 0, 0,   512);
  endShape();
  translate(-SPX, -SPY, -SPZ);
  blendMode(BLEND);
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#FFFFFF", "--hide-stop", "Synthaesthesia" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
