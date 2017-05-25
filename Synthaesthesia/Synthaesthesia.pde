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
import themidibus.*               ; //MIDI interface bridge
import queasycam.*                ; //Free view camera
import camera3D.generators.util.* ;
import camera3D.generators.*      ;
import camera3D.*                 ;

//Create instances
  //General
  Debug                  debug                 ;  //Debug
  // Background             background            //Background
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
  BrassGFX               brassgfx              ;  //Brass graphics       
  ReedGFX                reedgfx               ;  //Reed graphics      
  PipeGFX                pipegfx               ;  //Pipe graphics      
  SynthLeadGFX           synthleadgfx          ;  //Synth Lead graphics           
  SynthPadGFX            synthpadgfx           ;  //Synth Pad graphics          
  SynthEffectsGFX        syntheffectsgfx       ;  //Synth Effects graphics              
  EthnicGFX              ethnicgfx             ;  //Ethnic graphics        
  PercussiveGFX          percussivegfx         ;  //Percussive graphics                  
  PercussionGFX          percussiongfx         ;  //Percussion graphics  
  //Effects          
  ParticleSystem         ps                    ;  //Particles

//Instrument IDs
  int PianoChannelID               =  0; //Piano                - Channel #1
  int ChromaticPercussionChannelID =  1; //Chromatic Percussion - Channel #2
  int OrganChannelID               =  2; //Organ                - Channel #3
  int GuitarChannelID              =  3; //Guitar               - Channel #4
  int BassChannelID                =  4; //Bass                 - Channel #5
  int StringsChannelID             =  5; //Strings              - Channel #6
  int EnsembleChannelID            =  6; //Ensemble             - Channel #7
  int BrassChannelID               =  7; //Brass                - Channel #8
  int ReedChannelID                =  8; //Reed                 - Channel #9
  int PipeChannelID                = 10; //Pipe                 - Channel #11
  int SynthLeadChannelID           = 11; //Synth Lead           - Channel #12
  int SynthPadChannelID            = 12; //Synth Pad            - Channel #13
  int SynthEffectsChannelID        = 13; //Synth Effects        - Channel #14
  int EthnicChannelID              = 14; //Ethnic               - Channel #15
  int PercussiveChannelID          = 15; //Percussive           - Channel #16
  int SoundEffectsChannelID        = -1; //Sound effects        - N/A - Not used
  int PercussionChannelID          =  9; //Percussion           - Channel #10

//Global switches
  int[]             Widths = {960, 1280, 1920}; //1/4 1080p [0] | 720p [1] | 1080p [2]
  int[]            Heights = {540,  720, 1080}; //1/4 1080p [0] | 720p [1] | 1080p [2]
  int                Width =         Widths[2]; //Window width
  int               Height =        Heights[2]; //Window height
  boolean         EnableAA =             false; //Anti-aliasing
  boolean     Enable120FPS =             false; //120 frames per second
  boolean         Enable3D =             false; //Stereoscopic 3D
  int         Divergence3D =                 2; //3D focus point
  boolean EnableFreeCamera =             false; //Mouse-controlled camera     
  boolean       DumpFrames =             false; //Dump frames to Tiff files
  float          FrameRate                    ; //Frames per second
  float  RelativeFrameRate                    ; //Frames per second

//Declare and initialize global variable arrays
  //Instrument graphics state
    boolean PianoIsActive               = true;
    boolean ChromaticPercussionIsActive = true;
    boolean OrganIsActive               = true;
    boolean GuitarIsActive              = true;
    boolean BassIsActive                = true;
    boolean StringsIsActive             = true;
    boolean EnsembleIsActive            = true;
    boolean BrassIsActive               = true;
    boolean ReedIsActive                = true;
    boolean PipeIsActive                = true;
    boolean SynthLeadIsActive           = true;
    boolean SynthPadIsActive            = true;
    boolean SynthEffectsIsActive        = true;
    boolean EthnicIsActive              = true;
    boolean PercussiveIsActive          = true;
    boolean PercussionIsActive          = true;
  //MIDI channel state
    boolean[] ChannelIsActive                  = new boolean[128];
    boolean[] PianoPitchIsActive               = new boolean[128];
    boolean[] ChromaticPercussionPitchIsActive = new boolean[128];
    boolean[] OrganPitchIsActive               = new boolean[128];
    boolean[] GuitarPitchIsActive              = new boolean[128];
    boolean[] BassPitchIsActive                = new boolean[128];
    boolean[] StringsPitchIsActive             = new boolean[128];
    boolean[] EnsemblePitchIsActive            = new boolean[128];
    boolean[] BrassPitchIsActive               = new boolean[128];
    boolean[] ReedPitchIsActive                = new boolean[128];
    boolean[] PipePitchIsActive                = new boolean[128];
    boolean[] SynthLeadPitchIsActive           = new boolean[128];
    boolean[] SynthPadPitchIsActive            = new boolean[128];
    boolean[] SynthEffectsPitchIsActive        = new boolean[128];
    boolean[] EthnicPitchIsActive              = new boolean[128];
    boolean[] PercussivePitchIsActive          = new boolean[128];
    boolean[] PercussionPitchIsActive          = new boolean[128];

  //MIDI variables mapped to attributes
    int[] PitchHues                            = new int[128]; //Note pitch mapped to hue
    int[] OctaveSaturations                    = new int[128]; //Note pitch mapped to saturation
    int[] OctaveBrightnesses                   = new int[128]; //Note pitch mapped to brightness
  //MIDI instrument note pitches mapped to coordinates
    //Note pitch to X coordinates
      int[] PianoPitchX                       = new int[128];
      int[] ChromaticPercussionPitchX         = new int[128];
      float[] OrganPitchX                       = new float[128];
      int[] GuitarPitchX                      = new int[128];
      int[] BassPitchX                        = new int[128];
      int[] StringsPitchX                     = new int[128];
      int[] EnsemblePitchX                    = new int[128];
      int[] BrassPitchX                       = new int[128];
      int[] ReedPitchX                        = new int[128];
      int[] PipePitchX                        = new int[128];
      int[] SynthLeadPitchX                   = new int[128];
      int[] SynthPadPitchX                    = new int[128];
      int[] SynthEffectsPitchX                = new int[128];
      int[] EthnicPitchX                      = new int[128];
      int[] PercussivePitchX                  = new int[128];
      int[] PercussionPitchX                  = new int[128];
    //Note velocity to Y coordinates
      int[] PianoVelocityY                    = new int[128];
      int[] ChromaticPercussionVelocityY      = new int[128];
      float[] OrganVelocityY                    = new float[128];
      int[] GuitarVelocityY                   = new int[128];
      int[] BassVelocityY                     = new int[128];
      int[] StringsVelocityY                  = new int[128];
      int[] EnsembleVelocityY                 = new int[128];
      int[] BrassVelocityY                    = new int[128];
      int[] ReedVelocityY                     = new int[128];
      int[] PipeVelocityY                     = new int[128];
      int[] SynthLeadVelocityY                = new int[128];
      int[] SynthPadVelocityY                 = new int[128];
      int[] SynthEffectsVelocityY             = new int[128];
      int[] EthnicVelocityY                   = new int[128];
      int[] PercussiveVelocityY               = new int[128];
      int[] PercussionVelocityY               = new int[128];
    //Note velocity to transparency
      int[] PianoVelocityAlpha                = new int[128];
      int[] ChromaticPercussionVelocityAlpha  = new int[128];
      float[] OrganVelocityAlpha                = new float[128];
      float[] OrganPitchWidth                   = new float[128];
      float[] OrganPitchHeight                  = new float[128];
      int[] GuitarVelocityAlpha               = new int[128];
      int[] BassVelocityAlpha                 = new int[128];
      int[] StringsVelocityAlpha              = new int[128];
      int[] StringsPitchWidth                 = new int[128];
      int[] StringsPitchHeight                = new int[128];
      int[] EnsembleVelocityAlpha             = new int[128];
      int[] EnsemblePitchThickness            = new int[128];
      int[] BrassVelocityAlpha                = new int[128];
      int[] BrassPitchWidth                   = new int[128];
      int[] BrassPitchHeight                  = new int[128];
      int[] ReedVelocityAlpha                 = new int[128];
      int[] ReedPitchWidth                    = new int[128];
      int[] ReedPitchHeight                   = new int[128];
      int[] PipeVelocityAlpha                 = new int[128];
      int[] PipePitchWidth                    = new int[128];
      int[] PipePitchHeight                   = new int[128];
      int[] SynthLeadVelocityAlpha            = new int[128];
      int[] SynthPadVelocityAlpha             = new int[128];
      int[] SynthPadPitchThickness            = new int[128];
      int[] SynthEffectsVelocityAlpha         = new int[128];
      int[] EthnicVelocityAlpha               = new int[128];
      int[] PercussiveVelocityAlpha           = new int[128];
      int[] PercussionVelocityAlpha           = new int[128];
    //Note pitch to vibration
      float[] PitchVibration                    = new float[128];
  //Declare and initialize global Variables
    //MIDI
      int Channel          =         -1; //Global Channel
      int Pitch            =         -1; //Global Pitch
      int Velocity         =         -1; //Global Velocity
      int PitchScaleX      =          0; //Note pitch mapped to window width
      int PitchScaleY      =          0; //Note pitch mapped to window height
      int VelocityScaleX   =          0; //Note velocity mapped to window width
      int VelocityScaleY   =          0; //Note velocity mapped to window height
    //Playback       
      int Tempo            =        120; //Speed at which objects will move towards the camera
    //3D       
      int Depth            =      -1500; //3D object starting position
      int GeometryDetail   =         36; //Resolution of 3D objects
    //Constants
      float VibrationUnit  = 0.0009765625; // 1 divided by 128
    //Piano graphics
      float[] PianoCylinderX      = new float[GeometryDetail];
      float[] PianoCylinderY      = new float[GeometryDetail];
      float PianoSpinY            = 0                        ;
    //Organ graphics
      float[] OrganCylinderX      = new float[GeometryDetail];
      float[] OrganCylinderY      = new float[GeometryDetail];
    //Brass graphics
      float[] BrassCylinderX      = new float[GeometryDetail];
      float[] BrassCylinderY      = new float[GeometryDetail];
    //Reed graphics
      float[] ReedCylinderX       = new float[GeometryDetail];
      float[] ReedCylinderY       = new float[GeometryDetail];
    //Pipe graphics
      float[] PipeCylinderX       = new float[GeometryDetail];
      float[] PipeCylinderY       = new float[GeometryDetail];
    //Percussive graphics
      float[] PercussiveCylinderX = new float[GeometryDetail];
      float[] PercussiveCylinderY = new float[GeometryDetail];
      int     PercussiveSpinY     = 0                        ;
    //Percussion graphics
      float[] PercussionCylinderX = new float[GeometryDetail];
      float[] PercussionCylinderY = new float[GeometryDetail];
      int     PercussionSpinY     = 0                        ;
    //Color textures
      PImage PianoNoteColor              ;
      PImage PianoNoteColorRipple        ;
      PImage ChromaticPercussionNoteColor;
      PImage OrganNoteColor              ;
      PImage GuitarNoteColor             ;
      PImage BassNoteColor               ;
      PImage StringsNoteColor            ;
      PImage EnsembleNoteColor           ;
      PImage BrassNoteColor              ;
      PImage ReedNoteColor               ;
      PImage PipeNoteColor               ;
      PImage SynthLeadNoteColor          ;
      PImage SynthPadNoteColor           ;
      PImage SynthEffectsNoteColor       ;
      PImage EthnicNoteColor             ;
      PImage PercussiveNoteColor         ;
      PImage PercussiveNoteColorRipple   ;
      PImage PercussionNoteColor         ;
      PImage PercussionNoteColorRipple   ;
    //Instrument masks
      PImage   PianoMask               ;
      PImage   PianoMaskRipple         ;
      PImage   ChromaticPercussionMask ;
      PImage   OrganMask               ;
      PImage   GuitarMask              ;
      PImage   BassMask                ;
      PImage   StringsMask             ;
      PImage   EnsembleMask            ;
      PImage   BrassMask               ;
      PImage   ReedMask                ;
      PImage   PipeMask                ;
      PImage   SynthLeadMask           ;
      PImage   SynthPadMask            ;
      PImage   SynthEffectsMask        ;
      PImage   EthnicMask              ;
      PImage   PercussiveMask          ;
      PImage   PercussiveMaskRipple    ;
      PImage   PercussionMask          ;
      PImage   PercussionMaskRipple    ;
  //Animation
    //Depth
      int DepthRate = 10;
    //Vibration
      int   SineDiameter      = 10            ;
      float SineAngleConstant = 0.03125       ; 
      int   SineAngle[]       = new int[128]  ;
      float SineDepth[]       = new float[128];
    //Texture offset
      int SynthPadMaskOffset     = 0;
      int SynthPadMaskOffsetRate = 2;
      int OrganMaskOffset        = 0;  
      int OrganMaskOffsetRate    = 6; 
      int StringsMaskOffset      = 0;     
      int StringsMaskOffsetRate  = 4;     
      int EnsembleMaskOffset     = 0;     
      int EnsembleMaskOffsetRate = 2;         
      int BrassMaskOffset        = 0;  
      int BrassMaskOffsetRate    = 8;      
      int ReedMaskOffset         = 0; 
      int ReedMaskOffsetRate     = 2;     
      int PipeMaskOffset         = 0; 
      int PipeMaskOffsetRate     = 4;     
    //Fade out
      int PianoSustainAlpha               =  1;
      int ChromaticPercussionSustainAlpha =  2;
      int PercussiveSustainAlpha          =  6;
      int PercussionSustainAlpha          =  6;
    //Amplitude decay
      float GuitarAmplitudeDecay       = 0.975;
      float BassAmplitudeDecay         = 0.975;
      float SynthLeadAmplitudeDecay    = 1.00;
      float SynthEffectsAmplitudeDecay = 0.95;
      float EthnicAmplitudeDecay       = 0.95;
    //Sine wave
      int xspacing    = 8                           ; //How far apart should each horizontal location be spaced
      int w           = 512                         ; //Width of entire wave
      float theta     = 0                           ; //Start angle at 0
      int period      = 500                         ; //How many pixels before the wave repeats
      float dx        = (TWO_PI / period) * xspacing; //Value for incrementing X, a function of period and xspacing
      float[] yvalues = new float[w/xspacing]       ; //Using an array to store height values for the wave
      int     BeginningAmplitude    = 4             ;
      float[] GuitarAmplitude       = new float[128];  //Height of wave
      float[] BassAmplitude         = new float[128];  //Height of wave
      float[] SynthLeadAmplitude    = new float[128];  //Height of wave
      float[] SynthEffectsAmplitude = new float[128];  //Height of wave
      float[] EthnicAmplitude       = new float[128];  //Height of wave
    //Strings bowing orientation
      int StringsBowOrientation = 1;  //Bowing orientation. 1=Up | -1=Down
    //Spin
      int GuitarSpin               = 0 ; //Guitar initial rotation
      int GuitarRotationRate       = 6 ; //Guitar rotation speed
      int EnsembleSpin             = 0 ; //Ensemble initial rotation
      int EnsembleRotationRate     = 6 ; //Ensemble rotation speed
      int ReedSpin                 = 0 ; //Reed initial rotation
      int ReedRotationRate         = 6 ; //Reed rotation speed
      int PipeSpin                 = 0 ; //Pipe initial rotation
      int PipeRotationRate         = 6 ; //Pipe rotation speed
      int SynthLeadSpin            = 0 ; //Pipe initial rotation
      int SynthLeadRotationRate    = 6 ; //Pipe rotation speed
      int SynthEffectsSpin         = 0 ; //Pipe initial rotation
      int SynthEffectsRotationRate = 6 ; //Pipe rotation speed
    //Particles
      int rad = 5;
      int dir = 1;
      PImage Smoke;

  //Shapes
    //Sky dome
      PImage sky                      ;
      PShape dome                     ;
      int    sphereRotateX = 0        ;
      int    sphereRotateY = 1        ;
      int    sphereRotateZ = 0        ;
      int    cX            = width/2  ; //Display center X-Axis
      int    cY            = height/2 ; //Display center Y-Axis
      int    mX            = mouseX   ; //Mouse position X-Axis
      int    mY            = mouseY   ; //Mouse position Y-Axis
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

      PImage SkyBackground;
  
//Setup
void setup() {
  //General
    size(Width, Height, P3D);
    if (EnableAA     == true) {     smooth(8);}
    if (Enable120FPS == true) {frameRate(120);}
    
    hint(DISABLE_DEPTH_TEST); //Fixes Z-fighting and alpha overlapping
    textureWrap(REPEAT); 
    colorMode(HSB, 360, 100, 100, 100);
    
  //Background
    SkyBackground = loadImage("sky-background.png");

  //Camera
    // Free
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
  sky  = loadImage("sky.png");
  dome.setTexture(sky);
  
  //Starfield
  CX=width/2 ; 
  CY=height/2;
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
    float PianoCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PianoCylinderX[i] = cos(radians(i * PianoCylinderAngle));
      PianoCylinderY[i] = sin(radians(i * PianoCylinderAngle));
    }
    //Organ graphics
    float OrganCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      OrganCylinderX[i] = cos(radians(i * OrganCylinderAngle));
      OrganCylinderY[i] = sin(radians(i * OrganCylinderAngle));
    }
    //Reed graphics
    float ReedCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      ReedCylinderX[i] = cos(radians(i * ReedCylinderAngle));
      ReedCylinderY[i] = sin(radians(i * ReedCylinderAngle));
    }
    //Pipe graphics
    float PipeCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PipeCylinderX[i] = cos(radians(i * PipeCylinderAngle));
      PipeCylinderY[i] = sin(radians(i * PipeCylinderAngle));
    }
    //Percussive graphics
    float PercussiveCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PercussiveCylinderX[i] = cos(radians(i * PercussiveCylinderAngle));
      PercussiveCylinderY[i] = sin(radians(i * PercussiveCylinderAngle));
    }
    //Percussion graphics
    float PercussionCylinderAngle = 370.5 / GeometryDetail;
    for (int i = 0; i < GeometryDetail; i++) {
      PercussionCylinderX[i] = cos(radians(i * PercussionCylinderAngle));
      PercussionCylinderY[i] = sin(radians(i * PercussionCylinderAngle));
    }
  //Vibration variables
  for (int i = 0; i < 128; i++) {PitchVibration[i]        = VibrationUnit*i;}
  for (int i = 0; i < 128; i++) {GuitarAmplitude[i]       = 1;} //Initialize amplitude array
  for (int i = 0; i < 128; i++) {BassAmplitude[i]         = 1;} //Initialize amplitude array
  for (int i = 0; i < 128; i++) {SynthLeadAmplitude[i]    = 1;} //Initialize amplitude array
  for (int i = 0; i < 128; i++) {SynthEffectsAmplitude[i] = 1;} //Initialize amplitude array
  for (int i = 0; i < 128; i++) {EthnicAmplitude[i]       = 1;} //Initialize amplitude array

  //Call variable methods
  OctaveVariables();
  ColorTextures();
  ColorTexturesMasks();

  //Particles
  ps = new ParticleSystem(1, new PVector(width/2,height/2,0));
  Smoke = loadImage("SmokeParticle.png");
  Smoke.mask(Smoke);
}

//Draw
void draw() {
  debug = new Debug();
  // debug.framerate();
  FrameRate = frameRate;
  RelativeFrameRate = 60/FrameRate;
  debug.clickToPrintVariables();
  
  //Sky
  // noStroke();
  // rotateY(radians(sphereRotateY));
  // noStroke();
  // pushMatrix();
  //   noStroke();
  //   translate(width/2, height/2, -1250);
  //   shape(dome);
  // popMatrix();
  // sphereRotateY = sphereRotateY+0.05; //Animation/Gyro drift fix

//  //Background
 // pushMatrix();
 //   noStroke();
 //   translate(width/2, height/2, 0);
 //   beginShape();
 //     texture(sky);
 //     vertex(-width, -height, 0, 0,   0);
 //     vertex( width, -height, 0, 4096, 0);
 //     vertex( width,  height, 0, 4096, 2048);
 //     vertex(-width,  height, 0, 0,   2048);
 // endShape();
 // popMatrix();

  background(SkyBackground);
  
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
    if (PianoIsActive               == true) {PianoGFXDisplay()              ;}
    if (ChromaticPercussionIsActive == true) {ChromaticPercussionGFXDisplay();}
    if (OrganIsActive               == true) {OrganGFXDisplay()              ;}
    if (GuitarIsActive              == true) {GuitarGFXDisplay()             ;}
    if (BassIsActive                == true) {BassGFXDisplay()               ;}
    if (StringsIsActive             == true) {StringsGFXDisplay()            ;}
    if (EnsembleIsActive            == true) {EnsembleGFXDisplay()           ;}
    if (BrassIsActive               == true) {BrassGFXDisplay()              ;}
    if (ReedIsActive                == true) {ReedGFXDisplay()               ;}
    if (PipeIsActive                == true) {PipeGFXDisplay()               ;}
    if (SynthLeadIsActive           == true) {SynthLeadGFXDisplay()          ;}
    if (SynthPadIsActive            == true) {SynthPadGFXDisplay()           ;}
    if (SynthEffectsIsActive        == true) {SynthEffectsGFXDisplay()       ;}
    if (EthnicIsActive              == true) {EthnicGFXDisplay()             ;}
    if (PercussiveIsActive          == true) {PercussiveGFXDisplay()         ;}
    if (PercussionIsActive          == true) {PercussionGFXDisplay()         ;}
//Animation
  //Fade out
    if (PianoIsActive               == true) {for (int i = 0; i < 128; i++) {PianoVelocityAlpha[i]               = constrain((PianoVelocityAlpha[i]               - PianoSustainAlpha              ), 1, 100);}} //#Piano
    if (ChromaticPercussionIsActive == true) {for (int i = 0; i < 128; i++) {ChromaticPercussionVelocityAlpha[i] = constrain((ChromaticPercussionVelocityAlpha[i] - ChromaticPercussionSustainAlpha), 1, 100);}} //#Chromatic Percussion  
    if (PercussiveIsActive          == true) {for (int i = 0; i < 128; i++) {PercussiveVelocityAlpha[i]          = constrain((PercussiveVelocityAlpha[i]          - PercussiveSustainAlpha         ), 1, 100);}} //#Percussive
    if (PercussionIsActive          == true) {for (int i = 0; i < 128; i++) {PercussionVelocityAlpha[i]          = constrain((PercussionVelocityAlpha[i]          - PercussionSustainAlpha         ), 1, 100);}} //#Percussion
//Texture offset
    if (OrganMaskOffset    >= 0 && OrganMaskOffset    < 511) {OrganMaskOffset    = OrganMaskOffset    + OrganMaskOffsetRate;}    else {OrganMaskOffset    = 0;}
    if (StringsMaskOffset  >= 0 && StringsMaskOffset  < 511) {StringsMaskOffset  = StringsMaskOffset  + StringsMaskOffsetRate;}  else {StringsMaskOffset  = 0;}
    if (EnsembleMaskOffset >= 0 && EnsembleMaskOffset < 511) {EnsembleMaskOffset = EnsembleMaskOffset + EnsembleMaskOffsetRate;} else {EnsembleMaskOffset = 0;}
    if (BrassMaskOffset    >= 0 && BrassMaskOffset    < 511) {BrassMaskOffset    = BrassMaskOffset    + BrassMaskOffsetRate;}    else {BrassMaskOffset    = 0;}
    if (ReedMaskOffset     >= 0 && ReedMaskOffset     < 511) {ReedMaskOffset     = ReedMaskOffset     + ReedMaskOffsetRate;}     else {ReedMaskOffset     = 0;}
    if (PipeMaskOffset     >= 0 && PipeMaskOffset     < 511) {PipeMaskOffset     = PipeMaskOffset     + PipeMaskOffsetRate;}     else {PipeMaskOffset     = 0;}
    if (SynthPadMaskOffset >= 0 && SynthPadMaskOffset < 511) {SynthPadMaskOffset = SynthPadMaskOffset + SynthPadMaskOffsetRate;} else {SynthPadMaskOffset = 0;} 

//   //Decrease sine wave amplitude
    if (GuitarIsActive       == true) {for (int i = 0; i < 128; i++) {GuitarAmplitude[i]       = GuitarAmplitude[i]       * GuitarAmplitudeDecay      ;}}  //#Guitar
    if (BassIsActive         == true) {for (int i = 0; i < 128; i++) {BassAmplitude[i]         = BassAmplitude[i]         * BassAmplitudeDecay        ;}}  //#Bass
    if (SynthLeadIsActive    == true) {for (int i = 0; i < 128; i++) {SynthLeadAmplitude[i]    = SynthLeadAmplitude[i]    * SynthLeadAmplitudeDecay   ;}}  //#SynthLead
    if (SynthEffectsIsActive == true) {for (int i = 0; i < 128; i++) {SynthEffectsAmplitude[i] = SynthEffectsAmplitude[i] * SynthEffectsAmplitudeDecay;}}  //#SynthEffects
    if (EthnicIsActive       == true) {for (int i = 0; i < 128; i++) {EthnicAmplitude[i]       = EthnicAmplitude[i]       * EthnicAmplitudeDecay      ;}}  //#Ethnic
//   //Spin
    if (GuitarIsActive       == true) {GuitarSpin       = GuitarSpin       + GuitarRotationRate       ;}
    if (EnsembleIsActive     == true) {EnsembleSpin     = EnsembleSpin     - EnsembleRotationRate     ;}
    if (ReedIsActive         == true) {ReedSpin         = ReedSpin         - ReedRotationRate         ;}
    if (PipeIsActive         == true) {PipeSpin         = PipeSpin         + PipeRotationRate         ;}
    if (SynthLeadIsActive    == true) {SynthLeadSpin    = SynthLeadSpin    + SynthLeadRotationRate    ;}
    if (SynthEffectsIsActive == true) {SynthEffectsSpin = SynthEffectsSpin + SynthEffectsRotationRate ;}
   
  // Saves each frame
    if (DumpFrames == true) {
      saveFrame("Dump/Synthesthesia-######.tif");
    }
}

//Note on event
void noteOn(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel  = channel;
  Pitch    = pitch;
  Velocity = velocity;

  VelocityScaleX = int(map(velocity, 0, 127, 0, width));
  VelocityScaleY = int(map(velocity, 0, 127, 0, height));
  PitchScaleX    = int(map(pitch, 0, 127, 0, width));
  PitchScaleY    = int(map(pitch, 0, 127, 0, height));
 
  //Update instrument variables
  if (channel == StringsChannelID) {StringsBowOrientation = -StringsBowOrientation;} //Inverts the value of StringsBowOrientation upon each Strings note on event
  
  //Print global variables
  debug = new Debug();
  debug.noteOnReturn();
  
  //Call Instrument Note On variable updatemethods
  if (PianoIsActive               == true) {PianoChannelNoteOn()              ;}
  if (ChromaticPercussionIsActive == true) {ChromaticPercussionChannelNoteOn();}
  if (OrganIsActive               == true) {OrganChannelNoteOn()              ;}
  if (GuitarIsActive              == true) {GuitarChannelNoteOn()             ;}
  if (BassIsActive                == true) {BassChannelNoteOn()               ;}
  if (StringsIsActive             == true) {StringsChannelNoteOn()            ;}
  if (EnsembleIsActive            == true) {EnsembleChannelNoteOn()           ;}
  if (BrassIsActive               == true) {BrassChannelNoteOn()              ;}
  if (ReedIsActive                == true) {ReedChannelNoteOn()               ;}
  if (PipeIsActive                == true) {PipeChannelNoteOn()               ;}
  if (SynthLeadIsActive           == true) {SynthLeadChannelNoteOn()          ;}
  if (SynthPadIsActive            == true) {SynthPadChannelNoteOn()           ;}
  if (SynthEffectsIsActive        == true) {SynthEffectsChannelNoteOn()       ;}
  if (EthnicIsActive              == true) {EthnicChannelNoteOn()             ;}
  if (PercussiveIsActive          == true) {PercussiveChannelNoteOn()         ;}
  if (PercussionIsActive          == true) {PercussionChannelNoteOn()         ;}
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
    if (PianoIsActive               == true) {PianoChannelNoteOff()              ;}
    if (ChromaticPercussionIsActive == true) {ChromaticPercussionChannelNoteOff();}
    if (OrganIsActive               == true) {OrganChannelNoteOff()              ;}
    if (GuitarIsActive              == true) {GuitarChannelNoteOff()             ;}
    if (BassIsActive                == true) {BassChannelNoteOff()               ;}
    if (StringsIsActive             == true) {StringsChannelNoteOff()            ;}
    if (EnsembleIsActive            == true) {EnsembleChannelNoteOff()           ;}
    if (BrassIsActive               == true) {BrassChannelNoteOff()              ;}
    if (ReedIsActive                == true) {ReedChannelNoteOff()               ;}
    if (PipeIsActive                == true) {PipeChannelNoteOff()               ;}
    if (SynthLeadIsActive           == true) {SynthLeadChannelNoteOff()          ;}
    if (SynthPadIsActive            == true) {SynthPadChannelNoteOff()           ;}
    if (SynthEffectsIsActive        == true) {SynthEffectsChannelNoteOff()       ;}
    if (EthnicIsActive              == true) {EthnicChannelNoteOff()             ;}
    if (PercussiveIsActive          == true) {PercussiveChannelNoteOff()         ;}
    if (PercussionIsActive          == true) {PercussionChannelNoteOff()         ;}
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
  for (int i = 12; i < 128; i = i+1) {PitchHues[i]  =  PitchHues[i-12];} //Loop and copy values from 0-10 into 11-128

  //Octave-to-saturation correspondence (out of 100)
  for (int i =   0; i <  12; i = i+1) {OctaveSaturations[i]  =  76;}
  for (int i =  12; i <  24; i = i+1) {OctaveSaturations[i]  =  80;}
  for (int i =  24; i <  36; i = i+1) {OctaveSaturations[i]  =  85;}
  for (int i =  36; i <  48; i = i+1) {OctaveSaturations[i]  =  90;}
  for (int i =  48; i <  60; i = i+1) {OctaveSaturations[i]  =  95;}
  for (int i =  60; i <  72; i = i+1) {OctaveSaturations[i]  = 100;}
  for (int i =  72; i <  84; i = i+1) {OctaveSaturations[i]  =  66;}
  for (int i =  84; i <  96; i = i+1) {OctaveSaturations[i]  =  42;}
  for (int i =  96; i < 108; i = i+1) {OctaveSaturations[i]  =  27;}
  for (int i = 108; i < 120; i = i+1) {OctaveSaturations[i]  =  17;}
  for (int i = 120; i < 128; i = i+1) {OctaveSaturations[i]  =  11;}

 //Octave-to-brightness correspondence (out of 100)
  for (int i =   0; i <  12; i = i+1) {OctaveBrightnesses[i]  =  8;}
  for (int i =  12; i <  24; i = i+1) {OctaveBrightnesses[i]  = 12;}
  for (int i =  24; i <  36; i = i+1) {OctaveBrightnesses[i]  = 17;}
  for (int i =  36; i <  48; i = i+1) {OctaveBrightnesses[i]  = 24;}
  for (int i =  48; i <  60; i = i+1) {OctaveBrightnesses[i]  = 35;}
  for (int i =  60; i <  72; i = i+1) {OctaveBrightnesses[i]  = 50;}
  for (int i =  72; i <  84; i = i+1) {OctaveBrightnesses[i]  = 65;}
  for (int i =  84; i <  96; i = i+1) {OctaveBrightnesses[i]  = 75;}
  for (int i =  96; i < 108; i = i+1) {OctaveBrightnesses[i]  = 82;}
  for (int i = 108; i < 120; i = i+1) {OctaveBrightnesses[i]  = 87;}
  for (int i = 120; i < 128; i = i+1) {OctaveBrightnesses[i]  = 91;}
}

void ColorTextures(){
    if (PianoIsActive               == true) {PianoNoteColor               = loadImage("Note.png");}
    if (PianoIsActive               == true) {PianoNoteColorRipple           = loadImage("Note.png");}
    if (ChromaticPercussionIsActive == true) {ChromaticPercussionNoteColor = loadImage("Note.png");}
    if (OrganIsActive               == true) {OrganNoteColor               = loadImage("Note.png");}
    if (GuitarIsActive              == true) {GuitarNoteColor              = loadImage("Note.png");}
    if (GuitarIsActive              == true) {GuitarNoteColor              = loadImage("Note.png");}
    if (BassIsActive                == true) {BassNoteColor                = loadImage("Note.png");}
    if (StringsIsActive             == true) {StringsNoteColor             = loadImage("Note.png");}
    if (EnsembleIsActive            == true) {EnsembleNoteColor            = loadImage("Note.png");}
    if (BrassIsActive               == true) {BrassNoteColor               = loadImage("Note.png");}
    if (ReedIsActive                == true) {ReedNoteColor                = loadImage("Note.png");}
    if (PipeIsActive                == true) {PipeNoteColor                = loadImage("Note.png");}
    if (SynthLeadIsActive           == true) {SynthLeadNoteColor           = loadImage("Note.png");}
    if (SynthPadIsActive            == true) {SynthPadNoteColor            = loadImage("SynthPad-Alpha.png");}
    if (SynthEffectsIsActive        == true) {SynthEffectsNoteColor        = loadImage("Note.png");}
    if (EthnicIsActive              == true) {EthnicNoteColor              = loadImage("Note.png");}
    if (PercussiveIsActive          == true) {PercussiveNoteColor          = loadImage("Note.png");}
    if (PercussiveIsActive          == true) {PercussiveNoteColorRipple    = loadImage("Note.png");}
    if (PercussionIsActive          == true) {PercussionNoteColor          = loadImage("Note.png");}
    if (PercussionIsActive          == true) {PercussionNoteColorRipple    = loadImage("Note.png");}
}

void ColorTexturesMasks(){
  //Load alpha mask files
  PianoMask               = loadImage("Piano-Mask.png");
  PianoMaskRipple         = loadImage("Ripple-Mask.png");
  ChromaticPercussionMask = loadImage("ChromaticPercussion-Mask.png");
  OrganMask               = loadImage("Organ-Mask.png");
  GuitarMask              = loadImage("Guitar-Mask.png");
  BassMask                = loadImage("Bass-Mask.png");
  StringsMask             = loadImage("Strings-Mask.png");
  EnsembleMask            = loadImage("Ensemble-Mask.png");
  BrassMask               = loadImage("Pipe-Mask.png");
  ReedMask                = loadImage("Pipe-Mask.png");
  PipeMask                = loadImage("Pipe-Mask.png");
  SynthLeadMask           = loadImage("SynthLead-Mask.png");
  SynthPadMask            = loadImage("SynthPad-Mask.png");
  SynthEffectsMask        = loadImage("SynthEffects-Mask.png");
  EthnicMask              = loadImage("Ethnic-Mask.png");
  PercussiveMask          = loadImage("Percussive-Mask.png");
  PercussiveMaskRipple    = loadImage("Ripple-Mask.png");
  PercussionMask          = loadImage("Percussive-Mask.png");
  PercussionMaskRipple    = loadImage("Ripple-Mask.png");


    PianoNoteColor.mask (PianoMask);
    PianoNoteColorRipple.mask(PianoMaskRipple);
    ChromaticPercussionNoteColor.mask(ChromaticPercussionMask);
    OrganNoteColor.mask (OrganMask);
    GuitarNoteColor.mask (GuitarMask);
    GuitarNoteColor.mask (GuitarMask);
    BassNoteColor.mask (BassMask);
    StringsNoteColor.mask (StringsMask);
    EnsembleNoteColor.mask(EnsembleMask);
    BrassNoteColor.mask (BrassMask);
    ReedNoteColor.mask (ReedMask);
    PipeNoteColor.mask (PipeMask);
    SynthLeadNoteColor.mask(SynthLeadMask);
    SynthPadNoteColor.mask(SynthPadMask);
    SynthEffectsNoteColor.mask(SynthEffectsMask);
    EthnicNoteColor.mask (EthnicMask);
    PercussiveNoteColor.mask(PercussiveMask);
    PercussiveNoteColorRipple.mask(PercussiveMaskRipple);
    PercussionNoteColor.mask(PercussionMask);
    PercussionNoteColorRipple.mask(PercussionMaskRipple);
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
        PianoNoteColor        , //Texture
        PianoNoteColorRipple ); //Texture 2
        pianogfx.display()    ; //Display graphics   
      }
      pianogfx = new PianoGFX (
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
        PianoNoteColor        , //Texture
        PianoNoteColorRipple ); //Texture 2
      pianogfx.ripple()       ;
      if (PianoVelocityAlpha[i] == 1) {PianoPitchIsActive[i] = false;}
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
        ChromaticPercussionNoteColor      ); //Texture 
        chromaticpercussiongfx.display()   ; //Display graphics
        if (ChromaticPercussionVelocityAlpha[i] == 1) {ChromaticPercussionPitchIsActive[i] = false;}
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
        OrganPitchWidth[i]    , //Width  
        OrganPitchHeight[i]   , //Height  
        VelocityScaleY        , //Depth    
        PitchHues[i]          , //Hue  
        OctaveSaturations[i]  , //Saturation    
        OctaveBrightnesses[i] , //Brightness    
        OrganVelocityAlpha[i] , //Alpha  
        OrganNoteColor        , //Texture  
        OrganMaskOffset      ); //Texture offset
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
        GuitarSpin            , //Spin
        GuitarNoteColor      ); //Texture   
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
        BassNoteColor        ); //Texture   
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
        StringsPitchWidth[i]    , //Width  
        StringsPitchHeight[i]   , //Height  
        VelocityScaleY          , //Depth    
        PitchHues[i]            , //Hue  
        OctaveSaturations[i]    , //Saturation    
        OctaveBrightnesses[i]   , //Brightness    
        StringsVelocityAlpha[i] , //Alpha  
        StringsNoteColor        , //Texture 
        StringsMaskOffset      ); //Texture offset
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
        EnsembleSpin             , //Spin
        EnsembleNoteColor        , //Texture 
        EnsembleMaskOffset      ); //Texture offset
        ensemblegfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Brass
void BrassGFXDisplay(){
  if (ChannelIsActive[BrassChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (BrassPitchIsActive[i] == true) 
      {brassgfx = new BrassGFX (
        BrassPitchX[i]       , //X coordinate 
        BrassVelocityY[i]    , //Y coordinate  
        Depth+SineDepth[i]   , //Z coordinate  
        BrassPitchWidth[i]   , //Width  
        BrassPitchHeight[i]  , //Height  
        VelocityScaleY       , //Depth    
        PitchHues[i]         , //Hue  
        OctaveSaturations[i] , //Saturation    
        OctaveBrightnesses[i], //Brightness    
        BrassVelocityAlpha[i], //Alpha  
        BrassNoteColor       , //Texture
        BrassMaskOffset     ); //Texture offset
        brassgfx.display()   ; //Display graphics 
      }
    }
  }
}

//D#Reed
void ReedGFXDisplay(){
  if (ChannelIsActive[ReedChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (ReedPitchIsActive[i] == true) 
      {reedgfx = new ReedGFX (
        ReedPitchX[i]        , //X coordinate 
        ReedVelocityY[i]     , //Y coordinate  
        Depth+SineDepth[i]   , //Z coordinate  
        ReedPitchWidth[i]    , //Width  
        ReedPitchHeight[i]   , //Height  
        VelocityScaleY       , //Depth    
        PitchHues[i]         , //Hue  
        OctaveSaturations[i] , //Saturation    
        OctaveBrightnesses[i], //Brightness    
        ReedVelocityAlpha[i] , //Alpha  
        ReedNoteColor        , //Texture     
        ReedSpin             , //Spin
        ReedMaskOffset      ); //Texture offset
        reedgfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Pipe
void PipeGFXDisplay(){
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
        PipeNoteColor        , //Texture     
        PipeSpin             , //Texture offset
        PipeMaskOffset      ); //Spin
        pipegfx.display()    ; //Display graphics 
      }
    }
  }
}

//D#Synth Lead
void SynthLeadGFXDisplay(){
  if (ChannelIsActive[SynthLeadChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (SynthLeadPitchIsActive[i] == true) 
      {synthleadgfx = new SynthLeadGFX (
        SynthLeadPitchX[i]       , //X coordinate  
        SynthLeadVelocityY[i]    , //Y coordinate   
        Depth+SineDepth[i]       , //Z coordinate   
        VelocityScaleX           , //Width   
        VelocityScaleY           , //Height   
        VelocityScaleY           , //Depth      
        PitchHues[i]             , //Hue   
        OctaveSaturations[i]     , //Saturation      
        OctaveBrightnesses[i]    , //Brightness      
        SynthLeadVelocityAlpha[i], //Alpha   
        PitchVibration[i]        , //Vibration 
        SynthLeadSpin            , //Spin
        SynthLeadAmplitude[i]    , //Amplitude
        SynthLeadNoteColor      ); //Texture   
        synthleadgfx.display()   ; //Display graphics 
      } 
    }
  }
}

//D#Synth Pad
void SynthPadGFXDisplay(){
  if (ChannelIsActive[SynthPadChannelID] == true) {
    for (int i = 0; i < 128; i++) {
      if (SynthPadPitchIsActive[i] == true) 
        {synthpadgfx = new SynthPadGFX (
        SynthPadPitchX[i]         ,  //X coordinate 
        SynthPadVelocityY[i]      ,  //Y coordinate  
        Depth+SineDepth[i]        ,  //Z coordinate  
        PitchScaleX               ,  //Width  
        PitchScaleY               ,  //Height  
        VelocityScaleY            ,  //Depth    
        PitchHues[i]              ,  //Hue  
        OctaveSaturations[i]      ,  //Saturation    
        OctaveBrightnesses[i]     ,  //Brightness    
        SynthPadVelocityAlpha[i]  ,  //Alpha  
        SynthPadPitchThickness[i] ,  //Thickness
        SynthPadNoteColor         ,  //Texture 
        SynthPadMask              ,  //Texture 2
        SynthPadMaskOffset       );  //Texture offset
        synthpadgfx.display()     ;  //Display graphics 
      }
    }
  }
}

//D#Synth Effects
void SynthEffectsGFXDisplay(){
  if (ChannelIsActive[SynthEffectsChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (SynthEffectsPitchIsActive[i] == true) 
      {syntheffectsgfx = new SynthEffectsGFX (
        SynthEffectsPitchX[i]       , //X coordinate  
        SynthEffectsVelocityY[i]    , //Y coordinate   
        Depth+SineDepth[i]          , //Z coordinate   
        VelocityScaleX              , //Width   
        VelocityScaleY              , //Height   
        VelocityScaleY              , //Depth      
        PitchHues[i]                , //Hue   
        OctaveSaturations[i]        , //Saturation      
        OctaveBrightnesses[i]       , //Brightness      
        SynthEffectsVelocityAlpha[i], //Alpha   
        PitchVibration[i]           , //Vibration 
        SynthEffectsSpin            , //Spin
        SynthEffectsAmplitude[i]    , //Amplitude 
        SynthEffectsNoteColor      ); //Texture   
        syntheffectsgfx.display()   ; //Display graphics 
      } 
    }
  }
}

//D#Ethnic
void EthnicGFXDisplay(){
  if (ChannelIsActive[EthnicChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (EthnicPitchIsActive[i] == true) 
      {ethnicgfx = new EthnicGFX (
        EthnicPitchX[i]       , //X coordinate  
        EthnicVelocityY[i]    , //Y coordinate   
        Depth+SineDepth[i]    , //Z coordinate   
        VelocityScaleX        , //Width   
        VelocityScaleY        , //Height   
        VelocityScaleY        , //Depth      
        PitchHues[i]          , //Hue   
        OctaveSaturations[i]  , //Saturation      
        OctaveBrightnesses[i] , //Brightness      
        EthnicVelocityAlpha[i], //Alpha   
        PitchVibration[i]     , //Vibration 
        EthnicAmplitude[i]    , //Amplitude
        EthnicNoteColor      ); //Texture   
        ethnicgfx.display()   ; //Display graphics 
      } 
    }
  }
}

//D#Percussive
void PercussiveGFXDisplay(){//Percussive
  if (ChannelIsActive[PercussiveChannelID] == true) {
 for (int i = 0; i < 128; i++) {
   if (PercussivePitchIsActive[i] == true) 
     {percussivegfx = new PercussiveGFX (
       PercussivePitchX[i]          , //X coordinate
       PercussiveVelocityY[i]       , //Y coordinate
       Depth+SineDepth[i]           , //Z coordinate
       VelocityScaleX               , //Width
       VelocityScaleY               , //Height
       VelocityScaleY               , //Depth
       PitchHues[i]                 , //Hue
       OctaveSaturations[i]         , //Saturation
       OctaveBrightnesses[i]        , //Brightness
       PercussiveVelocityAlpha[i]   , //Alpha
       PercussiveNoteColor          , //Texture
       PercussiveNoteColorRipple   ); //Texture 2
       percussivegfx.display()      ; //Display graphics   
     }
   }
  }
}

//D#Percussion
void PercussionGFXDisplay(){//Percussion
  if (ChannelIsActive[PercussionChannelID] == true) {
  for (int i = 0; i < 128; i++) {
    if (PercussionPitchIsActive[i] == true) 
      {percussiongfx = new PercussionGFX (
        PercussionPitchX[i]          , //X coordinate
        PercussionVelocityY[i]       , //Y coordinate
        Depth+SineDepth[i]           , //Z coordinate
        VelocityScaleX               , //Width
        VelocityScaleY               , //Height
        VelocityScaleY               , //Depth
        PitchHues[i]                 , //Hue
        OctaveSaturations[i]         , //Saturation
        OctaveBrightnesses[i]        , //Brightness
        PercussionVelocityAlpha[i]   , //Alpha
        PercussionNoteColor          , //Texture
        PercussionNoteColorRipple   ); //Texture 2
        percussiongfx.display()      ; //Display graphics   
      }
    }
  }
}

// //MIDI note on events
  //N#Piano
  void PianoChannelNoteOn(){
    if (Channel == PianoChannelID) {
      ChannelIsActive[PianoChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PianoPitchIsActive[i] = true;
          PianoPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          PianoVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          PianoVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
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
          ChromaticPercussionPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          ChromaticPercussionVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          ChromaticPercussionVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
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
          OrganVelocityAlpha[i]  = map(Velocity, 0, 127, 1, 100);
          OrganPitchWidth[i]     = map(Pitch, 0, 127, 1,   0.015625);
          OrganPitchHeight[i]    = map(Pitch, 0, 127, 0.5, 1.375);
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
          GuitarPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          GuitarVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          GuitarVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
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
          BassPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          BassVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          BassVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
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
          StringsPitchX[i]         = int(map(Pitch, 0, 127, -width, width*2));
          StringsVelocityY[i]      = int(map(Velocity, 0, 127, height, 0));
          StringsVelocityAlpha[i]  = int(map(Velocity, 0, 127, 1, 100));
          StringsPitchWidth[i]     = int(map(Pitch, 0, 127, 1,   0.125));
          StringsPitchHeight[i]    = int(map(Pitch, 0, 127, 0.5, 1.375));
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
          EnsemblePitchX[i]         = int(map(Pitch, 0, 127, -width, width*2)); 
          EnsembleVelocityY[i]      = int(map(Velocity, 0, 127, height, 0));
          EnsembleVelocityAlpha[i]  = int(map(Velocity, 0, 127, 1, 100));
          EnsemblePitchThickness[i] = int(map(Pitch, 0, 127, 1, 0.125));
        }
      }
    }
  }
  //N#Brass
  void BrassChannelNoteOn(){
    if (Channel == BrassChannelID) {
      ChannelIsActive[BrassChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          BrassPitchIsActive[i] = true; 
          BrassPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          BrassVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          BrassVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
        }
      }
    }
  }
  //N#Reed
  void ReedChannelNoteOn(){
    if (Channel == ReedChannelID) {
      ChannelIsActive[ReedChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          ReedPitchIsActive[i]  = true; 
          ReedPitchX[i]         = int(map(Pitch, 0, 127, -width, width*2));
          ReedVelocityY[i]      = int(map(Velocity, 0, 127, height, 0));
          ReedVelocityAlpha[i]  = int(map(Velocity, 0, 127, 1, 100));
          ReedPitchWidth[i]     = int(map(Pitch, 0, 127, 1,   0.015625));
          ReedPitchHeight[i]    = int(map(Pitch, 0, 127, 0.5, 1.375));
        }
      }
    }
  }
  //N#Pipe
  void PipeChannelNoteOn(){
    if (Channel == PipeChannelID) {
      ChannelIsActive[PipeChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PipePitchIsActive[i]  = true; 
          PipePitchX[i]         = int(map(Pitch, 0, 127, -width, width*2));
          PipeVelocityY[i]      = int(map(Velocity, 0, 127, height, 0));
          PipeVelocityAlpha[i]  = int(map(Velocity, 0, 127, 1, 100));
          PipePitchWidth[i]     = int(map(Pitch, 0, 127, 1,   0.015625));
          PipePitchHeight[i]    = int(map(Pitch, 0, 127, 0.5, 1.375));
        }
      }
    }
  }
   //N#SynthLead
  void SynthLeadChannelNoteOn(){
    if (Channel == SynthLeadChannelID) {
      ChannelIsActive[SynthLeadChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthLeadPitchIsActive[i] = true; 
          SynthLeadPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          SynthLeadVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          SynthLeadVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
          SynthLeadAmplitude[i]     = BeginningAmplitude;
        }
      }
    }
  }
  //N#SynthPad
  void SynthPadChannelNoteOn(){
    if (Channel == SynthPadChannelID) {
      ChannelIsActive[SynthPadChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthPadPitchIsActive[i]  = true; 
          SynthPadPitchX[i]         = int(map(Pitch, 0, 127, -width, width*2));
          SynthPadVelocityY[i]      = int(map(Velocity, 0, 127, height, 0));
          SynthPadVelocityAlpha[i]  = int(map(Velocity, 0, 127, 1, 100));
          SynthPadPitchThickness[i] = int(map(Pitch, 0, 127, 1, 0.125));
        }
      }
    }
  }
  //N#SynthEffects
  void SynthEffectsChannelNoteOn(){
    if (Channel == SynthEffectsChannelID) {
      ChannelIsActive[SynthEffectsChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthEffectsPitchIsActive[i] = true; 
          SynthEffectsPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2)); 
          SynthEffectsVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));  
          SynthEffectsVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
          SynthEffectsAmplitude[i]     = BeginningAmplitude;
        }
      }
    }
  }
  //N#Ethnic
  void EthnicChannelNoteOn(){
    if (Channel == EthnicChannelID) {
      ChannelIsActive[EthnicChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          EthnicPitchIsActive[i] = true; 
          EthnicPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          EthnicVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          EthnicVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
          EthnicAmplitude[i]     = BeginningAmplitude;
        }
      }
    }
  }
  //N#Percussive
  void PercussiveChannelNoteOn(){
    if (Channel == PercussiveChannelID) {
      ChannelIsActive[PercussiveChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PercussivePitchIsActive[i] = true;
          PercussivePitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          PercussiveVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          PercussiveVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
        }
      }
    }
  }
  //N#Percussion
  void PercussionChannelNoteOn(){
    if (Channel == PercussionChannelID) {
      ChannelIsActive[PercussionChannelID] = true;
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PercussionPitchIsActive[i] = true;
          PercussionPitchX[i]        = int(map(Pitch, 0, 127, -width, width*2));
          PercussionVelocityY[i]     = int(map(Velocity, 0, 127, height, 0));
          PercussionVelocityAlpha[i] = int(map(Velocity, 0, 127, 1, 100));
        }
      }
    }
  }
  
// //MIDI note off events
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
//          ChromaticPercussionPitchIsActive[i] = false;
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
  //F#Brass
  void BrassChannelNoteOff(){
    if (Channel == BrassChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          BrassPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Reed
  void ReedChannelNoteOff(){
    if (Channel == ReedChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          ReedPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Pipe
  void PipeChannelNoteOff(){
    if (Channel == PipeChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          PipePitchIsActive[i] = false;
        }
      }
    }
  }
  //F#SynthLead
  void SynthLeadChannelNoteOff(){
    if (Channel == SynthLeadChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthLeadPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#SynthPad
  void SynthPadChannelNoteOff(){
    if (Channel == SynthPadChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthPadPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Synth Effects
  void SynthEffectsChannelNoteOff(){
    if (Channel == SynthEffectsChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          SynthEffectsPitchIsActive[i] = false;
        }
      }
    }
  }
  //F#Ethnic
  void EthnicChannelNoteOff(){
    if (Channel == EthnicChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
          EthnicPitchIsActive[i] = false;
        }
      }
    }
  }
   //F#Percussive
  void PercussiveChannelNoteOff(){
    if (Channel == PercussiveChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
//          PercussivePitchIsActive[i] = false;
        }
      }
    }
  }
   //F#Percussion
  void PercussionChannelNoteOff(){
    if (Channel == PercussionChannelID) {
      for (int i = 0; i < 128; i++) {
        if (Pitch == i) {
//          PercussionPitchIsActive[i] = false;
        }
      }
    }
  }
