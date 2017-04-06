// Synthesthesia
// MIDI music visualizer
// By Jonathan Arias
// MIDIBus by sparks - http://www.smallbutdigital.com/themidibus.php
// Starfield 3D by JimBrown - https://www.processing.org/discourse/beta/num_1209965886.html

// Instruments:
  // Piano
  // Chromatic Percussion
  // Organ
  // Guitar
  // Bass
  // Strings
  // Ensemble
  // Brass
  // Reed
  // Pipe
  // Synth Lead
  // Synth Pad
  // Synth Effects
  // Ethnic
  // Percussive
  // Sound effects
  // Percussion

//Import libraries
import themidibus.*;  // MIDI interface bridge
import queasycam.* ;  // Free view camera

//Create instances
  //Debugging
  Debug                  debug                 ;  // Debug
  //Background
  Background             background            ;  // Background
  //Camera
  QueasyCam              cam                   ;  // Dynamic camera
  //MIDI
  MidiBus                myBus                 ;  // MIDIBus
  //Instrument graphics
  PianoGFX               pianogfx              ;  // Piano graphics
  ChromaticPercussionGFX chromaticpercussiongfx;  // Chromatic Percussion graphics
  OrganGFX               organgfx              ;  // Organ graphics
  GuitarGFX              guitargfx             ;  // Guitar graphics        
  BassGFX                bassgfx               ;  // Bass graphics      
  StringsGFX             stringsgfx            ;  // Strings graphics         
  EnsembleGFX            ensemblegfx           ;  // Ensemble graphics          
  BrassGFX               brassgfx              ;  // Brass graphics       
  ReedGFX                reedgfx               ;  // Reed graphics      
  PipeGFX                pipegfx               ;  // Pipe graphics      
  SynthLeadGFX           synthleadgfx          ;  // Synth Lead graphics           
  SynthPadGFX            synthpadgfx           ;  // Synth Pad graphics          
  SynthEffectsGFX        syntheffectsgfx       ;  // Synth Effects graphics              
  EthnicGFX              ethnicgfx             ;  // Ethnic graphics        
  PercussiveGFX          percussivegfx         ;  // Percussive graphics            
  SoundEffectsGFX        soundeffectsgfx       ;  // Sound effects graphics              
  PercussionGFX          percussiongfx         ;  // Percussion graphics            

//Declare and initialize global variable arrays
  //MIDI message state
  boolean[] ChannelIsActive           = new boolean[128];
  boolean[] PitchIsActive             = new boolean[128];
  //MIDI variables mapped to attributes
  int[] PitchHues                     = new int[12];
  //MIDI octave color attributes
  int[] OctaveSaturations             = new int[11];
  int[] OctaveBrightnesses            = new int[11];
  //MIDI instrument note pitches mapped to coordinates
    //Note pitch to X coordinates
    float[] PianoPitchX                       = new float[128];
    float[] ChromaticPercussionPitchX         = new float[128];
    float[] OrganPitchX                       = new float[128];
    float[] GuitarPitchX                      = new float[128];
    float[] BassPitchX                        = new float[128];
    float[] StringsPitchX                     = new float[128];
    float[] EnsemblePitchX                    = new float[128];
    float[] BrassPitchX                       = new float[128];
    float[] ReedPitchX                        = new float[128];
    float[] PipePitchX                        = new float[128];
    float[] SynthLeadPitchX                   = new float[128];
    float[] SynthPadPitchX                    = new float[128];
    float[] SynthEffectsPitchX                = new float[128];
    float[] EthnicPitchX                      = new float[128];
    float[] PercussivePitchX                  = new float[128];
    float[] SoundEffectsPitchX                = new float[128];
    float[] PercussionPitchX                  = new float[128];
    //Note velocity to Y coordinates
    float[] PianoVelocityY                    = new float[128];
    float[] ChromaticPercussionVelocityY      = new float[128];
    float[] OrganVelocityY                    = new float[128];
    float[] GuitarVelocityY                   = new float[128];
    float[] BassVelocityY                     = new float[128];
    float[] StringsVelocityY                  = new float[128];
    float[] EnsembleVelocityY                 = new float[128];
    float[] BrassVelocityY                    = new float[128];
    float[] ReedVelocityY                     = new float[128];
    float[] PipeVelocityY                     = new float[128];
    float[] SynthLeadVelocityY                = new float[128];
    float[] SynthPadVelocityY                 = new float[128];
    float[] SynthEffectsVelocityY             = new float[128];
    float[] EthnicVelocityY                   = new float[128];
    float[] PercussiveVelocityY               = new float[128];
    float[] SoundEffectsVelocityY             = new float[128];
    float[] PercussionVelocityY               = new float[128];
    //Note velocity to transparency
    float[] PianoVelocityAlpha                = new float[128];
    float[] ChromaticPercussionVelocityAlpha  = new float[128];
    float[] OrganVelocityAlpha                = new float[128];
    float[] GuitarPitchAlpha                  = new float[128];
    float[] BassPitchAlpha                    = new float[128];
    float[] StringsPitchAlpha                 = new float[128];
    float[] EnsemblePitchAlpha                = new float[128];
    float[] BrassPitchAlpha                   = new float[128];
    float[] ReedPitchAlpha                    = new float[128];
    float[] PipePitchAlpha                    = new float[128];
    float[] SynthLeadPitchAlpha               = new float[128];
    float[] SynthPadPitchAlpha                = new float[128];
    float[] SynthEffectsPitchAlpha            = new float[128];
    float[] EthnicPitchAlpha                  = new float[128];
    float[] PercussivePitchAlpha              = new float[128];
    float[] SoundEffectsPitchAlpha            = new float[128];
    float[] PercussionPitchAlpha              = new float[128];

//Declare and initialize global Variables
  //MIDI
  int Channel          =   -1; // Global Channel
  int Pitch            =   -1; // Global Pitch
  int Velocity         =   -1; // Global Velocity
  float PitchX         =    0; // Note pitch mapped to window width
  float VelocityY      =    0; // Note velocity mapped to window height
  float PitchScaleX    =    0; // Note pitch mapped to X scale
  float VelocityScaleY =    0; // Note velocity mapped to window height
  float PitchHue       =    0; // Note pitch mapped to color hue (0-255)
  //Playback
  float Tempo          =  120; // Speed at which objects will move towards the camera
  //3D
  float Depth          = -500; // 3D object starting position

  //Color textures
  PImage[] PianoNoteColor               = new PImage[128];
  PImage[] ChromaticPercussionNoteColor = new PImage[128];
  PImage[] OrganNoteColor               = new PImage[128];
  PImage[] GuitarNoteColor              = new PImage[128];
  PImage[] BassNoteColor                = new PImage[128];
  PImage[] StringsNoteColor             = new PImage[128];
  PImage[] EnsembleNoteColor            = new PImage[128];
  PImage[] BrassNoteColor               = new PImage[128];
  PImage[] ReedNoteColor                = new PImage[128];
  PImage[] PipeNoteColor                = new PImage[128];
  PImage[] SynthLeadNoteColor           = new PImage[128];
  PImage[] SynthPadNoteColor            = new PImage[128];
  PImage[] SynthEffectsNoteColor        = new PImage[128];
  PImage[] EthnicNoteColor              = new PImage[128];
  PImage[] PercussiveNoteColor          = new PImage[128];
  PImage[] SoundEffectsNoteColor        = new PImage[128];
  PImage[] PercussionNoteColor          = new PImage[128];

  //Instrument masks
  PImage PianoMask;
  PImage ChromaticPercussionMask;
  PImage OrganMask;
  PImage GuitarMask;
  PImage BassMask;
  PImage StringsMask;
  PImage EnsembleMask;
  PImage BrassMask;
  PImage ReedMask;
  PImage PipeMask;
  PImage SynthLeadMask;
  PImage SynthPadMask;
  PImage SynthEffectsMask;
  PImage EthnicMask;
  PImage PercussiveMask;
  PImage SoundEffectsMask;
  PImage PercussionMask;

// Animation
  // Noise
  float am1 = 0;
  float  a0 = 0;
  float  a1 = 0;
  float  a2 = 0;
  float  a3 = 0;
  float  a4 = 0;
  float  a5 = 0;
  float  a6 = 0;
  float  a7 = 0;
  float  a8 = 0;
  float  a9 = 0;
  float NoiseScale = 100;

// Shapes
  // Sky dome
  PImage sky;
  PShape dome;
  float sphereRotateX = 0;
  float sphereRotateY = 1;
  float sphereRotateZ = 0;
  int cX = width/2;   //Display center X-Axish
  int cY = height/2;  //Display center Y-Axis
  int mX = mouseX;    //Mouse position X-Axis
  int mY = mouseY;    //Mouse position Y-Axis
  // Grid
  PShape Line1;
  PShape Line2;
  PShape Line3;
  PShape Line4;
  int Line1Z = -1024;
  int Line2Z = -256;
  int Line3Z = -384;
  int Line4Z = -512;
  // 3D Starfield
  int numstars=400;
  final int SPREAD=64;
  int CX,CY;
  final float SPEED=1.9;
  Star[] s = new Star[numstars];
 
// Setup
void setup() {
//  size(950, 540);        // 1/4 1080p
  size(950, 501, P3D);     // 1/4 1080p 3D
//  size(1280, 720);       // 720p 2D
//  size(1280, 720, P3D);  // 720p 3D
//  size(1920, 1080, P3D);  // 1080p 3D
//  smooth(8);             // 8X Antialiasing
  
  //Background
  background(0);
  
  //Camera
//  cam = new QueasyCam(this);
//  cam.speed = 2;                    //Default is 2
//  cam.sensitivity = 0.25;              //Default is 0.25
  
  //MIDI data
  MidiBus.list();                     // List available Midi devices
  myBus = new MidiBus(this, 0, -1);   // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

//Shapes
  //Sky dome
  dome = createShape(SPHERE, 2500);
  sky  = loadImage("sky.jpg");
  dome.setTexture(sky);
  
  //Starfield
  CX=width/2 ; CY=height/2;
  // s = new Star[numstars];
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
    
//Initialize variables
  //MIDI channels
  ChannelIsActive[0]  = false;
  ChannelIsActive[1]  = false;
  ChannelIsActive[2]  = false;
  ChannelIsActive[3]  = false;
  ChannelIsActive[4]  = false;
  ChannelIsActive[5]  = false;
  ChannelIsActive[6]  = false;
  ChannelIsActive[7]  = false;
  ChannelIsActive[8]  = false;
  ChannelIsActive[9]  = false;
  ChannelIsActive[10] = false;
  ChannelIsActive[11] = false;
  ChannelIsActive[12] = false;
  ChannelIsActive[13] = false;
  ChannelIsActive[14] = false;
  ChannelIsActive[15] = false;
  ChannelIsActive[16] = false;
  PitchIsActive[0]    = false;
  PitchIsActive[1]    = false;
  PitchIsActive[2]    = false;
  PitchIsActive[3]    = false;
  PitchIsActive[4]    = false;
  PitchIsActive[5]    = false;
  PitchIsActive[6]    = false;
  PitchIsActive[7]    = false;
  PitchIsActive[8]    = false;
  PitchIsActive[9]    = false;
  PitchIsActive[10]   = false;
  PitchIsActive[11]   = false;
  PitchIsActive[12]   = false;
  PitchIsActive[13]   = false;
  PitchIsActive[14]   = false;
  PitchIsActive[15]   = false;
  PitchIsActive[16]   = false;
  PitchIsActive[17]   = false;
  PitchIsActive[18]   = false;
  PitchIsActive[19]   = false;
  PitchIsActive[20]   = false;
  PitchIsActive[21]   = false;
  PitchIsActive[22]   = false;
  PitchIsActive[23]   = false;
  PitchIsActive[24]   = false;
  PitchIsActive[25]   = false;
  PitchIsActive[26]   = false;
  PitchIsActive[27]   = false;
  PitchIsActive[28]   = false;
  PitchIsActive[29]   = false;
  PitchIsActive[30]   = false;
  PitchIsActive[31]   = false;
  PitchIsActive[32]   = false;
  PitchIsActive[33]   = false;
  PitchIsActive[34]   = false;
  PitchIsActive[35]   = false;
  PitchIsActive[36]   = false;
  PitchIsActive[37]   = false;
  PitchIsActive[38]   = false;
  PitchIsActive[39]   = false;
  PitchIsActive[40]   = false;
  PitchIsActive[41]   = false;
  PitchIsActive[42]   = false;
  PitchIsActive[43]   = false;
  PitchIsActive[44]   = false;
  PitchIsActive[45]   = false;
  PitchIsActive[46]   = false;
  PitchIsActive[47]   = false;
  PitchIsActive[48]   = false;
  PitchIsActive[49]   = false;
  PitchIsActive[50]   = false;
  PitchIsActive[51]   = false;
  PitchIsActive[52]   = false;
  PitchIsActive[53]   = false;
  PitchIsActive[54]   = false;
  PitchIsActive[55]   = false;
  PitchIsActive[56]   = false;
  PitchIsActive[57]   = false;
  PitchIsActive[58]   = false;
  PitchIsActive[59]   = false;
  PitchIsActive[60]   = false;
  PitchIsActive[61]   = false;
  PitchIsActive[62]   = false;
  PitchIsActive[63]   = false;
  PitchIsActive[64]   = false;
  PitchIsActive[65]   = false;
  PitchIsActive[66]   = false;
  PitchIsActive[67]   = false;
  PitchIsActive[68]   = false;
  PitchIsActive[69]   = false;
  PitchIsActive[70]   = false;
  PitchIsActive[71]   = false;
  PitchIsActive[72]   = false;
  PitchIsActive[73]   = false;
  PitchIsActive[74]   = false;
  PitchIsActive[75]   = false;
  PitchIsActive[76]   = false;
  PitchIsActive[77]   = false;
  PitchIsActive[78]   = false;
  PitchIsActive[79]   = false;
  PitchIsActive[80]   = false;
  PitchIsActive[81]   = false;
  PitchIsActive[82]   = false;
  PitchIsActive[83]   = false;
  PitchIsActive[84]   = false;
  PitchIsActive[85]   = false;
  PitchIsActive[86]   = false;
  PitchIsActive[87]   = false;
  PitchIsActive[88]   = false;
  PitchIsActive[89]   = false;
  PitchIsActive[90]   = false;
  PitchIsActive[91]   = false;
  PitchIsActive[92]   = false;
  PitchIsActive[93]   = false;
  PitchIsActive[94]   = false;
  PitchIsActive[95]   = false;
  PitchIsActive[96]   = false;
  PitchIsActive[97]   = false;
  PitchIsActive[98]   = false;
  PitchIsActive[99]   = false;
  PitchIsActive[100]  = false;
  PitchIsActive[101]  = false;
  PitchIsActive[102]  = false;
  PitchIsActive[103]  = false;
  PitchIsActive[104]  = false;
  PitchIsActive[105]  = false;
  PitchIsActive[106]  = false;
  PitchIsActive[107]  = false;
  PitchIsActive[108]  = false;
  PitchIsActive[109]  = false;
  PitchIsActive[110]  = false;
  PitchIsActive[111]  = false;
  PitchIsActive[112]  = false;
  PitchIsActive[113]  = false;
  PitchIsActive[114]  = false;
  PitchIsActive[115]  = false;
  PitchIsActive[116]  = false;
  PitchIsActive[117]  = false;
  PitchIsActive[118]  = false;
  PitchIsActive[119]  = false;
  PitchIsActive[120]  = false;
  PitchIsActive[121]  = false;
  PitchIsActive[122]  = false;
  PitchIsActive[123]  = false;
  PitchIsActive[124]  = false;
  PitchIsActive[125]  = false;
  PitchIsActive[126]  = false;
  PitchIsActive[127]  = false;
  //Note-to-color correspondence (In degrees, out of 360)
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
  //Octave-to-saturation correspondence (out of 100)
  OctaveSaturations[0]  =  95; // Octave -1 saturation
  OctaveSaturations[1]  = 127; // Octave  0 saturation
  OctaveSaturations[2]  = 159; // Octave  1 saturation
  OctaveSaturations[3]  = 191; // Octave  2 saturation
  OctaveSaturations[4]  = 223; // Octave  3 saturation
  OctaveSaturations[5]  = 255; // Octave  4 saturation
  OctaveSaturations[6]  = 191; // Octave  5 saturation
  OctaveSaturations[7]  = 127; // Octave  6 saturation
  OctaveSaturations[8]  =  63; // Octave  7 saturation
  OctaveSaturations[9]  =   0; // Octave  8 saturation
  OctaveSaturations[10] =   0; // Octave  9 saturation
  //Octave-to-brightness correspondence (out of 100)
  OctaveBrightnesses[0]  =   0; // Octave -1 brightness
  OctaveBrightnesses[1]  =   0; // Octave  0 brightness
  OctaveBrightnesses[2]  =  31; // Octave  1 brightness
  OctaveBrightnesses[3]  =  63; // Octave  2 brightness
  OctaveBrightnesses[4]  =  95; // Octave  3 brightness
  OctaveBrightnesses[5]  = 127; // Octave  4 brightness
  OctaveBrightnesses[6]  = 191; // Octave  5 brightness
  OctaveBrightnesses[7]  = 255; // Octave  6 brightness
  OctaveBrightnesses[8]  = 255; // Octave  7 brightness
  OctaveBrightnesses[9]  = 255; // Octave  8 brightness
  OctaveBrightnesses[10] = 255; // Octave  9 brightness

//Colors
  //Piano
  PianoNoteColor[0]   = loadImage("Octavem1CColor.png");
  PianoNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  PianoNoteColor[2]   = loadImage("Octavem1DColor.png");
  PianoNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  PianoNoteColor[4]   = loadImage("Octavem1EColor.png");
  PianoNoteColor[5]   = loadImage("Octavem1FColor.png");
  PianoNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  PianoNoteColor[7]   = loadImage("Octavem1GColor.png");
  PianoNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  PianoNoteColor[9]   = loadImage("Octavem1AColor.png");
  PianoNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  PianoNoteColor[11]  = loadImage("Octavem1BColor.png");
  PianoNoteColor[12]  = loadImage("Octave0CColor.png");
  PianoNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  PianoNoteColor[14]  = loadImage("Octave0DColor.png");
  PianoNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  PianoNoteColor[16]  = loadImage("Octave0EColor.png");
  PianoNoteColor[17]  = loadImage("Octave0FColor.png");
  PianoNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  PianoNoteColor[19]  = loadImage("Octave0GColor.png");
  PianoNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  PianoNoteColor[21]  = loadImage("Octave0AColor.png");
  PianoNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  PianoNoteColor[23]  = loadImage("Octave0BColor.png");
  PianoNoteColor[24]  = loadImage("Octave1CColor.png");
  PianoNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  PianoNoteColor[26]  = loadImage("Octave1DColor.png");
  PianoNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  PianoNoteColor[28]  = loadImage("Octave1EColor.png");
  PianoNoteColor[29]  = loadImage("Octave1FColor.png");
  PianoNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  PianoNoteColor[31]  = loadImage("Octave1GColor.png");
  PianoNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  PianoNoteColor[33]  = loadImage("Octave1AColor.png");
  PianoNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  PianoNoteColor[35]  = loadImage("Octave1BColor.png");
  PianoNoteColor[36]  = loadImage("Octave2CColor.png");
  PianoNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  PianoNoteColor[38]  = loadImage("Octave2DColor.png");
  PianoNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  PianoNoteColor[40]  = loadImage("Octave2EColor.png");
  PianoNoteColor[41]  = loadImage("Octave2FColor.png");
  PianoNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  PianoNoteColor[43]  = loadImage("Octave2GColor.png");
  PianoNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  PianoNoteColor[45]  = loadImage("Octave2AColor.png");
  PianoNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  PianoNoteColor[47]  = loadImage("Octave2BColor.png");
  PianoNoteColor[48]  = loadImage("Octave3CColor.png");
  PianoNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  PianoNoteColor[50]  = loadImage("Octave3DColor.png");
  PianoNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  PianoNoteColor[52]  = loadImage("Octave3EColor.png");
  PianoNoteColor[53]  = loadImage("Octave3FColor.png");
  PianoNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  PianoNoteColor[55]  = loadImage("Octave3GColor.png");
  PianoNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  PianoNoteColor[57]  = loadImage("Octave3AColor.png");
  PianoNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  PianoNoteColor[59]  = loadImage("Octave3BColor.png");
  PianoNoteColor[60]  = loadImage("Octave4CColor.png");
  PianoNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  PianoNoteColor[62]  = loadImage("Octave4DColor.png");
  PianoNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  PianoNoteColor[64]  = loadImage("Octave4EColor.png");
  PianoNoteColor[65]  = loadImage("Octave4FColor.png");
  PianoNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  PianoNoteColor[67]  = loadImage("Octave4GColor.png");
  PianoNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  PianoNoteColor[69]  = loadImage("Octave4AColor.png");
  PianoNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  PianoNoteColor[71]  = loadImage("Octave4BColor.png");
  PianoNoteColor[72]  = loadImage("Octave5CColor.png");
  PianoNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  PianoNoteColor[74]  = loadImage("Octave5DColor.png");
  PianoNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  PianoNoteColor[76]  = loadImage("Octave5EColor.png");
  PianoNoteColor[77]  = loadImage("Octave5FColor.png");
  PianoNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  PianoNoteColor[79]  = loadImage("Octave5GColor.png");
  PianoNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  PianoNoteColor[81]  = loadImage("Octave5AColor.png");
  PianoNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  PianoNoteColor[83]  = loadImage("Octave5BColor.png");
  PianoNoteColor[84]  = loadImage("Octave6CColor.png");
  PianoNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  PianoNoteColor[86]  = loadImage("Octave6DColor.png");
  PianoNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  PianoNoteColor[88]  = loadImage("Octave6EColor.png");
  PianoNoteColor[89]  = loadImage("Octave6FColor.png");
  PianoNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  PianoNoteColor[91]  = loadImage("Octave6GColor.png");
  PianoNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  PianoNoteColor[93]  = loadImage("Octave6AColor.png");
  PianoNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  PianoNoteColor[95]  = loadImage("Octave6BColor.png");
  PianoNoteColor[96]  = loadImage("Octave7CColor.png");
  PianoNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  PianoNoteColor[98]  = loadImage("Octave7DColor.png");
  PianoNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  PianoNoteColor[100] = loadImage("Octave7EColor.png");
  PianoNoteColor[101] = loadImage("Octave7FColor.png");
  PianoNoteColor[102] = loadImage("Octave7FSharpColor.png");
  PianoNoteColor[103] = loadImage("Octave7GColor.png");
  PianoNoteColor[104] = loadImage("Octave7GSharpColor.png");
  PianoNoteColor[105] = loadImage("Octave7AColor.png");
  PianoNoteColor[106] = loadImage("Octave7ASharpColor.png");
  PianoNoteColor[107] = loadImage("Octave7BColor.png");
  PianoNoteColor[108] = loadImage("Octave8CColor.png");
  PianoNoteColor[109] = loadImage("Octave8CSharpColor.png");
  PianoNoteColor[110] = loadImage("Octave8DColor.png");
  PianoNoteColor[111] = loadImage("Octave8DSharpColor.png");
  PianoNoteColor[112] = loadImage("Octave8EColor.png");
  PianoNoteColor[113] = loadImage("Octave8FColor.png");
  PianoNoteColor[114] = loadImage("Octave8FSharpColor.png");
  PianoNoteColor[115] = loadImage("Octave8GColor.png");
  PianoNoteColor[116] = loadImage("Octave8GSharpColor.png");
  PianoNoteColor[117] = loadImage("Octave8AColor.png");
  PianoNoteColor[118] = loadImage("Octave8ASharpColor.png");
  PianoNoteColor[119] = loadImage("Octave8BColor.png");
  PianoNoteColor[120] = loadImage("Octave9CColor.png");
  PianoNoteColor[121] = loadImage("Octave9CSharpColor.png");
  PianoNoteColor[122] = loadImage("Octave9DColor.png");
  PianoNoteColor[123] = loadImage("Octave9DSharpColor.png");
  PianoNoteColor[124] = loadImage("Octave9EColor.png");
  PianoNoteColor[125] = loadImage("Octave9FColor.png");
  PianoNoteColor[126] = loadImage("Octave9FSharpColor.png");
  PianoNoteColor[127] = loadImage("Octave9GColor.png");
  //Chromatic Percussion
  ChromaticPercussionNoteColor[0]   = loadImage("Octavem1CColor.png");
  ChromaticPercussionNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  ChromaticPercussionNoteColor[2]   = loadImage("Octavem1DColor.png");
  ChromaticPercussionNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  ChromaticPercussionNoteColor[4]   = loadImage("Octavem1EColor.png");
  ChromaticPercussionNoteColor[5]   = loadImage("Octavem1FColor.png");
  ChromaticPercussionNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  ChromaticPercussionNoteColor[7]   = loadImage("Octavem1GColor.png");
  ChromaticPercussionNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  ChromaticPercussionNoteColor[9]   = loadImage("Octavem1AColor.png");
  ChromaticPercussionNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  ChromaticPercussionNoteColor[11]  = loadImage("Octavem1BColor.png");
  ChromaticPercussionNoteColor[12]  = loadImage("Octave0CColor.png");
  ChromaticPercussionNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  ChromaticPercussionNoteColor[14]  = loadImage("Octave0DColor.png");
  ChromaticPercussionNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  ChromaticPercussionNoteColor[16]  = loadImage("Octave0EColor.png");
  ChromaticPercussionNoteColor[17]  = loadImage("Octave0FColor.png");
  ChromaticPercussionNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  ChromaticPercussionNoteColor[19]  = loadImage("Octave0GColor.png");
  ChromaticPercussionNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  ChromaticPercussionNoteColor[21]  = loadImage("Octave0AColor.png");
  ChromaticPercussionNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  ChromaticPercussionNoteColor[23]  = loadImage("Octave0BColor.png");
  ChromaticPercussionNoteColor[24]  = loadImage("Octave1CColor.png");
  ChromaticPercussionNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  ChromaticPercussionNoteColor[26]  = loadImage("Octave1DColor.png");
  ChromaticPercussionNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  ChromaticPercussionNoteColor[28]  = loadImage("Octave1EColor.png");
  ChromaticPercussionNoteColor[29]  = loadImage("Octave1FColor.png");
  ChromaticPercussionNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  ChromaticPercussionNoteColor[31]  = loadImage("Octave1GColor.png");
  ChromaticPercussionNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  ChromaticPercussionNoteColor[33]  = loadImage("Octave1AColor.png");
  ChromaticPercussionNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  ChromaticPercussionNoteColor[35]  = loadImage("Octave1BColor.png");
  ChromaticPercussionNoteColor[36]  = loadImage("Octave2CColor.png");
  ChromaticPercussionNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  ChromaticPercussionNoteColor[38]  = loadImage("Octave2DColor.png");
  ChromaticPercussionNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  ChromaticPercussionNoteColor[40]  = loadImage("Octave2EColor.png");
  ChromaticPercussionNoteColor[41]  = loadImage("Octave2FColor.png");
  ChromaticPercussionNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  ChromaticPercussionNoteColor[43]  = loadImage("Octave2GColor.png");
  ChromaticPercussionNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  ChromaticPercussionNoteColor[45]  = loadImage("Octave2AColor.png");
  ChromaticPercussionNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  ChromaticPercussionNoteColor[47]  = loadImage("Octave2BColor.png");
  ChromaticPercussionNoteColor[48]  = loadImage("Octave3CColor.png");
  ChromaticPercussionNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  ChromaticPercussionNoteColor[50]  = loadImage("Octave3DColor.png");
  ChromaticPercussionNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  ChromaticPercussionNoteColor[52]  = loadImage("Octave3EColor.png");
  ChromaticPercussionNoteColor[53]  = loadImage("Octave3FColor.png");
  ChromaticPercussionNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  ChromaticPercussionNoteColor[55]  = loadImage("Octave3GColor.png");
  ChromaticPercussionNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  ChromaticPercussionNoteColor[57]  = loadImage("Octave3AColor.png");
  ChromaticPercussionNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  ChromaticPercussionNoteColor[59]  = loadImage("Octave3BColor.png");
  ChromaticPercussionNoteColor[60]  = loadImage("Octave4CColor.png");
  ChromaticPercussionNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  ChromaticPercussionNoteColor[62]  = loadImage("Octave4DColor.png");
  ChromaticPercussionNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  ChromaticPercussionNoteColor[64]  = loadImage("Octave4EColor.png");
  ChromaticPercussionNoteColor[65]  = loadImage("Octave4FColor.png");
  ChromaticPercussionNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  ChromaticPercussionNoteColor[67]  = loadImage("Octave4GColor.png");
  ChromaticPercussionNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  ChromaticPercussionNoteColor[69]  = loadImage("Octave4AColor.png");
  ChromaticPercussionNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  ChromaticPercussionNoteColor[71]  = loadImage("Octave4BColor.png");
  ChromaticPercussionNoteColor[72]  = loadImage("Octave5CColor.png");
  ChromaticPercussionNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  ChromaticPercussionNoteColor[74]  = loadImage("Octave5DColor.png");
  ChromaticPercussionNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  ChromaticPercussionNoteColor[76]  = loadImage("Octave5EColor.png");
  ChromaticPercussionNoteColor[77]  = loadImage("Octave5FColor.png");
  ChromaticPercussionNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  ChromaticPercussionNoteColor[79]  = loadImage("Octave5GColor.png");
  ChromaticPercussionNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  ChromaticPercussionNoteColor[81]  = loadImage("Octave5AColor.png");
  ChromaticPercussionNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  ChromaticPercussionNoteColor[83]  = loadImage("Octave5BColor.png");
  ChromaticPercussionNoteColor[84]  = loadImage("Octave6CColor.png");
  ChromaticPercussionNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  ChromaticPercussionNoteColor[86]  = loadImage("Octave6DColor.png");
  ChromaticPercussionNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  ChromaticPercussionNoteColor[88]  = loadImage("Octave6EColor.png");
  ChromaticPercussionNoteColor[89]  = loadImage("Octave6FColor.png");
  ChromaticPercussionNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  ChromaticPercussionNoteColor[91]  = loadImage("Octave6GColor.png");
  ChromaticPercussionNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  ChromaticPercussionNoteColor[93]  = loadImage("Octave6AColor.png");
  ChromaticPercussionNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  ChromaticPercussionNoteColor[95]  = loadImage("Octave6BColor.png");
  ChromaticPercussionNoteColor[96]  = loadImage("Octave7CColor.png");
  ChromaticPercussionNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  ChromaticPercussionNoteColor[98]  = loadImage("Octave7DColor.png");
  ChromaticPercussionNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  ChromaticPercussionNoteColor[100] = loadImage("Octave7EColor.png");
  ChromaticPercussionNoteColor[101] = loadImage("Octave7FColor.png");
  ChromaticPercussionNoteColor[102] = loadImage("Octave7FSharpColor.png");
  ChromaticPercussionNoteColor[103] = loadImage("Octave7GColor.png");
  ChromaticPercussionNoteColor[104] = loadImage("Octave7GSharpColor.png");
  ChromaticPercussionNoteColor[105] = loadImage("Octave7AColor.png");
  ChromaticPercussionNoteColor[106] = loadImage("Octave7ASharpColor.png");
  ChromaticPercussionNoteColor[107] = loadImage("Octave7BColor.png");
  ChromaticPercussionNoteColor[108] = loadImage("Octave8CColor.png");
  ChromaticPercussionNoteColor[109] = loadImage("Octave8CSharpColor.png");
  ChromaticPercussionNoteColor[110] = loadImage("Octave8DColor.png");
  ChromaticPercussionNoteColor[111] = loadImage("Octave8DSharpColor.png");
  ChromaticPercussionNoteColor[112] = loadImage("Octave8EColor.png");
  ChromaticPercussionNoteColor[113] = loadImage("Octave8FColor.png");
  ChromaticPercussionNoteColor[114] = loadImage("Octave8FSharpColor.png");
  ChromaticPercussionNoteColor[115] = loadImage("Octave8GColor.png");
  ChromaticPercussionNoteColor[116] = loadImage("Octave8GSharpColor.png");
  ChromaticPercussionNoteColor[117] = loadImage("Octave8AColor.png");
  ChromaticPercussionNoteColor[118] = loadImage("Octave8ASharpColor.png");
  ChromaticPercussionNoteColor[119] = loadImage("Octave8BColor.png");
  ChromaticPercussionNoteColor[120] = loadImage("Octave9CColor.png");
  ChromaticPercussionNoteColor[121] = loadImage("Octave9CSharpColor.png");
  ChromaticPercussionNoteColor[122] = loadImage("Octave9DColor.png");
  ChromaticPercussionNoteColor[123] = loadImage("Octave9DSharpColor.png");
  ChromaticPercussionNoteColor[124] = loadImage("Octave9EColor.png");
  ChromaticPercussionNoteColor[125] = loadImage("Octave9FColor.png");
  ChromaticPercussionNoteColor[126] = loadImage("Octave9FSharpColor.png");
  ChromaticPercussionNoteColor[127] = loadImage("Octave9GColor.png");
  //Organ
  OrganNoteColor[0]   = loadImage("Octavem1CColor.png");
  OrganNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  OrganNoteColor[2]   = loadImage("Octavem1DColor.png");
  OrganNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  OrganNoteColor[4]   = loadImage("Octavem1EColor.png");
  OrganNoteColor[5]   = loadImage("Octavem1FColor.png");
  OrganNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  OrganNoteColor[7]   = loadImage("Octavem1GColor.png");
  OrganNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  OrganNoteColor[9]   = loadImage("Octavem1AColor.png");
  OrganNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  OrganNoteColor[11]  = loadImage("Octavem1BColor.png");
  OrganNoteColor[12]  = loadImage("Octave0CColor.png");
  OrganNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  OrganNoteColor[14]  = loadImage("Octave0DColor.png");
  OrganNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  OrganNoteColor[16]  = loadImage("Octave0EColor.png");
  OrganNoteColor[17]  = loadImage("Octave0FColor.png");
  OrganNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  OrganNoteColor[19]  = loadImage("Octave0GColor.png");
  OrganNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  OrganNoteColor[21]  = loadImage("Octave0AColor.png");
  OrganNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  OrganNoteColor[23]  = loadImage("Octave0BColor.png");
  OrganNoteColor[24]  = loadImage("Octave1CColor.png");
  OrganNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  OrganNoteColor[26]  = loadImage("Octave1DColor.png");
  OrganNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  OrganNoteColor[28]  = loadImage("Octave1EColor.png");
  OrganNoteColor[29]  = loadImage("Octave1FColor.png");
  OrganNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  OrganNoteColor[31]  = loadImage("Octave1GColor.png");
  OrganNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  OrganNoteColor[33]  = loadImage("Octave1AColor.png");
  OrganNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  OrganNoteColor[35]  = loadImage("Octave1BColor.png");
  OrganNoteColor[36]  = loadImage("Octave2CColor.png");
  OrganNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  OrganNoteColor[38]  = loadImage("Octave2DColor.png");
  OrganNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  OrganNoteColor[40]  = loadImage("Octave2EColor.png");
  OrganNoteColor[41]  = loadImage("Octave2FColor.png");
  OrganNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  OrganNoteColor[43]  = loadImage("Octave2GColor.png");
  OrganNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  OrganNoteColor[45]  = loadImage("Octave2AColor.png");
  OrganNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  OrganNoteColor[47]  = loadImage("Octave2BColor.png");
  OrganNoteColor[48]  = loadImage("Octave3CColor.png");
  OrganNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  OrganNoteColor[50]  = loadImage("Octave3DColor.png");
  OrganNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  OrganNoteColor[52]  = loadImage("Octave3EColor.png");
  OrganNoteColor[53]  = loadImage("Octave3FColor.png");
  OrganNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  OrganNoteColor[55]  = loadImage("Octave3GColor.png");
  OrganNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  OrganNoteColor[57]  = loadImage("Octave3AColor.png");
  OrganNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  OrganNoteColor[59]  = loadImage("Octave3BColor.png");
  OrganNoteColor[60]  = loadImage("Octave4CColor.png");
  OrganNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  OrganNoteColor[62]  = loadImage("Octave4DColor.png");
  OrganNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  OrganNoteColor[64]  = loadImage("Octave4EColor.png");
  OrganNoteColor[65]  = loadImage("Octave4FColor.png");
  OrganNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  OrganNoteColor[67]  = loadImage("Octave4GColor.png");
  OrganNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  OrganNoteColor[69]  = loadImage("Octave4AColor.png");
  OrganNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  OrganNoteColor[71]  = loadImage("Octave4BColor.png");
  OrganNoteColor[72]  = loadImage("Octave5CColor.png");
  OrganNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  OrganNoteColor[74]  = loadImage("Octave5DColor.png");
  OrganNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  OrganNoteColor[76]  = loadImage("Octave5EColor.png");
  OrganNoteColor[77]  = loadImage("Octave5FColor.png");
  OrganNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  OrganNoteColor[79]  = loadImage("Octave5GColor.png");
  OrganNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  OrganNoteColor[81]  = loadImage("Octave5AColor.png");
  OrganNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  OrganNoteColor[83]  = loadImage("Octave5BColor.png");
  OrganNoteColor[84]  = loadImage("Octave6CColor.png");
  OrganNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  OrganNoteColor[86]  = loadImage("Octave6DColor.png");
  OrganNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  OrganNoteColor[88]  = loadImage("Octave6EColor.png");
  OrganNoteColor[89]  = loadImage("Octave6FColor.png");
  OrganNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  OrganNoteColor[91]  = loadImage("Octave6GColor.png");
  OrganNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  OrganNoteColor[93]  = loadImage("Octave6AColor.png");
  OrganNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  OrganNoteColor[95]  = loadImage("Octave6BColor.png");
  OrganNoteColor[96]  = loadImage("Octave7CColor.png");
  OrganNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  OrganNoteColor[98]  = loadImage("Octave7DColor.png");
  OrganNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  OrganNoteColor[100] = loadImage("Octave7EColor.png");
  OrganNoteColor[101] = loadImage("Octave7FColor.png");
  OrganNoteColor[102] = loadImage("Octave7FSharpColor.png");
  OrganNoteColor[103] = loadImage("Octave7GColor.png");
  OrganNoteColor[104] = loadImage("Octave7GSharpColor.png");
  OrganNoteColor[105] = loadImage("Octave7AColor.png");
  OrganNoteColor[106] = loadImage("Octave7ASharpColor.png");
  OrganNoteColor[107] = loadImage("Octave7BColor.png");
  OrganNoteColor[108] = loadImage("Octave8CColor.png");
  OrganNoteColor[109] = loadImage("Octave8CSharpColor.png");
  OrganNoteColor[110] = loadImage("Octave8DColor.png");
  OrganNoteColor[111] = loadImage("Octave8DSharpColor.png");
  OrganNoteColor[112] = loadImage("Octave8EColor.png");
  OrganNoteColor[113] = loadImage("Octave8FColor.png");
  OrganNoteColor[114] = loadImage("Octave8FSharpColor.png");
  OrganNoteColor[115] = loadImage("Octave8GColor.png");
  OrganNoteColor[116] = loadImage("Octave8GSharpColor.png");
  OrganNoteColor[117] = loadImage("Octave8AColor.png");
  OrganNoteColor[118] = loadImage("Octave8ASharpColor.png");
  OrganNoteColor[119] = loadImage("Octave8BColor.png");
  OrganNoteColor[120] = loadImage("Octave9CColor.png");
  OrganNoteColor[121] = loadImage("Octave9CSharpColor.png");
  OrganNoteColor[122] = loadImage("Octave9DColor.png");
  OrganNoteColor[123] = loadImage("Octave9DSharpColor.png");
  OrganNoteColor[124] = loadImage("Octave9EColor.png");
  OrganNoteColor[125] = loadImage("Octave9FColor.png");
  OrganNoteColor[126] = loadImage("Octave9FSharpColor.png");
  OrganNoteColor[127] = loadImage("Octave9GColor.png");
  //Guitar
  GuitarNoteColor[0]   = loadImage("Octavem1CColor.png");
  GuitarNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  GuitarNoteColor[2]   = loadImage("Octavem1DColor.png");
  GuitarNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  GuitarNoteColor[4]   = loadImage("Octavem1EColor.png");
  GuitarNoteColor[5]   = loadImage("Octavem1FColor.png");
  GuitarNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  GuitarNoteColor[7]   = loadImage("Octavem1GColor.png");
  GuitarNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  GuitarNoteColor[9]   = loadImage("Octavem1AColor.png");
  GuitarNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  GuitarNoteColor[11]  = loadImage("Octavem1BColor.png");
  GuitarNoteColor[12]  = loadImage("Octave0CColor.png");
  GuitarNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  GuitarNoteColor[14]  = loadImage("Octave0DColor.png");
  GuitarNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  GuitarNoteColor[16]  = loadImage("Octave0EColor.png");
  GuitarNoteColor[17]  = loadImage("Octave0FColor.png");
  GuitarNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  GuitarNoteColor[19]  = loadImage("Octave0GColor.png");
  GuitarNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  GuitarNoteColor[21]  = loadImage("Octave0AColor.png");
  GuitarNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  GuitarNoteColor[23]  = loadImage("Octave0BColor.png");
  GuitarNoteColor[24]  = loadImage("Octave1CColor.png");
  GuitarNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  GuitarNoteColor[26]  = loadImage("Octave1DColor.png");
  GuitarNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  GuitarNoteColor[28]  = loadImage("Octave1EColor.png");
  GuitarNoteColor[29]  = loadImage("Octave1FColor.png");
  GuitarNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  GuitarNoteColor[31]  = loadImage("Octave1GColor.png");
  GuitarNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  GuitarNoteColor[33]  = loadImage("Octave1AColor.png");
  GuitarNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  GuitarNoteColor[35]  = loadImage("Octave1BColor.png");
  GuitarNoteColor[36]  = loadImage("Octave2CColor.png");
  GuitarNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  GuitarNoteColor[38]  = loadImage("Octave2DColor.png");
  GuitarNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  GuitarNoteColor[40]  = loadImage("Octave2EColor.png");
  GuitarNoteColor[41]  = loadImage("Octave2FColor.png");
  GuitarNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  GuitarNoteColor[43]  = loadImage("Octave2GColor.png");
  GuitarNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  GuitarNoteColor[45]  = loadImage("Octave2AColor.png");
  GuitarNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  GuitarNoteColor[47]  = loadImage("Octave2BColor.png");
  GuitarNoteColor[48]  = loadImage("Octave3CColor.png");
  GuitarNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  GuitarNoteColor[50]  = loadImage("Octave3DColor.png");
  GuitarNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  GuitarNoteColor[52]  = loadImage("Octave3EColor.png");
  GuitarNoteColor[53]  = loadImage("Octave3FColor.png");
  GuitarNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  GuitarNoteColor[55]  = loadImage("Octave3GColor.png");
  GuitarNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  GuitarNoteColor[57]  = loadImage("Octave3AColor.png");
  GuitarNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  GuitarNoteColor[59]  = loadImage("Octave3BColor.png");
  GuitarNoteColor[60]  = loadImage("Octave4CColor.png");
  GuitarNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  GuitarNoteColor[62]  = loadImage("Octave4DColor.png");
  GuitarNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  GuitarNoteColor[64]  = loadImage("Octave4EColor.png");
  GuitarNoteColor[65]  = loadImage("Octave4FColor.png");
  GuitarNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  GuitarNoteColor[67]  = loadImage("Octave4GColor.png");
  GuitarNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  GuitarNoteColor[69]  = loadImage("Octave4AColor.png");
  GuitarNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  GuitarNoteColor[71]  = loadImage("Octave4BColor.png");
  GuitarNoteColor[72]  = loadImage("Octave5CColor.png");
  GuitarNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  GuitarNoteColor[74]  = loadImage("Octave5DColor.png");
  GuitarNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  GuitarNoteColor[76]  = loadImage("Octave5EColor.png");
  GuitarNoteColor[77]  = loadImage("Octave5FColor.png");
  GuitarNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  GuitarNoteColor[79]  = loadImage("Octave5GColor.png");
  GuitarNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  GuitarNoteColor[81]  = loadImage("Octave5AColor.png");
  GuitarNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  GuitarNoteColor[83]  = loadImage("Octave5BColor.png");
  GuitarNoteColor[84]  = loadImage("Octave6CColor.png");
  GuitarNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  GuitarNoteColor[86]  = loadImage("Octave6DColor.png");
  GuitarNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  GuitarNoteColor[88]  = loadImage("Octave6EColor.png");
  GuitarNoteColor[89]  = loadImage("Octave6FColor.png");
  GuitarNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  GuitarNoteColor[91]  = loadImage("Octave6GColor.png");
  GuitarNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  GuitarNoteColor[93]  = loadImage("Octave6AColor.png");
  GuitarNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  GuitarNoteColor[95]  = loadImage("Octave6BColor.png");
  GuitarNoteColor[96]  = loadImage("Octave7CColor.png");
  GuitarNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  GuitarNoteColor[98]  = loadImage("Octave7DColor.png");
  GuitarNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  GuitarNoteColor[100] = loadImage("Octave7EColor.png");
  GuitarNoteColor[101] = loadImage("Octave7FColor.png");
  GuitarNoteColor[102] = loadImage("Octave7FSharpColor.png");
  GuitarNoteColor[103] = loadImage("Octave7GColor.png");
  GuitarNoteColor[104] = loadImage("Octave7GSharpColor.png");
  GuitarNoteColor[105] = loadImage("Octave7AColor.png");
  GuitarNoteColor[106] = loadImage("Octave7ASharpColor.png");
  GuitarNoteColor[107] = loadImage("Octave7BColor.png");
  GuitarNoteColor[108] = loadImage("Octave8CColor.png");
  GuitarNoteColor[109] = loadImage("Octave8CSharpColor.png");
  GuitarNoteColor[110] = loadImage("Octave8DColor.png");
  GuitarNoteColor[111] = loadImage("Octave8DSharpColor.png");
  GuitarNoteColor[112] = loadImage("Octave8EColor.png");
  GuitarNoteColor[113] = loadImage("Octave8FColor.png");
  GuitarNoteColor[114] = loadImage("Octave8FSharpColor.png");
  GuitarNoteColor[115] = loadImage("Octave8GColor.png");
  GuitarNoteColor[116] = loadImage("Octave8GSharpColor.png");
  GuitarNoteColor[117] = loadImage("Octave8AColor.png");
  GuitarNoteColor[118] = loadImage("Octave8ASharpColor.png");
  GuitarNoteColor[119] = loadImage("Octave8BColor.png");
  GuitarNoteColor[120] = loadImage("Octave9CColor.png");
  GuitarNoteColor[121] = loadImage("Octave9CSharpColor.png");
  GuitarNoteColor[122] = loadImage("Octave9DColor.png");
  GuitarNoteColor[123] = loadImage("Octave9DSharpColor.png");
  GuitarNoteColor[124] = loadImage("Octave9EColor.png");
  GuitarNoteColor[125] = loadImage("Octave9FColor.png");
  GuitarNoteColor[126] = loadImage("Octave9FSharpColor.png");
  GuitarNoteColor[127] = loadImage("Octave9GColor.png");
  //Bass
  BassNoteColor[0]   = loadImage("Octavem1CColor.png");
  BassNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  BassNoteColor[2]   = loadImage("Octavem1DColor.png");
  BassNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  BassNoteColor[4]   = loadImage("Octavem1EColor.png");
  BassNoteColor[5]   = loadImage("Octavem1FColor.png");
  BassNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  BassNoteColor[7]   = loadImage("Octavem1GColor.png");
  BassNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  BassNoteColor[9]   = loadImage("Octavem1AColor.png");
  BassNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  BassNoteColor[11]  = loadImage("Octavem1BColor.png");
  BassNoteColor[12]  = loadImage("Octave0CColor.png");
  BassNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  BassNoteColor[14]  = loadImage("Octave0DColor.png");
  BassNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  BassNoteColor[16]  = loadImage("Octave0EColor.png");
  BassNoteColor[17]  = loadImage("Octave0FColor.png");
  BassNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  BassNoteColor[19]  = loadImage("Octave0GColor.png");
  BassNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  BassNoteColor[21]  = loadImage("Octave0AColor.png");
  BassNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  BassNoteColor[23]  = loadImage("Octave0BColor.png");
  BassNoteColor[24]  = loadImage("Octave1CColor.png");
  BassNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  BassNoteColor[26]  = loadImage("Octave1DColor.png");
  BassNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  BassNoteColor[28]  = loadImage("Octave1EColor.png");
  BassNoteColor[29]  = loadImage("Octave1FColor.png");
  BassNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  BassNoteColor[31]  = loadImage("Octave1GColor.png");
  BassNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  BassNoteColor[33]  = loadImage("Octave1AColor.png");
  BassNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  BassNoteColor[35]  = loadImage("Octave1BColor.png");
  BassNoteColor[36]  = loadImage("Octave2CColor.png");
  BassNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  BassNoteColor[38]  = loadImage("Octave2DColor.png");
  BassNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  BassNoteColor[40]  = loadImage("Octave2EColor.png");
  BassNoteColor[41]  = loadImage("Octave2FColor.png");
  BassNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  BassNoteColor[43]  = loadImage("Octave2GColor.png");
  BassNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  BassNoteColor[45]  = loadImage("Octave2AColor.png");
  BassNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  BassNoteColor[47]  = loadImage("Octave2BColor.png");
  BassNoteColor[48]  = loadImage("Octave3CColor.png");
  BassNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  BassNoteColor[50]  = loadImage("Octave3DColor.png");
  BassNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  BassNoteColor[52]  = loadImage("Octave3EColor.png");
  BassNoteColor[53]  = loadImage("Octave3FColor.png");
  BassNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  BassNoteColor[55]  = loadImage("Octave3GColor.png");
  BassNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  BassNoteColor[57]  = loadImage("Octave3AColor.png");
  BassNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  BassNoteColor[59]  = loadImage("Octave3BColor.png");
  BassNoteColor[60]  = loadImage("Octave4CColor.png");
  BassNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  BassNoteColor[62]  = loadImage("Octave4DColor.png");
  BassNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  BassNoteColor[64]  = loadImage("Octave4EColor.png");
  BassNoteColor[65]  = loadImage("Octave4FColor.png");
  BassNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  BassNoteColor[67]  = loadImage("Octave4GColor.png");
  BassNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  BassNoteColor[69]  = loadImage("Octave4AColor.png");
  BassNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  BassNoteColor[71]  = loadImage("Octave4BColor.png");
  BassNoteColor[72]  = loadImage("Octave5CColor.png");
  BassNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  BassNoteColor[74]  = loadImage("Octave5DColor.png");
  BassNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  BassNoteColor[76]  = loadImage("Octave5EColor.png");
  BassNoteColor[77]  = loadImage("Octave5FColor.png");
  BassNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  BassNoteColor[79]  = loadImage("Octave5GColor.png");
  BassNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  BassNoteColor[81]  = loadImage("Octave5AColor.png");
  BassNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  BassNoteColor[83]  = loadImage("Octave5BColor.png");
  BassNoteColor[84]  = loadImage("Octave6CColor.png");
  BassNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  BassNoteColor[86]  = loadImage("Octave6DColor.png");
  BassNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  BassNoteColor[88]  = loadImage("Octave6EColor.png");
  BassNoteColor[89]  = loadImage("Octave6FColor.png");
  BassNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  BassNoteColor[91]  = loadImage("Octave6GColor.png");
  BassNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  BassNoteColor[93]  = loadImage("Octave6AColor.png");
  BassNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  BassNoteColor[95]  = loadImage("Octave6BColor.png");
  BassNoteColor[96]  = loadImage("Octave7CColor.png");
  BassNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  BassNoteColor[98]  = loadImage("Octave7DColor.png");
  BassNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  BassNoteColor[100] = loadImage("Octave7EColor.png");
  BassNoteColor[101] = loadImage("Octave7FColor.png");
  BassNoteColor[102] = loadImage("Octave7FSharpColor.png");
  BassNoteColor[103] = loadImage("Octave7GColor.png");
  BassNoteColor[104] = loadImage("Octave7GSharpColor.png");
  BassNoteColor[105] = loadImage("Octave7AColor.png");
  BassNoteColor[106] = loadImage("Octave7ASharpColor.png");
  BassNoteColor[107] = loadImage("Octave7BColor.png");
  BassNoteColor[108] = loadImage("Octave8CColor.png");
  BassNoteColor[109] = loadImage("Octave8CSharpColor.png");
  BassNoteColor[110] = loadImage("Octave8DColor.png");
  BassNoteColor[111] = loadImage("Octave8DSharpColor.png");
  BassNoteColor[112] = loadImage("Octave8EColor.png");
  BassNoteColor[113] = loadImage("Octave8FColor.png");
  BassNoteColor[114] = loadImage("Octave8FSharpColor.png");
  BassNoteColor[115] = loadImage("Octave8GColor.png");
  BassNoteColor[116] = loadImage("Octave8GSharpColor.png");
  BassNoteColor[117] = loadImage("Octave8AColor.png");
  BassNoteColor[118] = loadImage("Octave8ASharpColor.png");
  BassNoteColor[119] = loadImage("Octave8BColor.png");
  BassNoteColor[120] = loadImage("Octave9CColor.png");
  BassNoteColor[121] = loadImage("Octave9CSharpColor.png");
  BassNoteColor[122] = loadImage("Octave9DColor.png");
  BassNoteColor[123] = loadImage("Octave9DSharpColor.png");
  BassNoteColor[124] = loadImage("Octave9EColor.png");
  BassNoteColor[125] = loadImage("Octave9FColor.png");
  BassNoteColor[126] = loadImage("Octave9FSharpColor.png");
  BassNoteColor[127] = loadImage("Octave9GColor.png");
  //Strings
  StringsNoteColor[0]   = loadImage("Octavem1CColor.png");
  StringsNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  StringsNoteColor[2]   = loadImage("Octavem1DColor.png");
  StringsNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  StringsNoteColor[4]   = loadImage("Octavem1EColor.png");
  StringsNoteColor[5]   = loadImage("Octavem1FColor.png");
  StringsNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  StringsNoteColor[7]   = loadImage("Octavem1GColor.png");
  StringsNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  StringsNoteColor[9]   = loadImage("Octavem1AColor.png");
  StringsNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  StringsNoteColor[11]  = loadImage("Octavem1BColor.png");
  StringsNoteColor[12]  = loadImage("Octave0CColor.png");
  StringsNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  StringsNoteColor[14]  = loadImage("Octave0DColor.png");
  StringsNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  StringsNoteColor[16]  = loadImage("Octave0EColor.png");
  StringsNoteColor[17]  = loadImage("Octave0FColor.png");
  StringsNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  StringsNoteColor[19]  = loadImage("Octave0GColor.png");
  StringsNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  StringsNoteColor[21]  = loadImage("Octave0AColor.png");
  StringsNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  StringsNoteColor[23]  = loadImage("Octave0BColor.png");
  StringsNoteColor[24]  = loadImage("Octave1CColor.png");
  StringsNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  StringsNoteColor[26]  = loadImage("Octave1DColor.png");
  StringsNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  StringsNoteColor[28]  = loadImage("Octave1EColor.png");
  StringsNoteColor[29]  = loadImage("Octave1FColor.png");
  StringsNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  StringsNoteColor[31]  = loadImage("Octave1GColor.png");
  StringsNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  StringsNoteColor[33]  = loadImage("Octave1AColor.png");
  StringsNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  StringsNoteColor[35]  = loadImage("Octave1BColor.png");
  StringsNoteColor[36]  = loadImage("Octave2CColor.png");
  StringsNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  StringsNoteColor[38]  = loadImage("Octave2DColor.png");
  StringsNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  StringsNoteColor[40]  = loadImage("Octave2EColor.png");
  StringsNoteColor[41]  = loadImage("Octave2FColor.png");
  StringsNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  StringsNoteColor[43]  = loadImage("Octave2GColor.png");
  StringsNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  StringsNoteColor[45]  = loadImage("Octave2AColor.png");
  StringsNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  StringsNoteColor[47]  = loadImage("Octave2BColor.png");
  StringsNoteColor[48]  = loadImage("Octave3CColor.png");
  StringsNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  StringsNoteColor[50]  = loadImage("Octave3DColor.png");
  StringsNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  StringsNoteColor[52]  = loadImage("Octave3EColor.png");
  StringsNoteColor[53]  = loadImage("Octave3FColor.png");
  StringsNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  StringsNoteColor[55]  = loadImage("Octave3GColor.png");
  StringsNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  StringsNoteColor[57]  = loadImage("Octave3AColor.png");
  StringsNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  StringsNoteColor[59]  = loadImage("Octave3BColor.png");
  StringsNoteColor[60]  = loadImage("Octave4CColor.png");
  StringsNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  StringsNoteColor[62]  = loadImage("Octave4DColor.png");
  StringsNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  StringsNoteColor[64]  = loadImage("Octave4EColor.png");
  StringsNoteColor[65]  = loadImage("Octave4FColor.png");
  StringsNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  StringsNoteColor[67]  = loadImage("Octave4GColor.png");
  StringsNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  StringsNoteColor[69]  = loadImage("Octave4AColor.png");
  StringsNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  StringsNoteColor[71]  = loadImage("Octave4BColor.png");
  StringsNoteColor[72]  = loadImage("Octave5CColor.png");
  StringsNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  StringsNoteColor[74]  = loadImage("Octave5DColor.png");
  StringsNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  StringsNoteColor[76]  = loadImage("Octave5EColor.png");
  StringsNoteColor[77]  = loadImage("Octave5FColor.png");
  StringsNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  StringsNoteColor[79]  = loadImage("Octave5GColor.png");
  StringsNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  StringsNoteColor[81]  = loadImage("Octave5AColor.png");
  StringsNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  StringsNoteColor[83]  = loadImage("Octave5BColor.png");
  StringsNoteColor[84]  = loadImage("Octave6CColor.png");
  StringsNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  StringsNoteColor[86]  = loadImage("Octave6DColor.png");
  StringsNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  StringsNoteColor[88]  = loadImage("Octave6EColor.png");
  StringsNoteColor[89]  = loadImage("Octave6FColor.png");
  StringsNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  StringsNoteColor[91]  = loadImage("Octave6GColor.png");
  StringsNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  StringsNoteColor[93]  = loadImage("Octave6AColor.png");
  StringsNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  StringsNoteColor[95]  = loadImage("Octave6BColor.png");
  StringsNoteColor[96]  = loadImage("Octave7CColor.png");
  StringsNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  StringsNoteColor[98]  = loadImage("Octave7DColor.png");
  StringsNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  StringsNoteColor[100] = loadImage("Octave7EColor.png");
  StringsNoteColor[101] = loadImage("Octave7FColor.png");
  StringsNoteColor[102] = loadImage("Octave7FSharpColor.png");
  StringsNoteColor[103] = loadImage("Octave7GColor.png");
  StringsNoteColor[104] = loadImage("Octave7GSharpColor.png");
  StringsNoteColor[105] = loadImage("Octave7AColor.png");
  StringsNoteColor[106] = loadImage("Octave7ASharpColor.png");
  StringsNoteColor[107] = loadImage("Octave7BColor.png");
  StringsNoteColor[108] = loadImage("Octave8CColor.png");
  StringsNoteColor[109] = loadImage("Octave8CSharpColor.png");
  StringsNoteColor[110] = loadImage("Octave8DColor.png");
  StringsNoteColor[111] = loadImage("Octave8DSharpColor.png");
  StringsNoteColor[112] = loadImage("Octave8EColor.png");
  StringsNoteColor[113] = loadImage("Octave8FColor.png");
  StringsNoteColor[114] = loadImage("Octave8FSharpColor.png");
  StringsNoteColor[115] = loadImage("Octave8GColor.png");
  StringsNoteColor[116] = loadImage("Octave8GSharpColor.png");
  StringsNoteColor[117] = loadImage("Octave8AColor.png");
  StringsNoteColor[118] = loadImage("Octave8ASharpColor.png");
  StringsNoteColor[119] = loadImage("Octave8BColor.png");
  StringsNoteColor[120] = loadImage("Octave9CColor.png");
  StringsNoteColor[121] = loadImage("Octave9CSharpColor.png");
  StringsNoteColor[122] = loadImage("Octave9DColor.png");
  StringsNoteColor[123] = loadImage("Octave9DSharpColor.png");
  StringsNoteColor[124] = loadImage("Octave9EColor.png");
  StringsNoteColor[125] = loadImage("Octave9FColor.png");
  StringsNoteColor[126] = loadImage("Octave9FSharpColor.png");
  StringsNoteColor[127] = loadImage("Octave9GColor.png");
  //Ensemble
  EnsembleNoteColor[0]   = loadImage("Octavem1CColor.png");
  EnsembleNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  EnsembleNoteColor[2]   = loadImage("Octavem1DColor.png");
  EnsembleNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  EnsembleNoteColor[4]   = loadImage("Octavem1EColor.png");
  EnsembleNoteColor[5]   = loadImage("Octavem1FColor.png");
  EnsembleNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  EnsembleNoteColor[7]   = loadImage("Octavem1GColor.png");
  EnsembleNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  EnsembleNoteColor[9]   = loadImage("Octavem1AColor.png");
  EnsembleNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  EnsembleNoteColor[11]  = loadImage("Octavem1BColor.png");
  EnsembleNoteColor[12]  = loadImage("Octave0CColor.png");
  EnsembleNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  EnsembleNoteColor[14]  = loadImage("Octave0DColor.png");
  EnsembleNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  EnsembleNoteColor[16]  = loadImage("Octave0EColor.png");
  EnsembleNoteColor[17]  = loadImage("Octave0FColor.png");
  EnsembleNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  EnsembleNoteColor[19]  = loadImage("Octave0GColor.png");
  EnsembleNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  EnsembleNoteColor[21]  = loadImage("Octave0AColor.png");
  EnsembleNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  EnsembleNoteColor[23]  = loadImage("Octave0BColor.png");
  EnsembleNoteColor[24]  = loadImage("Octave1CColor.png");
  EnsembleNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  EnsembleNoteColor[26]  = loadImage("Octave1DColor.png");
  EnsembleNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  EnsembleNoteColor[28]  = loadImage("Octave1EColor.png");
  EnsembleNoteColor[29]  = loadImage("Octave1FColor.png");
  EnsembleNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  EnsembleNoteColor[31]  = loadImage("Octave1GColor.png");
  EnsembleNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  EnsembleNoteColor[33]  = loadImage("Octave1AColor.png");
  EnsembleNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  EnsembleNoteColor[35]  = loadImage("Octave1BColor.png");
  EnsembleNoteColor[36]  = loadImage("Octave2CColor.png");
  EnsembleNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  EnsembleNoteColor[38]  = loadImage("Octave2DColor.png");
  EnsembleNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  EnsembleNoteColor[40]  = loadImage("Octave2EColor.png");
  EnsembleNoteColor[41]  = loadImage("Octave2FColor.png");
  EnsembleNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  EnsembleNoteColor[43]  = loadImage("Octave2GColor.png");
  EnsembleNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  EnsembleNoteColor[45]  = loadImage("Octave2AColor.png");
  EnsembleNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  EnsembleNoteColor[47]  = loadImage("Octave2BColor.png");
  EnsembleNoteColor[48]  = loadImage("Octave3CColor.png");
  EnsembleNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  EnsembleNoteColor[50]  = loadImage("Octave3DColor.png");
  EnsembleNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  EnsembleNoteColor[52]  = loadImage("Octave3EColor.png");
  EnsembleNoteColor[53]  = loadImage("Octave3FColor.png");
  EnsembleNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  EnsembleNoteColor[55]  = loadImage("Octave3GColor.png");
  EnsembleNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  EnsembleNoteColor[57]  = loadImage("Octave3AColor.png");
  EnsembleNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  EnsembleNoteColor[59]  = loadImage("Octave3BColor.png");
  EnsembleNoteColor[60]  = loadImage("Octave4CColor.png");
  EnsembleNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  EnsembleNoteColor[62]  = loadImage("Octave4DColor.png");
  EnsembleNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  EnsembleNoteColor[64]  = loadImage("Octave4EColor.png");
  EnsembleNoteColor[65]  = loadImage("Octave4FColor.png");
  EnsembleNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  EnsembleNoteColor[67]  = loadImage("Octave4GColor.png");
  EnsembleNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  EnsembleNoteColor[69]  = loadImage("Octave4AColor.png");
  EnsembleNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  EnsembleNoteColor[71]  = loadImage("Octave4BColor.png");
  EnsembleNoteColor[72]  = loadImage("Octave5CColor.png");
  EnsembleNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  EnsembleNoteColor[74]  = loadImage("Octave5DColor.png");
  EnsembleNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  EnsembleNoteColor[76]  = loadImage("Octave5EColor.png");
  EnsembleNoteColor[77]  = loadImage("Octave5FColor.png");
  EnsembleNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  EnsembleNoteColor[79]  = loadImage("Octave5GColor.png");
  EnsembleNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  EnsembleNoteColor[81]  = loadImage("Octave5AColor.png");
  EnsembleNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  EnsembleNoteColor[83]  = loadImage("Octave5BColor.png");
  EnsembleNoteColor[84]  = loadImage("Octave6CColor.png");
  EnsembleNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  EnsembleNoteColor[86]  = loadImage("Octave6DColor.png");
  EnsembleNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  EnsembleNoteColor[88]  = loadImage("Octave6EColor.png");
  EnsembleNoteColor[89]  = loadImage("Octave6FColor.png");
  EnsembleNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  EnsembleNoteColor[91]  = loadImage("Octave6GColor.png");
  EnsembleNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  EnsembleNoteColor[93]  = loadImage("Octave6AColor.png");
  EnsembleNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  EnsembleNoteColor[95]  = loadImage("Octave6BColor.png");
  EnsembleNoteColor[96]  = loadImage("Octave7CColor.png");
  EnsembleNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  EnsembleNoteColor[98]  = loadImage("Octave7DColor.png");
  EnsembleNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  EnsembleNoteColor[100] = loadImage("Octave7EColor.png");
  EnsembleNoteColor[101] = loadImage("Octave7FColor.png");
  EnsembleNoteColor[102] = loadImage("Octave7FSharpColor.png");
  EnsembleNoteColor[103] = loadImage("Octave7GColor.png");
  EnsembleNoteColor[104] = loadImage("Octave7GSharpColor.png");
  EnsembleNoteColor[105] = loadImage("Octave7AColor.png");
  EnsembleNoteColor[106] = loadImage("Octave7ASharpColor.png");
  EnsembleNoteColor[107] = loadImage("Octave7BColor.png");
  EnsembleNoteColor[108] = loadImage("Octave8CColor.png");
  EnsembleNoteColor[109] = loadImage("Octave8CSharpColor.png");
  EnsembleNoteColor[110] = loadImage("Octave8DColor.png");
  EnsembleNoteColor[111] = loadImage("Octave8DSharpColor.png");
  EnsembleNoteColor[112] = loadImage("Octave8EColor.png");
  EnsembleNoteColor[113] = loadImage("Octave8FColor.png");
  EnsembleNoteColor[114] = loadImage("Octave8FSharpColor.png");
  EnsembleNoteColor[115] = loadImage("Octave8GColor.png");
  EnsembleNoteColor[116] = loadImage("Octave8GSharpColor.png");
  EnsembleNoteColor[117] = loadImage("Octave8AColor.png");
  EnsembleNoteColor[118] = loadImage("Octave8ASharpColor.png");
  EnsembleNoteColor[119] = loadImage("Octave8BColor.png");
  EnsembleNoteColor[120] = loadImage("Octave9CColor.png");
  EnsembleNoteColor[121] = loadImage("Octave9CSharpColor.png");
  EnsembleNoteColor[122] = loadImage("Octave9DColor.png");
  EnsembleNoteColor[123] = loadImage("Octave9DSharpColor.png");
  EnsembleNoteColor[124] = loadImage("Octave9EColor.png");
  EnsembleNoteColor[125] = loadImage("Octave9FColor.png");
  EnsembleNoteColor[126] = loadImage("Octave9FSharpColor.png");
  EnsembleNoteColor[127] = loadImage("Octave9GColor.png");
  //Brass
  BrassNoteColor[0]   = loadImage("Octavem1CColor.png");
  BrassNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  BrassNoteColor[2]   = loadImage("Octavem1DColor.png");
  BrassNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  BrassNoteColor[4]   = loadImage("Octavem1EColor.png");
  BrassNoteColor[5]   = loadImage("Octavem1FColor.png");
  BrassNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  BrassNoteColor[7]   = loadImage("Octavem1GColor.png");
  BrassNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  BrassNoteColor[9]   = loadImage("Octavem1AColor.png");
  BrassNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  BrassNoteColor[11]  = loadImage("Octavem1BColor.png");
  BrassNoteColor[12]  = loadImage("Octave0CColor.png");
  BrassNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  BrassNoteColor[14]  = loadImage("Octave0DColor.png");
  BrassNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  BrassNoteColor[16]  = loadImage("Octave0EColor.png");
  BrassNoteColor[17]  = loadImage("Octave0FColor.png");
  BrassNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  BrassNoteColor[19]  = loadImage("Octave0GColor.png");
  BrassNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  BrassNoteColor[21]  = loadImage("Octave0AColor.png");
  BrassNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  BrassNoteColor[23]  = loadImage("Octave0BColor.png");
  BrassNoteColor[24]  = loadImage("Octave1CColor.png");
  BrassNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  BrassNoteColor[26]  = loadImage("Octave1DColor.png");
  BrassNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  BrassNoteColor[28]  = loadImage("Octave1EColor.png");
  BrassNoteColor[29]  = loadImage("Octave1FColor.png");
  BrassNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  BrassNoteColor[31]  = loadImage("Octave1GColor.png");
  BrassNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  BrassNoteColor[33]  = loadImage("Octave1AColor.png");
  BrassNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  BrassNoteColor[35]  = loadImage("Octave1BColor.png");
  BrassNoteColor[36]  = loadImage("Octave2CColor.png");
  BrassNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  BrassNoteColor[38]  = loadImage("Octave2DColor.png");
  BrassNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  BrassNoteColor[40]  = loadImage("Octave2EColor.png");
  BrassNoteColor[41]  = loadImage("Octave2FColor.png");
  BrassNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  BrassNoteColor[43]  = loadImage("Octave2GColor.png");
  BrassNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  BrassNoteColor[45]  = loadImage("Octave2AColor.png");
  BrassNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  BrassNoteColor[47]  = loadImage("Octave2BColor.png");
  BrassNoteColor[48]  = loadImage("Octave3CColor.png");
  BrassNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  BrassNoteColor[50]  = loadImage("Octave3DColor.png");
  BrassNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  BrassNoteColor[52]  = loadImage("Octave3EColor.png");
  BrassNoteColor[53]  = loadImage("Octave3FColor.png");
  BrassNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  BrassNoteColor[55]  = loadImage("Octave3GColor.png");
  BrassNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  BrassNoteColor[57]  = loadImage("Octave3AColor.png");
  BrassNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  BrassNoteColor[59]  = loadImage("Octave3BColor.png");
  BrassNoteColor[60]  = loadImage("Octave4CColor.png");
  BrassNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  BrassNoteColor[62]  = loadImage("Octave4DColor.png");
  BrassNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  BrassNoteColor[64]  = loadImage("Octave4EColor.png");
  BrassNoteColor[65]  = loadImage("Octave4FColor.png");
  BrassNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  BrassNoteColor[67]  = loadImage("Octave4GColor.png");
  BrassNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  BrassNoteColor[69]  = loadImage("Octave4AColor.png");
  BrassNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  BrassNoteColor[71]  = loadImage("Octave4BColor.png");
  BrassNoteColor[72]  = loadImage("Octave5CColor.png");
  BrassNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  BrassNoteColor[74]  = loadImage("Octave5DColor.png");
  BrassNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  BrassNoteColor[76]  = loadImage("Octave5EColor.png");
  BrassNoteColor[77]  = loadImage("Octave5FColor.png");
  BrassNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  BrassNoteColor[79]  = loadImage("Octave5GColor.png");
  BrassNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  BrassNoteColor[81]  = loadImage("Octave5AColor.png");
  BrassNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  BrassNoteColor[83]  = loadImage("Octave5BColor.png");
  BrassNoteColor[84]  = loadImage("Octave6CColor.png");
  BrassNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  BrassNoteColor[86]  = loadImage("Octave6DColor.png");
  BrassNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  BrassNoteColor[88]  = loadImage("Octave6EColor.png");
  BrassNoteColor[89]  = loadImage("Octave6FColor.png");
  BrassNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  BrassNoteColor[91]  = loadImage("Octave6GColor.png");
  BrassNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  BrassNoteColor[93]  = loadImage("Octave6AColor.png");
  BrassNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  BrassNoteColor[95]  = loadImage("Octave6BColor.png");
  BrassNoteColor[96]  = loadImage("Octave7CColor.png");
  BrassNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  BrassNoteColor[98]  = loadImage("Octave7DColor.png");
  BrassNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  BrassNoteColor[100] = loadImage("Octave7EColor.png");
  BrassNoteColor[101] = loadImage("Octave7FColor.png");
  BrassNoteColor[102] = loadImage("Octave7FSharpColor.png");
  BrassNoteColor[103] = loadImage("Octave7GColor.png");
  BrassNoteColor[104] = loadImage("Octave7GSharpColor.png");
  BrassNoteColor[105] = loadImage("Octave7AColor.png");
  BrassNoteColor[106] = loadImage("Octave7ASharpColor.png");
  BrassNoteColor[107] = loadImage("Octave7BColor.png");
  BrassNoteColor[108] = loadImage("Octave8CColor.png");
  BrassNoteColor[109] = loadImage("Octave8CSharpColor.png");
  BrassNoteColor[110] = loadImage("Octave8DColor.png");
  BrassNoteColor[111] = loadImage("Octave8DSharpColor.png");
  BrassNoteColor[112] = loadImage("Octave8EColor.png");
  BrassNoteColor[113] = loadImage("Octave8FColor.png");
  BrassNoteColor[114] = loadImage("Octave8FSharpColor.png");
  BrassNoteColor[115] = loadImage("Octave8GColor.png");
  BrassNoteColor[116] = loadImage("Octave8GSharpColor.png");
  BrassNoteColor[117] = loadImage("Octave8AColor.png");
  BrassNoteColor[118] = loadImage("Octave8ASharpColor.png");
  BrassNoteColor[119] = loadImage("Octave8BColor.png");
  BrassNoteColor[120] = loadImage("Octave9CColor.png");
  BrassNoteColor[121] = loadImage("Octave9CSharpColor.png");
  BrassNoteColor[122] = loadImage("Octave9DColor.png");
  BrassNoteColor[123] = loadImage("Octave9DSharpColor.png");
  BrassNoteColor[124] = loadImage("Octave9EColor.png");
  BrassNoteColor[125] = loadImage("Octave9FColor.png");
  BrassNoteColor[126] = loadImage("Octave9FSharpColor.png");
  BrassNoteColor[127] = loadImage("Octave9GColor.png");
  //Reed
  ReedNoteColor[0]   = loadImage("Octavem1CColor.png");
  ReedNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  ReedNoteColor[2]   = loadImage("Octavem1DColor.png");
  ReedNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  ReedNoteColor[4]   = loadImage("Octavem1EColor.png");
  ReedNoteColor[5]   = loadImage("Octavem1FColor.png");
  ReedNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  ReedNoteColor[7]   = loadImage("Octavem1GColor.png");
  ReedNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  ReedNoteColor[9]   = loadImage("Octavem1AColor.png");
  ReedNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  ReedNoteColor[11]  = loadImage("Octavem1BColor.png");
  ReedNoteColor[12]  = loadImage("Octave0CColor.png");
  ReedNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  ReedNoteColor[14]  = loadImage("Octave0DColor.png");
  ReedNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  ReedNoteColor[16]  = loadImage("Octave0EColor.png");
  ReedNoteColor[17]  = loadImage("Octave0FColor.png");
  ReedNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  ReedNoteColor[19]  = loadImage("Octave0GColor.png");
  ReedNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  ReedNoteColor[21]  = loadImage("Octave0AColor.png");
  ReedNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  ReedNoteColor[23]  = loadImage("Octave0BColor.png");
  ReedNoteColor[24]  = loadImage("Octave1CColor.png");
  ReedNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  ReedNoteColor[26]  = loadImage("Octave1DColor.png");
  ReedNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  ReedNoteColor[28]  = loadImage("Octave1EColor.png");
  ReedNoteColor[29]  = loadImage("Octave1FColor.png");
  ReedNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  ReedNoteColor[31]  = loadImage("Octave1GColor.png");
  ReedNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  ReedNoteColor[33]  = loadImage("Octave1AColor.png");
  ReedNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  ReedNoteColor[35]  = loadImage("Octave1BColor.png");
  ReedNoteColor[36]  = loadImage("Octave2CColor.png");
  ReedNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  ReedNoteColor[38]  = loadImage("Octave2DColor.png");
  ReedNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  ReedNoteColor[40]  = loadImage("Octave2EColor.png");
  ReedNoteColor[41]  = loadImage("Octave2FColor.png");
  ReedNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  ReedNoteColor[43]  = loadImage("Octave2GColor.png");
  ReedNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  ReedNoteColor[45]  = loadImage("Octave2AColor.png");
  ReedNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  ReedNoteColor[47]  = loadImage("Octave2BColor.png");
  ReedNoteColor[48]  = loadImage("Octave3CColor.png");
  ReedNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  ReedNoteColor[50]  = loadImage("Octave3DColor.png");
  ReedNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  ReedNoteColor[52]  = loadImage("Octave3EColor.png");
  ReedNoteColor[53]  = loadImage("Octave3FColor.png");
  ReedNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  ReedNoteColor[55]  = loadImage("Octave3GColor.png");
  ReedNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  ReedNoteColor[57]  = loadImage("Octave3AColor.png");
  ReedNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  ReedNoteColor[59]  = loadImage("Octave3BColor.png");
  ReedNoteColor[60]  = loadImage("Octave4CColor.png");
  ReedNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  ReedNoteColor[62]  = loadImage("Octave4DColor.png");
  ReedNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  ReedNoteColor[64]  = loadImage("Octave4EColor.png");
  ReedNoteColor[65]  = loadImage("Octave4FColor.png");
  ReedNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  ReedNoteColor[67]  = loadImage("Octave4GColor.png");
  ReedNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  ReedNoteColor[69]  = loadImage("Octave4AColor.png");
  ReedNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  ReedNoteColor[71]  = loadImage("Octave4BColor.png");
  ReedNoteColor[72]  = loadImage("Octave5CColor.png");
  ReedNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  ReedNoteColor[74]  = loadImage("Octave5DColor.png");
  ReedNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  ReedNoteColor[76]  = loadImage("Octave5EColor.png");
  ReedNoteColor[77]  = loadImage("Octave5FColor.png");
  ReedNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  ReedNoteColor[79]  = loadImage("Octave5GColor.png");
  ReedNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  ReedNoteColor[81]  = loadImage("Octave5AColor.png");
  ReedNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  ReedNoteColor[83]  = loadImage("Octave5BColor.png");
  ReedNoteColor[84]  = loadImage("Octave6CColor.png");
  ReedNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  ReedNoteColor[86]  = loadImage("Octave6DColor.png");
  ReedNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  ReedNoteColor[88]  = loadImage("Octave6EColor.png");
  ReedNoteColor[89]  = loadImage("Octave6FColor.png");
  ReedNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  ReedNoteColor[91]  = loadImage("Octave6GColor.png");
  ReedNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  ReedNoteColor[93]  = loadImage("Octave6AColor.png");
  ReedNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  ReedNoteColor[95]  = loadImage("Octave6BColor.png");
  ReedNoteColor[96]  = loadImage("Octave7CColor.png");
  ReedNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  ReedNoteColor[98]  = loadImage("Octave7DColor.png");
  ReedNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  ReedNoteColor[100] = loadImage("Octave7EColor.png");
  ReedNoteColor[101] = loadImage("Octave7FColor.png");
  ReedNoteColor[102] = loadImage("Octave7FSharpColor.png");
  ReedNoteColor[103] = loadImage("Octave7GColor.png");
  ReedNoteColor[104] = loadImage("Octave7GSharpColor.png");
  ReedNoteColor[105] = loadImage("Octave7AColor.png");
  ReedNoteColor[106] = loadImage("Octave7ASharpColor.png");
  ReedNoteColor[107] = loadImage("Octave7BColor.png");
  ReedNoteColor[108] = loadImage("Octave8CColor.png");
  ReedNoteColor[109] = loadImage("Octave8CSharpColor.png");
  ReedNoteColor[110] = loadImage("Octave8DColor.png");
  ReedNoteColor[111] = loadImage("Octave8DSharpColor.png");
  ReedNoteColor[112] = loadImage("Octave8EColor.png");
  ReedNoteColor[113] = loadImage("Octave8FColor.png");
  ReedNoteColor[114] = loadImage("Octave8FSharpColor.png");
  ReedNoteColor[115] = loadImage("Octave8GColor.png");
  ReedNoteColor[116] = loadImage("Octave8GSharpColor.png");
  ReedNoteColor[117] = loadImage("Octave8AColor.png");
  ReedNoteColor[118] = loadImage("Octave8ASharpColor.png");
  ReedNoteColor[119] = loadImage("Octave8BColor.png");
  ReedNoteColor[120] = loadImage("Octave9CColor.png");
  ReedNoteColor[121] = loadImage("Octave9CSharpColor.png");
  ReedNoteColor[122] = loadImage("Octave9DColor.png");
  ReedNoteColor[123] = loadImage("Octave9DSharpColor.png");
  ReedNoteColor[124] = loadImage("Octave9EColor.png");
  ReedNoteColor[125] = loadImage("Octave9FColor.png");
  ReedNoteColor[126] = loadImage("Octave9FSharpColor.png");
  ReedNoteColor[127] = loadImage("Octave9GColor.png");
  //Pipe
  PipeNoteColor[0]   = loadImage("Octavem1CColor.png");
  PipeNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  PipeNoteColor[2]   = loadImage("Octavem1DColor.png");
  PipeNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  PipeNoteColor[4]   = loadImage("Octavem1EColor.png");
  PipeNoteColor[5]   = loadImage("Octavem1FColor.png");
  PipeNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  PipeNoteColor[7]   = loadImage("Octavem1GColor.png");
  PipeNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  PipeNoteColor[9]   = loadImage("Octavem1AColor.png");
  PipeNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  PipeNoteColor[11]  = loadImage("Octavem1BColor.png");
  PipeNoteColor[12]  = loadImage("Octave0CColor.png");
  PipeNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  PipeNoteColor[14]  = loadImage("Octave0DColor.png");
  PipeNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  PipeNoteColor[16]  = loadImage("Octave0EColor.png");
  PipeNoteColor[17]  = loadImage("Octave0FColor.png");
  PipeNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  PipeNoteColor[19]  = loadImage("Octave0GColor.png");
  PipeNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  PipeNoteColor[21]  = loadImage("Octave0AColor.png");
  PipeNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  PipeNoteColor[23]  = loadImage("Octave0BColor.png");
  PipeNoteColor[24]  = loadImage("Octave1CColor.png");
  PipeNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  PipeNoteColor[26]  = loadImage("Octave1DColor.png");
  PipeNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  PipeNoteColor[28]  = loadImage("Octave1EColor.png");
  PipeNoteColor[29]  = loadImage("Octave1FColor.png");
  PipeNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  PipeNoteColor[31]  = loadImage("Octave1GColor.png");
  PipeNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  PipeNoteColor[33]  = loadImage("Octave1AColor.png");
  PipeNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  PipeNoteColor[35]  = loadImage("Octave1BColor.png");
  PipeNoteColor[36]  = loadImage("Octave2CColor.png");
  PipeNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  PipeNoteColor[38]  = loadImage("Octave2DColor.png");
  PipeNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  PipeNoteColor[40]  = loadImage("Octave2EColor.png");
  PipeNoteColor[41]  = loadImage("Octave2FColor.png");
  PipeNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  PipeNoteColor[43]  = loadImage("Octave2GColor.png");
  PipeNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  PipeNoteColor[45]  = loadImage("Octave2AColor.png");
  PipeNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  PipeNoteColor[47]  = loadImage("Octave2BColor.png");
  PipeNoteColor[48]  = loadImage("Octave3CColor.png");
  PipeNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  PipeNoteColor[50]  = loadImage("Octave3DColor.png");
  PipeNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  PipeNoteColor[52]  = loadImage("Octave3EColor.png");
  PipeNoteColor[53]  = loadImage("Octave3FColor.png");
  PipeNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  PipeNoteColor[55]  = loadImage("Octave3GColor.png");
  PipeNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  PipeNoteColor[57]  = loadImage("Octave3AColor.png");
  PipeNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  PipeNoteColor[59]  = loadImage("Octave3BColor.png");
  PipeNoteColor[60]  = loadImage("Octave4CColor.png");
  PipeNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  PipeNoteColor[62]  = loadImage("Octave4DColor.png");
  PipeNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  PipeNoteColor[64]  = loadImage("Octave4EColor.png");
  PipeNoteColor[65]  = loadImage("Octave4FColor.png");
  PipeNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  PipeNoteColor[67]  = loadImage("Octave4GColor.png");
  PipeNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  PipeNoteColor[69]  = loadImage("Octave4AColor.png");
  PipeNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  PipeNoteColor[71]  = loadImage("Octave4BColor.png");
  PipeNoteColor[72]  = loadImage("Octave5CColor.png");
  PipeNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  PipeNoteColor[74]  = loadImage("Octave5DColor.png");
  PipeNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  PipeNoteColor[76]  = loadImage("Octave5EColor.png");
  PipeNoteColor[77]  = loadImage("Octave5FColor.png");
  PipeNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  PipeNoteColor[79]  = loadImage("Octave5GColor.png");
  PipeNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  PipeNoteColor[81]  = loadImage("Octave5AColor.png");
  PipeNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  PipeNoteColor[83]  = loadImage("Octave5BColor.png");
  PipeNoteColor[84]  = loadImage("Octave6CColor.png");
  PipeNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  PipeNoteColor[86]  = loadImage("Octave6DColor.png");
  PipeNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  PipeNoteColor[88]  = loadImage("Octave6EColor.png");
  PipeNoteColor[89]  = loadImage("Octave6FColor.png");
  PipeNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  PipeNoteColor[91]  = loadImage("Octave6GColor.png");
  PipeNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  PipeNoteColor[93]  = loadImage("Octave6AColor.png");
  PipeNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  PipeNoteColor[95]  = loadImage("Octave6BColor.png");
  PipeNoteColor[96]  = loadImage("Octave7CColor.png");
  PipeNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  PipeNoteColor[98]  = loadImage("Octave7DColor.png");
  PipeNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  PipeNoteColor[100] = loadImage("Octave7EColor.png");
  PipeNoteColor[101] = loadImage("Octave7FColor.png");
  PipeNoteColor[102] = loadImage("Octave7FSharpColor.png");
  PipeNoteColor[103] = loadImage("Octave7GColor.png");
  PipeNoteColor[104] = loadImage("Octave7GSharpColor.png");
  PipeNoteColor[105] = loadImage("Octave7AColor.png");
  PipeNoteColor[106] = loadImage("Octave7ASharpColor.png");
  PipeNoteColor[107] = loadImage("Octave7BColor.png");
  PipeNoteColor[108] = loadImage("Octave8CColor.png");
  PipeNoteColor[109] = loadImage("Octave8CSharpColor.png");
  PipeNoteColor[110] = loadImage("Octave8DColor.png");
  PipeNoteColor[111] = loadImage("Octave8DSharpColor.png");
  PipeNoteColor[112] = loadImage("Octave8EColor.png");
  PipeNoteColor[113] = loadImage("Octave8FColor.png");
  PipeNoteColor[114] = loadImage("Octave8FSharpColor.png");
  PipeNoteColor[115] = loadImage("Octave8GColor.png");
  PipeNoteColor[116] = loadImage("Octave8GSharpColor.png");
  PipeNoteColor[117] = loadImage("Octave8AColor.png");
  PipeNoteColor[118] = loadImage("Octave8ASharpColor.png");
  PipeNoteColor[119] = loadImage("Octave8BColor.png");
  PipeNoteColor[120] = loadImage("Octave9CColor.png");
  PipeNoteColor[121] = loadImage("Octave9CSharpColor.png");
  PipeNoteColor[122] = loadImage("Octave9DColor.png");
  PipeNoteColor[123] = loadImage("Octave9DSharpColor.png");
  PipeNoteColor[124] = loadImage("Octave9EColor.png");
  PipeNoteColor[125] = loadImage("Octave9FColor.png");
  PipeNoteColor[126] = loadImage("Octave9FSharpColor.png");
  PipeNoteColor[127] = loadImage("Octave9GColor.png");
  //Synth Lead
  SynthLeadNoteColor[0]   = loadImage("Octavem1CColor.png");
  SynthLeadNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  SynthLeadNoteColor[2]   = loadImage("Octavem1DColor.png");
  SynthLeadNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  SynthLeadNoteColor[4]   = loadImage("Octavem1EColor.png");
  SynthLeadNoteColor[5]   = loadImage("Octavem1FColor.png");
  SynthLeadNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  SynthLeadNoteColor[7]   = loadImage("Octavem1GColor.png");
  SynthLeadNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  SynthLeadNoteColor[9]   = loadImage("Octavem1AColor.png");
  SynthLeadNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  SynthLeadNoteColor[11]  = loadImage("Octavem1BColor.png");
  SynthLeadNoteColor[12]  = loadImage("Octave0CColor.png");
  SynthLeadNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  SynthLeadNoteColor[14]  = loadImage("Octave0DColor.png");
  SynthLeadNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  SynthLeadNoteColor[16]  = loadImage("Octave0EColor.png");
  SynthLeadNoteColor[17]  = loadImage("Octave0FColor.png");
  SynthLeadNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  SynthLeadNoteColor[19]  = loadImage("Octave0GColor.png");
  SynthLeadNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  SynthLeadNoteColor[21]  = loadImage("Octave0AColor.png");
  SynthLeadNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  SynthLeadNoteColor[23]  = loadImage("Octave0BColor.png");
  SynthLeadNoteColor[24]  = loadImage("Octave1CColor.png");
  SynthLeadNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  SynthLeadNoteColor[26]  = loadImage("Octave1DColor.png");
  SynthLeadNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  SynthLeadNoteColor[28]  = loadImage("Octave1EColor.png");
  SynthLeadNoteColor[29]  = loadImage("Octave1FColor.png");
  SynthLeadNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  SynthLeadNoteColor[31]  = loadImage("Octave1GColor.png");
  SynthLeadNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  SynthLeadNoteColor[33]  = loadImage("Octave1AColor.png");
  SynthLeadNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  SynthLeadNoteColor[35]  = loadImage("Octave1BColor.png");
  SynthLeadNoteColor[36]  = loadImage("Octave2CColor.png");
  SynthLeadNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  SynthLeadNoteColor[38]  = loadImage("Octave2DColor.png");
  SynthLeadNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  SynthLeadNoteColor[40]  = loadImage("Octave2EColor.png");
  SynthLeadNoteColor[41]  = loadImage("Octave2FColor.png");
  SynthLeadNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  SynthLeadNoteColor[43]  = loadImage("Octave2GColor.png");
  SynthLeadNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  SynthLeadNoteColor[45]  = loadImage("Octave2AColor.png");
  SynthLeadNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  SynthLeadNoteColor[47]  = loadImage("Octave2BColor.png");
  SynthLeadNoteColor[48]  = loadImage("Octave3CColor.png");
  SynthLeadNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  SynthLeadNoteColor[50]  = loadImage("Octave3DColor.png");
  SynthLeadNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  SynthLeadNoteColor[52]  = loadImage("Octave3EColor.png");
  SynthLeadNoteColor[53]  = loadImage("Octave3FColor.png");
  SynthLeadNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  SynthLeadNoteColor[55]  = loadImage("Octave3GColor.png");
  SynthLeadNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  SynthLeadNoteColor[57]  = loadImage("Octave3AColor.png");
  SynthLeadNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  SynthLeadNoteColor[59]  = loadImage("Octave3BColor.png");
  SynthLeadNoteColor[60]  = loadImage("Octave4CColor.png");
  SynthLeadNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  SynthLeadNoteColor[62]  = loadImage("Octave4DColor.png");
  SynthLeadNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  SynthLeadNoteColor[64]  = loadImage("Octave4EColor.png");
  SynthLeadNoteColor[65]  = loadImage("Octave4FColor.png");
  SynthLeadNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  SynthLeadNoteColor[67]  = loadImage("Octave4GColor.png");
  SynthLeadNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  SynthLeadNoteColor[69]  = loadImage("Octave4AColor.png");
  SynthLeadNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  SynthLeadNoteColor[71]  = loadImage("Octave4BColor.png");
  SynthLeadNoteColor[72]  = loadImage("Octave5CColor.png");
  SynthLeadNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  SynthLeadNoteColor[74]  = loadImage("Octave5DColor.png");
  SynthLeadNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  SynthLeadNoteColor[76]  = loadImage("Octave5EColor.png");
  SynthLeadNoteColor[77]  = loadImage("Octave5FColor.png");
  SynthLeadNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  SynthLeadNoteColor[79]  = loadImage("Octave5GColor.png");
  SynthLeadNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  SynthLeadNoteColor[81]  = loadImage("Octave5AColor.png");
  SynthLeadNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  SynthLeadNoteColor[83]  = loadImage("Octave5BColor.png");
  SynthLeadNoteColor[84]  = loadImage("Octave6CColor.png");
  SynthLeadNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  SynthLeadNoteColor[86]  = loadImage("Octave6DColor.png");
  SynthLeadNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  SynthLeadNoteColor[88]  = loadImage("Octave6EColor.png");
  SynthLeadNoteColor[89]  = loadImage("Octave6FColor.png");
  SynthLeadNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  SynthLeadNoteColor[91]  = loadImage("Octave6GColor.png");
  SynthLeadNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  SynthLeadNoteColor[93]  = loadImage("Octave6AColor.png");
  SynthLeadNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  SynthLeadNoteColor[95]  = loadImage("Octave6BColor.png");
  SynthLeadNoteColor[96]  = loadImage("Octave7CColor.png");
  SynthLeadNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  SynthLeadNoteColor[98]  = loadImage("Octave7DColor.png");
  SynthLeadNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  SynthLeadNoteColor[100] = loadImage("Octave7EColor.png");
  SynthLeadNoteColor[101] = loadImage("Octave7FColor.png");
  SynthLeadNoteColor[102] = loadImage("Octave7FSharpColor.png");
  SynthLeadNoteColor[103] = loadImage("Octave7GColor.png");
  SynthLeadNoteColor[104] = loadImage("Octave7GSharpColor.png");
  SynthLeadNoteColor[105] = loadImage("Octave7AColor.png");
  SynthLeadNoteColor[106] = loadImage("Octave7ASharpColor.png");
  SynthLeadNoteColor[107] = loadImage("Octave7BColor.png");
  SynthLeadNoteColor[108] = loadImage("Octave8CColor.png");
  SynthLeadNoteColor[109] = loadImage("Octave8CSharpColor.png");
  SynthLeadNoteColor[110] = loadImage("Octave8DColor.png");
  SynthLeadNoteColor[111] = loadImage("Octave8DSharpColor.png");
  SynthLeadNoteColor[112] = loadImage("Octave8EColor.png");
  SynthLeadNoteColor[113] = loadImage("Octave8FColor.png");
  SynthLeadNoteColor[114] = loadImage("Octave8FSharpColor.png");
  SynthLeadNoteColor[115] = loadImage("Octave8GColor.png");
  SynthLeadNoteColor[116] = loadImage("Octave8GSharpColor.png");
  SynthLeadNoteColor[117] = loadImage("Octave8AColor.png");
  SynthLeadNoteColor[118] = loadImage("Octave8ASharpColor.png");
  SynthLeadNoteColor[119] = loadImage("Octave8BColor.png");
  SynthLeadNoteColor[120] = loadImage("Octave9CColor.png");
  SynthLeadNoteColor[121] = loadImage("Octave9CSharpColor.png");
  SynthLeadNoteColor[122] = loadImage("Octave9DColor.png");
  SynthLeadNoteColor[123] = loadImage("Octave9DSharpColor.png");
  SynthLeadNoteColor[124] = loadImage("Octave9EColor.png");
  SynthLeadNoteColor[125] = loadImage("Octave9FColor.png");
  SynthLeadNoteColor[126] = loadImage("Octave9FSharpColor.png");
  SynthLeadNoteColor[127] = loadImage("Octave9GColor.png");
  //Synth Pad
  SynthPadNoteColor[0]   = loadImage("Octavem1CColor.png");
  SynthPadNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  SynthPadNoteColor[2]   = loadImage("Octavem1DColor.png");
  SynthPadNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  SynthPadNoteColor[4]   = loadImage("Octavem1EColor.png");
  SynthPadNoteColor[5]   = loadImage("Octavem1FColor.png");
  SynthPadNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  SynthPadNoteColor[7]   = loadImage("Octavem1GColor.png");
  SynthPadNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  SynthPadNoteColor[9]   = loadImage("Octavem1AColor.png");
  SynthPadNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  SynthPadNoteColor[11]  = loadImage("Octavem1BColor.png");
  SynthPadNoteColor[12]  = loadImage("Octave0CColor.png");
  SynthPadNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  SynthPadNoteColor[14]  = loadImage("Octave0DColor.png");
  SynthPadNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  SynthPadNoteColor[16]  = loadImage("Octave0EColor.png");
  SynthPadNoteColor[17]  = loadImage("Octave0FColor.png");
  SynthPadNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  SynthPadNoteColor[19]  = loadImage("Octave0GColor.png");
  SynthPadNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  SynthPadNoteColor[21]  = loadImage("Octave0AColor.png");
  SynthPadNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  SynthPadNoteColor[23]  = loadImage("Octave0BColor.png");
  SynthPadNoteColor[24]  = loadImage("Octave1CColor.png");
  SynthPadNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  SynthPadNoteColor[26]  = loadImage("Octave1DColor.png");
  SynthPadNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  SynthPadNoteColor[28]  = loadImage("Octave1EColor.png");
  SynthPadNoteColor[29]  = loadImage("Octave1FColor.png");
  SynthPadNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  SynthPadNoteColor[31]  = loadImage("Octave1GColor.png");
  SynthPadNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  SynthPadNoteColor[33]  = loadImage("Octave1AColor.png");
  SynthPadNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  SynthPadNoteColor[35]  = loadImage("Octave1BColor.png");
  SynthPadNoteColor[36]  = loadImage("Octave2CColor.png");
  SynthPadNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  SynthPadNoteColor[38]  = loadImage("Octave2DColor.png");
  SynthPadNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  SynthPadNoteColor[40]  = loadImage("Octave2EColor.png");
  SynthPadNoteColor[41]  = loadImage("Octave2FColor.png");
  SynthPadNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  SynthPadNoteColor[43]  = loadImage("Octave2GColor.png");
  SynthPadNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  SynthPadNoteColor[45]  = loadImage("Octave2AColor.png");
  SynthPadNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  SynthPadNoteColor[47]  = loadImage("Octave2BColor.png");
  SynthPadNoteColor[48]  = loadImage("Octave3CColor.png");
  SynthPadNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  SynthPadNoteColor[50]  = loadImage("Octave3DColor.png");
  SynthPadNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  SynthPadNoteColor[52]  = loadImage("Octave3EColor.png");
  SynthPadNoteColor[53]  = loadImage("Octave3FColor.png");
  SynthPadNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  SynthPadNoteColor[55]  = loadImage("Octave3GColor.png");
  SynthPadNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  SynthPadNoteColor[57]  = loadImage("Octave3AColor.png");
  SynthPadNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  SynthPadNoteColor[59]  = loadImage("Octave3BColor.png");
  SynthPadNoteColor[60]  = loadImage("Octave4CColor.png");
  SynthPadNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  SynthPadNoteColor[62]  = loadImage("Octave4DColor.png");
  SynthPadNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  SynthPadNoteColor[64]  = loadImage("Octave4EColor.png");
  SynthPadNoteColor[65]  = loadImage("Octave4FColor.png");
  SynthPadNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  SynthPadNoteColor[67]  = loadImage("Octave4GColor.png");
  SynthPadNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  SynthPadNoteColor[69]  = loadImage("Octave4AColor.png");
  SynthPadNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  SynthPadNoteColor[71]  = loadImage("Octave4BColor.png");
  SynthPadNoteColor[72]  = loadImage("Octave5CColor.png");
  SynthPadNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  SynthPadNoteColor[74]  = loadImage("Octave5DColor.png");
  SynthPadNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  SynthPadNoteColor[76]  = loadImage("Octave5EColor.png");
  SynthPadNoteColor[77]  = loadImage("Octave5FColor.png");
  SynthPadNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  SynthPadNoteColor[79]  = loadImage("Octave5GColor.png");
  SynthPadNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  SynthPadNoteColor[81]  = loadImage("Octave5AColor.png");
  SynthPadNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  SynthPadNoteColor[83]  = loadImage("Octave5BColor.png");
  SynthPadNoteColor[84]  = loadImage("Octave6CColor.png");
  SynthPadNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  SynthPadNoteColor[86]  = loadImage("Octave6DColor.png");
  SynthPadNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  SynthPadNoteColor[88]  = loadImage("Octave6EColor.png");
  SynthPadNoteColor[89]  = loadImage("Octave6FColor.png");
  SynthPadNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  SynthPadNoteColor[91]  = loadImage("Octave6GColor.png");
  SynthPadNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  SynthPadNoteColor[93]  = loadImage("Octave6AColor.png");
  SynthPadNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  SynthPadNoteColor[95]  = loadImage("Octave6BColor.png");
  SynthPadNoteColor[96]  = loadImage("Octave7CColor.png");
  SynthPadNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  SynthPadNoteColor[98]  = loadImage("Octave7DColor.png");
  SynthPadNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  SynthPadNoteColor[100] = loadImage("Octave7EColor.png");
  SynthPadNoteColor[101] = loadImage("Octave7FColor.png");
  SynthPadNoteColor[102] = loadImage("Octave7FSharpColor.png");
  SynthPadNoteColor[103] = loadImage("Octave7GColor.png");
  SynthPadNoteColor[104] = loadImage("Octave7GSharpColor.png");
  SynthPadNoteColor[105] = loadImage("Octave7AColor.png");
  SynthPadNoteColor[106] = loadImage("Octave7ASharpColor.png");
  SynthPadNoteColor[107] = loadImage("Octave7BColor.png");
  SynthPadNoteColor[108] = loadImage("Octave8CColor.png");
  SynthPadNoteColor[109] = loadImage("Octave8CSharpColor.png");
  SynthPadNoteColor[110] = loadImage("Octave8DColor.png");
  SynthPadNoteColor[111] = loadImage("Octave8DSharpColor.png");
  SynthPadNoteColor[112] = loadImage("Octave8EColor.png");
  SynthPadNoteColor[113] = loadImage("Octave8FColor.png");
  SynthPadNoteColor[114] = loadImage("Octave8FSharpColor.png");
  SynthPadNoteColor[115] = loadImage("Octave8GColor.png");
  SynthPadNoteColor[116] = loadImage("Octave8GSharpColor.png");
  SynthPadNoteColor[117] = loadImage("Octave8AColor.png");
  SynthPadNoteColor[118] = loadImage("Octave8ASharpColor.png");
  SynthPadNoteColor[119] = loadImage("Octave8BColor.png");
  SynthPadNoteColor[120] = loadImage("Octave9CColor.png");
  SynthPadNoteColor[121] = loadImage("Octave9CSharpColor.png");
  SynthPadNoteColor[122] = loadImage("Octave9DColor.png");
  SynthPadNoteColor[123] = loadImage("Octave9DSharpColor.png");
  SynthPadNoteColor[124] = loadImage("Octave9EColor.png");
  SynthPadNoteColor[125] = loadImage("Octave9FColor.png");
  SynthPadNoteColor[126] = loadImage("Octave9FSharpColor.png");
  SynthPadNoteColor[127] = loadImage("Octave9GColor.png");
  //Synth Effects
  SynthEffectsNoteColor[0]   = loadImage("Octavem1CColor.png");
  SynthEffectsNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  SynthEffectsNoteColor[2]   = loadImage("Octavem1DColor.png");
  SynthEffectsNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  SynthEffectsNoteColor[4]   = loadImage("Octavem1EColor.png");
  SynthEffectsNoteColor[5]   = loadImage("Octavem1FColor.png");
  SynthEffectsNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  SynthEffectsNoteColor[7]   = loadImage("Octavem1GColor.png");
  SynthEffectsNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  SynthEffectsNoteColor[9]   = loadImage("Octavem1AColor.png");
  SynthEffectsNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  SynthEffectsNoteColor[11]  = loadImage("Octavem1BColor.png");
  SynthEffectsNoteColor[12]  = loadImage("Octave0CColor.png");
  SynthEffectsNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  SynthEffectsNoteColor[14]  = loadImage("Octave0DColor.png");
  SynthEffectsNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  SynthEffectsNoteColor[16]  = loadImage("Octave0EColor.png");
  SynthEffectsNoteColor[17]  = loadImage("Octave0FColor.png");
  SynthEffectsNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  SynthEffectsNoteColor[19]  = loadImage("Octave0GColor.png");
  SynthEffectsNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  SynthEffectsNoteColor[21]  = loadImage("Octave0AColor.png");
  SynthEffectsNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  SynthEffectsNoteColor[23]  = loadImage("Octave0BColor.png");
  SynthEffectsNoteColor[24]  = loadImage("Octave1CColor.png");
  SynthEffectsNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  SynthEffectsNoteColor[26]  = loadImage("Octave1DColor.png");
  SynthEffectsNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  SynthEffectsNoteColor[28]  = loadImage("Octave1EColor.png");
  SynthEffectsNoteColor[29]  = loadImage("Octave1FColor.png");
  SynthEffectsNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  SynthEffectsNoteColor[31]  = loadImage("Octave1GColor.png");
  SynthEffectsNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  SynthEffectsNoteColor[33]  = loadImage("Octave1AColor.png");
  SynthEffectsNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  SynthEffectsNoteColor[35]  = loadImage("Octave1BColor.png");
  SynthEffectsNoteColor[36]  = loadImage("Octave2CColor.png");
  SynthEffectsNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  SynthEffectsNoteColor[38]  = loadImage("Octave2DColor.png");
  SynthEffectsNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  SynthEffectsNoteColor[40]  = loadImage("Octave2EColor.png");
  SynthEffectsNoteColor[41]  = loadImage("Octave2FColor.png");
  SynthEffectsNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  SynthEffectsNoteColor[43]  = loadImage("Octave2GColor.png");
  SynthEffectsNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  SynthEffectsNoteColor[45]  = loadImage("Octave2AColor.png");
  SynthEffectsNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  SynthEffectsNoteColor[47]  = loadImage("Octave2BColor.png");
  SynthEffectsNoteColor[48]  = loadImage("Octave3CColor.png");
  SynthEffectsNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  SynthEffectsNoteColor[50]  = loadImage("Octave3DColor.png");
  SynthEffectsNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  SynthEffectsNoteColor[52]  = loadImage("Octave3EColor.png");
  SynthEffectsNoteColor[53]  = loadImage("Octave3FColor.png");
  SynthEffectsNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  SynthEffectsNoteColor[55]  = loadImage("Octave3GColor.png");
  SynthEffectsNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  SynthEffectsNoteColor[57]  = loadImage("Octave3AColor.png");
  SynthEffectsNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  SynthEffectsNoteColor[59]  = loadImage("Octave3BColor.png");
  SynthEffectsNoteColor[60]  = loadImage("Octave4CColor.png");
  SynthEffectsNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  SynthEffectsNoteColor[62]  = loadImage("Octave4DColor.png");
  SynthEffectsNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  SynthEffectsNoteColor[64]  = loadImage("Octave4EColor.png");
  SynthEffectsNoteColor[65]  = loadImage("Octave4FColor.png");
  SynthEffectsNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  SynthEffectsNoteColor[67]  = loadImage("Octave4GColor.png");
  SynthEffectsNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  SynthEffectsNoteColor[69]  = loadImage("Octave4AColor.png");
  SynthEffectsNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  SynthEffectsNoteColor[71]  = loadImage("Octave4BColor.png");
  SynthEffectsNoteColor[72]  = loadImage("Octave5CColor.png");
  SynthEffectsNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  SynthEffectsNoteColor[74]  = loadImage("Octave5DColor.png");
  SynthEffectsNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  SynthEffectsNoteColor[76]  = loadImage("Octave5EColor.png");
  SynthEffectsNoteColor[77]  = loadImage("Octave5FColor.png");
  SynthEffectsNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  SynthEffectsNoteColor[79]  = loadImage("Octave5GColor.png");
  SynthEffectsNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  SynthEffectsNoteColor[81]  = loadImage("Octave5AColor.png");
  SynthEffectsNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  SynthEffectsNoteColor[83]  = loadImage("Octave5BColor.png");
  SynthEffectsNoteColor[84]  = loadImage("Octave6CColor.png");
  SynthEffectsNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  SynthEffectsNoteColor[86]  = loadImage("Octave6DColor.png");
  SynthEffectsNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  SynthEffectsNoteColor[88]  = loadImage("Octave6EColor.png");
  SynthEffectsNoteColor[89]  = loadImage("Octave6FColor.png");
  SynthEffectsNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  SynthEffectsNoteColor[91]  = loadImage("Octave6GColor.png");
  SynthEffectsNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  SynthEffectsNoteColor[93]  = loadImage("Octave6AColor.png");
  SynthEffectsNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  SynthEffectsNoteColor[95]  = loadImage("Octave6BColor.png");
  SynthEffectsNoteColor[96]  = loadImage("Octave7CColor.png");
  SynthEffectsNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  SynthEffectsNoteColor[98]  = loadImage("Octave7DColor.png");
  SynthEffectsNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  SynthEffectsNoteColor[100] = loadImage("Octave7EColor.png");
  SynthEffectsNoteColor[101] = loadImage("Octave7FColor.png");
  SynthEffectsNoteColor[102] = loadImage("Octave7FSharpColor.png");
  SynthEffectsNoteColor[103] = loadImage("Octave7GColor.png");
  SynthEffectsNoteColor[104] = loadImage("Octave7GSharpColor.png");
  SynthEffectsNoteColor[105] = loadImage("Octave7AColor.png");
  SynthEffectsNoteColor[106] = loadImage("Octave7ASharpColor.png");
  SynthEffectsNoteColor[107] = loadImage("Octave7BColor.png");
  SynthEffectsNoteColor[108] = loadImage("Octave8CColor.png");
  SynthEffectsNoteColor[109] = loadImage("Octave8CSharpColor.png");
  SynthEffectsNoteColor[110] = loadImage("Octave8DColor.png");
  SynthEffectsNoteColor[111] = loadImage("Octave8DSharpColor.png");
  SynthEffectsNoteColor[112] = loadImage("Octave8EColor.png");
  SynthEffectsNoteColor[113] = loadImage("Octave8FColor.png");
  SynthEffectsNoteColor[114] = loadImage("Octave8FSharpColor.png");
  SynthEffectsNoteColor[115] = loadImage("Octave8GColor.png");
  SynthEffectsNoteColor[116] = loadImage("Octave8GSharpColor.png");
  SynthEffectsNoteColor[117] = loadImage("Octave8AColor.png");
  SynthEffectsNoteColor[118] = loadImage("Octave8ASharpColor.png");
  SynthEffectsNoteColor[119] = loadImage("Octave8BColor.png");
  SynthEffectsNoteColor[120] = loadImage("Octave9CColor.png");
  SynthEffectsNoteColor[121] = loadImage("Octave9CSharpColor.png");
  SynthEffectsNoteColor[122] = loadImage("Octave9DColor.png");
  SynthEffectsNoteColor[123] = loadImage("Octave9DSharpColor.png");
  SynthEffectsNoteColor[124] = loadImage("Octave9EColor.png");
  SynthEffectsNoteColor[125] = loadImage("Octave9FColor.png");
  SynthEffectsNoteColor[126] = loadImage("Octave9FSharpColor.png");
  SynthEffectsNoteColor[127] = loadImage("Octave9GColor.png");
  //Ethnic
  EthnicNoteColor[0]   = loadImage("Octavem1CColor.png");
  EthnicNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  EthnicNoteColor[2]   = loadImage("Octavem1DColor.png");
  EthnicNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  EthnicNoteColor[4]   = loadImage("Octavem1EColor.png");
  EthnicNoteColor[5]   = loadImage("Octavem1FColor.png");
  EthnicNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  EthnicNoteColor[7]   = loadImage("Octavem1GColor.png");
  EthnicNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  EthnicNoteColor[9]   = loadImage("Octavem1AColor.png");
  EthnicNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  EthnicNoteColor[11]  = loadImage("Octavem1BColor.png");
  EthnicNoteColor[12]  = loadImage("Octave0CColor.png");
  EthnicNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  EthnicNoteColor[14]  = loadImage("Octave0DColor.png");
  EthnicNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  EthnicNoteColor[16]  = loadImage("Octave0EColor.png");
  EthnicNoteColor[17]  = loadImage("Octave0FColor.png");
  EthnicNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  EthnicNoteColor[19]  = loadImage("Octave0GColor.png");
  EthnicNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  EthnicNoteColor[21]  = loadImage("Octave0AColor.png");
  EthnicNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  EthnicNoteColor[23]  = loadImage("Octave0BColor.png");
  EthnicNoteColor[24]  = loadImage("Octave1CColor.png");
  EthnicNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  EthnicNoteColor[26]  = loadImage("Octave1DColor.png");
  EthnicNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  EthnicNoteColor[28]  = loadImage("Octave1EColor.png");
  EthnicNoteColor[29]  = loadImage("Octave1FColor.png");
  EthnicNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  EthnicNoteColor[31]  = loadImage("Octave1GColor.png");
  EthnicNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  EthnicNoteColor[33]  = loadImage("Octave1AColor.png");
  EthnicNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  EthnicNoteColor[35]  = loadImage("Octave1BColor.png");
  EthnicNoteColor[36]  = loadImage("Octave2CColor.png");
  EthnicNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  EthnicNoteColor[38]  = loadImage("Octave2DColor.png");
  EthnicNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  EthnicNoteColor[40]  = loadImage("Octave2EColor.png");
  EthnicNoteColor[41]  = loadImage("Octave2FColor.png");
  EthnicNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  EthnicNoteColor[43]  = loadImage("Octave2GColor.png");
  EthnicNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  EthnicNoteColor[45]  = loadImage("Octave2AColor.png");
  EthnicNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  EthnicNoteColor[47]  = loadImage("Octave2BColor.png");
  EthnicNoteColor[48]  = loadImage("Octave3CColor.png");
  EthnicNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  EthnicNoteColor[50]  = loadImage("Octave3DColor.png");
  EthnicNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  EthnicNoteColor[52]  = loadImage("Octave3EColor.png");
  EthnicNoteColor[53]  = loadImage("Octave3FColor.png");
  EthnicNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  EthnicNoteColor[55]  = loadImage("Octave3GColor.png");
  EthnicNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  EthnicNoteColor[57]  = loadImage("Octave3AColor.png");
  EthnicNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  EthnicNoteColor[59]  = loadImage("Octave3BColor.png");
  EthnicNoteColor[60]  = loadImage("Octave4CColor.png");
  EthnicNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  EthnicNoteColor[62]  = loadImage("Octave4DColor.png");
  EthnicNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  EthnicNoteColor[64]  = loadImage("Octave4EColor.png");
  EthnicNoteColor[65]  = loadImage("Octave4FColor.png");
  EthnicNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  EthnicNoteColor[67]  = loadImage("Octave4GColor.png");
  EthnicNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  EthnicNoteColor[69]  = loadImage("Octave4AColor.png");
  EthnicNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  EthnicNoteColor[71]  = loadImage("Octave4BColor.png");
  EthnicNoteColor[72]  = loadImage("Octave5CColor.png");
  EthnicNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  EthnicNoteColor[74]  = loadImage("Octave5DColor.png");
  EthnicNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  EthnicNoteColor[76]  = loadImage("Octave5EColor.png");
  EthnicNoteColor[77]  = loadImage("Octave5FColor.png");
  EthnicNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  EthnicNoteColor[79]  = loadImage("Octave5GColor.png");
  EthnicNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  EthnicNoteColor[81]  = loadImage("Octave5AColor.png");
  EthnicNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  EthnicNoteColor[83]  = loadImage("Octave5BColor.png");
  EthnicNoteColor[84]  = loadImage("Octave6CColor.png");
  EthnicNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  EthnicNoteColor[86]  = loadImage("Octave6DColor.png");
  EthnicNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  EthnicNoteColor[88]  = loadImage("Octave6EColor.png");
  EthnicNoteColor[89]  = loadImage("Octave6FColor.png");
  EthnicNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  EthnicNoteColor[91]  = loadImage("Octave6GColor.png");
  EthnicNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  EthnicNoteColor[93]  = loadImage("Octave6AColor.png");
  EthnicNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  EthnicNoteColor[95]  = loadImage("Octave6BColor.png");
  EthnicNoteColor[96]  = loadImage("Octave7CColor.png");
  EthnicNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  EthnicNoteColor[98]  = loadImage("Octave7DColor.png");
  EthnicNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  EthnicNoteColor[100] = loadImage("Octave7EColor.png");
  EthnicNoteColor[101] = loadImage("Octave7FColor.png");
  EthnicNoteColor[102] = loadImage("Octave7FSharpColor.png");
  EthnicNoteColor[103] = loadImage("Octave7GColor.png");
  EthnicNoteColor[104] = loadImage("Octave7GSharpColor.png");
  EthnicNoteColor[105] = loadImage("Octave7AColor.png");
  EthnicNoteColor[106] = loadImage("Octave7ASharpColor.png");
  EthnicNoteColor[107] = loadImage("Octave7BColor.png");
  EthnicNoteColor[108] = loadImage("Octave8CColor.png");
  EthnicNoteColor[109] = loadImage("Octave8CSharpColor.png");
  EthnicNoteColor[110] = loadImage("Octave8DColor.png");
  EthnicNoteColor[111] = loadImage("Octave8DSharpColor.png");
  EthnicNoteColor[112] = loadImage("Octave8EColor.png");
  EthnicNoteColor[113] = loadImage("Octave8FColor.png");
  EthnicNoteColor[114] = loadImage("Octave8FSharpColor.png");
  EthnicNoteColor[115] = loadImage("Octave8GColor.png");
  EthnicNoteColor[116] = loadImage("Octave8GSharpColor.png");
  EthnicNoteColor[117] = loadImage("Octave8AColor.png");
  EthnicNoteColor[118] = loadImage("Octave8ASharpColor.png");
  EthnicNoteColor[119] = loadImage("Octave8BColor.png");
  EthnicNoteColor[120] = loadImage("Octave9CColor.png");
  EthnicNoteColor[121] = loadImage("Octave9CSharpColor.png");
  EthnicNoteColor[122] = loadImage("Octave9DColor.png");
  EthnicNoteColor[123] = loadImage("Octave9DSharpColor.png");
  EthnicNoteColor[124] = loadImage("Octave9EColor.png");
  EthnicNoteColor[125] = loadImage("Octave9FColor.png");
  EthnicNoteColor[126] = loadImage("Octave9FSharpColor.png");
  EthnicNoteColor[127] = loadImage("Octave9GColor.png");
  //Percussive
  PercussiveNoteColor[0]   = loadImage("Octavem1CColor.png");
  PercussiveNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  PercussiveNoteColor[2]   = loadImage("Octavem1DColor.png");
  PercussiveNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  PercussiveNoteColor[4]   = loadImage("Octavem1EColor.png");
  PercussiveNoteColor[5]   = loadImage("Octavem1FColor.png");
  PercussiveNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  PercussiveNoteColor[7]   = loadImage("Octavem1GColor.png");
  PercussiveNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  PercussiveNoteColor[9]   = loadImage("Octavem1AColor.png");
  PercussiveNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  PercussiveNoteColor[11]  = loadImage("Octavem1BColor.png");
  PercussiveNoteColor[12]  = loadImage("Octave0CColor.png");
  PercussiveNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  PercussiveNoteColor[14]  = loadImage("Octave0DColor.png");
  PercussiveNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  PercussiveNoteColor[16]  = loadImage("Octave0EColor.png");
  PercussiveNoteColor[17]  = loadImage("Octave0FColor.png");
  PercussiveNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  PercussiveNoteColor[19]  = loadImage("Octave0GColor.png");
  PercussiveNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  PercussiveNoteColor[21]  = loadImage("Octave0AColor.png");
  PercussiveNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  PercussiveNoteColor[23]  = loadImage("Octave0BColor.png");
  PercussiveNoteColor[24]  = loadImage("Octave1CColor.png");
  PercussiveNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  PercussiveNoteColor[26]  = loadImage("Octave1DColor.png");
  PercussiveNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  PercussiveNoteColor[28]  = loadImage("Octave1EColor.png");
  PercussiveNoteColor[29]  = loadImage("Octave1FColor.png");
  PercussiveNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  PercussiveNoteColor[31]  = loadImage("Octave1GColor.png");
  PercussiveNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  PercussiveNoteColor[33]  = loadImage("Octave1AColor.png");
  PercussiveNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  PercussiveNoteColor[35]  = loadImage("Octave1BColor.png");
  PercussiveNoteColor[36]  = loadImage("Octave2CColor.png");
  PercussiveNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  PercussiveNoteColor[38]  = loadImage("Octave2DColor.png");
  PercussiveNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  PercussiveNoteColor[40]  = loadImage("Octave2EColor.png");
  PercussiveNoteColor[41]  = loadImage("Octave2FColor.png");
  PercussiveNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  PercussiveNoteColor[43]  = loadImage("Octave2GColor.png");
  PercussiveNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  PercussiveNoteColor[45]  = loadImage("Octave2AColor.png");
  PercussiveNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  PercussiveNoteColor[47]  = loadImage("Octave2BColor.png");
  PercussiveNoteColor[48]  = loadImage("Octave3CColor.png");
  PercussiveNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  PercussiveNoteColor[50]  = loadImage("Octave3DColor.png");
  PercussiveNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  PercussiveNoteColor[52]  = loadImage("Octave3EColor.png");
  PercussiveNoteColor[53]  = loadImage("Octave3FColor.png");
  PercussiveNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  PercussiveNoteColor[55]  = loadImage("Octave3GColor.png");
  PercussiveNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  PercussiveNoteColor[57]  = loadImage("Octave3AColor.png");
  PercussiveNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  PercussiveNoteColor[59]  = loadImage("Octave3BColor.png");
  PercussiveNoteColor[60]  = loadImage("Octave4CColor.png");
  PercussiveNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  PercussiveNoteColor[62]  = loadImage("Octave4DColor.png");
  PercussiveNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  PercussiveNoteColor[64]  = loadImage("Octave4EColor.png");
  PercussiveNoteColor[65]  = loadImage("Octave4FColor.png");
  PercussiveNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  PercussiveNoteColor[67]  = loadImage("Octave4GColor.png");
  PercussiveNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  PercussiveNoteColor[69]  = loadImage("Octave4AColor.png");
  PercussiveNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  PercussiveNoteColor[71]  = loadImage("Octave4BColor.png");
  PercussiveNoteColor[72]  = loadImage("Octave5CColor.png");
  PercussiveNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  PercussiveNoteColor[74]  = loadImage("Octave5DColor.png");
  PercussiveNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  PercussiveNoteColor[76]  = loadImage("Octave5EColor.png");
  PercussiveNoteColor[77]  = loadImage("Octave5FColor.png");
  PercussiveNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  PercussiveNoteColor[79]  = loadImage("Octave5GColor.png");
  PercussiveNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  PercussiveNoteColor[81]  = loadImage("Octave5AColor.png");
  PercussiveNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  PercussiveNoteColor[83]  = loadImage("Octave5BColor.png");
  PercussiveNoteColor[84]  = loadImage("Octave6CColor.png");
  PercussiveNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  PercussiveNoteColor[86]  = loadImage("Octave6DColor.png");
  PercussiveNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  PercussiveNoteColor[88]  = loadImage("Octave6EColor.png");
  PercussiveNoteColor[89]  = loadImage("Octave6FColor.png");
  PercussiveNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  PercussiveNoteColor[91]  = loadImage("Octave6GColor.png");
  PercussiveNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  PercussiveNoteColor[93]  = loadImage("Octave6AColor.png");
  PercussiveNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  PercussiveNoteColor[95]  = loadImage("Octave6BColor.png");
  PercussiveNoteColor[96]  = loadImage("Octave7CColor.png");
  PercussiveNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  PercussiveNoteColor[98]  = loadImage("Octave7DColor.png");
  PercussiveNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  PercussiveNoteColor[100] = loadImage("Octave7EColor.png");
  PercussiveNoteColor[101] = loadImage("Octave7FColor.png");
  PercussiveNoteColor[102] = loadImage("Octave7FSharpColor.png");
  PercussiveNoteColor[103] = loadImage("Octave7GColor.png");
  PercussiveNoteColor[104] = loadImage("Octave7GSharpColor.png");
  PercussiveNoteColor[105] = loadImage("Octave7AColor.png");
  PercussiveNoteColor[106] = loadImage("Octave7ASharpColor.png");
  PercussiveNoteColor[107] = loadImage("Octave7BColor.png");
  PercussiveNoteColor[108] = loadImage("Octave8CColor.png");
  PercussiveNoteColor[109] = loadImage("Octave8CSharpColor.png");
  PercussiveNoteColor[110] = loadImage("Octave8DColor.png");
  PercussiveNoteColor[111] = loadImage("Octave8DSharpColor.png");
  PercussiveNoteColor[112] = loadImage("Octave8EColor.png");
  PercussiveNoteColor[113] = loadImage("Octave8FColor.png");
  PercussiveNoteColor[114] = loadImage("Octave8FSharpColor.png");
  PercussiveNoteColor[115] = loadImage("Octave8GColor.png");
  PercussiveNoteColor[116] = loadImage("Octave8GSharpColor.png");
  PercussiveNoteColor[117] = loadImage("Octave8AColor.png");
  PercussiveNoteColor[118] = loadImage("Octave8ASharpColor.png");
  PercussiveNoteColor[119] = loadImage("Octave8BColor.png");
  PercussiveNoteColor[120] = loadImage("Octave9CColor.png");
  PercussiveNoteColor[121] = loadImage("Octave9CSharpColor.png");
  PercussiveNoteColor[122] = loadImage("Octave9DColor.png");
  PercussiveNoteColor[123] = loadImage("Octave9DSharpColor.png");
  PercussiveNoteColor[124] = loadImage("Octave9EColor.png");
  PercussiveNoteColor[125] = loadImage("Octave9FColor.png");
  PercussiveNoteColor[126] = loadImage("Octave9FSharpColor.png");
  PercussiveNoteColor[127] = loadImage("Octave9GColor.png");
  //Sound Effects
  SoundEffectsNoteColor[0]   = loadImage("Octavem1CColor.png");
  SoundEffectsNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  SoundEffectsNoteColor[2]   = loadImage("Octavem1DColor.png");
  SoundEffectsNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  SoundEffectsNoteColor[4]   = loadImage("Octavem1EColor.png");
  SoundEffectsNoteColor[5]   = loadImage("Octavem1FColor.png");
  SoundEffectsNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  SoundEffectsNoteColor[7]   = loadImage("Octavem1GColor.png");
  SoundEffectsNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  SoundEffectsNoteColor[9]   = loadImage("Octavem1AColor.png");
  SoundEffectsNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  SoundEffectsNoteColor[11]  = loadImage("Octavem1BColor.png");
  SoundEffectsNoteColor[12]  = loadImage("Octave0CColor.png");
  SoundEffectsNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  SoundEffectsNoteColor[14]  = loadImage("Octave0DColor.png");
  SoundEffectsNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  SoundEffectsNoteColor[16]  = loadImage("Octave0EColor.png");
  SoundEffectsNoteColor[17]  = loadImage("Octave0FColor.png");
  SoundEffectsNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  SoundEffectsNoteColor[19]  = loadImage("Octave0GColor.png");
  SoundEffectsNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  SoundEffectsNoteColor[21]  = loadImage("Octave0AColor.png");
  SoundEffectsNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  SoundEffectsNoteColor[23]  = loadImage("Octave0BColor.png");
  SoundEffectsNoteColor[24]  = loadImage("Octave1CColor.png");
  SoundEffectsNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  SoundEffectsNoteColor[26]  = loadImage("Octave1DColor.png");
  SoundEffectsNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  SoundEffectsNoteColor[28]  = loadImage("Octave1EColor.png");
  SoundEffectsNoteColor[29]  = loadImage("Octave1FColor.png");
  SoundEffectsNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  SoundEffectsNoteColor[31]  = loadImage("Octave1GColor.png");
  SoundEffectsNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  SoundEffectsNoteColor[33]  = loadImage("Octave1AColor.png");
  SoundEffectsNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  SoundEffectsNoteColor[35]  = loadImage("Octave1BColor.png");
  SoundEffectsNoteColor[36]  = loadImage("Octave2CColor.png");
  SoundEffectsNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  SoundEffectsNoteColor[38]  = loadImage("Octave2DColor.png");
  SoundEffectsNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  SoundEffectsNoteColor[40]  = loadImage("Octave2EColor.png");
  SoundEffectsNoteColor[41]  = loadImage("Octave2FColor.png");
  SoundEffectsNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  SoundEffectsNoteColor[43]  = loadImage("Octave2GColor.png");
  SoundEffectsNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  SoundEffectsNoteColor[45]  = loadImage("Octave2AColor.png");
  SoundEffectsNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  SoundEffectsNoteColor[47]  = loadImage("Octave2BColor.png");
  SoundEffectsNoteColor[48]  = loadImage("Octave3CColor.png");
  SoundEffectsNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  SoundEffectsNoteColor[50]  = loadImage("Octave3DColor.png");
  SoundEffectsNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  SoundEffectsNoteColor[52]  = loadImage("Octave3EColor.png");
  SoundEffectsNoteColor[53]  = loadImage("Octave3FColor.png");
  SoundEffectsNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  SoundEffectsNoteColor[55]  = loadImage("Octave3GColor.png");
  SoundEffectsNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  SoundEffectsNoteColor[57]  = loadImage("Octave3AColor.png");
  SoundEffectsNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  SoundEffectsNoteColor[59]  = loadImage("Octave3BColor.png");
  SoundEffectsNoteColor[60]  = loadImage("Octave4CColor.png");
  SoundEffectsNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  SoundEffectsNoteColor[62]  = loadImage("Octave4DColor.png");
  SoundEffectsNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  SoundEffectsNoteColor[64]  = loadImage("Octave4EColor.png");
  SoundEffectsNoteColor[65]  = loadImage("Octave4FColor.png");
  SoundEffectsNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  SoundEffectsNoteColor[67]  = loadImage("Octave4GColor.png");
  SoundEffectsNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  SoundEffectsNoteColor[69]  = loadImage("Octave4AColor.png");
  SoundEffectsNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  SoundEffectsNoteColor[71]  = loadImage("Octave4BColor.png");
  SoundEffectsNoteColor[72]  = loadImage("Octave5CColor.png");
  SoundEffectsNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  SoundEffectsNoteColor[74]  = loadImage("Octave5DColor.png");
  SoundEffectsNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  SoundEffectsNoteColor[76]  = loadImage("Octave5EColor.png");
  SoundEffectsNoteColor[77]  = loadImage("Octave5FColor.png");
  SoundEffectsNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  SoundEffectsNoteColor[79]  = loadImage("Octave5GColor.png");
  SoundEffectsNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  SoundEffectsNoteColor[81]  = loadImage("Octave5AColor.png");
  SoundEffectsNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  SoundEffectsNoteColor[83]  = loadImage("Octave5BColor.png");
  SoundEffectsNoteColor[84]  = loadImage("Octave6CColor.png");
  SoundEffectsNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  SoundEffectsNoteColor[86]  = loadImage("Octave6DColor.png");
  SoundEffectsNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  SoundEffectsNoteColor[88]  = loadImage("Octave6EColor.png");
  SoundEffectsNoteColor[89]  = loadImage("Octave6FColor.png");
  SoundEffectsNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  SoundEffectsNoteColor[91]  = loadImage("Octave6GColor.png");
  SoundEffectsNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  SoundEffectsNoteColor[93]  = loadImage("Octave6AColor.png");
  SoundEffectsNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  SoundEffectsNoteColor[95]  = loadImage("Octave6BColor.png");
  SoundEffectsNoteColor[96]  = loadImage("Octave7CColor.png");
  SoundEffectsNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  SoundEffectsNoteColor[98]  = loadImage("Octave7DColor.png");
  SoundEffectsNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  SoundEffectsNoteColor[100] = loadImage("Octave7EColor.png");
  SoundEffectsNoteColor[101] = loadImage("Octave7FColor.png");
  SoundEffectsNoteColor[102] = loadImage("Octave7FSharpColor.png");
  SoundEffectsNoteColor[103] = loadImage("Octave7GColor.png");
  SoundEffectsNoteColor[104] = loadImage("Octave7GSharpColor.png");
  SoundEffectsNoteColor[105] = loadImage("Octave7AColor.png");
  SoundEffectsNoteColor[106] = loadImage("Octave7ASharpColor.png");
  SoundEffectsNoteColor[107] = loadImage("Octave7BColor.png");
  SoundEffectsNoteColor[108] = loadImage("Octave8CColor.png");
  SoundEffectsNoteColor[109] = loadImage("Octave8CSharpColor.png");
  SoundEffectsNoteColor[110] = loadImage("Octave8DColor.png");
  SoundEffectsNoteColor[111] = loadImage("Octave8DSharpColor.png");
  SoundEffectsNoteColor[112] = loadImage("Octave8EColor.png");
  SoundEffectsNoteColor[113] = loadImage("Octave8FColor.png");
  SoundEffectsNoteColor[114] = loadImage("Octave8FSharpColor.png");
  SoundEffectsNoteColor[115] = loadImage("Octave8GColor.png");
  SoundEffectsNoteColor[116] = loadImage("Octave8GSharpColor.png");
  SoundEffectsNoteColor[117] = loadImage("Octave8AColor.png");
  SoundEffectsNoteColor[118] = loadImage("Octave8ASharpColor.png");
  SoundEffectsNoteColor[119] = loadImage("Octave8BColor.png");
  SoundEffectsNoteColor[120] = loadImage("Octave9CColor.png");
  SoundEffectsNoteColor[121] = loadImage("Octave9CSharpColor.png");
  SoundEffectsNoteColor[122] = loadImage("Octave9DColor.png");
  SoundEffectsNoteColor[123] = loadImage("Octave9DSharpColor.png");
  SoundEffectsNoteColor[124] = loadImage("Octave9EColor.png");
  SoundEffectsNoteColor[125] = loadImage("Octave9FColor.png");
  SoundEffectsNoteColor[126] = loadImage("Octave9FSharpColor.png");
  SoundEffectsNoteColor[127] = loadImage("Octave9GColor.png");
  //Percussion
  PercussionNoteColor[0]   = loadImage("Octavem1CColor.png");
  PercussionNoteColor[1]   = loadImage("Octavem1CSharpColor.png");
  PercussionNoteColor[2]   = loadImage("Octavem1DColor.png");
  PercussionNoteColor[3]   = loadImage("Octavem1DSharpColor.png");
  PercussionNoteColor[4]   = loadImage("Octavem1EColor.png");
  PercussionNoteColor[5]   = loadImage("Octavem1FColor.png");
  PercussionNoteColor[6]   = loadImage("Octavem1FSharpColor.png");
  PercussionNoteColor[7]   = loadImage("Octavem1GColor.png");
  PercussionNoteColor[8]   = loadImage("Octavem1GSharpColor.png");
  PercussionNoteColor[9]   = loadImage("Octavem1AColor.png");
  PercussionNoteColor[10]  = loadImage("Octavem1ASharpColor.png");
  PercussionNoteColor[11]  = loadImage("Octavem1BColor.png");
  PercussionNoteColor[12]  = loadImage("Octave0CColor.png");
  PercussionNoteColor[13]  = loadImage("Octave0CSharpColor.png");
  PercussionNoteColor[14]  = loadImage("Octave0DColor.png");
  PercussionNoteColor[15]  = loadImage("Octave0DSharpColor.png");
  PercussionNoteColor[16]  = loadImage("Octave0EColor.png");
  PercussionNoteColor[17]  = loadImage("Octave0FColor.png");
  PercussionNoteColor[18]  = loadImage("Octave0FSharpColor.png");
  PercussionNoteColor[19]  = loadImage("Octave0GColor.png");
  PercussionNoteColor[20]  = loadImage("Octave0GSharpColor.png");
  PercussionNoteColor[21]  = loadImage("Octave0AColor.png");
  PercussionNoteColor[22]  = loadImage("Octave0ASharpColor.png");
  PercussionNoteColor[23]  = loadImage("Octave0BColor.png");
  PercussionNoteColor[24]  = loadImage("Octave1CColor.png");
  PercussionNoteColor[25]  = loadImage("Octave1CSharpColor.png");
  PercussionNoteColor[26]  = loadImage("Octave1DColor.png");
  PercussionNoteColor[27]  = loadImage("Octave1DSharpColor.png");
  PercussionNoteColor[28]  = loadImage("Octave1EColor.png");
  PercussionNoteColor[29]  = loadImage("Octave1FColor.png");
  PercussionNoteColor[30]  = loadImage("Octave1FSharpColor.png");
  PercussionNoteColor[31]  = loadImage("Octave1GColor.png");
  PercussionNoteColor[32]  = loadImage("Octave1GSharpColor.png");
  PercussionNoteColor[33]  = loadImage("Octave1AColor.png");
  PercussionNoteColor[34]  = loadImage("Octave1ASharpColor.png");
  PercussionNoteColor[35]  = loadImage("Octave1BColor.png");
  PercussionNoteColor[36]  = loadImage("Octave2CColor.png");
  PercussionNoteColor[37]  = loadImage("Octave2CSharpColor.png");
  PercussionNoteColor[38]  = loadImage("Octave2DColor.png");
  PercussionNoteColor[39]  = loadImage("Octave2DSharpColor.png");
  PercussionNoteColor[40]  = loadImage("Octave2EColor.png");
  PercussionNoteColor[41]  = loadImage("Octave2FColor.png");
  PercussionNoteColor[42]  = loadImage("Octave2FSharpColor.png");
  PercussionNoteColor[43]  = loadImage("Octave2GColor.png");
  PercussionNoteColor[44]  = loadImage("Octave2GSharpColor.png");
  PercussionNoteColor[45]  = loadImage("Octave2AColor.png");
  PercussionNoteColor[46]  = loadImage("Octave2ASharpColor.png");
  PercussionNoteColor[47]  = loadImage("Octave2BColor.png");
  PercussionNoteColor[48]  = loadImage("Octave3CColor.png");
  PercussionNoteColor[49]  = loadImage("Octave3CSharpColor.png");
  PercussionNoteColor[50]  = loadImage("Octave3DColor.png");
  PercussionNoteColor[51]  = loadImage("Octave3DSharpColor.png");
  PercussionNoteColor[52]  = loadImage("Octave3EColor.png");
  PercussionNoteColor[53]  = loadImage("Octave3FColor.png");
  PercussionNoteColor[54]  = loadImage("Octave3FSharpColor.png");
  PercussionNoteColor[55]  = loadImage("Octave3GColor.png");
  PercussionNoteColor[56]  = loadImage("Octave3GSharpColor.png");
  PercussionNoteColor[57]  = loadImage("Octave3AColor.png");
  PercussionNoteColor[58]  = loadImage("Octave3ASharpColor.png");
  PercussionNoteColor[59]  = loadImage("Octave3BColor.png");
  PercussionNoteColor[60]  = loadImage("Octave4CColor.png");
  PercussionNoteColor[61]  = loadImage("Octave4CSharpColor.png");
  PercussionNoteColor[62]  = loadImage("Octave4DColor.png");
  PercussionNoteColor[63]  = loadImage("Octave4DSharpColor.png");
  PercussionNoteColor[64]  = loadImage("Octave4EColor.png");
  PercussionNoteColor[65]  = loadImage("Octave4FColor.png");
  PercussionNoteColor[66]  = loadImage("Octave4FSharpColor.png");
  PercussionNoteColor[67]  = loadImage("Octave4GColor.png");
  PercussionNoteColor[68]  = loadImage("Octave4GSharpColor.png");
  PercussionNoteColor[69]  = loadImage("Octave4AColor.png");
  PercussionNoteColor[70]  = loadImage("Octave4ASharpColor.png");
  PercussionNoteColor[71]  = loadImage("Octave4BColor.png");
  PercussionNoteColor[72]  = loadImage("Octave5CColor.png");
  PercussionNoteColor[73]  = loadImage("Octave5CSharpColor.png");
  PercussionNoteColor[74]  = loadImage("Octave5DColor.png");
  PercussionNoteColor[75]  = loadImage("Octave5DSharpColor.png");
  PercussionNoteColor[76]  = loadImage("Octave5EColor.png");
  PercussionNoteColor[77]  = loadImage("Octave5FColor.png");
  PercussionNoteColor[78]  = loadImage("Octave5FSharpColor.png");
  PercussionNoteColor[79]  = loadImage("Octave5GColor.png");
  PercussionNoteColor[80]  = loadImage("Octave5GSharpColor.png");
  PercussionNoteColor[81]  = loadImage("Octave5AColor.png");
  PercussionNoteColor[82]  = loadImage("Octave5ASharpColor.png");
  PercussionNoteColor[83]  = loadImage("Octave5BColor.png");
  PercussionNoteColor[84]  = loadImage("Octave6CColor.png");
  PercussionNoteColor[85]  = loadImage("Octave6CSharpColor.png");
  PercussionNoteColor[86]  = loadImage("Octave6DColor.png");
  PercussionNoteColor[87]  = loadImage("Octave6DSharpColor.png");
  PercussionNoteColor[88]  = loadImage("Octave6EColor.png");
  PercussionNoteColor[89]  = loadImage("Octave6FColor.png");
  PercussionNoteColor[90]  = loadImage("Octave6FSharpColor.png");
  PercussionNoteColor[91]  = loadImage("Octave6GColor.png");
  PercussionNoteColor[92]  = loadImage("Octave6GSharpColor.png");
  PercussionNoteColor[93]  = loadImage("Octave6AColor.png");
  PercussionNoteColor[94]  = loadImage("Octave6ASharpColor.png");
  PercussionNoteColor[95]  = loadImage("Octave6BColor.png");
  PercussionNoteColor[96]  = loadImage("Octave7CColor.png");
  PercussionNoteColor[97]  = loadImage("Octave7CSharpColor.png");
  PercussionNoteColor[98]  = loadImage("Octave7DColor.png");
  PercussionNoteColor[99]  = loadImage("Octave7DSharpColor.png");
  PercussionNoteColor[100] = loadImage("Octave7EColor.png");
  PercussionNoteColor[101] = loadImage("Octave7FColor.png");
  PercussionNoteColor[102] = loadImage("Octave7FSharpColor.png");
  PercussionNoteColor[103] = loadImage("Octave7GColor.png");
  PercussionNoteColor[104] = loadImage("Octave7GSharpColor.png");
  PercussionNoteColor[105] = loadImage("Octave7AColor.png");
  PercussionNoteColor[106] = loadImage("Octave7ASharpColor.png");
  PercussionNoteColor[107] = loadImage("Octave7BColor.png");
  PercussionNoteColor[108] = loadImage("Octave8CColor.png");
  PercussionNoteColor[109] = loadImage("Octave8CSharpColor.png");
  PercussionNoteColor[110] = loadImage("Octave8DColor.png");
  PercussionNoteColor[111] = loadImage("Octave8DSharpColor.png");
  PercussionNoteColor[112] = loadImage("Octave8EColor.png");
  PercussionNoteColor[113] = loadImage("Octave8FColor.png");
  PercussionNoteColor[114] = loadImage("Octave8FSharpColor.png");
  PercussionNoteColor[115] = loadImage("Octave8GColor.png");
  PercussionNoteColor[116] = loadImage("Octave8GSharpColor.png");
  PercussionNoteColor[117] = loadImage("Octave8AColor.png");
  PercussionNoteColor[118] = loadImage("Octave8ASharpColor.png");
  PercussionNoteColor[119] = loadImage("Octave8BColor.png");
  PercussionNoteColor[120] = loadImage("Octave9CColor.png");
  PercussionNoteColor[121] = loadImage("Octave9CSharpColor.png");
  PercussionNoteColor[122] = loadImage("Octave9DColor.png");
  PercussionNoteColor[123] = loadImage("Octave9DSharpColor.png");
  PercussionNoteColor[124] = loadImage("Octave9EColor.png");
  PercussionNoteColor[125] = loadImage("Octave9FColor.png");
  PercussionNoteColor[126] = loadImage("Octave9FSharpColor.png");
  PercussionNoteColor[127] = loadImage("Octave9GColor.png");

  //Alpha masks
  PianoMask               = loadImage("Mask-Piano.png");
  ChromaticPercussionMask = loadImage("Mask-ChromaticPercussion.png");
  OrganMask               = loadImage("Mask-Organ.png");
  GuitarMask              = loadImage("Mask-Guitar.png");
  BassMask                = loadImage("Mask-Bass.png");
  StringsMask             = loadImage("Mask-Strings.png");
  EnsembleMask            = loadImage("Mask-Ensemble.png");
  BrassMask               = loadImage("Mask-Brass.png");
  ReedMask                = loadImage("Mask-Reed.png");
  PipeMask                = loadImage("Mask-Pipe.png");
  SynthLeadMask           = loadImage("Mask-SynthLead.png");
  SynthPadMask            = loadImage("Mask-SynthPad.png");
  SynthEffectsMask        = loadImage("Mask-SynthEffects.png");
  EthnicMask              = loadImage("Mask-Ethnic.png");
  PercussiveMask          = loadImage("Mask-Percussive.png");
  SoundEffectsMask        = loadImage("Mask-SoundEffects.png");
  PercussionMask          = loadImage("Mask-Percussion.png");
  
//Colors
  //Piano
  PianoNoteColor[0].mask(PianoMask);
  PianoNoteColor[1].mask(PianoMask);
  PianoNoteColor[2].mask(PianoMask);
  PianoNoteColor[3].mask(PianoMask);
  PianoNoteColor[4].mask(PianoMask);
  PianoNoteColor[5].mask(PianoMask);
  PianoNoteColor[6].mask(PianoMask);
  PianoNoteColor[7].mask(PianoMask);
  PianoNoteColor[8].mask(PianoMask);
  PianoNoteColor[9].mask(PianoMask);
  PianoNoteColor[10].mask(PianoMask);
  PianoNoteColor[11].mask(PianoMask);
  PianoNoteColor[12].mask(PianoMask);
  PianoNoteColor[13].mask(PianoMask);
  PianoNoteColor[14].mask(PianoMask);
  PianoNoteColor[15].mask(PianoMask);
  PianoNoteColor[16].mask(PianoMask);
  PianoNoteColor[17].mask(PianoMask);
  PianoNoteColor[18].mask(PianoMask);
  PianoNoteColor[19].mask(PianoMask);
  PianoNoteColor[20].mask(PianoMask);
  PianoNoteColor[21].mask(PianoMask);
  PianoNoteColor[22].mask(PianoMask);
  PianoNoteColor[23].mask(PianoMask);
  PianoNoteColor[24].mask(PianoMask);
  PianoNoteColor[25].mask(PianoMask);
  PianoNoteColor[26].mask(PianoMask);
  PianoNoteColor[27].mask(PianoMask);
  PianoNoteColor[28].mask(PianoMask);
  PianoNoteColor[29].mask(PianoMask);
  PianoNoteColor[30].mask(PianoMask);
  PianoNoteColor[31].mask(PianoMask);
  PianoNoteColor[32].mask(PianoMask);
  PianoNoteColor[33].mask(PianoMask);
  PianoNoteColor[34].mask(PianoMask);
  PianoNoteColor[35].mask(PianoMask);
  PianoNoteColor[36].mask(PianoMask);
  PianoNoteColor[37].mask(PianoMask);
  PianoNoteColor[38].mask(PianoMask);
  PianoNoteColor[39].mask(PianoMask);
  PianoNoteColor[40].mask(PianoMask);
  PianoNoteColor[41].mask(PianoMask);
  PianoNoteColor[42].mask(PianoMask);
  PianoNoteColor[43].mask(PianoMask);
  PianoNoteColor[44].mask(PianoMask);
  PianoNoteColor[45].mask(PianoMask);
  PianoNoteColor[46].mask(PianoMask);
  PianoNoteColor[47].mask(PianoMask);
  PianoNoteColor[48].mask(PianoMask);
  PianoNoteColor[49].mask(PianoMask);
  PianoNoteColor[50].mask(PianoMask);
  PianoNoteColor[51].mask(PianoMask);
  PianoNoteColor[52].mask(PianoMask);
  PianoNoteColor[53].mask(PianoMask);
  PianoNoteColor[54].mask(PianoMask);
  PianoNoteColor[55].mask(PianoMask);
  PianoNoteColor[56].mask(PianoMask);
  PianoNoteColor[57].mask(PianoMask);
  PianoNoteColor[58].mask(PianoMask);
  PianoNoteColor[59].mask(PianoMask);
  PianoNoteColor[60].mask(PianoMask);
  PianoNoteColor[61].mask(PianoMask);
  PianoNoteColor[62].mask(PianoMask);
  PianoNoteColor[63].mask(PianoMask);
  PianoNoteColor[64].mask(PianoMask);
  PianoNoteColor[65].mask(PianoMask);
  PianoNoteColor[66].mask(PianoMask);
  PianoNoteColor[67].mask(PianoMask);
  PianoNoteColor[68].mask(PianoMask);
  PianoNoteColor[69].mask(PianoMask);
  PianoNoteColor[70].mask(PianoMask);
  PianoNoteColor[71].mask(PianoMask);
  PianoNoteColor[72].mask(PianoMask);
  PianoNoteColor[73].mask(PianoMask);
  PianoNoteColor[74].mask(PianoMask);
  PianoNoteColor[75].mask(PianoMask);
  PianoNoteColor[76].mask(PianoMask);
  PianoNoteColor[77].mask(PianoMask);
  PianoNoteColor[78].mask(PianoMask);
  PianoNoteColor[79].mask(PianoMask);
  PianoNoteColor[80].mask(PianoMask);
  PianoNoteColor[81].mask(PianoMask);
  PianoNoteColor[82].mask(PianoMask);
  PianoNoteColor[83].mask(PianoMask);
  PianoNoteColor[84].mask(PianoMask);
  PianoNoteColor[85].mask(PianoMask);
  PianoNoteColor[86].mask(PianoMask);
  PianoNoteColor[87].mask(PianoMask);
  PianoNoteColor[88].mask(PianoMask);
  PianoNoteColor[89].mask(PianoMask);
  PianoNoteColor[90].mask(PianoMask);
  PianoNoteColor[91].mask(PianoMask);
  PianoNoteColor[92].mask(PianoMask);
  PianoNoteColor[93].mask(PianoMask);
  PianoNoteColor[94].mask(PianoMask);
  PianoNoteColor[95].mask(PianoMask);
  PianoNoteColor[96].mask(PianoMask);
  PianoNoteColor[97].mask(PianoMask);
  PianoNoteColor[98].mask(PianoMask);
  PianoNoteColor[99].mask(PianoMask);
  PianoNoteColor[100].mask(PianoMask);
  PianoNoteColor[101].mask(PianoMask);
  PianoNoteColor[102].mask(PianoMask);
  PianoNoteColor[103].mask(PianoMask);
  PianoNoteColor[104].mask(PianoMask);
  PianoNoteColor[105].mask(PianoMask);
  PianoNoteColor[106].mask(PianoMask);
  PianoNoteColor[107].mask(PianoMask);
  PianoNoteColor[108].mask(PianoMask);
  PianoNoteColor[109].mask(PianoMask);
  PianoNoteColor[110].mask(PianoMask);
  PianoNoteColor[111].mask(PianoMask);
  PianoNoteColor[112].mask(PianoMask);
  PianoNoteColor[113].mask(PianoMask);
  PianoNoteColor[114].mask(PianoMask);
  PianoNoteColor[115].mask(PianoMask);
  PianoNoteColor[116].mask(PianoMask);
  PianoNoteColor[117].mask(PianoMask);
  PianoNoteColor[118].mask(PianoMask);
  PianoNoteColor[119].mask(PianoMask);
  PianoNoteColor[120].mask(PianoMask);
  PianoNoteColor[121].mask(PianoMask);
  PianoNoteColor[122].mask(PianoMask);
  PianoNoteColor[123].mask(PianoMask);
  PianoNoteColor[124].mask(PianoMask);
  PianoNoteColor[125].mask(PianoMask);
  PianoNoteColor[126].mask(PianoMask);
  PianoNoteColor[127].mask(PianoMask);
  //Chromatic Percussion
  ChromaticPercussionNoteColor[0].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[1].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[2].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[3].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[4].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[5].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[6].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[7].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[8].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[9].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[10].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[11].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[12].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[13].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[14].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[15].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[16].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[17].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[18].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[19].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[20].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[21].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[22].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[23].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[24].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[25].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[26].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[27].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[28].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[29].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[30].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[31].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[32].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[33].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[34].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[35].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[36].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[37].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[38].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[39].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[40].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[41].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[42].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[43].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[44].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[45].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[46].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[47].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[48].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[49].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[50].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[51].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[52].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[53].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[54].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[55].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[56].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[57].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[58].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[59].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[60].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[61].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[62].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[63].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[64].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[65].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[66].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[67].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[68].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[69].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[70].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[71].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[72].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[73].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[74].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[75].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[76].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[77].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[78].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[79].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[80].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[81].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[82].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[83].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[84].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[85].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[86].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[87].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[88].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[89].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[90].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[91].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[92].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[93].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[94].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[95].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[96].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[97].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[98].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[99].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[100].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[101].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[102].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[103].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[104].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[105].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[106].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[107].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[108].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[109].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[110].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[111].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[112].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[113].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[114].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[115].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[116].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[117].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[118].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[119].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[120].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[121].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[122].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[123].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[124].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[125].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[126].mask(ChromaticPercussionMask);
  ChromaticPercussionNoteColor[127].mask(ChromaticPercussionMask);
  //Organ
  OrganNoteColor[0].mask(OrganMask);
  OrganNoteColor[1].mask(OrganMask);
  OrganNoteColor[2].mask(OrganMask);
  OrganNoteColor[3].mask(OrganMask);
  OrganNoteColor[4].mask(OrganMask);
  OrganNoteColor[5].mask(OrganMask);
  OrganNoteColor[6].mask(OrganMask);
  OrganNoteColor[7].mask(OrganMask);
  OrganNoteColor[8].mask(OrganMask);
  OrganNoteColor[9].mask(OrganMask);
  OrganNoteColor[10].mask(OrganMask);
  OrganNoteColor[11].mask(OrganMask);
  OrganNoteColor[12].mask(OrganMask);
  OrganNoteColor[13].mask(OrganMask);
  OrganNoteColor[14].mask(OrganMask);
  OrganNoteColor[15].mask(OrganMask);
  OrganNoteColor[16].mask(OrganMask);
  OrganNoteColor[17].mask(OrganMask);
  OrganNoteColor[18].mask(OrganMask);
  OrganNoteColor[19].mask(OrganMask);
  OrganNoteColor[20].mask(OrganMask);
  OrganNoteColor[21].mask(OrganMask);
  OrganNoteColor[22].mask(OrganMask);
  OrganNoteColor[23].mask(OrganMask);
  OrganNoteColor[24].mask(OrganMask);
  OrganNoteColor[25].mask(OrganMask);
  OrganNoteColor[26].mask(OrganMask);
  OrganNoteColor[27].mask(OrganMask);
  OrganNoteColor[28].mask(OrganMask);
  OrganNoteColor[29].mask(OrganMask);
  OrganNoteColor[30].mask(OrganMask);
  OrganNoteColor[31].mask(OrganMask);
  OrganNoteColor[32].mask(OrganMask);
  OrganNoteColor[33].mask(OrganMask);
  OrganNoteColor[34].mask(OrganMask);
  OrganNoteColor[35].mask(OrganMask);
  OrganNoteColor[36].mask(OrganMask);
  OrganNoteColor[37].mask(OrganMask);
  OrganNoteColor[38].mask(OrganMask);
  OrganNoteColor[39].mask(OrganMask);
  OrganNoteColor[40].mask(OrganMask);
  OrganNoteColor[41].mask(OrganMask);
  OrganNoteColor[42].mask(OrganMask);
  OrganNoteColor[43].mask(OrganMask);
  OrganNoteColor[44].mask(OrganMask);
  OrganNoteColor[45].mask(OrganMask);
  OrganNoteColor[46].mask(OrganMask);
  OrganNoteColor[47].mask(OrganMask);
  OrganNoteColor[48].mask(OrganMask);
  OrganNoteColor[49].mask(OrganMask);
  OrganNoteColor[50].mask(OrganMask);
  OrganNoteColor[51].mask(OrganMask);
  OrganNoteColor[52].mask(OrganMask);
  OrganNoteColor[53].mask(OrganMask);
  OrganNoteColor[54].mask(OrganMask);
  OrganNoteColor[55].mask(OrganMask);
  OrganNoteColor[56].mask(OrganMask);
  OrganNoteColor[57].mask(OrganMask);
  OrganNoteColor[58].mask(OrganMask);
  OrganNoteColor[59].mask(OrganMask);
  OrganNoteColor[60].mask(OrganMask);
  OrganNoteColor[61].mask(OrganMask);
  OrganNoteColor[62].mask(OrganMask);
  OrganNoteColor[63].mask(OrganMask);
  OrganNoteColor[64].mask(OrganMask);
  OrganNoteColor[65].mask(OrganMask);
  OrganNoteColor[66].mask(OrganMask);
  OrganNoteColor[67].mask(OrganMask);
  OrganNoteColor[68].mask(OrganMask);
  OrganNoteColor[69].mask(OrganMask);
  OrganNoteColor[70].mask(OrganMask);
  OrganNoteColor[71].mask(OrganMask);
  OrganNoteColor[72].mask(OrganMask);
  OrganNoteColor[73].mask(OrganMask);
  OrganNoteColor[74].mask(OrganMask);
  OrganNoteColor[75].mask(OrganMask);
  OrganNoteColor[76].mask(OrganMask);
  OrganNoteColor[77].mask(OrganMask);
  OrganNoteColor[78].mask(OrganMask);
  OrganNoteColor[79].mask(OrganMask);
  OrganNoteColor[80].mask(OrganMask);
  OrganNoteColor[81].mask(OrganMask);
  OrganNoteColor[82].mask(OrganMask);
  OrganNoteColor[83].mask(OrganMask);
  OrganNoteColor[84].mask(OrganMask);
  OrganNoteColor[85].mask(OrganMask);
  OrganNoteColor[86].mask(OrganMask);
  OrganNoteColor[87].mask(OrganMask);
  OrganNoteColor[88].mask(OrganMask);
  OrganNoteColor[89].mask(OrganMask);
  OrganNoteColor[90].mask(OrganMask);
  OrganNoteColor[91].mask(OrganMask);
  OrganNoteColor[92].mask(OrganMask);
  OrganNoteColor[93].mask(OrganMask);
  OrganNoteColor[94].mask(OrganMask);
  OrganNoteColor[95].mask(OrganMask);
  OrganNoteColor[96].mask(OrganMask);
  OrganNoteColor[97].mask(OrganMask);
  OrganNoteColor[98].mask(OrganMask);
  OrganNoteColor[99].mask(OrganMask);
  OrganNoteColor[100].mask(OrganMask);
  OrganNoteColor[101].mask(OrganMask);
  OrganNoteColor[102].mask(OrganMask);
  OrganNoteColor[103].mask(OrganMask);
  OrganNoteColor[104].mask(OrganMask);
  OrganNoteColor[105].mask(OrganMask);
  OrganNoteColor[106].mask(OrganMask);
  OrganNoteColor[107].mask(OrganMask);
  OrganNoteColor[108].mask(OrganMask);
  OrganNoteColor[109].mask(OrganMask);
  OrganNoteColor[110].mask(OrganMask);
  OrganNoteColor[111].mask(OrganMask);
  OrganNoteColor[112].mask(OrganMask);
  OrganNoteColor[113].mask(OrganMask);
  OrganNoteColor[114].mask(OrganMask);
  OrganNoteColor[115].mask(OrganMask);
  OrganNoteColor[116].mask(OrganMask);
  OrganNoteColor[117].mask(OrganMask);
  OrganNoteColor[118].mask(OrganMask);
  OrganNoteColor[119].mask(OrganMask);
  OrganNoteColor[120].mask(OrganMask);
  OrganNoteColor[121].mask(OrganMask);
  OrganNoteColor[122].mask(OrganMask);
  OrganNoteColor[123].mask(OrganMask);
  OrganNoteColor[124].mask(OrganMask);
  OrganNoteColor[125].mask(OrganMask);
  OrganNoteColor[126].mask(OrganMask);
  OrganNoteColor[127].mask(OrganMask);
  //Guitar
  GuitarNoteColor[0].mask(GuitarMask);
  GuitarNoteColor[1].mask(GuitarMask);
  GuitarNoteColor[2].mask(GuitarMask);
  GuitarNoteColor[3].mask(GuitarMask);
  GuitarNoteColor[4].mask(GuitarMask);
  GuitarNoteColor[5].mask(GuitarMask);
  GuitarNoteColor[6].mask(GuitarMask);
  GuitarNoteColor[7].mask(GuitarMask);
  GuitarNoteColor[8].mask(GuitarMask);
  GuitarNoteColor[9].mask(GuitarMask);
  GuitarNoteColor[10].mask(GuitarMask);
  GuitarNoteColor[11].mask(GuitarMask);
  GuitarNoteColor[12].mask(GuitarMask);
  GuitarNoteColor[13].mask(GuitarMask);
  GuitarNoteColor[14].mask(GuitarMask);
  GuitarNoteColor[15].mask(GuitarMask);
  GuitarNoteColor[16].mask(GuitarMask);
  GuitarNoteColor[17].mask(GuitarMask);
  GuitarNoteColor[18].mask(GuitarMask);
  GuitarNoteColor[19].mask(GuitarMask);
  GuitarNoteColor[20].mask(GuitarMask);
  GuitarNoteColor[21].mask(GuitarMask);
  GuitarNoteColor[22].mask(GuitarMask);
  GuitarNoteColor[23].mask(GuitarMask);
  GuitarNoteColor[24].mask(GuitarMask);
  GuitarNoteColor[25].mask(GuitarMask);
  GuitarNoteColor[26].mask(GuitarMask);
  GuitarNoteColor[27].mask(GuitarMask);
  GuitarNoteColor[28].mask(GuitarMask);
  GuitarNoteColor[29].mask(GuitarMask);
  GuitarNoteColor[30].mask(GuitarMask);
  GuitarNoteColor[31].mask(GuitarMask);
  GuitarNoteColor[32].mask(GuitarMask);
  GuitarNoteColor[33].mask(GuitarMask);
  GuitarNoteColor[34].mask(GuitarMask);
  GuitarNoteColor[35].mask(GuitarMask);
  GuitarNoteColor[36].mask(GuitarMask);
  GuitarNoteColor[37].mask(GuitarMask);
  GuitarNoteColor[38].mask(GuitarMask);
  GuitarNoteColor[39].mask(GuitarMask);
  GuitarNoteColor[40].mask(GuitarMask);
  GuitarNoteColor[41].mask(GuitarMask);
  GuitarNoteColor[42].mask(GuitarMask);
  GuitarNoteColor[43].mask(GuitarMask);
  GuitarNoteColor[44].mask(GuitarMask);
  GuitarNoteColor[45].mask(GuitarMask);
  GuitarNoteColor[46].mask(GuitarMask);
  GuitarNoteColor[47].mask(GuitarMask);
  GuitarNoteColor[48].mask(GuitarMask);
  GuitarNoteColor[49].mask(GuitarMask);
  GuitarNoteColor[50].mask(GuitarMask);
  GuitarNoteColor[51].mask(GuitarMask);
  GuitarNoteColor[52].mask(GuitarMask);
  GuitarNoteColor[53].mask(GuitarMask);
  GuitarNoteColor[54].mask(GuitarMask);
  GuitarNoteColor[55].mask(GuitarMask);
  GuitarNoteColor[56].mask(GuitarMask);
  GuitarNoteColor[57].mask(GuitarMask);
  GuitarNoteColor[58].mask(GuitarMask);
  GuitarNoteColor[59].mask(GuitarMask);
  GuitarNoteColor[60].mask(GuitarMask);
  GuitarNoteColor[61].mask(GuitarMask);
  GuitarNoteColor[62].mask(GuitarMask);
  GuitarNoteColor[63].mask(GuitarMask);
  GuitarNoteColor[64].mask(GuitarMask);
  GuitarNoteColor[65].mask(GuitarMask);
  GuitarNoteColor[66].mask(GuitarMask);
  GuitarNoteColor[67].mask(GuitarMask);
  GuitarNoteColor[68].mask(GuitarMask);
  GuitarNoteColor[69].mask(GuitarMask);
  GuitarNoteColor[70].mask(GuitarMask);
  GuitarNoteColor[71].mask(GuitarMask);
  GuitarNoteColor[72].mask(GuitarMask);
  GuitarNoteColor[73].mask(GuitarMask);
  GuitarNoteColor[74].mask(GuitarMask);
  GuitarNoteColor[75].mask(GuitarMask);
  GuitarNoteColor[76].mask(GuitarMask);
  GuitarNoteColor[77].mask(GuitarMask);
  GuitarNoteColor[78].mask(GuitarMask);
  GuitarNoteColor[79].mask(GuitarMask);
  GuitarNoteColor[80].mask(GuitarMask);
  GuitarNoteColor[81].mask(GuitarMask);
  GuitarNoteColor[82].mask(GuitarMask);
  GuitarNoteColor[83].mask(GuitarMask);
  GuitarNoteColor[84].mask(GuitarMask);
  GuitarNoteColor[85].mask(GuitarMask);
  GuitarNoteColor[86].mask(GuitarMask);
  GuitarNoteColor[87].mask(GuitarMask);
  GuitarNoteColor[88].mask(GuitarMask);
  GuitarNoteColor[89].mask(GuitarMask);
  GuitarNoteColor[90].mask(GuitarMask);
  GuitarNoteColor[91].mask(GuitarMask);
  GuitarNoteColor[92].mask(GuitarMask);
  GuitarNoteColor[93].mask(GuitarMask);
  GuitarNoteColor[94].mask(GuitarMask);
  GuitarNoteColor[95].mask(GuitarMask);
  GuitarNoteColor[96].mask(GuitarMask);
  GuitarNoteColor[97].mask(GuitarMask);
  GuitarNoteColor[98].mask(GuitarMask);
  GuitarNoteColor[99].mask(GuitarMask);
  GuitarNoteColor[100].mask(GuitarMask);
  GuitarNoteColor[101].mask(GuitarMask);
  GuitarNoteColor[102].mask(GuitarMask);
  GuitarNoteColor[103].mask(GuitarMask);
  GuitarNoteColor[104].mask(GuitarMask);
  GuitarNoteColor[105].mask(GuitarMask);
  GuitarNoteColor[106].mask(GuitarMask);
  GuitarNoteColor[107].mask(GuitarMask);
  GuitarNoteColor[108].mask(GuitarMask);
  GuitarNoteColor[109].mask(GuitarMask);
  GuitarNoteColor[110].mask(GuitarMask);
  GuitarNoteColor[111].mask(GuitarMask);
  GuitarNoteColor[112].mask(GuitarMask);
  GuitarNoteColor[113].mask(GuitarMask);
  GuitarNoteColor[114].mask(GuitarMask);
  GuitarNoteColor[115].mask(GuitarMask);
  GuitarNoteColor[116].mask(GuitarMask);
  GuitarNoteColor[117].mask(GuitarMask);
  GuitarNoteColor[118].mask(GuitarMask);
  GuitarNoteColor[119].mask(GuitarMask);
  GuitarNoteColor[120].mask(GuitarMask);
  GuitarNoteColor[121].mask(GuitarMask);
  GuitarNoteColor[122].mask(GuitarMask);
  GuitarNoteColor[123].mask(GuitarMask);
  GuitarNoteColor[124].mask(GuitarMask);
  GuitarNoteColor[125].mask(GuitarMask);
  GuitarNoteColor[126].mask(GuitarMask);
  GuitarNoteColor[127].mask(GuitarMask);
  //Bass
  BassNoteColor[0].mask(BassMask);
  BassNoteColor[1].mask(BassMask);
  BassNoteColor[2].mask(BassMask);
  BassNoteColor[3].mask(BassMask);
  BassNoteColor[4].mask(BassMask);
  BassNoteColor[5].mask(BassMask);
  BassNoteColor[6].mask(BassMask);
  BassNoteColor[7].mask(BassMask);
  BassNoteColor[8].mask(BassMask);
  BassNoteColor[9].mask(BassMask);
  BassNoteColor[10].mask(BassMask);
  BassNoteColor[11].mask(BassMask);
  BassNoteColor[12].mask(BassMask);
  BassNoteColor[13].mask(BassMask);
  BassNoteColor[14].mask(BassMask);
  BassNoteColor[15].mask(BassMask);
  BassNoteColor[16].mask(BassMask);
  BassNoteColor[17].mask(BassMask);
  BassNoteColor[18].mask(BassMask);
  BassNoteColor[19].mask(BassMask);
  BassNoteColor[20].mask(BassMask);
  BassNoteColor[21].mask(BassMask);
  BassNoteColor[22].mask(BassMask);
  BassNoteColor[23].mask(BassMask);
  BassNoteColor[24].mask(BassMask);
  BassNoteColor[25].mask(BassMask);
  BassNoteColor[26].mask(BassMask);
  BassNoteColor[27].mask(BassMask);
  BassNoteColor[28].mask(BassMask);
  BassNoteColor[29].mask(BassMask);
  BassNoteColor[30].mask(BassMask);
  BassNoteColor[31].mask(BassMask);
  BassNoteColor[32].mask(BassMask);
  BassNoteColor[33].mask(BassMask);
  BassNoteColor[34].mask(BassMask);
  BassNoteColor[35].mask(BassMask);
  BassNoteColor[36].mask(BassMask);
  BassNoteColor[37].mask(BassMask);
  BassNoteColor[38].mask(BassMask);
  BassNoteColor[39].mask(BassMask);
  BassNoteColor[40].mask(BassMask);
  BassNoteColor[41].mask(BassMask);
  BassNoteColor[42].mask(BassMask);
  BassNoteColor[43].mask(BassMask);
  BassNoteColor[44].mask(BassMask);
  BassNoteColor[45].mask(BassMask);
  BassNoteColor[46].mask(BassMask);
  BassNoteColor[47].mask(BassMask);
  BassNoteColor[48].mask(BassMask);
  BassNoteColor[49].mask(BassMask);
  BassNoteColor[50].mask(BassMask);
  BassNoteColor[51].mask(BassMask);
  BassNoteColor[52].mask(BassMask);
  BassNoteColor[53].mask(BassMask);
  BassNoteColor[54].mask(BassMask);
  BassNoteColor[55].mask(BassMask);
  BassNoteColor[56].mask(BassMask);
  BassNoteColor[57].mask(BassMask);
  BassNoteColor[58].mask(BassMask);
  BassNoteColor[59].mask(BassMask);
  BassNoteColor[60].mask(BassMask);
  BassNoteColor[61].mask(BassMask);
  BassNoteColor[62].mask(BassMask);
  BassNoteColor[63].mask(BassMask);
  BassNoteColor[64].mask(BassMask);
  BassNoteColor[65].mask(BassMask);
  BassNoteColor[66].mask(BassMask);
  BassNoteColor[67].mask(BassMask);
  BassNoteColor[68].mask(BassMask);
  BassNoteColor[69].mask(BassMask);
  BassNoteColor[70].mask(BassMask);
  BassNoteColor[71].mask(BassMask);
  BassNoteColor[72].mask(BassMask);
  BassNoteColor[73].mask(BassMask);
  BassNoteColor[74].mask(BassMask);
  BassNoteColor[75].mask(BassMask);
  BassNoteColor[76].mask(BassMask);
  BassNoteColor[77].mask(BassMask);
  BassNoteColor[78].mask(BassMask);
  BassNoteColor[79].mask(BassMask);
  BassNoteColor[80].mask(BassMask);
  BassNoteColor[81].mask(BassMask);
  BassNoteColor[82].mask(BassMask);
  BassNoteColor[83].mask(BassMask);
  BassNoteColor[84].mask(BassMask);
  BassNoteColor[85].mask(BassMask);
  BassNoteColor[86].mask(BassMask);
  BassNoteColor[87].mask(BassMask);
  BassNoteColor[88].mask(BassMask);
  BassNoteColor[89].mask(BassMask);
  BassNoteColor[90].mask(BassMask);
  BassNoteColor[91].mask(BassMask);
  BassNoteColor[92].mask(BassMask);
  BassNoteColor[93].mask(BassMask);
  BassNoteColor[94].mask(BassMask);
  BassNoteColor[95].mask(BassMask);
  BassNoteColor[96].mask(BassMask);
  BassNoteColor[97].mask(BassMask);
  BassNoteColor[98].mask(BassMask);
  BassNoteColor[99].mask(BassMask);
  BassNoteColor[100].mask(BassMask);
  BassNoteColor[101].mask(BassMask);
  BassNoteColor[102].mask(BassMask);
  BassNoteColor[103].mask(BassMask);
  BassNoteColor[104].mask(BassMask);
  BassNoteColor[105].mask(BassMask);
  BassNoteColor[106].mask(BassMask);
  BassNoteColor[107].mask(BassMask);
  BassNoteColor[108].mask(BassMask);
  BassNoteColor[109].mask(BassMask);
  BassNoteColor[110].mask(BassMask);
  BassNoteColor[111].mask(BassMask);
  BassNoteColor[112].mask(BassMask);
  BassNoteColor[113].mask(BassMask);
  BassNoteColor[114].mask(BassMask);
  BassNoteColor[115].mask(BassMask);
  BassNoteColor[116].mask(BassMask);
  BassNoteColor[117].mask(BassMask);
  BassNoteColor[118].mask(BassMask);
  BassNoteColor[119].mask(BassMask);
  BassNoteColor[120].mask(BassMask);
  BassNoteColor[121].mask(BassMask);
  BassNoteColor[122].mask(BassMask);
  BassNoteColor[123].mask(BassMask);
  BassNoteColor[124].mask(BassMask);
  BassNoteColor[125].mask(BassMask);
  BassNoteColor[126].mask(BassMask);
  BassNoteColor[127].mask(BassMask);
  //Strings
  StringsNoteColor[0].mask(StringsMask);
  StringsNoteColor[1].mask(StringsMask);
  StringsNoteColor[2].mask(StringsMask);
  StringsNoteColor[3].mask(StringsMask);
  StringsNoteColor[4].mask(StringsMask);
  StringsNoteColor[5].mask(StringsMask);
  StringsNoteColor[6].mask(StringsMask);
  StringsNoteColor[7].mask(StringsMask);
  StringsNoteColor[8].mask(StringsMask);
  StringsNoteColor[9].mask(StringsMask);
  StringsNoteColor[10].mask(StringsMask);
  StringsNoteColor[11].mask(StringsMask);
  StringsNoteColor[12].mask(StringsMask);
  StringsNoteColor[13].mask(StringsMask);
  StringsNoteColor[14].mask(StringsMask);
  StringsNoteColor[15].mask(StringsMask);
  StringsNoteColor[16].mask(StringsMask);
  StringsNoteColor[17].mask(StringsMask);
  StringsNoteColor[18].mask(StringsMask);
  StringsNoteColor[19].mask(StringsMask);
  StringsNoteColor[20].mask(StringsMask);
  StringsNoteColor[21].mask(StringsMask);
  StringsNoteColor[22].mask(StringsMask);
  StringsNoteColor[23].mask(StringsMask);
  StringsNoteColor[24].mask(StringsMask);
  StringsNoteColor[25].mask(StringsMask);
  StringsNoteColor[26].mask(StringsMask);
  StringsNoteColor[27].mask(StringsMask);
  StringsNoteColor[28].mask(StringsMask);
  StringsNoteColor[29].mask(StringsMask);
  StringsNoteColor[30].mask(StringsMask);
  StringsNoteColor[31].mask(StringsMask);
  StringsNoteColor[32].mask(StringsMask);
  StringsNoteColor[33].mask(StringsMask);
  StringsNoteColor[34].mask(StringsMask);
  StringsNoteColor[35].mask(StringsMask);
  StringsNoteColor[36].mask(StringsMask);
  StringsNoteColor[37].mask(StringsMask);
  StringsNoteColor[38].mask(StringsMask);
  StringsNoteColor[39].mask(StringsMask);
  StringsNoteColor[40].mask(StringsMask);
  StringsNoteColor[41].mask(StringsMask);
  StringsNoteColor[42].mask(StringsMask);
  StringsNoteColor[43].mask(StringsMask);
  StringsNoteColor[44].mask(StringsMask);
  StringsNoteColor[45].mask(StringsMask);
  StringsNoteColor[46].mask(StringsMask);
  StringsNoteColor[47].mask(StringsMask);
  StringsNoteColor[48].mask(StringsMask);
  StringsNoteColor[49].mask(StringsMask);
  StringsNoteColor[50].mask(StringsMask);
  StringsNoteColor[51].mask(StringsMask);
  StringsNoteColor[52].mask(StringsMask);
  StringsNoteColor[53].mask(StringsMask);
  StringsNoteColor[54].mask(StringsMask);
  StringsNoteColor[55].mask(StringsMask);
  StringsNoteColor[56].mask(StringsMask);
  StringsNoteColor[57].mask(StringsMask);
  StringsNoteColor[58].mask(StringsMask);
  StringsNoteColor[59].mask(StringsMask);
  StringsNoteColor[60].mask(StringsMask);
  StringsNoteColor[61].mask(StringsMask);
  StringsNoteColor[62].mask(StringsMask);
  StringsNoteColor[63].mask(StringsMask);
  StringsNoteColor[64].mask(StringsMask);
  StringsNoteColor[65].mask(StringsMask);
  StringsNoteColor[66].mask(StringsMask);
  StringsNoteColor[67].mask(StringsMask);
  StringsNoteColor[68].mask(StringsMask);
  StringsNoteColor[69].mask(StringsMask);
  StringsNoteColor[70].mask(StringsMask);
  StringsNoteColor[71].mask(StringsMask);
  StringsNoteColor[72].mask(StringsMask);
  StringsNoteColor[73].mask(StringsMask);
  StringsNoteColor[74].mask(StringsMask);
  StringsNoteColor[75].mask(StringsMask);
  StringsNoteColor[76].mask(StringsMask);
  StringsNoteColor[77].mask(StringsMask);
  StringsNoteColor[78].mask(StringsMask);
  StringsNoteColor[79].mask(StringsMask);
  StringsNoteColor[80].mask(StringsMask);
  StringsNoteColor[81].mask(StringsMask);
  StringsNoteColor[82].mask(StringsMask);
  StringsNoteColor[83].mask(StringsMask);
  StringsNoteColor[84].mask(StringsMask);
  StringsNoteColor[85].mask(StringsMask);
  StringsNoteColor[86].mask(StringsMask);
  StringsNoteColor[87].mask(StringsMask);
  StringsNoteColor[88].mask(StringsMask);
  StringsNoteColor[89].mask(StringsMask);
  StringsNoteColor[90].mask(StringsMask);
  StringsNoteColor[91].mask(StringsMask);
  StringsNoteColor[92].mask(StringsMask);
  StringsNoteColor[93].mask(StringsMask);
  StringsNoteColor[94].mask(StringsMask);
  StringsNoteColor[95].mask(StringsMask);
  StringsNoteColor[96].mask(StringsMask);
  StringsNoteColor[97].mask(StringsMask);
  StringsNoteColor[98].mask(StringsMask);
  StringsNoteColor[99].mask(StringsMask);
  StringsNoteColor[100].mask(StringsMask);
  StringsNoteColor[101].mask(StringsMask);
  StringsNoteColor[102].mask(StringsMask);
  StringsNoteColor[103].mask(StringsMask);
  StringsNoteColor[104].mask(StringsMask);
  StringsNoteColor[105].mask(StringsMask);
  StringsNoteColor[106].mask(StringsMask);
  StringsNoteColor[107].mask(StringsMask);
  StringsNoteColor[108].mask(StringsMask);
  StringsNoteColor[109].mask(StringsMask);
  StringsNoteColor[110].mask(StringsMask);
  StringsNoteColor[111].mask(StringsMask);
  StringsNoteColor[112].mask(StringsMask);
  StringsNoteColor[113].mask(StringsMask);
  StringsNoteColor[114].mask(StringsMask);
  StringsNoteColor[115].mask(StringsMask);
  StringsNoteColor[116].mask(StringsMask);
  StringsNoteColor[117].mask(StringsMask);
  StringsNoteColor[118].mask(StringsMask);
  StringsNoteColor[119].mask(StringsMask);
  StringsNoteColor[120].mask(StringsMask);
  StringsNoteColor[121].mask(StringsMask);
  StringsNoteColor[122].mask(StringsMask);
  StringsNoteColor[123].mask(StringsMask);
  StringsNoteColor[124].mask(StringsMask);
  StringsNoteColor[125].mask(StringsMask);
  StringsNoteColor[126].mask(StringsMask);
  StringsNoteColor[127].mask(StringsMask);
  //Ensemble
  EnsembleNoteColor[0].mask(EnsembleMask);
  EnsembleNoteColor[1].mask(EnsembleMask);
  EnsembleNoteColor[2].mask(EnsembleMask);
  EnsembleNoteColor[3].mask(EnsembleMask);
  EnsembleNoteColor[4].mask(EnsembleMask);
  EnsembleNoteColor[5].mask(EnsembleMask);
  EnsembleNoteColor[6].mask(EnsembleMask);
  EnsembleNoteColor[7].mask(EnsembleMask);
  EnsembleNoteColor[8].mask(EnsembleMask);
  EnsembleNoteColor[9].mask(EnsembleMask);
  EnsembleNoteColor[10].mask(EnsembleMask);
  EnsembleNoteColor[11].mask(EnsembleMask);
  EnsembleNoteColor[12].mask(EnsembleMask);
  EnsembleNoteColor[13].mask(EnsembleMask);
  EnsembleNoteColor[14].mask(EnsembleMask);
  EnsembleNoteColor[15].mask(EnsembleMask);
  EnsembleNoteColor[16].mask(EnsembleMask);
  EnsembleNoteColor[17].mask(EnsembleMask);
  EnsembleNoteColor[18].mask(EnsembleMask);
  EnsembleNoteColor[19].mask(EnsembleMask);
  EnsembleNoteColor[20].mask(EnsembleMask);
  EnsembleNoteColor[21].mask(EnsembleMask);
  EnsembleNoteColor[22].mask(EnsembleMask);
  EnsembleNoteColor[23].mask(EnsembleMask);
  EnsembleNoteColor[24].mask(EnsembleMask);
  EnsembleNoteColor[25].mask(EnsembleMask);
  EnsembleNoteColor[26].mask(EnsembleMask);
  EnsembleNoteColor[27].mask(EnsembleMask);
  EnsembleNoteColor[28].mask(EnsembleMask);
  EnsembleNoteColor[29].mask(EnsembleMask);
  EnsembleNoteColor[30].mask(EnsembleMask);
  EnsembleNoteColor[31].mask(EnsembleMask);
  EnsembleNoteColor[32].mask(EnsembleMask);
  EnsembleNoteColor[33].mask(EnsembleMask);
  EnsembleNoteColor[34].mask(EnsembleMask);
  EnsembleNoteColor[35].mask(EnsembleMask);
  EnsembleNoteColor[36].mask(EnsembleMask);
  EnsembleNoteColor[37].mask(EnsembleMask);
  EnsembleNoteColor[38].mask(EnsembleMask);
  EnsembleNoteColor[39].mask(EnsembleMask);
  EnsembleNoteColor[40].mask(EnsembleMask);
  EnsembleNoteColor[41].mask(EnsembleMask);
  EnsembleNoteColor[42].mask(EnsembleMask);
  EnsembleNoteColor[43].mask(EnsembleMask);
  EnsembleNoteColor[44].mask(EnsembleMask);
  EnsembleNoteColor[45].mask(EnsembleMask);
  EnsembleNoteColor[46].mask(EnsembleMask);
  EnsembleNoteColor[47].mask(EnsembleMask);
  EnsembleNoteColor[48].mask(EnsembleMask);
  EnsembleNoteColor[49].mask(EnsembleMask);
  EnsembleNoteColor[50].mask(EnsembleMask);
  EnsembleNoteColor[51].mask(EnsembleMask);
  EnsembleNoteColor[52].mask(EnsembleMask);
  EnsembleNoteColor[53].mask(EnsembleMask);
  EnsembleNoteColor[54].mask(EnsembleMask);
  EnsembleNoteColor[55].mask(EnsembleMask);
  EnsembleNoteColor[56].mask(EnsembleMask);
  EnsembleNoteColor[57].mask(EnsembleMask);
  EnsembleNoteColor[58].mask(EnsembleMask);
  EnsembleNoteColor[59].mask(EnsembleMask);
  EnsembleNoteColor[60].mask(EnsembleMask);
  EnsembleNoteColor[61].mask(EnsembleMask);
  EnsembleNoteColor[62].mask(EnsembleMask);
  EnsembleNoteColor[63].mask(EnsembleMask);
  EnsembleNoteColor[64].mask(EnsembleMask);
  EnsembleNoteColor[65].mask(EnsembleMask);
  EnsembleNoteColor[66].mask(EnsembleMask);
  EnsembleNoteColor[67].mask(EnsembleMask);
  EnsembleNoteColor[68].mask(EnsembleMask);
  EnsembleNoteColor[69].mask(EnsembleMask);
  EnsembleNoteColor[70].mask(EnsembleMask);
  EnsembleNoteColor[71].mask(EnsembleMask);
  EnsembleNoteColor[72].mask(EnsembleMask);
  EnsembleNoteColor[73].mask(EnsembleMask);
  EnsembleNoteColor[74].mask(EnsembleMask);
  EnsembleNoteColor[75].mask(EnsembleMask);
  EnsembleNoteColor[76].mask(EnsembleMask);
  EnsembleNoteColor[77].mask(EnsembleMask);
  EnsembleNoteColor[78].mask(EnsembleMask);
  EnsembleNoteColor[79].mask(EnsembleMask);
  EnsembleNoteColor[80].mask(EnsembleMask);
  EnsembleNoteColor[81].mask(EnsembleMask);
  EnsembleNoteColor[82].mask(EnsembleMask);
  EnsembleNoteColor[83].mask(EnsembleMask);
  EnsembleNoteColor[84].mask(EnsembleMask);
  EnsembleNoteColor[85].mask(EnsembleMask);
  EnsembleNoteColor[86].mask(EnsembleMask);
  EnsembleNoteColor[87].mask(EnsembleMask);
  EnsembleNoteColor[88].mask(EnsembleMask);
  EnsembleNoteColor[89].mask(EnsembleMask);
  EnsembleNoteColor[90].mask(EnsembleMask);
  EnsembleNoteColor[91].mask(EnsembleMask);
  EnsembleNoteColor[92].mask(EnsembleMask);
  EnsembleNoteColor[93].mask(EnsembleMask);
  EnsembleNoteColor[94].mask(EnsembleMask);
  EnsembleNoteColor[95].mask(EnsembleMask);
  EnsembleNoteColor[96].mask(EnsembleMask);
  EnsembleNoteColor[97].mask(EnsembleMask);
  EnsembleNoteColor[98].mask(EnsembleMask);
  EnsembleNoteColor[99].mask(EnsembleMask);
  EnsembleNoteColor[100].mask(EnsembleMask);
  EnsembleNoteColor[101].mask(EnsembleMask);
  EnsembleNoteColor[102].mask(EnsembleMask);
  EnsembleNoteColor[103].mask(EnsembleMask);
  EnsembleNoteColor[104].mask(EnsembleMask);
  EnsembleNoteColor[105].mask(EnsembleMask);
  EnsembleNoteColor[106].mask(EnsembleMask);
  EnsembleNoteColor[107].mask(EnsembleMask);
  EnsembleNoteColor[108].mask(EnsembleMask);
  EnsembleNoteColor[109].mask(EnsembleMask);
  EnsembleNoteColor[110].mask(EnsembleMask);
  EnsembleNoteColor[111].mask(EnsembleMask);
  EnsembleNoteColor[112].mask(EnsembleMask);
  EnsembleNoteColor[113].mask(EnsembleMask);
  EnsembleNoteColor[114].mask(EnsembleMask);
  EnsembleNoteColor[115].mask(EnsembleMask);
  EnsembleNoteColor[116].mask(EnsembleMask);
  EnsembleNoteColor[117].mask(EnsembleMask);
  EnsembleNoteColor[118].mask(EnsembleMask);
  EnsembleNoteColor[119].mask(EnsembleMask);
  EnsembleNoteColor[120].mask(EnsembleMask);
  EnsembleNoteColor[121].mask(EnsembleMask);
  EnsembleNoteColor[122].mask(EnsembleMask);
  EnsembleNoteColor[123].mask(EnsembleMask);
  EnsembleNoteColor[124].mask(EnsembleMask);
  EnsembleNoteColor[125].mask(EnsembleMask);
  EnsembleNoteColor[126].mask(EnsembleMask);
  EnsembleNoteColor[127].mask(EnsembleMask);
  //Brass
  BrassNoteColor[0].mask(BrassMask);
  BrassNoteColor[1].mask(BrassMask);
  BrassNoteColor[2].mask(BrassMask);
  BrassNoteColor[3].mask(BrassMask);
  BrassNoteColor[4].mask(BrassMask);
  BrassNoteColor[5].mask(BrassMask);
  BrassNoteColor[6].mask(BrassMask);
  BrassNoteColor[7].mask(BrassMask);
  BrassNoteColor[8].mask(BrassMask);
  BrassNoteColor[9].mask(BrassMask);
  BrassNoteColor[10].mask(BrassMask);
  BrassNoteColor[11].mask(BrassMask);
  BrassNoteColor[12].mask(BrassMask);
  BrassNoteColor[13].mask(BrassMask);
  BrassNoteColor[14].mask(BrassMask);
  BrassNoteColor[15].mask(BrassMask);
  BrassNoteColor[16].mask(BrassMask);
  BrassNoteColor[17].mask(BrassMask);
  BrassNoteColor[18].mask(BrassMask);
  BrassNoteColor[19].mask(BrassMask);
  BrassNoteColor[20].mask(BrassMask);
  BrassNoteColor[21].mask(BrassMask);
  BrassNoteColor[22].mask(BrassMask);
  BrassNoteColor[23].mask(BrassMask);
  BrassNoteColor[24].mask(BrassMask);
  BrassNoteColor[25].mask(BrassMask);
  BrassNoteColor[26].mask(BrassMask);
  BrassNoteColor[27].mask(BrassMask);
  BrassNoteColor[28].mask(BrassMask);
  BrassNoteColor[29].mask(BrassMask);
  BrassNoteColor[30].mask(BrassMask);
  BrassNoteColor[31].mask(BrassMask);
  BrassNoteColor[32].mask(BrassMask);
  BrassNoteColor[33].mask(BrassMask);
  BrassNoteColor[34].mask(BrassMask);
  BrassNoteColor[35].mask(BrassMask);
  BrassNoteColor[36].mask(BrassMask);
  BrassNoteColor[37].mask(BrassMask);
  BrassNoteColor[38].mask(BrassMask);
  BrassNoteColor[39].mask(BrassMask);
  BrassNoteColor[40].mask(BrassMask);
  BrassNoteColor[41].mask(BrassMask);
  BrassNoteColor[42].mask(BrassMask);
  BrassNoteColor[43].mask(BrassMask);
  BrassNoteColor[44].mask(BrassMask);
  BrassNoteColor[45].mask(BrassMask);
  BrassNoteColor[46].mask(BrassMask);
  BrassNoteColor[47].mask(BrassMask);
  BrassNoteColor[48].mask(BrassMask);
  BrassNoteColor[49].mask(BrassMask);
  BrassNoteColor[50].mask(BrassMask);
  BrassNoteColor[51].mask(BrassMask);
  BrassNoteColor[52].mask(BrassMask);
  BrassNoteColor[53].mask(BrassMask);
  BrassNoteColor[54].mask(BrassMask);
  BrassNoteColor[55].mask(BrassMask);
  BrassNoteColor[56].mask(BrassMask);
  BrassNoteColor[57].mask(BrassMask);
  BrassNoteColor[58].mask(BrassMask);
  BrassNoteColor[59].mask(BrassMask);
  BrassNoteColor[60].mask(BrassMask);
  BrassNoteColor[61].mask(BrassMask);
  BrassNoteColor[62].mask(BrassMask);
  BrassNoteColor[63].mask(BrassMask);
  BrassNoteColor[64].mask(BrassMask);
  BrassNoteColor[65].mask(BrassMask);
  BrassNoteColor[66].mask(BrassMask);
  BrassNoteColor[67].mask(BrassMask);
  BrassNoteColor[68].mask(BrassMask);
  BrassNoteColor[69].mask(BrassMask);
  BrassNoteColor[70].mask(BrassMask);
  BrassNoteColor[71].mask(BrassMask);
  BrassNoteColor[72].mask(BrassMask);
  BrassNoteColor[73].mask(BrassMask);
  BrassNoteColor[74].mask(BrassMask);
  BrassNoteColor[75].mask(BrassMask);
  BrassNoteColor[76].mask(BrassMask);
  BrassNoteColor[77].mask(BrassMask);
  BrassNoteColor[78].mask(BrassMask);
  BrassNoteColor[79].mask(BrassMask);
  BrassNoteColor[80].mask(BrassMask);
  BrassNoteColor[81].mask(BrassMask);
  BrassNoteColor[82].mask(BrassMask);
  BrassNoteColor[83].mask(BrassMask);
  BrassNoteColor[84].mask(BrassMask);
  BrassNoteColor[85].mask(BrassMask);
  BrassNoteColor[86].mask(BrassMask);
  BrassNoteColor[87].mask(BrassMask);
  BrassNoteColor[88].mask(BrassMask);
  BrassNoteColor[89].mask(BrassMask);
  BrassNoteColor[90].mask(BrassMask);
  BrassNoteColor[91].mask(BrassMask);
  BrassNoteColor[92].mask(BrassMask);
  BrassNoteColor[93].mask(BrassMask);
  BrassNoteColor[94].mask(BrassMask);
  BrassNoteColor[95].mask(BrassMask);
  BrassNoteColor[96].mask(BrassMask);
  BrassNoteColor[97].mask(BrassMask);
  BrassNoteColor[98].mask(BrassMask);
  BrassNoteColor[99].mask(BrassMask);
  BrassNoteColor[100].mask(BrassMask);
  BrassNoteColor[101].mask(BrassMask);
  BrassNoteColor[102].mask(BrassMask);
  BrassNoteColor[103].mask(BrassMask);
  BrassNoteColor[104].mask(BrassMask);
  BrassNoteColor[105].mask(BrassMask);
  BrassNoteColor[106].mask(BrassMask);
  BrassNoteColor[107].mask(BrassMask);
  BrassNoteColor[108].mask(BrassMask);
  BrassNoteColor[109].mask(BrassMask);
  BrassNoteColor[110].mask(BrassMask);
  BrassNoteColor[111].mask(BrassMask);
  BrassNoteColor[112].mask(BrassMask);
  BrassNoteColor[113].mask(BrassMask);
  BrassNoteColor[114].mask(BrassMask);
  BrassNoteColor[115].mask(BrassMask);
  BrassNoteColor[116].mask(BrassMask);
  BrassNoteColor[117].mask(BrassMask);
  BrassNoteColor[118].mask(BrassMask);
  BrassNoteColor[119].mask(BrassMask);
  BrassNoteColor[120].mask(BrassMask);
  BrassNoteColor[121].mask(BrassMask);
  BrassNoteColor[122].mask(BrassMask);
  BrassNoteColor[123].mask(BrassMask);
  BrassNoteColor[124].mask(BrassMask);
  BrassNoteColor[125].mask(BrassMask);
  BrassNoteColor[126].mask(BrassMask);
  BrassNoteColor[127].mask(BrassMask);
  //Reed
  ReedNoteColor[0].mask(ReedMask);
  ReedNoteColor[1].mask(ReedMask);
  ReedNoteColor[2].mask(ReedMask);
  ReedNoteColor[3].mask(ReedMask);
  ReedNoteColor[4].mask(ReedMask);
  ReedNoteColor[5].mask(ReedMask);
  ReedNoteColor[6].mask(ReedMask);
  ReedNoteColor[7].mask(ReedMask);
  ReedNoteColor[8].mask(ReedMask);
  ReedNoteColor[9].mask(ReedMask);
  ReedNoteColor[10].mask(ReedMask);
  ReedNoteColor[11].mask(ReedMask);
  ReedNoteColor[12].mask(ReedMask);
  ReedNoteColor[13].mask(ReedMask);
  ReedNoteColor[14].mask(ReedMask);
  ReedNoteColor[15].mask(ReedMask);
  ReedNoteColor[16].mask(ReedMask);
  ReedNoteColor[17].mask(ReedMask);
  ReedNoteColor[18].mask(ReedMask);
  ReedNoteColor[19].mask(ReedMask);
  ReedNoteColor[20].mask(ReedMask);
  ReedNoteColor[21].mask(ReedMask);
  ReedNoteColor[22].mask(ReedMask);
  ReedNoteColor[23].mask(ReedMask);
  ReedNoteColor[24].mask(ReedMask);
  ReedNoteColor[25].mask(ReedMask);
  ReedNoteColor[26].mask(ReedMask);
  ReedNoteColor[27].mask(ReedMask);
  ReedNoteColor[28].mask(ReedMask);
  ReedNoteColor[29].mask(ReedMask);
  ReedNoteColor[30].mask(ReedMask);
  ReedNoteColor[31].mask(ReedMask);
  ReedNoteColor[32].mask(ReedMask);
  ReedNoteColor[33].mask(ReedMask);
  ReedNoteColor[34].mask(ReedMask);
  ReedNoteColor[35].mask(ReedMask);
  ReedNoteColor[36].mask(ReedMask);
  ReedNoteColor[37].mask(ReedMask);
  ReedNoteColor[38].mask(ReedMask);
  ReedNoteColor[39].mask(ReedMask);
  ReedNoteColor[40].mask(ReedMask);
  ReedNoteColor[41].mask(ReedMask);
  ReedNoteColor[42].mask(ReedMask);
  ReedNoteColor[43].mask(ReedMask);
  ReedNoteColor[44].mask(ReedMask);
  ReedNoteColor[45].mask(ReedMask);
  ReedNoteColor[46].mask(ReedMask);
  ReedNoteColor[47].mask(ReedMask);
  ReedNoteColor[48].mask(ReedMask);
  ReedNoteColor[49].mask(ReedMask);
  ReedNoteColor[50].mask(ReedMask);
  ReedNoteColor[51].mask(ReedMask);
  ReedNoteColor[52].mask(ReedMask);
  ReedNoteColor[53].mask(ReedMask);
  ReedNoteColor[54].mask(ReedMask);
  ReedNoteColor[55].mask(ReedMask);
  ReedNoteColor[56].mask(ReedMask);
  ReedNoteColor[57].mask(ReedMask);
  ReedNoteColor[58].mask(ReedMask);
  ReedNoteColor[59].mask(ReedMask);
  ReedNoteColor[60].mask(ReedMask);
  ReedNoteColor[61].mask(ReedMask);
  ReedNoteColor[62].mask(ReedMask);
  ReedNoteColor[63].mask(ReedMask);
  ReedNoteColor[64].mask(ReedMask);
  ReedNoteColor[65].mask(ReedMask);
  ReedNoteColor[66].mask(ReedMask);
  ReedNoteColor[67].mask(ReedMask);
  ReedNoteColor[68].mask(ReedMask);
  ReedNoteColor[69].mask(ReedMask);
  ReedNoteColor[70].mask(ReedMask);
  ReedNoteColor[71].mask(ReedMask);
  ReedNoteColor[72].mask(ReedMask);
  ReedNoteColor[73].mask(ReedMask);
  ReedNoteColor[74].mask(ReedMask);
  ReedNoteColor[75].mask(ReedMask);
  ReedNoteColor[76].mask(ReedMask);
  ReedNoteColor[77].mask(ReedMask);
  ReedNoteColor[78].mask(ReedMask);
  ReedNoteColor[79].mask(ReedMask);
  ReedNoteColor[80].mask(ReedMask);
  ReedNoteColor[81].mask(ReedMask);
  ReedNoteColor[82].mask(ReedMask);
  ReedNoteColor[83].mask(ReedMask);
  ReedNoteColor[84].mask(ReedMask);
  ReedNoteColor[85].mask(ReedMask);
  ReedNoteColor[86].mask(ReedMask);
  ReedNoteColor[87].mask(ReedMask);
  ReedNoteColor[88].mask(ReedMask);
  ReedNoteColor[89].mask(ReedMask);
  ReedNoteColor[90].mask(ReedMask);
  ReedNoteColor[91].mask(ReedMask);
  ReedNoteColor[92].mask(ReedMask);
  ReedNoteColor[93].mask(ReedMask);
  ReedNoteColor[94].mask(ReedMask);
  ReedNoteColor[95].mask(ReedMask);
  ReedNoteColor[96].mask(ReedMask);
  ReedNoteColor[97].mask(ReedMask);
  ReedNoteColor[98].mask(ReedMask);
  ReedNoteColor[99].mask(ReedMask);
  ReedNoteColor[100].mask(ReedMask);
  ReedNoteColor[101].mask(ReedMask);
  ReedNoteColor[102].mask(ReedMask);
  ReedNoteColor[103].mask(ReedMask);
  ReedNoteColor[104].mask(ReedMask);
  ReedNoteColor[105].mask(ReedMask);
  ReedNoteColor[106].mask(ReedMask);
  ReedNoteColor[107].mask(ReedMask);
  ReedNoteColor[108].mask(ReedMask);
  ReedNoteColor[109].mask(ReedMask);
  ReedNoteColor[110].mask(ReedMask);
  ReedNoteColor[111].mask(ReedMask);
  ReedNoteColor[112].mask(ReedMask);
  ReedNoteColor[113].mask(ReedMask);
  ReedNoteColor[114].mask(ReedMask);
  ReedNoteColor[115].mask(ReedMask);
  ReedNoteColor[116].mask(ReedMask);
  ReedNoteColor[117].mask(ReedMask);
  ReedNoteColor[118].mask(ReedMask);
  ReedNoteColor[119].mask(ReedMask);
  ReedNoteColor[120].mask(ReedMask);
  ReedNoteColor[121].mask(ReedMask);
  ReedNoteColor[122].mask(ReedMask);
  ReedNoteColor[123].mask(ReedMask);
  ReedNoteColor[124].mask(ReedMask);
  ReedNoteColor[125].mask(ReedMask);
  ReedNoteColor[126].mask(ReedMask);
  ReedNoteColor[127].mask(ReedMask);
  //Pipe
  PipeNoteColor[0].mask(PipeMask);
  PipeNoteColor[1].mask(PipeMask);
  PipeNoteColor[2].mask(PipeMask);
  PipeNoteColor[3].mask(PipeMask);
  PipeNoteColor[4].mask(PipeMask);
  PipeNoteColor[5].mask(PipeMask);
  PipeNoteColor[6].mask(PipeMask);
  PipeNoteColor[7].mask(PipeMask);
  PipeNoteColor[8].mask(PipeMask);
  PipeNoteColor[9].mask(PipeMask);
  PipeNoteColor[10].mask(PipeMask);
  PipeNoteColor[11].mask(PipeMask);
  PipeNoteColor[12].mask(PipeMask);
  PipeNoteColor[13].mask(PipeMask);
  PipeNoteColor[14].mask(PipeMask);
  PipeNoteColor[15].mask(PipeMask);
  PipeNoteColor[16].mask(PipeMask);
  PipeNoteColor[17].mask(PipeMask);
  PipeNoteColor[18].mask(PipeMask);
  PipeNoteColor[19].mask(PipeMask);
  PipeNoteColor[20].mask(PipeMask);
  PipeNoteColor[21].mask(PipeMask);
  PipeNoteColor[22].mask(PipeMask);
  PipeNoteColor[23].mask(PipeMask);
  PipeNoteColor[24].mask(PipeMask);
  PipeNoteColor[25].mask(PipeMask);
  PipeNoteColor[26].mask(PipeMask);
  PipeNoteColor[27].mask(PipeMask);
  PipeNoteColor[28].mask(PipeMask);
  PipeNoteColor[29].mask(PipeMask);
  PipeNoteColor[30].mask(PipeMask);
  PipeNoteColor[31].mask(PipeMask);
  PipeNoteColor[32].mask(PipeMask);
  PipeNoteColor[33].mask(PipeMask);
  PipeNoteColor[34].mask(PipeMask);
  PipeNoteColor[35].mask(PipeMask);
  PipeNoteColor[36].mask(PipeMask);
  PipeNoteColor[37].mask(PipeMask);
  PipeNoteColor[38].mask(PipeMask);
  PipeNoteColor[39].mask(PipeMask);
  PipeNoteColor[40].mask(PipeMask);
  PipeNoteColor[41].mask(PipeMask);
  PipeNoteColor[42].mask(PipeMask);
  PipeNoteColor[43].mask(PipeMask);
  PipeNoteColor[44].mask(PipeMask);
  PipeNoteColor[45].mask(PipeMask);
  PipeNoteColor[46].mask(PipeMask);
  PipeNoteColor[47].mask(PipeMask);
  PipeNoteColor[48].mask(PipeMask);
  PipeNoteColor[49].mask(PipeMask);
  PipeNoteColor[50].mask(PipeMask);
  PipeNoteColor[51].mask(PipeMask);
  PipeNoteColor[52].mask(PipeMask);
  PipeNoteColor[53].mask(PipeMask);
  PipeNoteColor[54].mask(PipeMask);
  PipeNoteColor[55].mask(PipeMask);
  PipeNoteColor[56].mask(PipeMask);
  PipeNoteColor[57].mask(PipeMask);
  PipeNoteColor[58].mask(PipeMask);
  PipeNoteColor[59].mask(PipeMask);
  PipeNoteColor[60].mask(PipeMask);
  PipeNoteColor[61].mask(PipeMask);
  PipeNoteColor[62].mask(PipeMask);
  PipeNoteColor[63].mask(PipeMask);
  PipeNoteColor[64].mask(PipeMask);
  PipeNoteColor[65].mask(PipeMask);
  PipeNoteColor[66].mask(PipeMask);
  PipeNoteColor[67].mask(PipeMask);
  PipeNoteColor[68].mask(PipeMask);
  PipeNoteColor[69].mask(PipeMask);
  PipeNoteColor[70].mask(PipeMask);
  PipeNoteColor[71].mask(PipeMask);
  PipeNoteColor[72].mask(PipeMask);
  PipeNoteColor[73].mask(PipeMask);
  PipeNoteColor[74].mask(PipeMask);
  PipeNoteColor[75].mask(PipeMask);
  PipeNoteColor[76].mask(PipeMask);
  PipeNoteColor[77].mask(PipeMask);
  PipeNoteColor[78].mask(PipeMask);
  PipeNoteColor[79].mask(PipeMask);
  PipeNoteColor[80].mask(PipeMask);
  PipeNoteColor[81].mask(PipeMask);
  PipeNoteColor[82].mask(PipeMask);
  PipeNoteColor[83].mask(PipeMask);
  PipeNoteColor[84].mask(PipeMask);
  PipeNoteColor[85].mask(PipeMask);
  PipeNoteColor[86].mask(PipeMask);
  PipeNoteColor[87].mask(PipeMask);
  PipeNoteColor[88].mask(PipeMask);
  PipeNoteColor[89].mask(PipeMask);
  PipeNoteColor[90].mask(PipeMask);
  PipeNoteColor[91].mask(PipeMask);
  PipeNoteColor[92].mask(PipeMask);
  PipeNoteColor[93].mask(PipeMask);
  PipeNoteColor[94].mask(PipeMask);
  PipeNoteColor[95].mask(PipeMask);
  PipeNoteColor[96].mask(PipeMask);
  PipeNoteColor[97].mask(PipeMask);
  PipeNoteColor[98].mask(PipeMask);
  PipeNoteColor[99].mask(PipeMask);
  PipeNoteColor[100].mask(PipeMask);
  PipeNoteColor[101].mask(PipeMask);
  PipeNoteColor[102].mask(PipeMask);
  PipeNoteColor[103].mask(PipeMask);
  PipeNoteColor[104].mask(PipeMask);
  PipeNoteColor[105].mask(PipeMask);
  PipeNoteColor[106].mask(PipeMask);
  PipeNoteColor[107].mask(PipeMask);
  PipeNoteColor[108].mask(PipeMask);
  PipeNoteColor[109].mask(PipeMask);
  PipeNoteColor[110].mask(PipeMask);
  PipeNoteColor[111].mask(PipeMask);
  PipeNoteColor[112].mask(PipeMask);
  PipeNoteColor[113].mask(PipeMask);
  PipeNoteColor[114].mask(PipeMask);
  PipeNoteColor[115].mask(PipeMask);
  PipeNoteColor[116].mask(PipeMask);
  PipeNoteColor[117].mask(PipeMask);
  PipeNoteColor[118].mask(PipeMask);
  PipeNoteColor[119].mask(PipeMask);
  PipeNoteColor[120].mask(PipeMask);
  PipeNoteColor[121].mask(PipeMask);
  PipeNoteColor[122].mask(PipeMask);
  PipeNoteColor[123].mask(PipeMask);
  PipeNoteColor[124].mask(PipeMask);
  PipeNoteColor[125].mask(PipeMask);
  PipeNoteColor[126].mask(PipeMask);
  PipeNoteColor[127].mask(PipeMask);
  //Synth Lead
  SynthLeadNoteColor[0].mask(SynthLeadMask);
  SynthLeadNoteColor[1].mask(SynthLeadMask);
  SynthLeadNoteColor[2].mask(SynthLeadMask);
  SynthLeadNoteColor[3].mask(SynthLeadMask);
  SynthLeadNoteColor[4].mask(SynthLeadMask);
  SynthLeadNoteColor[5].mask(SynthLeadMask);
  SynthLeadNoteColor[6].mask(SynthLeadMask);
  SynthLeadNoteColor[7].mask(SynthLeadMask);
  SynthLeadNoteColor[8].mask(SynthLeadMask);
  SynthLeadNoteColor[9].mask(SynthLeadMask);
  SynthLeadNoteColor[10].mask(SynthLeadMask);
  SynthLeadNoteColor[11].mask(SynthLeadMask);
  SynthLeadNoteColor[12].mask(SynthLeadMask);
  SynthLeadNoteColor[13].mask(SynthLeadMask);
  SynthLeadNoteColor[14].mask(SynthLeadMask);
  SynthLeadNoteColor[15].mask(SynthLeadMask);
  SynthLeadNoteColor[16].mask(SynthLeadMask);
  SynthLeadNoteColor[17].mask(SynthLeadMask);
  SynthLeadNoteColor[18].mask(SynthLeadMask);
  SynthLeadNoteColor[19].mask(SynthLeadMask);
  SynthLeadNoteColor[20].mask(SynthLeadMask);
  SynthLeadNoteColor[21].mask(SynthLeadMask);
  SynthLeadNoteColor[22].mask(SynthLeadMask);
  SynthLeadNoteColor[23].mask(SynthLeadMask);
  SynthLeadNoteColor[24].mask(SynthLeadMask);
  SynthLeadNoteColor[25].mask(SynthLeadMask);
  SynthLeadNoteColor[26].mask(SynthLeadMask);
  SynthLeadNoteColor[27].mask(SynthLeadMask);
  SynthLeadNoteColor[28].mask(SynthLeadMask);
  SynthLeadNoteColor[29].mask(SynthLeadMask);
  SynthLeadNoteColor[30].mask(SynthLeadMask);
  SynthLeadNoteColor[31].mask(SynthLeadMask);
  SynthLeadNoteColor[32].mask(SynthLeadMask);
  SynthLeadNoteColor[33].mask(SynthLeadMask);
  SynthLeadNoteColor[34].mask(SynthLeadMask);
  SynthLeadNoteColor[35].mask(SynthLeadMask);
  SynthLeadNoteColor[36].mask(SynthLeadMask);
  SynthLeadNoteColor[37].mask(SynthLeadMask);
  SynthLeadNoteColor[38].mask(SynthLeadMask);
  SynthLeadNoteColor[39].mask(SynthLeadMask);
  SynthLeadNoteColor[40].mask(SynthLeadMask);
  SynthLeadNoteColor[41].mask(SynthLeadMask);
  SynthLeadNoteColor[42].mask(SynthLeadMask);
  SynthLeadNoteColor[43].mask(SynthLeadMask);
  SynthLeadNoteColor[44].mask(SynthLeadMask);
  SynthLeadNoteColor[45].mask(SynthLeadMask);
  SynthLeadNoteColor[46].mask(SynthLeadMask);
  SynthLeadNoteColor[47].mask(SynthLeadMask);
  SynthLeadNoteColor[48].mask(SynthLeadMask);
  SynthLeadNoteColor[49].mask(SynthLeadMask);
  SynthLeadNoteColor[50].mask(SynthLeadMask);
  SynthLeadNoteColor[51].mask(SynthLeadMask);
  SynthLeadNoteColor[52].mask(SynthLeadMask);
  SynthLeadNoteColor[53].mask(SynthLeadMask);
  SynthLeadNoteColor[54].mask(SynthLeadMask);
  SynthLeadNoteColor[55].mask(SynthLeadMask);
  SynthLeadNoteColor[56].mask(SynthLeadMask);
  SynthLeadNoteColor[57].mask(SynthLeadMask);
  SynthLeadNoteColor[58].mask(SynthLeadMask);
  SynthLeadNoteColor[59].mask(SynthLeadMask);
  SynthLeadNoteColor[60].mask(SynthLeadMask);
  SynthLeadNoteColor[61].mask(SynthLeadMask);
  SynthLeadNoteColor[62].mask(SynthLeadMask);
  SynthLeadNoteColor[63].mask(SynthLeadMask);
  SynthLeadNoteColor[64].mask(SynthLeadMask);
  SynthLeadNoteColor[65].mask(SynthLeadMask);
  SynthLeadNoteColor[66].mask(SynthLeadMask);
  SynthLeadNoteColor[67].mask(SynthLeadMask);
  SynthLeadNoteColor[68].mask(SynthLeadMask);
  SynthLeadNoteColor[69].mask(SynthLeadMask);
  SynthLeadNoteColor[70].mask(SynthLeadMask);
  SynthLeadNoteColor[71].mask(SynthLeadMask);
  SynthLeadNoteColor[72].mask(SynthLeadMask);
  SynthLeadNoteColor[73].mask(SynthLeadMask);
  SynthLeadNoteColor[74].mask(SynthLeadMask);
  SynthLeadNoteColor[75].mask(SynthLeadMask);
  SynthLeadNoteColor[76].mask(SynthLeadMask);
  SynthLeadNoteColor[77].mask(SynthLeadMask);
  SynthLeadNoteColor[78].mask(SynthLeadMask);
  SynthLeadNoteColor[79].mask(SynthLeadMask);
  SynthLeadNoteColor[80].mask(SynthLeadMask);
  SynthLeadNoteColor[81].mask(SynthLeadMask);
  SynthLeadNoteColor[82].mask(SynthLeadMask);
  SynthLeadNoteColor[83].mask(SynthLeadMask);
  SynthLeadNoteColor[84].mask(SynthLeadMask);
  SynthLeadNoteColor[85].mask(SynthLeadMask);
  SynthLeadNoteColor[86].mask(SynthLeadMask);
  SynthLeadNoteColor[87].mask(SynthLeadMask);
  SynthLeadNoteColor[88].mask(SynthLeadMask);
  SynthLeadNoteColor[89].mask(SynthLeadMask);
  SynthLeadNoteColor[90].mask(SynthLeadMask);
  SynthLeadNoteColor[91].mask(SynthLeadMask);
  SynthLeadNoteColor[92].mask(SynthLeadMask);
  SynthLeadNoteColor[93].mask(SynthLeadMask);
  SynthLeadNoteColor[94].mask(SynthLeadMask);
  SynthLeadNoteColor[95].mask(SynthLeadMask);
  SynthLeadNoteColor[96].mask(SynthLeadMask);
  SynthLeadNoteColor[97].mask(SynthLeadMask);
  SynthLeadNoteColor[98].mask(SynthLeadMask);
  SynthLeadNoteColor[99].mask(SynthLeadMask);
  SynthLeadNoteColor[100].mask(SynthLeadMask);
  SynthLeadNoteColor[101].mask(SynthLeadMask);
  SynthLeadNoteColor[102].mask(SynthLeadMask);
  SynthLeadNoteColor[103].mask(SynthLeadMask);
  SynthLeadNoteColor[104].mask(SynthLeadMask);
  SynthLeadNoteColor[105].mask(SynthLeadMask);
  SynthLeadNoteColor[106].mask(SynthLeadMask);
  SynthLeadNoteColor[107].mask(SynthLeadMask);
  SynthLeadNoteColor[108].mask(SynthLeadMask);
  SynthLeadNoteColor[109].mask(SynthLeadMask);
  SynthLeadNoteColor[110].mask(SynthLeadMask);
  SynthLeadNoteColor[111].mask(SynthLeadMask);
  SynthLeadNoteColor[112].mask(SynthLeadMask);
  SynthLeadNoteColor[113].mask(SynthLeadMask);
  SynthLeadNoteColor[114].mask(SynthLeadMask);
  SynthLeadNoteColor[115].mask(SynthLeadMask);
  SynthLeadNoteColor[116].mask(SynthLeadMask);
  SynthLeadNoteColor[117].mask(SynthLeadMask);
  SynthLeadNoteColor[118].mask(SynthLeadMask);
  SynthLeadNoteColor[119].mask(SynthLeadMask);
  SynthLeadNoteColor[120].mask(SynthLeadMask);
  SynthLeadNoteColor[121].mask(SynthLeadMask);
  SynthLeadNoteColor[122].mask(SynthLeadMask);
  SynthLeadNoteColor[123].mask(SynthLeadMask);
  SynthLeadNoteColor[124].mask(SynthLeadMask);
  SynthLeadNoteColor[125].mask(SynthLeadMask);
  SynthLeadNoteColor[126].mask(SynthLeadMask);
  SynthLeadNoteColor[127].mask(SynthLeadMask);
  //Synth Pad
  SynthPadNoteColor[0].mask(SynthPadMask);
  SynthPadNoteColor[1].mask(SynthPadMask);
  SynthPadNoteColor[2].mask(SynthPadMask);
  SynthPadNoteColor[3].mask(SynthPadMask);
  SynthPadNoteColor[4].mask(SynthPadMask);
  SynthPadNoteColor[5].mask(SynthPadMask);
  SynthPadNoteColor[6].mask(SynthPadMask);
  SynthPadNoteColor[7].mask(SynthPadMask);
  SynthPadNoteColor[8].mask(SynthPadMask);
  SynthPadNoteColor[9].mask(SynthPadMask);
  SynthPadNoteColor[10].mask(SynthPadMask);
  SynthPadNoteColor[11].mask(SynthPadMask);
  SynthPadNoteColor[12].mask(SynthPadMask);
  SynthPadNoteColor[13].mask(SynthPadMask);
  SynthPadNoteColor[14].mask(SynthPadMask);
  SynthPadNoteColor[15].mask(SynthPadMask);
  SynthPadNoteColor[16].mask(SynthPadMask);
  SynthPadNoteColor[17].mask(SynthPadMask);
  SynthPadNoteColor[18].mask(SynthPadMask);
  SynthPadNoteColor[19].mask(SynthPadMask);
  SynthPadNoteColor[20].mask(SynthPadMask);
  SynthPadNoteColor[21].mask(SynthPadMask);
  SynthPadNoteColor[22].mask(SynthPadMask);
  SynthPadNoteColor[23].mask(SynthPadMask);
  SynthPadNoteColor[24].mask(SynthPadMask);
  SynthPadNoteColor[25].mask(SynthPadMask);
  SynthPadNoteColor[26].mask(SynthPadMask);
  SynthPadNoteColor[27].mask(SynthPadMask);
  SynthPadNoteColor[28].mask(SynthPadMask);
  SynthPadNoteColor[29].mask(SynthPadMask);
  SynthPadNoteColor[30].mask(SynthPadMask);
  SynthPadNoteColor[31].mask(SynthPadMask);
  SynthPadNoteColor[32].mask(SynthPadMask);
  SynthPadNoteColor[33].mask(SynthPadMask);
  SynthPadNoteColor[34].mask(SynthPadMask);
  SynthPadNoteColor[35].mask(SynthPadMask);
  SynthPadNoteColor[36].mask(SynthPadMask);
  SynthPadNoteColor[37].mask(SynthPadMask);
  SynthPadNoteColor[38].mask(SynthPadMask);
  SynthPadNoteColor[39].mask(SynthPadMask);
  SynthPadNoteColor[40].mask(SynthPadMask);
  SynthPadNoteColor[41].mask(SynthPadMask);
  SynthPadNoteColor[42].mask(SynthPadMask);
  SynthPadNoteColor[43].mask(SynthPadMask);
  SynthPadNoteColor[44].mask(SynthPadMask);
  SynthPadNoteColor[45].mask(SynthPadMask);
  SynthPadNoteColor[46].mask(SynthPadMask);
  SynthPadNoteColor[47].mask(SynthPadMask);
  SynthPadNoteColor[48].mask(SynthPadMask);
  SynthPadNoteColor[49].mask(SynthPadMask);
  SynthPadNoteColor[50].mask(SynthPadMask);
  SynthPadNoteColor[51].mask(SynthPadMask);
  SynthPadNoteColor[52].mask(SynthPadMask);
  SynthPadNoteColor[53].mask(SynthPadMask);
  SynthPadNoteColor[54].mask(SynthPadMask);
  SynthPadNoteColor[55].mask(SynthPadMask);
  SynthPadNoteColor[56].mask(SynthPadMask);
  SynthPadNoteColor[57].mask(SynthPadMask);
  SynthPadNoteColor[58].mask(SynthPadMask);
  SynthPadNoteColor[59].mask(SynthPadMask);
  SynthPadNoteColor[60].mask(SynthPadMask);
  SynthPadNoteColor[61].mask(SynthPadMask);
  SynthPadNoteColor[62].mask(SynthPadMask);
  SynthPadNoteColor[63].mask(SynthPadMask);
  SynthPadNoteColor[64].mask(SynthPadMask);
  SynthPadNoteColor[65].mask(SynthPadMask);
  SynthPadNoteColor[66].mask(SynthPadMask);
  SynthPadNoteColor[67].mask(SynthPadMask);
  SynthPadNoteColor[68].mask(SynthPadMask);
  SynthPadNoteColor[69].mask(SynthPadMask);
  SynthPadNoteColor[70].mask(SynthPadMask);
  SynthPadNoteColor[71].mask(SynthPadMask);
  SynthPadNoteColor[72].mask(SynthPadMask);
  SynthPadNoteColor[73].mask(SynthPadMask);
  SynthPadNoteColor[74].mask(SynthPadMask);
  SynthPadNoteColor[75].mask(SynthPadMask);
  SynthPadNoteColor[76].mask(SynthPadMask);
  SynthPadNoteColor[77].mask(SynthPadMask);
  SynthPadNoteColor[78].mask(SynthPadMask);
  SynthPadNoteColor[79].mask(SynthPadMask);
  SynthPadNoteColor[80].mask(SynthPadMask);
  SynthPadNoteColor[81].mask(SynthPadMask);
  SynthPadNoteColor[82].mask(SynthPadMask);
  SynthPadNoteColor[83].mask(SynthPadMask);
  SynthPadNoteColor[84].mask(SynthPadMask);
  SynthPadNoteColor[85].mask(SynthPadMask);
  SynthPadNoteColor[86].mask(SynthPadMask);
  SynthPadNoteColor[87].mask(SynthPadMask);
  SynthPadNoteColor[88].mask(SynthPadMask);
  SynthPadNoteColor[89].mask(SynthPadMask);
  SynthPadNoteColor[90].mask(SynthPadMask);
  SynthPadNoteColor[91].mask(SynthPadMask);
  SynthPadNoteColor[92].mask(SynthPadMask);
  SynthPadNoteColor[93].mask(SynthPadMask);
  SynthPadNoteColor[94].mask(SynthPadMask);
  SynthPadNoteColor[95].mask(SynthPadMask);
  SynthPadNoteColor[96].mask(SynthPadMask);
  SynthPadNoteColor[97].mask(SynthPadMask);
  SynthPadNoteColor[98].mask(SynthPadMask);
  SynthPadNoteColor[99].mask(SynthPadMask);
  SynthPadNoteColor[100].mask(SynthPadMask);
  SynthPadNoteColor[101].mask(SynthPadMask);
  SynthPadNoteColor[102].mask(SynthPadMask);
  SynthPadNoteColor[103].mask(SynthPadMask);
  SynthPadNoteColor[104].mask(SynthPadMask);
  SynthPadNoteColor[105].mask(SynthPadMask);
  SynthPadNoteColor[106].mask(SynthPadMask);
  SynthPadNoteColor[107].mask(SynthPadMask);
  SynthPadNoteColor[108].mask(SynthPadMask);
  SynthPadNoteColor[109].mask(SynthPadMask);
  SynthPadNoteColor[110].mask(SynthPadMask);
  SynthPadNoteColor[111].mask(SynthPadMask);
  SynthPadNoteColor[112].mask(SynthPadMask);
  SynthPadNoteColor[113].mask(SynthPadMask);
  SynthPadNoteColor[114].mask(SynthPadMask);
  SynthPadNoteColor[115].mask(SynthPadMask);
  SynthPadNoteColor[116].mask(SynthPadMask);
  SynthPadNoteColor[117].mask(SynthPadMask);
  SynthPadNoteColor[118].mask(SynthPadMask);
  SynthPadNoteColor[119].mask(SynthPadMask);
  SynthPadNoteColor[120].mask(SynthPadMask);
  SynthPadNoteColor[121].mask(SynthPadMask);
  SynthPadNoteColor[122].mask(SynthPadMask);
  SynthPadNoteColor[123].mask(SynthPadMask);
  SynthPadNoteColor[124].mask(SynthPadMask);
  SynthPadNoteColor[125].mask(SynthPadMask);
  SynthPadNoteColor[126].mask(SynthPadMask);
  SynthPadNoteColor[127].mask(SynthPadMask);
  //Synth Effects
  SynthEffectsNoteColor[0].mask(SynthEffectsMask);
  SynthEffectsNoteColor[1].mask(SynthEffectsMask);
  SynthEffectsNoteColor[2].mask(SynthEffectsMask);
  SynthEffectsNoteColor[3].mask(SynthEffectsMask);
  SynthEffectsNoteColor[4].mask(SynthEffectsMask);
  SynthEffectsNoteColor[5].mask(SynthEffectsMask);
  SynthEffectsNoteColor[6].mask(SynthEffectsMask);
  SynthEffectsNoteColor[7].mask(SynthEffectsMask);
  SynthEffectsNoteColor[8].mask(SynthEffectsMask);
  SynthEffectsNoteColor[9].mask(SynthEffectsMask);
  SynthEffectsNoteColor[10].mask(SynthEffectsMask);
  SynthEffectsNoteColor[11].mask(SynthEffectsMask);
  SynthEffectsNoteColor[12].mask(SynthEffectsMask);
  SynthEffectsNoteColor[13].mask(SynthEffectsMask);
  SynthEffectsNoteColor[14].mask(SynthEffectsMask);
  SynthEffectsNoteColor[15].mask(SynthEffectsMask);
  SynthEffectsNoteColor[16].mask(SynthEffectsMask);
  SynthEffectsNoteColor[17].mask(SynthEffectsMask);
  SynthEffectsNoteColor[18].mask(SynthEffectsMask);
  SynthEffectsNoteColor[19].mask(SynthEffectsMask);
  SynthEffectsNoteColor[20].mask(SynthEffectsMask);
  SynthEffectsNoteColor[21].mask(SynthEffectsMask);
  SynthEffectsNoteColor[22].mask(SynthEffectsMask);
  SynthEffectsNoteColor[23].mask(SynthEffectsMask);
  SynthEffectsNoteColor[24].mask(SynthEffectsMask);
  SynthEffectsNoteColor[25].mask(SynthEffectsMask);
  SynthEffectsNoteColor[26].mask(SynthEffectsMask);
  SynthEffectsNoteColor[27].mask(SynthEffectsMask);
  SynthEffectsNoteColor[28].mask(SynthEffectsMask);
  SynthEffectsNoteColor[29].mask(SynthEffectsMask);
  SynthEffectsNoteColor[30].mask(SynthEffectsMask);
  SynthEffectsNoteColor[31].mask(SynthEffectsMask);
  SynthEffectsNoteColor[32].mask(SynthEffectsMask);
  SynthEffectsNoteColor[33].mask(SynthEffectsMask);
  SynthEffectsNoteColor[34].mask(SynthEffectsMask);
  SynthEffectsNoteColor[35].mask(SynthEffectsMask);
  SynthEffectsNoteColor[36].mask(SynthEffectsMask);
  SynthEffectsNoteColor[37].mask(SynthEffectsMask);
  SynthEffectsNoteColor[38].mask(SynthEffectsMask);
  SynthEffectsNoteColor[39].mask(SynthEffectsMask);
  SynthEffectsNoteColor[40].mask(SynthEffectsMask);
  SynthEffectsNoteColor[41].mask(SynthEffectsMask);
  SynthEffectsNoteColor[42].mask(SynthEffectsMask);
  SynthEffectsNoteColor[43].mask(SynthEffectsMask);
  SynthEffectsNoteColor[44].mask(SynthEffectsMask);
  SynthEffectsNoteColor[45].mask(SynthEffectsMask);
  SynthEffectsNoteColor[46].mask(SynthEffectsMask);
  SynthEffectsNoteColor[47].mask(SynthEffectsMask);
  SynthEffectsNoteColor[48].mask(SynthEffectsMask);
  SynthEffectsNoteColor[49].mask(SynthEffectsMask);
  SynthEffectsNoteColor[50].mask(SynthEffectsMask);
  SynthEffectsNoteColor[51].mask(SynthEffectsMask);
  SynthEffectsNoteColor[52].mask(SynthEffectsMask);
  SynthEffectsNoteColor[53].mask(SynthEffectsMask);
  SynthEffectsNoteColor[54].mask(SynthEffectsMask);
  SynthEffectsNoteColor[55].mask(SynthEffectsMask);
  SynthEffectsNoteColor[56].mask(SynthEffectsMask);
  SynthEffectsNoteColor[57].mask(SynthEffectsMask);
  SynthEffectsNoteColor[58].mask(SynthEffectsMask);
  SynthEffectsNoteColor[59].mask(SynthEffectsMask);
  SynthEffectsNoteColor[60].mask(SynthEffectsMask);
  SynthEffectsNoteColor[61].mask(SynthEffectsMask);
  SynthEffectsNoteColor[62].mask(SynthEffectsMask);
  SynthEffectsNoteColor[63].mask(SynthEffectsMask);
  SynthEffectsNoteColor[64].mask(SynthEffectsMask);
  SynthEffectsNoteColor[65].mask(SynthEffectsMask);
  SynthEffectsNoteColor[66].mask(SynthEffectsMask);
  SynthEffectsNoteColor[67].mask(SynthEffectsMask);
  SynthEffectsNoteColor[68].mask(SynthEffectsMask);
  SynthEffectsNoteColor[69].mask(SynthEffectsMask);
  SynthEffectsNoteColor[70].mask(SynthEffectsMask);
  SynthEffectsNoteColor[71].mask(SynthEffectsMask);
  SynthEffectsNoteColor[72].mask(SynthEffectsMask);
  SynthEffectsNoteColor[73].mask(SynthEffectsMask);
  SynthEffectsNoteColor[74].mask(SynthEffectsMask);
  SynthEffectsNoteColor[75].mask(SynthEffectsMask);
  SynthEffectsNoteColor[76].mask(SynthEffectsMask);
  SynthEffectsNoteColor[77].mask(SynthEffectsMask);
  SynthEffectsNoteColor[78].mask(SynthEffectsMask);
  SynthEffectsNoteColor[79].mask(SynthEffectsMask);
  SynthEffectsNoteColor[80].mask(SynthEffectsMask);
  SynthEffectsNoteColor[81].mask(SynthEffectsMask);
  SynthEffectsNoteColor[82].mask(SynthEffectsMask);
  SynthEffectsNoteColor[83].mask(SynthEffectsMask);
  SynthEffectsNoteColor[84].mask(SynthEffectsMask);
  SynthEffectsNoteColor[85].mask(SynthEffectsMask);
  SynthEffectsNoteColor[86].mask(SynthEffectsMask);
  SynthEffectsNoteColor[87].mask(SynthEffectsMask);
  SynthEffectsNoteColor[88].mask(SynthEffectsMask);
  SynthEffectsNoteColor[89].mask(SynthEffectsMask);
  SynthEffectsNoteColor[90].mask(SynthEffectsMask);
  SynthEffectsNoteColor[91].mask(SynthEffectsMask);
  SynthEffectsNoteColor[92].mask(SynthEffectsMask);
  SynthEffectsNoteColor[93].mask(SynthEffectsMask);
  SynthEffectsNoteColor[94].mask(SynthEffectsMask);
  SynthEffectsNoteColor[95].mask(SynthEffectsMask);
  SynthEffectsNoteColor[96].mask(SynthEffectsMask);
  SynthEffectsNoteColor[97].mask(SynthEffectsMask);
  SynthEffectsNoteColor[98].mask(SynthEffectsMask);
  SynthEffectsNoteColor[99].mask(SynthEffectsMask);
  SynthEffectsNoteColor[100].mask(SynthEffectsMask);
  SynthEffectsNoteColor[101].mask(SynthEffectsMask);
  SynthEffectsNoteColor[102].mask(SynthEffectsMask);
  SynthEffectsNoteColor[103].mask(SynthEffectsMask);
  SynthEffectsNoteColor[104].mask(SynthEffectsMask);
  SynthEffectsNoteColor[105].mask(SynthEffectsMask);
  SynthEffectsNoteColor[106].mask(SynthEffectsMask);
  SynthEffectsNoteColor[107].mask(SynthEffectsMask);
  SynthEffectsNoteColor[108].mask(SynthEffectsMask);
  SynthEffectsNoteColor[109].mask(SynthEffectsMask);
  SynthEffectsNoteColor[110].mask(SynthEffectsMask);
  SynthEffectsNoteColor[111].mask(SynthEffectsMask);
  SynthEffectsNoteColor[112].mask(SynthEffectsMask);
  SynthEffectsNoteColor[113].mask(SynthEffectsMask);
  SynthEffectsNoteColor[114].mask(SynthEffectsMask);
  SynthEffectsNoteColor[115].mask(SynthEffectsMask);
  SynthEffectsNoteColor[116].mask(SynthEffectsMask);
  SynthEffectsNoteColor[117].mask(SynthEffectsMask);
  SynthEffectsNoteColor[118].mask(SynthEffectsMask);
  SynthEffectsNoteColor[119].mask(SynthEffectsMask);
  SynthEffectsNoteColor[120].mask(SynthEffectsMask);
  SynthEffectsNoteColor[121].mask(SynthEffectsMask);
  SynthEffectsNoteColor[122].mask(SynthEffectsMask);
  SynthEffectsNoteColor[123].mask(SynthEffectsMask);
  SynthEffectsNoteColor[124].mask(SynthEffectsMask);
  SynthEffectsNoteColor[125].mask(SynthEffectsMask);
  SynthEffectsNoteColor[126].mask(SynthEffectsMask);
  SynthEffectsNoteColor[127].mask(SynthEffectsMask);
  //Ethnic
  EthnicNoteColor[0].mask(EthnicMask);
  EthnicNoteColor[1].mask(EthnicMask);
  EthnicNoteColor[2].mask(EthnicMask);
  EthnicNoteColor[3].mask(EthnicMask);
  EthnicNoteColor[4].mask(EthnicMask);
  EthnicNoteColor[5].mask(EthnicMask);
  EthnicNoteColor[6].mask(EthnicMask);
  EthnicNoteColor[7].mask(EthnicMask);
  EthnicNoteColor[8].mask(EthnicMask);
  EthnicNoteColor[9].mask(EthnicMask);
  EthnicNoteColor[10].mask(EthnicMask);
  EthnicNoteColor[11].mask(EthnicMask);
  EthnicNoteColor[12].mask(EthnicMask);
  EthnicNoteColor[13].mask(EthnicMask);
  EthnicNoteColor[14].mask(EthnicMask);
  EthnicNoteColor[15].mask(EthnicMask);
  EthnicNoteColor[16].mask(EthnicMask);
  EthnicNoteColor[17].mask(EthnicMask);
  EthnicNoteColor[18].mask(EthnicMask);
  EthnicNoteColor[19].mask(EthnicMask);
  EthnicNoteColor[20].mask(EthnicMask);
  EthnicNoteColor[21].mask(EthnicMask);
  EthnicNoteColor[22].mask(EthnicMask);
  EthnicNoteColor[23].mask(EthnicMask);
  EthnicNoteColor[24].mask(EthnicMask);
  EthnicNoteColor[25].mask(EthnicMask);
  EthnicNoteColor[26].mask(EthnicMask);
  EthnicNoteColor[27].mask(EthnicMask);
  EthnicNoteColor[28].mask(EthnicMask);
  EthnicNoteColor[29].mask(EthnicMask);
  EthnicNoteColor[30].mask(EthnicMask);
  EthnicNoteColor[31].mask(EthnicMask);
  EthnicNoteColor[32].mask(EthnicMask);
  EthnicNoteColor[33].mask(EthnicMask);
  EthnicNoteColor[34].mask(EthnicMask);
  EthnicNoteColor[35].mask(EthnicMask);
  EthnicNoteColor[36].mask(EthnicMask);
  EthnicNoteColor[37].mask(EthnicMask);
  EthnicNoteColor[38].mask(EthnicMask);
  EthnicNoteColor[39].mask(EthnicMask);
  EthnicNoteColor[40].mask(EthnicMask);
  EthnicNoteColor[41].mask(EthnicMask);
  EthnicNoteColor[42].mask(EthnicMask);
  EthnicNoteColor[43].mask(EthnicMask);
  EthnicNoteColor[44].mask(EthnicMask);
  EthnicNoteColor[45].mask(EthnicMask);
  EthnicNoteColor[46].mask(EthnicMask);
  EthnicNoteColor[47].mask(EthnicMask);
  EthnicNoteColor[48].mask(EthnicMask);
  EthnicNoteColor[49].mask(EthnicMask);
  EthnicNoteColor[50].mask(EthnicMask);
  EthnicNoteColor[51].mask(EthnicMask);
  EthnicNoteColor[52].mask(EthnicMask);
  EthnicNoteColor[53].mask(EthnicMask);
  EthnicNoteColor[54].mask(EthnicMask);
  EthnicNoteColor[55].mask(EthnicMask);
  EthnicNoteColor[56].mask(EthnicMask);
  EthnicNoteColor[57].mask(EthnicMask);
  EthnicNoteColor[58].mask(EthnicMask);
  EthnicNoteColor[59].mask(EthnicMask);
  EthnicNoteColor[60].mask(EthnicMask);
  EthnicNoteColor[61].mask(EthnicMask);
  EthnicNoteColor[62].mask(EthnicMask);
  EthnicNoteColor[63].mask(EthnicMask);
  EthnicNoteColor[64].mask(EthnicMask);
  EthnicNoteColor[65].mask(EthnicMask);
  EthnicNoteColor[66].mask(EthnicMask);
  EthnicNoteColor[67].mask(EthnicMask);
  EthnicNoteColor[68].mask(EthnicMask);
  EthnicNoteColor[69].mask(EthnicMask);
  EthnicNoteColor[70].mask(EthnicMask);
  EthnicNoteColor[71].mask(EthnicMask);
  EthnicNoteColor[72].mask(EthnicMask);
  EthnicNoteColor[73].mask(EthnicMask);
  EthnicNoteColor[74].mask(EthnicMask);
  EthnicNoteColor[75].mask(EthnicMask);
  EthnicNoteColor[76].mask(EthnicMask);
  EthnicNoteColor[77].mask(EthnicMask);
  EthnicNoteColor[78].mask(EthnicMask);
  EthnicNoteColor[79].mask(EthnicMask);
  EthnicNoteColor[80].mask(EthnicMask);
  EthnicNoteColor[81].mask(EthnicMask);
  EthnicNoteColor[82].mask(EthnicMask);
  EthnicNoteColor[83].mask(EthnicMask);
  EthnicNoteColor[84].mask(EthnicMask);
  EthnicNoteColor[85].mask(EthnicMask);
  EthnicNoteColor[86].mask(EthnicMask);
  EthnicNoteColor[87].mask(EthnicMask);
  EthnicNoteColor[88].mask(EthnicMask);
  EthnicNoteColor[89].mask(EthnicMask);
  EthnicNoteColor[90].mask(EthnicMask);
  EthnicNoteColor[91].mask(EthnicMask);
  EthnicNoteColor[92].mask(EthnicMask);
  EthnicNoteColor[93].mask(EthnicMask);
  EthnicNoteColor[94].mask(EthnicMask);
  EthnicNoteColor[95].mask(EthnicMask);
  EthnicNoteColor[96].mask(EthnicMask);
  EthnicNoteColor[97].mask(EthnicMask);
  EthnicNoteColor[98].mask(EthnicMask);
  EthnicNoteColor[99].mask(EthnicMask);
  EthnicNoteColor[100].mask(EthnicMask);
  EthnicNoteColor[101].mask(EthnicMask);
  EthnicNoteColor[102].mask(EthnicMask);
  EthnicNoteColor[103].mask(EthnicMask);
  EthnicNoteColor[104].mask(EthnicMask);
  EthnicNoteColor[105].mask(EthnicMask);
  EthnicNoteColor[106].mask(EthnicMask);
  EthnicNoteColor[107].mask(EthnicMask);
  EthnicNoteColor[108].mask(EthnicMask);
  EthnicNoteColor[109].mask(EthnicMask);
  EthnicNoteColor[110].mask(EthnicMask);
  EthnicNoteColor[111].mask(EthnicMask);
  EthnicNoteColor[112].mask(EthnicMask);
  EthnicNoteColor[113].mask(EthnicMask);
  EthnicNoteColor[114].mask(EthnicMask);
  EthnicNoteColor[115].mask(EthnicMask);
  EthnicNoteColor[116].mask(EthnicMask);
  EthnicNoteColor[117].mask(EthnicMask);
  EthnicNoteColor[118].mask(EthnicMask);
  EthnicNoteColor[119].mask(EthnicMask);
  EthnicNoteColor[120].mask(EthnicMask);
  EthnicNoteColor[121].mask(EthnicMask);
  EthnicNoteColor[122].mask(EthnicMask);
  EthnicNoteColor[123].mask(EthnicMask);
  EthnicNoteColor[124].mask(EthnicMask);
  EthnicNoteColor[125].mask(EthnicMask);
  EthnicNoteColor[126].mask(EthnicMask);
  EthnicNoteColor[127].mask(EthnicMask);
  //Percussive
  PercussiveNoteColor[0].mask(PercussiveMask);
  PercussiveNoteColor[1].mask(PercussiveMask);
  PercussiveNoteColor[2].mask(PercussiveMask);
  PercussiveNoteColor[3].mask(PercussiveMask);
  PercussiveNoteColor[4].mask(PercussiveMask);
  PercussiveNoteColor[5].mask(PercussiveMask);
  PercussiveNoteColor[6].mask(PercussiveMask);
  PercussiveNoteColor[7].mask(PercussiveMask);
  PercussiveNoteColor[8].mask(PercussiveMask);
  PercussiveNoteColor[9].mask(PercussiveMask);
  PercussiveNoteColor[10].mask(PercussiveMask);
  PercussiveNoteColor[11].mask(PercussiveMask);
  PercussiveNoteColor[12].mask(PercussiveMask);
  PercussiveNoteColor[13].mask(PercussiveMask);
  PercussiveNoteColor[14].mask(PercussiveMask);
  PercussiveNoteColor[15].mask(PercussiveMask);
  PercussiveNoteColor[16].mask(PercussiveMask);
  PercussiveNoteColor[17].mask(PercussiveMask);
  PercussiveNoteColor[18].mask(PercussiveMask);
  PercussiveNoteColor[19].mask(PercussiveMask);
  PercussiveNoteColor[20].mask(PercussiveMask);
  PercussiveNoteColor[21].mask(PercussiveMask);
  PercussiveNoteColor[22].mask(PercussiveMask);
  PercussiveNoteColor[23].mask(PercussiveMask);
  PercussiveNoteColor[24].mask(PercussiveMask);
  PercussiveNoteColor[25].mask(PercussiveMask);
  PercussiveNoteColor[26].mask(PercussiveMask);
  PercussiveNoteColor[27].mask(PercussiveMask);
  PercussiveNoteColor[28].mask(PercussiveMask);
  PercussiveNoteColor[29].mask(PercussiveMask);
  PercussiveNoteColor[30].mask(PercussiveMask);
  PercussiveNoteColor[31].mask(PercussiveMask);
  PercussiveNoteColor[32].mask(PercussiveMask);
  PercussiveNoteColor[33].mask(PercussiveMask);
  PercussiveNoteColor[34].mask(PercussiveMask);
  PercussiveNoteColor[35].mask(PercussiveMask);
  PercussiveNoteColor[36].mask(PercussiveMask);
  PercussiveNoteColor[37].mask(PercussiveMask);
  PercussiveNoteColor[38].mask(PercussiveMask);
  PercussiveNoteColor[39].mask(PercussiveMask);
  PercussiveNoteColor[40].mask(PercussiveMask);
  PercussiveNoteColor[41].mask(PercussiveMask);
  PercussiveNoteColor[42].mask(PercussiveMask);
  PercussiveNoteColor[43].mask(PercussiveMask);
  PercussiveNoteColor[44].mask(PercussiveMask);
  PercussiveNoteColor[45].mask(PercussiveMask);
  PercussiveNoteColor[46].mask(PercussiveMask);
  PercussiveNoteColor[47].mask(PercussiveMask);
  PercussiveNoteColor[48].mask(PercussiveMask);
  PercussiveNoteColor[49].mask(PercussiveMask);
  PercussiveNoteColor[50].mask(PercussiveMask);
  PercussiveNoteColor[51].mask(PercussiveMask);
  PercussiveNoteColor[52].mask(PercussiveMask);
  PercussiveNoteColor[53].mask(PercussiveMask);
  PercussiveNoteColor[54].mask(PercussiveMask);
  PercussiveNoteColor[55].mask(PercussiveMask);
  PercussiveNoteColor[56].mask(PercussiveMask);
  PercussiveNoteColor[57].mask(PercussiveMask);
  PercussiveNoteColor[58].mask(PercussiveMask);
  PercussiveNoteColor[59].mask(PercussiveMask);
  PercussiveNoteColor[60].mask(PercussiveMask);
  PercussiveNoteColor[61].mask(PercussiveMask);
  PercussiveNoteColor[62].mask(PercussiveMask);
  PercussiveNoteColor[63].mask(PercussiveMask);
  PercussiveNoteColor[64].mask(PercussiveMask);
  PercussiveNoteColor[65].mask(PercussiveMask);
  PercussiveNoteColor[66].mask(PercussiveMask);
  PercussiveNoteColor[67].mask(PercussiveMask);
  PercussiveNoteColor[68].mask(PercussiveMask);
  PercussiveNoteColor[69].mask(PercussiveMask);
  PercussiveNoteColor[70].mask(PercussiveMask);
  PercussiveNoteColor[71].mask(PercussiveMask);
  PercussiveNoteColor[72].mask(PercussiveMask);
  PercussiveNoteColor[73].mask(PercussiveMask);
  PercussiveNoteColor[74].mask(PercussiveMask);
  PercussiveNoteColor[75].mask(PercussiveMask);
  PercussiveNoteColor[76].mask(PercussiveMask);
  PercussiveNoteColor[77].mask(PercussiveMask);
  PercussiveNoteColor[78].mask(PercussiveMask);
  PercussiveNoteColor[79].mask(PercussiveMask);
  PercussiveNoteColor[80].mask(PercussiveMask);
  PercussiveNoteColor[81].mask(PercussiveMask);
  PercussiveNoteColor[82].mask(PercussiveMask);
  PercussiveNoteColor[83].mask(PercussiveMask);
  PercussiveNoteColor[84].mask(PercussiveMask);
  PercussiveNoteColor[85].mask(PercussiveMask);
  PercussiveNoteColor[86].mask(PercussiveMask);
  PercussiveNoteColor[87].mask(PercussiveMask);
  PercussiveNoteColor[88].mask(PercussiveMask);
  PercussiveNoteColor[89].mask(PercussiveMask);
  PercussiveNoteColor[90].mask(PercussiveMask);
  PercussiveNoteColor[91].mask(PercussiveMask);
  PercussiveNoteColor[92].mask(PercussiveMask);
  PercussiveNoteColor[93].mask(PercussiveMask);
  PercussiveNoteColor[94].mask(PercussiveMask);
  PercussiveNoteColor[95].mask(PercussiveMask);
  PercussiveNoteColor[96].mask(PercussiveMask);
  PercussiveNoteColor[97].mask(PercussiveMask);
  PercussiveNoteColor[98].mask(PercussiveMask);
  PercussiveNoteColor[99].mask(PercussiveMask);
  PercussiveNoteColor[100].mask(PercussiveMask);
  PercussiveNoteColor[101].mask(PercussiveMask);
  PercussiveNoteColor[102].mask(PercussiveMask);
  PercussiveNoteColor[103].mask(PercussiveMask);
  PercussiveNoteColor[104].mask(PercussiveMask);
  PercussiveNoteColor[105].mask(PercussiveMask);
  PercussiveNoteColor[106].mask(PercussiveMask);
  PercussiveNoteColor[107].mask(PercussiveMask);
  PercussiveNoteColor[108].mask(PercussiveMask);
  PercussiveNoteColor[109].mask(PercussiveMask);
  PercussiveNoteColor[110].mask(PercussiveMask);
  PercussiveNoteColor[111].mask(PercussiveMask);
  PercussiveNoteColor[112].mask(PercussiveMask);
  PercussiveNoteColor[113].mask(PercussiveMask);
  PercussiveNoteColor[114].mask(PercussiveMask);
  PercussiveNoteColor[115].mask(PercussiveMask);
  PercussiveNoteColor[116].mask(PercussiveMask);
  PercussiveNoteColor[117].mask(PercussiveMask);
  PercussiveNoteColor[118].mask(PercussiveMask);
  PercussiveNoteColor[119].mask(PercussiveMask);
  PercussiveNoteColor[120].mask(PercussiveMask);
  PercussiveNoteColor[121].mask(PercussiveMask);
  PercussiveNoteColor[122].mask(PercussiveMask);
  PercussiveNoteColor[123].mask(PercussiveMask);
  PercussiveNoteColor[124].mask(PercussiveMask);
  PercussiveNoteColor[125].mask(PercussiveMask);
  PercussiveNoteColor[126].mask(PercussiveMask);
  PercussiveNoteColor[127].mask(PercussiveMask);
  //Sound Effects
  SoundEffectsNoteColor[0].mask(SoundEffectsMask);
  SoundEffectsNoteColor[1].mask(SoundEffectsMask);
  SoundEffectsNoteColor[2].mask(SoundEffectsMask);
  SoundEffectsNoteColor[3].mask(SoundEffectsMask);
  SoundEffectsNoteColor[4].mask(SoundEffectsMask);
  SoundEffectsNoteColor[5].mask(SoundEffectsMask);
  SoundEffectsNoteColor[6].mask(SoundEffectsMask);
  SoundEffectsNoteColor[7].mask(SoundEffectsMask);
  SoundEffectsNoteColor[8].mask(SoundEffectsMask);
  SoundEffectsNoteColor[9].mask(SoundEffectsMask);
  SoundEffectsNoteColor[10].mask(SoundEffectsMask);
  SoundEffectsNoteColor[11].mask(SoundEffectsMask);
  SoundEffectsNoteColor[12].mask(SoundEffectsMask);
  SoundEffectsNoteColor[13].mask(SoundEffectsMask);
  SoundEffectsNoteColor[14].mask(SoundEffectsMask);
  SoundEffectsNoteColor[15].mask(SoundEffectsMask);
  SoundEffectsNoteColor[16].mask(SoundEffectsMask);
  SoundEffectsNoteColor[17].mask(SoundEffectsMask);
  SoundEffectsNoteColor[18].mask(SoundEffectsMask);
  SoundEffectsNoteColor[19].mask(SoundEffectsMask);
  SoundEffectsNoteColor[20].mask(SoundEffectsMask);
  SoundEffectsNoteColor[21].mask(SoundEffectsMask);
  SoundEffectsNoteColor[22].mask(SoundEffectsMask);
  SoundEffectsNoteColor[23].mask(SoundEffectsMask);
  SoundEffectsNoteColor[24].mask(SoundEffectsMask);
  SoundEffectsNoteColor[25].mask(SoundEffectsMask);
  SoundEffectsNoteColor[26].mask(SoundEffectsMask);
  SoundEffectsNoteColor[27].mask(SoundEffectsMask);
  SoundEffectsNoteColor[28].mask(SoundEffectsMask);
  SoundEffectsNoteColor[29].mask(SoundEffectsMask);
  SoundEffectsNoteColor[30].mask(SoundEffectsMask);
  SoundEffectsNoteColor[31].mask(SoundEffectsMask);
  SoundEffectsNoteColor[32].mask(SoundEffectsMask);
  SoundEffectsNoteColor[33].mask(SoundEffectsMask);
  SoundEffectsNoteColor[34].mask(SoundEffectsMask);
  SoundEffectsNoteColor[35].mask(SoundEffectsMask);
  SoundEffectsNoteColor[36].mask(SoundEffectsMask);
  SoundEffectsNoteColor[37].mask(SoundEffectsMask);
  SoundEffectsNoteColor[38].mask(SoundEffectsMask);
  SoundEffectsNoteColor[39].mask(SoundEffectsMask);
  SoundEffectsNoteColor[40].mask(SoundEffectsMask);
  SoundEffectsNoteColor[41].mask(SoundEffectsMask);
  SoundEffectsNoteColor[42].mask(SoundEffectsMask);
  SoundEffectsNoteColor[43].mask(SoundEffectsMask);
  SoundEffectsNoteColor[44].mask(SoundEffectsMask);
  SoundEffectsNoteColor[45].mask(SoundEffectsMask);
  SoundEffectsNoteColor[46].mask(SoundEffectsMask);
  SoundEffectsNoteColor[47].mask(SoundEffectsMask);
  SoundEffectsNoteColor[48].mask(SoundEffectsMask);
  SoundEffectsNoteColor[49].mask(SoundEffectsMask);
  SoundEffectsNoteColor[50].mask(SoundEffectsMask);
  SoundEffectsNoteColor[51].mask(SoundEffectsMask);
  SoundEffectsNoteColor[52].mask(SoundEffectsMask);
  SoundEffectsNoteColor[53].mask(SoundEffectsMask);
  SoundEffectsNoteColor[54].mask(SoundEffectsMask);
  SoundEffectsNoteColor[55].mask(SoundEffectsMask);
  SoundEffectsNoteColor[56].mask(SoundEffectsMask);
  SoundEffectsNoteColor[57].mask(SoundEffectsMask);
  SoundEffectsNoteColor[58].mask(SoundEffectsMask);
  SoundEffectsNoteColor[59].mask(SoundEffectsMask);
  SoundEffectsNoteColor[60].mask(SoundEffectsMask);
  SoundEffectsNoteColor[61].mask(SoundEffectsMask);
  SoundEffectsNoteColor[62].mask(SoundEffectsMask);
  SoundEffectsNoteColor[63].mask(SoundEffectsMask);
  SoundEffectsNoteColor[64].mask(SoundEffectsMask);
  SoundEffectsNoteColor[65].mask(SoundEffectsMask);
  SoundEffectsNoteColor[66].mask(SoundEffectsMask);
  SoundEffectsNoteColor[67].mask(SoundEffectsMask);
  SoundEffectsNoteColor[68].mask(SoundEffectsMask);
  SoundEffectsNoteColor[69].mask(SoundEffectsMask);
  SoundEffectsNoteColor[70].mask(SoundEffectsMask);
  SoundEffectsNoteColor[71].mask(SoundEffectsMask);
  SoundEffectsNoteColor[72].mask(SoundEffectsMask);
  SoundEffectsNoteColor[73].mask(SoundEffectsMask);
  SoundEffectsNoteColor[74].mask(SoundEffectsMask);
  SoundEffectsNoteColor[75].mask(SoundEffectsMask);
  SoundEffectsNoteColor[76].mask(SoundEffectsMask);
  SoundEffectsNoteColor[77].mask(SoundEffectsMask);
  SoundEffectsNoteColor[78].mask(SoundEffectsMask);
  SoundEffectsNoteColor[79].mask(SoundEffectsMask);
  SoundEffectsNoteColor[80].mask(SoundEffectsMask);
  SoundEffectsNoteColor[81].mask(SoundEffectsMask);
  SoundEffectsNoteColor[82].mask(SoundEffectsMask);
  SoundEffectsNoteColor[83].mask(SoundEffectsMask);
  SoundEffectsNoteColor[84].mask(SoundEffectsMask);
  SoundEffectsNoteColor[85].mask(SoundEffectsMask);
  SoundEffectsNoteColor[86].mask(SoundEffectsMask);
  SoundEffectsNoteColor[87].mask(SoundEffectsMask);
  SoundEffectsNoteColor[88].mask(SoundEffectsMask);
  SoundEffectsNoteColor[89].mask(SoundEffectsMask);
  SoundEffectsNoteColor[90].mask(SoundEffectsMask);
  SoundEffectsNoteColor[91].mask(SoundEffectsMask);
  SoundEffectsNoteColor[92].mask(SoundEffectsMask);
  SoundEffectsNoteColor[93].mask(SoundEffectsMask);
  SoundEffectsNoteColor[94].mask(SoundEffectsMask);
  SoundEffectsNoteColor[95].mask(SoundEffectsMask);
  SoundEffectsNoteColor[96].mask(SoundEffectsMask);
  SoundEffectsNoteColor[97].mask(SoundEffectsMask);
  SoundEffectsNoteColor[98].mask(SoundEffectsMask);
  SoundEffectsNoteColor[99].mask(SoundEffectsMask);
  SoundEffectsNoteColor[100].mask(SoundEffectsMask);
  SoundEffectsNoteColor[101].mask(SoundEffectsMask);
  SoundEffectsNoteColor[102].mask(SoundEffectsMask);
  SoundEffectsNoteColor[103].mask(SoundEffectsMask);
  SoundEffectsNoteColor[104].mask(SoundEffectsMask);
  SoundEffectsNoteColor[105].mask(SoundEffectsMask);
  SoundEffectsNoteColor[106].mask(SoundEffectsMask);
  SoundEffectsNoteColor[107].mask(SoundEffectsMask);
  SoundEffectsNoteColor[108].mask(SoundEffectsMask);
  SoundEffectsNoteColor[109].mask(SoundEffectsMask);
  SoundEffectsNoteColor[110].mask(SoundEffectsMask);
  SoundEffectsNoteColor[111].mask(SoundEffectsMask);
  SoundEffectsNoteColor[112].mask(SoundEffectsMask);
  SoundEffectsNoteColor[113].mask(SoundEffectsMask);
  SoundEffectsNoteColor[114].mask(SoundEffectsMask);
  SoundEffectsNoteColor[115].mask(SoundEffectsMask);
  SoundEffectsNoteColor[116].mask(SoundEffectsMask);
  SoundEffectsNoteColor[117].mask(SoundEffectsMask);
  SoundEffectsNoteColor[118].mask(SoundEffectsMask);
  SoundEffectsNoteColor[119].mask(SoundEffectsMask);
  SoundEffectsNoteColor[120].mask(SoundEffectsMask);
  SoundEffectsNoteColor[121].mask(SoundEffectsMask);
  SoundEffectsNoteColor[122].mask(SoundEffectsMask);
  SoundEffectsNoteColor[123].mask(SoundEffectsMask);
  SoundEffectsNoteColor[124].mask(SoundEffectsMask);
  SoundEffectsNoteColor[125].mask(SoundEffectsMask);
  SoundEffectsNoteColor[126].mask(SoundEffectsMask);
  SoundEffectsNoteColor[127].mask(SoundEffectsMask);
  //Percussion
  PercussionNoteColor[0].mask(PercussionMask);
  PercussionNoteColor[1].mask(PercussionMask);
  PercussionNoteColor[2].mask(PercussionMask);
  PercussionNoteColor[3].mask(PercussionMask);
  PercussionNoteColor[4].mask(PercussionMask);
  PercussionNoteColor[5].mask(PercussionMask);
  PercussionNoteColor[6].mask(PercussionMask);
  PercussionNoteColor[7].mask(PercussionMask);
  PercussionNoteColor[8].mask(PercussionMask);
  PercussionNoteColor[9].mask(PercussionMask);
  PercussionNoteColor[10].mask(PercussionMask);
  PercussionNoteColor[11].mask(PercussionMask);
  PercussionNoteColor[12].mask(PercussionMask);
  PercussionNoteColor[13].mask(PercussionMask);
  PercussionNoteColor[14].mask(PercussionMask);
  PercussionNoteColor[15].mask(PercussionMask);
  PercussionNoteColor[16].mask(PercussionMask);
  PercussionNoteColor[17].mask(PercussionMask);
  PercussionNoteColor[18].mask(PercussionMask);
  PercussionNoteColor[19].mask(PercussionMask);
  PercussionNoteColor[20].mask(PercussionMask);
  PercussionNoteColor[21].mask(PercussionMask);
  PercussionNoteColor[22].mask(PercussionMask);
  PercussionNoteColor[23].mask(PercussionMask);
  PercussionNoteColor[24].mask(PercussionMask);
  PercussionNoteColor[25].mask(PercussionMask);
  PercussionNoteColor[26].mask(PercussionMask);
  PercussionNoteColor[27].mask(PercussionMask);
  PercussionNoteColor[28].mask(PercussionMask);
  PercussionNoteColor[29].mask(PercussionMask);
  PercussionNoteColor[30].mask(PercussionMask);
  PercussionNoteColor[31].mask(PercussionMask);
  PercussionNoteColor[32].mask(PercussionMask);
  PercussionNoteColor[33].mask(PercussionMask);
  PercussionNoteColor[34].mask(PercussionMask);
  PercussionNoteColor[35].mask(PercussionMask);
  PercussionNoteColor[36].mask(PercussionMask);
  PercussionNoteColor[37].mask(PercussionMask);
  PercussionNoteColor[38].mask(PercussionMask);
  PercussionNoteColor[39].mask(PercussionMask);
  PercussionNoteColor[40].mask(PercussionMask);
  PercussionNoteColor[41].mask(PercussionMask);
  PercussionNoteColor[42].mask(PercussionMask);
  PercussionNoteColor[43].mask(PercussionMask);
  PercussionNoteColor[44].mask(PercussionMask);
  PercussionNoteColor[45].mask(PercussionMask);
  PercussionNoteColor[46].mask(PercussionMask);
  PercussionNoteColor[47].mask(PercussionMask);
  PercussionNoteColor[48].mask(PercussionMask);
  PercussionNoteColor[49].mask(PercussionMask);
  PercussionNoteColor[50].mask(PercussionMask);
  PercussionNoteColor[51].mask(PercussionMask);
  PercussionNoteColor[52].mask(PercussionMask);
  PercussionNoteColor[53].mask(PercussionMask);
  PercussionNoteColor[54].mask(PercussionMask);
  PercussionNoteColor[55].mask(PercussionMask);
  PercussionNoteColor[56].mask(PercussionMask);
  PercussionNoteColor[57].mask(PercussionMask);
  PercussionNoteColor[58].mask(PercussionMask);
  PercussionNoteColor[59].mask(PercussionMask);
  PercussionNoteColor[60].mask(PercussionMask);
  PercussionNoteColor[61].mask(PercussionMask);
  PercussionNoteColor[62].mask(PercussionMask);
  PercussionNoteColor[63].mask(PercussionMask);
  PercussionNoteColor[64].mask(PercussionMask);
  PercussionNoteColor[65].mask(PercussionMask);
  PercussionNoteColor[66].mask(PercussionMask);
  PercussionNoteColor[67].mask(PercussionMask);
  PercussionNoteColor[68].mask(PercussionMask);
  PercussionNoteColor[69].mask(PercussionMask);
  PercussionNoteColor[70].mask(PercussionMask);
  PercussionNoteColor[71].mask(PercussionMask);
  PercussionNoteColor[72].mask(PercussionMask);
  PercussionNoteColor[73].mask(PercussionMask);
  PercussionNoteColor[74].mask(PercussionMask);
  PercussionNoteColor[75].mask(PercussionMask);
  PercussionNoteColor[76].mask(PercussionMask);
  PercussionNoteColor[77].mask(PercussionMask);
  PercussionNoteColor[78].mask(PercussionMask);
  PercussionNoteColor[79].mask(PercussionMask);
  PercussionNoteColor[80].mask(PercussionMask);
  PercussionNoteColor[81].mask(PercussionMask);
  PercussionNoteColor[82].mask(PercussionMask);
  PercussionNoteColor[83].mask(PercussionMask);
  PercussionNoteColor[84].mask(PercussionMask);
  PercussionNoteColor[85].mask(PercussionMask);
  PercussionNoteColor[86].mask(PercussionMask);
  PercussionNoteColor[87].mask(PercussionMask);
  PercussionNoteColor[88].mask(PercussionMask);
  PercussionNoteColor[89].mask(PercussionMask);
  PercussionNoteColor[90].mask(PercussionMask);
  PercussionNoteColor[91].mask(PercussionMask);
  PercussionNoteColor[92].mask(PercussionMask);
  PercussionNoteColor[93].mask(PercussionMask);
  PercussionNoteColor[94].mask(PercussionMask);
  PercussionNoteColor[95].mask(PercussionMask);
  PercussionNoteColor[96].mask(PercussionMask);
  PercussionNoteColor[97].mask(PercussionMask);
  PercussionNoteColor[98].mask(PercussionMask);
  PercussionNoteColor[99].mask(PercussionMask);
  PercussionNoteColor[100].mask(PercussionMask);
  PercussionNoteColor[101].mask(PercussionMask);
  PercussionNoteColor[102].mask(PercussionMask);
  PercussionNoteColor[103].mask(PercussionMask);
  PercussionNoteColor[104].mask(PercussionMask);
  PercussionNoteColor[105].mask(PercussionMask);
  PercussionNoteColor[106].mask(PercussionMask);
  PercussionNoteColor[107].mask(PercussionMask);
  PercussionNoteColor[108].mask(PercussionMask);
  PercussionNoteColor[109].mask(PercussionMask);
  PercussionNoteColor[110].mask(PercussionMask);
  PercussionNoteColor[111].mask(PercussionMask);
  PercussionNoteColor[112].mask(PercussionMask);
  PercussionNoteColor[113].mask(PercussionMask);
  PercussionNoteColor[114].mask(PercussionMask);
  PercussionNoteColor[115].mask(PercussionMask);
  PercussionNoteColor[116].mask(PercussionMask);
  PercussionNoteColor[117].mask(PercussionMask);
  PercussionNoteColor[118].mask(PercussionMask);
  PercussionNoteColor[119].mask(PercussionMask);
  PercussionNoteColor[120].mask(PercussionMask);
  PercussionNoteColor[121].mask(PercussionMask);
  PercussionNoteColor[122].mask(PercussionMask);
  PercussionNoteColor[123].mask(PercussionMask);
  PercussionNoteColor[124].mask(PercussionMask);
  PercussionNoteColor[125].mask(PercussionMask);
  PercussionNoteColor[126].mask(PercussionMask);
  PercussionNoteColor[127].mask(PercussionMask);
}

//Draw
void draw() {
  debug = new Debug();
//  debug.framerate();
  debug.clickToPrintVariables();

 //Sky
  noStroke();
  rotateY(radians(sphereRotateY));
  noStroke();
  shape(dome);
//  sphereRotateY = sphereRotateY+0.05; //Animation/Gyro drift fix
  
  //Starfield
  for(int i=0;i<numstars;i++){
    s[i].DrawStar();
  }
  
  //Grids
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
  
  //Animation
    //Noise
    float Noisem1 = noise(am1)*NoiseScale; am1+=0.0;
    float Noise0  = noise( a0)*NoiseScale;  a0+=0.1;
    float Noise1  = noise( a1)*NoiseScale;  a1+=0.2;
    float Noise2  = noise( a2)*NoiseScale;  a2+=0.3;
    float Noise3  = noise( a3)*NoiseScale;  a3+=0.4;
    float Noise4  = noise( a4)*NoiseScale;  a4+=0.5;
    float Noise5  = noise( a5)*NoiseScale;  a5+=0.6;
    float Noise6  = noise( a6)*NoiseScale;  a6+=0.7;
    float Noise7  = noise( a7)*NoiseScale;  a7+=0.8;
    float Noise8  = noise( a7)*NoiseScale;  a7+=0.9;
    float Noise9  = noise( a7)*NoiseScale;  a7+=1.0;

  //Piano
  if (ChannelIsActive[0] == true) {// Piano Channel graphics        X                  Y               Z         Width          Height           Depth            Hue           Saturation             Brightness                 Alpha                 Texture           Display graphics
    if (PitchIsActive[0]   == true) {pianogfx = new PianoGFX (PianoPitchX[0  ], PianoVelocityY[0]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[0]  , PianoNoteColor[0]  ); pianogfx.display();}
    if (PitchIsActive[1]   == true) {pianogfx = new PianoGFX (PianoPitchX[1  ], PianoVelocityY[1]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[1]  , PianoNoteColor[1]  ); pianogfx.display();}
    if (PitchIsActive[2]   == true) {pianogfx = new PianoGFX (PianoPitchX[2  ], PianoVelocityY[2]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[2]  , PianoNoteColor[2]  ); pianogfx.display();}
    if (PitchIsActive[3]   == true) {pianogfx = new PianoGFX (PianoPitchX[3  ], PianoVelocityY[3]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[3]  , PianoNoteColor[3]  ); pianogfx.display();}
    if (PitchIsActive[4]   == true) {pianogfx = new PianoGFX (PianoPitchX[4  ], PianoVelocityY[4]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[4]  , PianoNoteColor[4]  ); pianogfx.display();}
    if (PitchIsActive[5]   == true) {pianogfx = new PianoGFX (PianoPitchX[5  ], PianoVelocityY[5]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[5]  , PianoNoteColor[5]  ); pianogfx.display();}
    if (PitchIsActive[6]   == true) {pianogfx = new PianoGFX (PianoPitchX[6  ], PianoVelocityY[6]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[6]  , PianoNoteColor[6]  ); pianogfx.display();}
    if (PitchIsActive[7]   == true) {pianogfx = new PianoGFX (PianoPitchX[7  ], PianoVelocityY[7]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[7]  , PianoNoteColor[7]  ); pianogfx.display();}
    if (PitchIsActive[8]   == true) {pianogfx = new PianoGFX (PianoPitchX[8  ], PianoVelocityY[8]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[8]  , PianoNoteColor[8]  ); pianogfx.display();}
    if (PitchIsActive[9]   == true) {pianogfx = new PianoGFX (PianoPitchX[9  ], PianoVelocityY[9]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[9]  , PianoNoteColor[9]  ); pianogfx.display();}
    if (PitchIsActive[10]  == true) {pianogfx = new PianoGFX (PianoPitchX[10 ], PianoVelocityY[10] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[10] , PianoNoteColor[10] ); pianogfx.display();}
    if (PitchIsActive[11]  == true) {pianogfx = new PianoGFX (PianoPitchX[11 ], PianoVelocityY[11] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  PianoVelocityAlpha[11] , PianoNoteColor[11] ); pianogfx.display();}
    if (PitchIsActive[12]  == true) {pianogfx = new PianoGFX (PianoPitchX[12 ], PianoVelocityY[12] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[12] , PianoNoteColor[12] ); pianogfx.display();}
    if (PitchIsActive[13]  == true) {pianogfx = new PianoGFX (PianoPitchX[13 ], PianoVelocityY[13] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[13] , PianoNoteColor[13] ); pianogfx.display();}
    if (PitchIsActive[14]  == true) {pianogfx = new PianoGFX (PianoPitchX[14 ], PianoVelocityY[14] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[14] , PianoNoteColor[14] ); pianogfx.display();}
    if (PitchIsActive[15]  == true) {pianogfx = new PianoGFX (PianoPitchX[15 ], PianoVelocityY[15] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[15] , PianoNoteColor[15] ); pianogfx.display();}
    if (PitchIsActive[16]  == true) {pianogfx = new PianoGFX (PianoPitchX[16 ], PianoVelocityY[16] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[16] , PianoNoteColor[16] ); pianogfx.display();}
    if (PitchIsActive[17]  == true) {pianogfx = new PianoGFX (PianoPitchX[17 ], PianoVelocityY[17] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[17] , PianoNoteColor[17] ); pianogfx.display();}
    if (PitchIsActive[18]  == true) {pianogfx = new PianoGFX (PianoPitchX[18 ], PianoVelocityY[18] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[18] , PianoNoteColor[18] ); pianogfx.display();}
    if (PitchIsActive[19]  == true) {pianogfx = new PianoGFX (PianoPitchX[19 ], PianoVelocityY[19] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[19] , PianoNoteColor[19] ); pianogfx.display();}
    if (PitchIsActive[20]  == true) {pianogfx = new PianoGFX (PianoPitchX[20 ], PianoVelocityY[20] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[20] , PianoNoteColor[20] ); pianogfx.display();}
    if (PitchIsActive[21]  == true) {pianogfx = new PianoGFX (PianoPitchX[21 ], PianoVelocityY[21] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[21] , PianoNoteColor[21] ); pianogfx.display();}
    if (PitchIsActive[22]  == true) {pianogfx = new PianoGFX (PianoPitchX[22 ], PianoVelocityY[22] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[22] , PianoNoteColor[22] ); pianogfx.display();}
    if (PitchIsActive[23]  == true) {pianogfx = new PianoGFX (PianoPitchX[23 ], PianoVelocityY[23] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],  PianoVelocityAlpha[23] , PianoNoteColor[23] ); pianogfx.display();}
    if (PitchIsActive[24]  == true) {pianogfx = new PianoGFX (PianoPitchX[24 ], PianoVelocityY[24] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[24] , PianoNoteColor[24] ); pianogfx.display();}
    if (PitchIsActive[25]  == true) {pianogfx = new PianoGFX (PianoPitchX[25 ], PianoVelocityY[25] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[25] , PianoNoteColor[25] ); pianogfx.display();}
    if (PitchIsActive[26]  == true) {pianogfx = new PianoGFX (PianoPitchX[26 ], PianoVelocityY[26] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[26] , PianoNoteColor[26] ); pianogfx.display();}
    if (PitchIsActive[27]  == true) {pianogfx = new PianoGFX (PianoPitchX[27 ], PianoVelocityY[27] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[27] , PianoNoteColor[27] ); pianogfx.display();}
    if (PitchIsActive[28]  == true) {pianogfx = new PianoGFX (PianoPitchX[28 ], PianoVelocityY[28] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[28] , PianoNoteColor[28] ); pianogfx.display();}
    if (PitchIsActive[29]  == true) {pianogfx = new PianoGFX (PianoPitchX[29 ], PianoVelocityY[29] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[29] , PianoNoteColor[29] ); pianogfx.display();}
    if (PitchIsActive[30]  == true) {pianogfx = new PianoGFX (PianoPitchX[30 ], PianoVelocityY[30] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[30] , PianoNoteColor[30] ); pianogfx.display();}
    if (PitchIsActive[31]  == true) {pianogfx = new PianoGFX (PianoPitchX[31 ], PianoVelocityY[31] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[31] , PianoNoteColor[31] ); pianogfx.display();}
    if (PitchIsActive[32]  == true) {pianogfx = new PianoGFX (PianoPitchX[32 ], PianoVelocityY[32] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[32] , PianoNoteColor[32] ); pianogfx.display();}
    if (PitchIsActive[33]  == true) {pianogfx = new PianoGFX (PianoPitchX[33 ], PianoVelocityY[33] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[33] , PianoNoteColor[33] ); pianogfx.display();}
    if (PitchIsActive[34]  == true) {pianogfx = new PianoGFX (PianoPitchX[34 ], PianoVelocityY[34] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[34] , PianoNoteColor[34] ); pianogfx.display();}
    if (PitchIsActive[35]  == true) {pianogfx = new PianoGFX (PianoPitchX[35 ], PianoVelocityY[35] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],  PianoVelocityAlpha[35] , PianoNoteColor[35] ); pianogfx.display();}
    if (PitchIsActive[36]  == true) {pianogfx = new PianoGFX (PianoPitchX[36 ], PianoVelocityY[36] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[36] , PianoNoteColor[36] ); pianogfx.display();}
    if (PitchIsActive[37]  == true) {pianogfx = new PianoGFX (PianoPitchX[37 ], PianoVelocityY[37] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[37] , PianoNoteColor[37] ); pianogfx.display();}
    if (PitchIsActive[38]  == true) {pianogfx = new PianoGFX (PianoPitchX[38 ], PianoVelocityY[38] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[38] , PianoNoteColor[38] ); pianogfx.display();}
    if (PitchIsActive[39]  == true) {pianogfx = new PianoGFX (PianoPitchX[39 ], PianoVelocityY[39] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[39] , PianoNoteColor[39] ); pianogfx.display();}
    if (PitchIsActive[40]  == true) {pianogfx = new PianoGFX (PianoPitchX[40 ], PianoVelocityY[40] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[40] , PianoNoteColor[40] ); pianogfx.display();}
    if (PitchIsActive[41]  == true) {pianogfx = new PianoGFX (PianoPitchX[41 ], PianoVelocityY[41] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[41] , PianoNoteColor[41] ); pianogfx.display();}
    if (PitchIsActive[42]  == true) {pianogfx = new PianoGFX (PianoPitchX[42 ], PianoVelocityY[42] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[42] , PianoNoteColor[42] ); pianogfx.display();}
    if (PitchIsActive[43]  == true) {pianogfx = new PianoGFX (PianoPitchX[43 ], PianoVelocityY[43] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[43] , PianoNoteColor[43] ); pianogfx.display();}
    if (PitchIsActive[44]  == true) {pianogfx = new PianoGFX (PianoPitchX[44 ], PianoVelocityY[44] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[44] , PianoNoteColor[44] ); pianogfx.display();}
    if (PitchIsActive[45]  == true) {pianogfx = new PianoGFX (PianoPitchX[45 ], PianoVelocityY[45] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[45] , PianoNoteColor[45] ); pianogfx.display();}
    if (PitchIsActive[46]  == true) {pianogfx = new PianoGFX (PianoPitchX[46 ], PianoVelocityY[46] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[46] , PianoNoteColor[46] ); pianogfx.display();}
    if (PitchIsActive[47]  == true) {pianogfx = new PianoGFX (PianoPitchX[47 ], PianoVelocityY[47] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],  PianoVelocityAlpha[47] , PianoNoteColor[47] ); pianogfx.display();}
    if (PitchIsActive[48]  == true) {pianogfx = new PianoGFX (PianoPitchX[48 ], PianoVelocityY[48] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[48] , PianoNoteColor[48] ); pianogfx.display();}
    if (PitchIsActive[49]  == true) {pianogfx = new PianoGFX (PianoPitchX[49 ], PianoVelocityY[49] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[49] , PianoNoteColor[49] ); pianogfx.display();}
    if (PitchIsActive[50]  == true) {pianogfx = new PianoGFX (PianoPitchX[50 ], PianoVelocityY[50] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[50] , PianoNoteColor[50] ); pianogfx.display();}
    if (PitchIsActive[51]  == true) {pianogfx = new PianoGFX (PianoPitchX[51 ], PianoVelocityY[51] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[51] , PianoNoteColor[51] ); pianogfx.display();}
    if (PitchIsActive[52]  == true) {pianogfx = new PianoGFX (PianoPitchX[52 ], PianoVelocityY[52] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[52] , PianoNoteColor[52] ); pianogfx.display();}
    if (PitchIsActive[53]  == true) {pianogfx = new PianoGFX (PianoPitchX[53 ], PianoVelocityY[53] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[53] , PianoNoteColor[53] ); pianogfx.display();}
    if (PitchIsActive[54]  == true) {pianogfx = new PianoGFX (PianoPitchX[54 ], PianoVelocityY[54] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[54] , PianoNoteColor[54] ); pianogfx.display();}
    if (PitchIsActive[55]  == true) {pianogfx = new PianoGFX (PianoPitchX[55 ], PianoVelocityY[55] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[55] , PianoNoteColor[55] ); pianogfx.display();}
    if (PitchIsActive[56]  == true) {pianogfx = new PianoGFX (PianoPitchX[56 ], PianoVelocityY[56] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[56] , PianoNoteColor[56] ); pianogfx.display();}
    if (PitchIsActive[57]  == true) {pianogfx = new PianoGFX (PianoPitchX[57 ], PianoVelocityY[57] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[57] , PianoNoteColor[57] ); pianogfx.display();}
    if (PitchIsActive[58]  == true) {pianogfx = new PianoGFX (PianoPitchX[58 ], PianoVelocityY[58] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[58] , PianoNoteColor[58] ); pianogfx.display();}
    if (PitchIsActive[59]  == true) {pianogfx = new PianoGFX (PianoPitchX[59 ], PianoVelocityY[59] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],  PianoVelocityAlpha[59] , PianoNoteColor[59] ); pianogfx.display();}
    if (PitchIsActive[60]  == true) {pianogfx = new PianoGFX (PianoPitchX[60 ], PianoVelocityY[60] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[60] , PianoNoteColor[60] ); pianogfx.display();}
    if (PitchIsActive[61]  == true) {pianogfx = new PianoGFX (PianoPitchX[61 ], PianoVelocityY[61] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[61] , PianoNoteColor[61] ); pianogfx.display();}
    if (PitchIsActive[62]  == true) {pianogfx = new PianoGFX (PianoPitchX[62 ], PianoVelocityY[62] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[62] , PianoNoteColor[62] ); pianogfx.display();}
    if (PitchIsActive[63]  == true) {pianogfx = new PianoGFX (PianoPitchX[63 ], PianoVelocityY[63] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[63] , PianoNoteColor[63] ); pianogfx.display();}
    if (PitchIsActive[64]  == true) {pianogfx = new PianoGFX (PianoPitchX[64 ], PianoVelocityY[64] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[64] , PianoNoteColor[64] ); pianogfx.display();}
    if (PitchIsActive[65]  == true) {pianogfx = new PianoGFX (PianoPitchX[65 ], PianoVelocityY[65] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[65] , PianoNoteColor[65] ); pianogfx.display();}
    if (PitchIsActive[66]  == true) {pianogfx = new PianoGFX (PianoPitchX[66 ], PianoVelocityY[66] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[66] , PianoNoteColor[66] ); pianogfx.display();}
    if (PitchIsActive[67]  == true) {pianogfx = new PianoGFX (PianoPitchX[67 ], PianoVelocityY[67] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[67] , PianoNoteColor[67] ); pianogfx.display();}
    if (PitchIsActive[68]  == true) {pianogfx = new PianoGFX (PianoPitchX[68 ], PianoVelocityY[68] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[68] , PianoNoteColor[68] ); pianogfx.display();}
    if (PitchIsActive[69]  == true) {pianogfx = new PianoGFX (PianoPitchX[69 ], PianoVelocityY[69] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[69] , PianoNoteColor[69] ); pianogfx.display();}
    if (PitchIsActive[70]  == true) {pianogfx = new PianoGFX (PianoPitchX[70 ], PianoVelocityY[70] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[70] , PianoNoteColor[70] ); pianogfx.display();}
    if (PitchIsActive[71]  == true) {pianogfx = new PianoGFX (PianoPitchX[71 ], PianoVelocityY[71] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],  PianoVelocityAlpha[71] , PianoNoteColor[71] ); pianogfx.display();}
    if (PitchIsActive[72]  == true) {pianogfx = new PianoGFX (PianoPitchX[72 ], PianoVelocityY[72] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[72] , PianoNoteColor[72] ); pianogfx.display();}
    if (PitchIsActive[73]  == true) {pianogfx = new PianoGFX (PianoPitchX[73 ], PianoVelocityY[73] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[73] , PianoNoteColor[73] ); pianogfx.display();}
    if (PitchIsActive[74]  == true) {pianogfx = new PianoGFX (PianoPitchX[74 ], PianoVelocityY[74] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[74] , PianoNoteColor[74] ); pianogfx.display();}
    if (PitchIsActive[75]  == true) {pianogfx = new PianoGFX (PianoPitchX[75 ], PianoVelocityY[75] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[75] , PianoNoteColor[75] ); pianogfx.display();}
    if (PitchIsActive[76]  == true) {pianogfx = new PianoGFX (PianoPitchX[76 ], PianoVelocityY[76] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[76] , PianoNoteColor[76] ); pianogfx.display();}
    if (PitchIsActive[77]  == true) {pianogfx = new PianoGFX (PianoPitchX[77 ], PianoVelocityY[77] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[77] , PianoNoteColor[77] ); pianogfx.display();}
    if (PitchIsActive[78]  == true) {pianogfx = new PianoGFX (PianoPitchX[78 ], PianoVelocityY[78] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[78] , PianoNoteColor[78] ); pianogfx.display();}
    if (PitchIsActive[79]  == true) {pianogfx = new PianoGFX (PianoPitchX[79 ], PianoVelocityY[79] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[79] , PianoNoteColor[79] ); pianogfx.display();}
    if (PitchIsActive[80]  == true) {pianogfx = new PianoGFX (PianoPitchX[80 ], PianoVelocityY[80] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[80] , PianoNoteColor[80] ); pianogfx.display();}
    if (PitchIsActive[81]  == true) {pianogfx = new PianoGFX (PianoPitchX[81 ], PianoVelocityY[81] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[81] , PianoNoteColor[81] ); pianogfx.display();}
    if (PitchIsActive[82]  == true) {pianogfx = new PianoGFX (PianoPitchX[82 ], PianoVelocityY[82] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[82] , PianoNoteColor[82] ); pianogfx.display();}
    if (PitchIsActive[83]  == true) {pianogfx = new PianoGFX (PianoPitchX[83 ], PianoVelocityY[83] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],  PianoVelocityAlpha[83] , PianoNoteColor[83] ); pianogfx.display();}
    if (PitchIsActive[84]  == true) {pianogfx = new PianoGFX (PianoPitchX[84 ], PianoVelocityY[84] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[84] , PianoNoteColor[84] ); pianogfx.display();}
    if (PitchIsActive[85]  == true) {pianogfx = new PianoGFX (PianoPitchX[85 ], PianoVelocityY[85] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[85] , PianoNoteColor[85] ); pianogfx.display();}
    if (PitchIsActive[86]  == true) {pianogfx = new PianoGFX (PianoPitchX[86 ], PianoVelocityY[86] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[86] , PianoNoteColor[86] ); pianogfx.display();}
    if (PitchIsActive[87]  == true) {pianogfx = new PianoGFX (PianoPitchX[87 ], PianoVelocityY[87] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[87] , PianoNoteColor[87] ); pianogfx.display();}
    if (PitchIsActive[88]  == true) {pianogfx = new PianoGFX (PianoPitchX[88 ], PianoVelocityY[88] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[88] , PianoNoteColor[88] ); pianogfx.display();}
    if (PitchIsActive[89]  == true) {pianogfx = new PianoGFX (PianoPitchX[89 ], PianoVelocityY[89] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[89] , PianoNoteColor[89] ); pianogfx.display();}
    if (PitchIsActive[90]  == true) {pianogfx = new PianoGFX (PianoPitchX[90 ], PianoVelocityY[90] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[90] , PianoNoteColor[90] ); pianogfx.display();}
    if (PitchIsActive[91]  == true) {pianogfx = new PianoGFX (PianoPitchX[91 ], PianoVelocityY[91] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[91] , PianoNoteColor[91] ); pianogfx.display();}
    if (PitchIsActive[92]  == true) {pianogfx = new PianoGFX (PianoPitchX[92 ], PianoVelocityY[92] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[92] , PianoNoteColor[92] ); pianogfx.display();}
    if (PitchIsActive[93]  == true) {pianogfx = new PianoGFX (PianoPitchX[93 ], PianoVelocityY[93] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[93] , PianoNoteColor[93] ); pianogfx.display();}
    if (PitchIsActive[94]  == true) {pianogfx = new PianoGFX (PianoPitchX[94 ], PianoVelocityY[94] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[94] , PianoNoteColor[94] ); pianogfx.display();}
    if (PitchIsActive[95]  == true) {pianogfx = new PianoGFX (PianoPitchX[95 ], PianoVelocityY[95] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],  PianoVelocityAlpha[95] , PianoNoteColor[95] ); pianogfx.display();}
    if (PitchIsActive[96]  == true) {pianogfx = new PianoGFX (PianoPitchX[96 ], PianoVelocityY[96] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[96] , PianoNoteColor[96] ); pianogfx.display();}
    if (PitchIsActive[97]  == true) {pianogfx = new PianoGFX (PianoPitchX[97 ], PianoVelocityY[97] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[97] , PianoNoteColor[97] ); pianogfx.display();}
    if (PitchIsActive[98]  == true) {pianogfx = new PianoGFX (PianoPitchX[98 ], PianoVelocityY[98] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[98] , PianoNoteColor[98] ); pianogfx.display();}
    if (PitchIsActive[99]  == true) {pianogfx = new PianoGFX (PianoPitchX[99 ], PianoVelocityY[99] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[99] , PianoNoteColor[99] ); pianogfx.display();}
    if (PitchIsActive[100] == true) {pianogfx = new PianoGFX (PianoPitchX[100], PianoVelocityY[100], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[100], PianoNoteColor[100]); pianogfx.display();}
    if (PitchIsActive[101] == true) {pianogfx = new PianoGFX (PianoPitchX[101], PianoVelocityY[101], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[101], PianoNoteColor[101]); pianogfx.display();}
    if (PitchIsActive[102] == true) {pianogfx = new PianoGFX (PianoPitchX[102], PianoVelocityY[102], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[102], PianoNoteColor[102]); pianogfx.display();}
    if (PitchIsActive[103] == true) {pianogfx = new PianoGFX (PianoPitchX[103], PianoVelocityY[103], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[103], PianoNoteColor[103]); pianogfx.display();}
    if (PitchIsActive[104] == true) {pianogfx = new PianoGFX (PianoPitchX[104], PianoVelocityY[104], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[104], PianoNoteColor[104]); pianogfx.display();}
    if (PitchIsActive[105] == true) {pianogfx = new PianoGFX (PianoPitchX[105], PianoVelocityY[105], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[105], PianoNoteColor[105]); pianogfx.display();}
    if (PitchIsActive[106] == true) {pianogfx = new PianoGFX (PianoPitchX[106], PianoVelocityY[106], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[106], PianoNoteColor[106]); pianogfx.display();}
    if (PitchIsActive[107] == true) {pianogfx = new PianoGFX (PianoPitchX[107], PianoVelocityY[107], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],  PianoVelocityAlpha[107], PianoNoteColor[107]); pianogfx.display();}
    if (PitchIsActive[108] == true) {pianogfx = new PianoGFX (PianoPitchX[108], PianoVelocityY[108], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[108], PianoNoteColor[108]); pianogfx.display();}
    if (PitchIsActive[109] == true) {pianogfx = new PianoGFX (PianoPitchX[109], PianoVelocityY[109], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[109], PianoNoteColor[109]); pianogfx.display();}
    if (PitchIsActive[110] == true) {pianogfx = new PianoGFX (PianoPitchX[110], PianoVelocityY[110], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[110], PianoNoteColor[110]); pianogfx.display();}
    if (PitchIsActive[111] == true) {pianogfx = new PianoGFX (PianoPitchX[111], PianoVelocityY[111], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[111], PianoNoteColor[111]); pianogfx.display();}
    if (PitchIsActive[112] == true) {pianogfx = new PianoGFX (PianoPitchX[112], PianoVelocityY[112], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[112], PianoNoteColor[112]); pianogfx.display();}
    if (PitchIsActive[113] == true) {pianogfx = new PianoGFX (PianoPitchX[113], PianoVelocityY[113], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[113], PianoNoteColor[113]); pianogfx.display();}
    if (PitchIsActive[114] == true) {pianogfx = new PianoGFX (PianoPitchX[114], PianoVelocityY[114], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[114], PianoNoteColor[114]); pianogfx.display();}
    if (PitchIsActive[115] == true) {pianogfx = new PianoGFX (PianoPitchX[115], PianoVelocityY[115], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[115], PianoNoteColor[115]); pianogfx.display();}
    if (PitchIsActive[116] == true) {pianogfx = new PianoGFX (PianoPitchX[116], PianoVelocityY[116], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[116], PianoNoteColor[116]); pianogfx.display();}
    if (PitchIsActive[117] == true) {pianogfx = new PianoGFX (PianoPitchX[117], PianoVelocityY[117], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[117], PianoNoteColor[117]); pianogfx.display();}
    if (PitchIsActive[118] == true) {pianogfx = new PianoGFX (PianoPitchX[118], PianoVelocityY[118], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[118], PianoNoteColor[118]); pianogfx.display();}
    if (PitchIsActive[119] == true) {pianogfx = new PianoGFX (PianoPitchX[119], PianoVelocityY[119], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],  PianoVelocityAlpha[119], PianoNoteColor[119]); pianogfx.display();}
    if (PitchIsActive[120] == true) {pianogfx = new PianoGFX (PianoPitchX[120], PianoVelocityY[120], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[120], PianoNoteColor[120]); pianogfx.display();}
    if (PitchIsActive[121] == true) {pianogfx = new PianoGFX (PianoPitchX[121], PianoVelocityY[121], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[121], PianoNoteColor[121]); pianogfx.display();}
    if (PitchIsActive[122] == true) {pianogfx = new PianoGFX (PianoPitchX[122], PianoVelocityY[122], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[122], PianoNoteColor[122]); pianogfx.display();}
    if (PitchIsActive[123] == true) {pianogfx = new PianoGFX (PianoPitchX[123], PianoVelocityY[123], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[123], PianoNoteColor[123]); pianogfx.display();}
    if (PitchIsActive[124] == true) {pianogfx = new PianoGFX (PianoPitchX[124], PianoVelocityY[124], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[124], PianoNoteColor[124]); pianogfx.display();}
    if (PitchIsActive[125] == true) {pianogfx = new PianoGFX (PianoPitchX[125], PianoVelocityY[125], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[125], PianoNoteColor[125]); pianogfx.display();}
    if (PitchIsActive[126] == true) {pianogfx = new PianoGFX (PianoPitchX[126], PianoVelocityY[126], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[126], PianoNoteColor[126]); pianogfx.display();}
    if (PitchIsActive[127] == true) {pianogfx = new PianoGFX (PianoPitchX[127], PianoVelocityY[127], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10], PianoVelocityAlpha[127], PianoNoteColor[127]); pianogfx.display();}
  }

  //Chromatic Percussion
  if (ChannelIsActive[1] == true) {// Chromatic Percussion Channel graphics                            X                                 Y                     Z         Width          Height           Depth            Hue           Saturation             Brightness                        Alpha                                Texture                       Display graphics
    if (PitchIsActive[0]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[0  ], ChromaticPercussionVelocityY[0]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[0]  , ChromaticPercussionNoteColor[0]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[1]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[1  ], ChromaticPercussionVelocityY[1]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[1]  , ChromaticPercussionNoteColor[1]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[2]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[2  ], ChromaticPercussionVelocityY[2]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[2]  , ChromaticPercussionNoteColor[2]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[3]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[3  ], ChromaticPercussionVelocityY[3]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[3]  , ChromaticPercussionNoteColor[3]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[4]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[4  ], ChromaticPercussionVelocityY[4]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[4]  , ChromaticPercussionNoteColor[4]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[5]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[5  ], ChromaticPercussionVelocityY[5]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[5]  , ChromaticPercussionNoteColor[5]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[6]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[6  ], ChromaticPercussionVelocityY[6]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[6]  , ChromaticPercussionNoteColor[6]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[7]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[7  ], ChromaticPercussionVelocityY[7]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[7]  , ChromaticPercussionNoteColor[7]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[8]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[8  ], ChromaticPercussionVelocityY[8]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[8]  , ChromaticPercussionNoteColor[8]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[9]   == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[9  ], ChromaticPercussionVelocityY[9]  , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[9]  , ChromaticPercussionNoteColor[9]  ); chromaticpercussiongfx.display();}
    if (PitchIsActive[10]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[10 ], ChromaticPercussionVelocityY[10] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[10] , ChromaticPercussionNoteColor[10] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[11]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[11 ], ChromaticPercussionVelocityY[11] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  ChromaticPercussionVelocityAlpha[11] , ChromaticPercussionNoteColor[11] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[12]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[12 ], ChromaticPercussionVelocityY[12] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[12] , ChromaticPercussionNoteColor[12] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[13]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[13 ], ChromaticPercussionVelocityY[13] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[13] , ChromaticPercussionNoteColor[13] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[14]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[14 ], ChromaticPercussionVelocityY[14] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[14] , ChromaticPercussionNoteColor[14] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[15]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[15 ], ChromaticPercussionVelocityY[15] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[15] , ChromaticPercussionNoteColor[15] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[16]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[16 ], ChromaticPercussionVelocityY[16] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[16] , ChromaticPercussionNoteColor[16] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[17]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[17 ], ChromaticPercussionVelocityY[17] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[17] , ChromaticPercussionNoteColor[17] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[18]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[18 ], ChromaticPercussionVelocityY[18] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[18] , ChromaticPercussionNoteColor[18] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[19]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[19 ], ChromaticPercussionVelocityY[19] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[19] , ChromaticPercussionNoteColor[19] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[20]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[20 ], ChromaticPercussionVelocityY[20] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[20] , ChromaticPercussionNoteColor[20] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[21]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[21 ], ChromaticPercussionVelocityY[21] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[21] , ChromaticPercussionNoteColor[21] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[22]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[22 ], ChromaticPercussionVelocityY[22] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[22] , ChromaticPercussionNoteColor[22] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[23]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[23 ], ChromaticPercussionVelocityY[23] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],  ChromaticPercussionVelocityAlpha[23] , ChromaticPercussionNoteColor[23] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[24]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[24 ], ChromaticPercussionVelocityY[24] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[24] , ChromaticPercussionNoteColor[24] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[25]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[25 ], ChromaticPercussionVelocityY[25] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[25] , ChromaticPercussionNoteColor[25] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[26]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[26 ], ChromaticPercussionVelocityY[26] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[26] , ChromaticPercussionNoteColor[26] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[27]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[27 ], ChromaticPercussionVelocityY[27] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[27] , ChromaticPercussionNoteColor[27] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[28]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[28 ], ChromaticPercussionVelocityY[28] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[28] , ChromaticPercussionNoteColor[28] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[29]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[29 ], ChromaticPercussionVelocityY[29] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[29] , ChromaticPercussionNoteColor[29] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[30]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[30 ], ChromaticPercussionVelocityY[30] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[30] , ChromaticPercussionNoteColor[30] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[31]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[31 ], ChromaticPercussionVelocityY[31] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[31] , ChromaticPercussionNoteColor[31] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[32]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[32 ], ChromaticPercussionVelocityY[32] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[32] , ChromaticPercussionNoteColor[32] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[33]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[33 ], ChromaticPercussionVelocityY[33] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[33] , ChromaticPercussionNoteColor[33] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[34]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[34 ], ChromaticPercussionVelocityY[34] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[34] , ChromaticPercussionNoteColor[34] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[35]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[35 ], ChromaticPercussionVelocityY[35] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],  ChromaticPercussionVelocityAlpha[35] , ChromaticPercussionNoteColor[35] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[36]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[36 ], ChromaticPercussionVelocityY[36] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[36] , ChromaticPercussionNoteColor[36] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[37]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[37 ], ChromaticPercussionVelocityY[37] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[37] , ChromaticPercussionNoteColor[37] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[38]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[38 ], ChromaticPercussionVelocityY[38] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[38] , ChromaticPercussionNoteColor[38] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[39]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[39 ], ChromaticPercussionVelocityY[39] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[39] , ChromaticPercussionNoteColor[39] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[40]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[40 ], ChromaticPercussionVelocityY[40] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[40] , ChromaticPercussionNoteColor[40] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[41]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[41 ], ChromaticPercussionVelocityY[41] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[41] , ChromaticPercussionNoteColor[41] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[42]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[42 ], ChromaticPercussionVelocityY[42] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[42] , ChromaticPercussionNoteColor[42] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[43]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[43 ], ChromaticPercussionVelocityY[43] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[43] , ChromaticPercussionNoteColor[43] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[44]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[44 ], ChromaticPercussionVelocityY[44] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[44] , ChromaticPercussionNoteColor[44] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[45]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[45 ], ChromaticPercussionVelocityY[45] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[45] , ChromaticPercussionNoteColor[45] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[46]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[46 ], ChromaticPercussionVelocityY[46] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[46] , ChromaticPercussionNoteColor[46] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[47]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[47 ], ChromaticPercussionVelocityY[47] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],  ChromaticPercussionVelocityAlpha[47] , ChromaticPercussionNoteColor[47] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[48]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[48 ], ChromaticPercussionVelocityY[48] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[48] , ChromaticPercussionNoteColor[48] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[49]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[49 ], ChromaticPercussionVelocityY[49] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[49] , ChromaticPercussionNoteColor[49] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[50]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[50 ], ChromaticPercussionVelocityY[50] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[50] , ChromaticPercussionNoteColor[50] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[51]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[51 ], ChromaticPercussionVelocityY[51] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[51] , ChromaticPercussionNoteColor[51] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[52]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[52 ], ChromaticPercussionVelocityY[52] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[52] , ChromaticPercussionNoteColor[52] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[53]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[53 ], ChromaticPercussionVelocityY[53] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[53] , ChromaticPercussionNoteColor[53] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[54]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[54 ], ChromaticPercussionVelocityY[54] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[54] , ChromaticPercussionNoteColor[54] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[55]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[55 ], ChromaticPercussionVelocityY[55] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[55] , ChromaticPercussionNoteColor[55] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[56]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[56 ], ChromaticPercussionVelocityY[56] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[56] , ChromaticPercussionNoteColor[56] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[57]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[57 ], ChromaticPercussionVelocityY[57] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[57] , ChromaticPercussionNoteColor[57] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[58]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[58 ], ChromaticPercussionVelocityY[58] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[58] , ChromaticPercussionNoteColor[58] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[59]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[59 ], ChromaticPercussionVelocityY[59] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],  ChromaticPercussionVelocityAlpha[59] , ChromaticPercussionNoteColor[59] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[60]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[60 ], ChromaticPercussionVelocityY[60] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[60] , ChromaticPercussionNoteColor[60] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[61]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[61 ], ChromaticPercussionVelocityY[61] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[61] , ChromaticPercussionNoteColor[61] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[62]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[62 ], ChromaticPercussionVelocityY[62] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[62] , ChromaticPercussionNoteColor[62] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[63]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[63 ], ChromaticPercussionVelocityY[63] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[63] , ChromaticPercussionNoteColor[63] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[64]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[64 ], ChromaticPercussionVelocityY[64] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[64] , ChromaticPercussionNoteColor[64] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[65]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[65 ], ChromaticPercussionVelocityY[65] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[65] , ChromaticPercussionNoteColor[65] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[66]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[66 ], ChromaticPercussionVelocityY[66] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[66] , ChromaticPercussionNoteColor[66] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[67]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[67 ], ChromaticPercussionVelocityY[67] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[67] , ChromaticPercussionNoteColor[67] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[68]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[68 ], ChromaticPercussionVelocityY[68] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[68] , ChromaticPercussionNoteColor[68] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[69]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[69 ], ChromaticPercussionVelocityY[69] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[69] , ChromaticPercussionNoteColor[69] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[70]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[70 ], ChromaticPercussionVelocityY[70] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[70] , ChromaticPercussionNoteColor[70] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[71]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[71 ], ChromaticPercussionVelocityY[71] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],  ChromaticPercussionVelocityAlpha[71] , ChromaticPercussionNoteColor[71] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[72]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[72 ], ChromaticPercussionVelocityY[72] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[72] , ChromaticPercussionNoteColor[72] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[73]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[73 ], ChromaticPercussionVelocityY[73] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[73] , ChromaticPercussionNoteColor[73] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[74]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[74 ], ChromaticPercussionVelocityY[74] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[74] , ChromaticPercussionNoteColor[74] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[75]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[75 ], ChromaticPercussionVelocityY[75] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[75] , ChromaticPercussionNoteColor[75] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[76]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[76 ], ChromaticPercussionVelocityY[76] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[76] , ChromaticPercussionNoteColor[76] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[77]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[77 ], ChromaticPercussionVelocityY[77] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[77] , ChromaticPercussionNoteColor[77] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[78]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[78 ], ChromaticPercussionVelocityY[78] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[78] , ChromaticPercussionNoteColor[78] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[79]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[79 ], ChromaticPercussionVelocityY[79] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[79] , ChromaticPercussionNoteColor[79] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[80]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[80 ], ChromaticPercussionVelocityY[80] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[80] , ChromaticPercussionNoteColor[80] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[81]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[81 ], ChromaticPercussionVelocityY[81] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[81] , ChromaticPercussionNoteColor[81] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[82]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[82 ], ChromaticPercussionVelocityY[82] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[82] , ChromaticPercussionNoteColor[82] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[83]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[83 ], ChromaticPercussionVelocityY[83] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],  ChromaticPercussionVelocityAlpha[83] , ChromaticPercussionNoteColor[83] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[84]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[84 ], ChromaticPercussionVelocityY[84] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[84] , ChromaticPercussionNoteColor[84] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[85]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[85 ], ChromaticPercussionVelocityY[85] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[85] , ChromaticPercussionNoteColor[85] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[86]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[86 ], ChromaticPercussionVelocityY[86] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[86] , ChromaticPercussionNoteColor[86] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[87]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[87 ], ChromaticPercussionVelocityY[87] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[87] , ChromaticPercussionNoteColor[87] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[88]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[88 ], ChromaticPercussionVelocityY[88] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[88] , ChromaticPercussionNoteColor[88] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[89]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[89 ], ChromaticPercussionVelocityY[89] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[89] , ChromaticPercussionNoteColor[89] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[90]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[90 ], ChromaticPercussionVelocityY[90] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[90] , ChromaticPercussionNoteColor[90] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[91]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[91 ], ChromaticPercussionVelocityY[91] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[91] , ChromaticPercussionNoteColor[91] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[92]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[92 ], ChromaticPercussionVelocityY[92] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[92] , ChromaticPercussionNoteColor[92] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[93]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[93 ], ChromaticPercussionVelocityY[93] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[93] , ChromaticPercussionNoteColor[93] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[94]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[94 ], ChromaticPercussionVelocityY[94] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[94] , ChromaticPercussionNoteColor[94] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[95]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[95 ], ChromaticPercussionVelocityY[95] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],  ChromaticPercussionVelocityAlpha[95] , ChromaticPercussionNoteColor[95] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[96]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[96 ], ChromaticPercussionVelocityY[96] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[96] , ChromaticPercussionNoteColor[96] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[97]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[97 ], ChromaticPercussionVelocityY[97] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[97] , ChromaticPercussionNoteColor[97] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[98]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[98 ], ChromaticPercussionVelocityY[98] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[98] , ChromaticPercussionNoteColor[98] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[99]  == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[99 ], ChromaticPercussionVelocityY[99] , Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[99] , ChromaticPercussionNoteColor[99] ); chromaticpercussiongfx.display();}
    if (PitchIsActive[100] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[100], ChromaticPercussionVelocityY[100], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[100], ChromaticPercussionNoteColor[100]); chromaticpercussiongfx.display();}
    if (PitchIsActive[101] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[101], ChromaticPercussionVelocityY[101], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[101], ChromaticPercussionNoteColor[101]); chromaticpercussiongfx.display();}
    if (PitchIsActive[102] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[102], ChromaticPercussionVelocityY[102], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[102], ChromaticPercussionNoteColor[102]); chromaticpercussiongfx.display();}
    if (PitchIsActive[103] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[103], ChromaticPercussionVelocityY[103], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[103], ChromaticPercussionNoteColor[103]); chromaticpercussiongfx.display();}
    if (PitchIsActive[104] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[104], ChromaticPercussionVelocityY[104], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[104], ChromaticPercussionNoteColor[104]); chromaticpercussiongfx.display();}
    if (PitchIsActive[105] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[105], ChromaticPercussionVelocityY[105], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[105], ChromaticPercussionNoteColor[105]); chromaticpercussiongfx.display();}
    if (PitchIsActive[106] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[106], ChromaticPercussionVelocityY[106], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[106], ChromaticPercussionNoteColor[106]); chromaticpercussiongfx.display();}
    if (PitchIsActive[107] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[107], ChromaticPercussionVelocityY[107], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],  ChromaticPercussionVelocityAlpha[107], ChromaticPercussionNoteColor[107]); chromaticpercussiongfx.display();}
    if (PitchIsActive[108] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[108], ChromaticPercussionVelocityY[108], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[108], ChromaticPercussionNoteColor[108]); chromaticpercussiongfx.display();}
    if (PitchIsActive[109] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[109], ChromaticPercussionVelocityY[109], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[109], ChromaticPercussionNoteColor[109]); chromaticpercussiongfx.display();}
    if (PitchIsActive[110] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[110], ChromaticPercussionVelocityY[110], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[110], ChromaticPercussionNoteColor[110]); chromaticpercussiongfx.display();}
    if (PitchIsActive[111] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[111], ChromaticPercussionVelocityY[111], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[111], ChromaticPercussionNoteColor[111]); chromaticpercussiongfx.display();}
    if (PitchIsActive[112] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[112], ChromaticPercussionVelocityY[112], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[112], ChromaticPercussionNoteColor[112]); chromaticpercussiongfx.display();}
    if (PitchIsActive[113] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[113], ChromaticPercussionVelocityY[113], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[113], ChromaticPercussionNoteColor[113]); chromaticpercussiongfx.display();}
    if (PitchIsActive[114] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[114], ChromaticPercussionVelocityY[114], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[114], ChromaticPercussionNoteColor[114]); chromaticpercussiongfx.display();}
    if (PitchIsActive[115] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[115], ChromaticPercussionVelocityY[115], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[115], ChromaticPercussionNoteColor[115]); chromaticpercussiongfx.display();}
    if (PitchIsActive[116] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[116], ChromaticPercussionVelocityY[116], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[116], ChromaticPercussionNoteColor[116]); chromaticpercussiongfx.display();}
    if (PitchIsActive[117] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[117], ChromaticPercussionVelocityY[117], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[117], ChromaticPercussionNoteColor[117]); chromaticpercussiongfx.display();}
    if (PitchIsActive[118] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[118], ChromaticPercussionVelocityY[118], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[118], ChromaticPercussionNoteColor[118]); chromaticpercussiongfx.display();}
    if (PitchIsActive[119] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[119], ChromaticPercussionVelocityY[119], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],  ChromaticPercussionVelocityAlpha[119], ChromaticPercussionNoteColor[119]); chromaticpercussiongfx.display();}
    if (PitchIsActive[120] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[120], ChromaticPercussionVelocityY[120], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[120], ChromaticPercussionNoteColor[120]); chromaticpercussiongfx.display();}
    if (PitchIsActive[121] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[121], ChromaticPercussionVelocityY[121], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[121], ChromaticPercussionNoteColor[121]); chromaticpercussiongfx.display();}
    if (PitchIsActive[122] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[122], ChromaticPercussionVelocityY[122], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[122], ChromaticPercussionNoteColor[122]); chromaticpercussiongfx.display();}
    if (PitchIsActive[123] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[123], ChromaticPercussionVelocityY[123], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[123], ChromaticPercussionNoteColor[123]); chromaticpercussiongfx.display();}
    if (PitchIsActive[124] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[124], ChromaticPercussionVelocityY[124], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[124], ChromaticPercussionNoteColor[124]); chromaticpercussiongfx.display();}
    if (PitchIsActive[125] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[125], ChromaticPercussionVelocityY[125], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[125], ChromaticPercussionNoteColor[125]); chromaticpercussiongfx.display();}
    if (PitchIsActive[126] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[126], ChromaticPercussionVelocityY[126], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[126], ChromaticPercussionNoteColor[126]); chromaticpercussiongfx.display();}
    if (PitchIsActive[127] == true) {chromaticpercussiongfx = new ChromaticPercussionGFX (ChromaticPercussionPitchX[127], ChromaticPercussionVelocityY[127], Depth, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10], ChromaticPercussionVelocityAlpha[127], ChromaticPercussionNoteColor[127]); chromaticpercussiongfx.display();}
  }

  //Organ
  if (ChannelIsActive[2] == true) { // Organ         Channel graphics      X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha    Texture
    if (PitchIsActive[0]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[0]  ); organgfx.display();}
    if (PitchIsActive[1]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[1]  ); organgfx.display();}
    if (PitchIsActive[2]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[2]  ); organgfx.display();}
    if (PitchIsActive[3]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[3]  ); organgfx.display();}
    if (PitchIsActive[4]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[4]  ); organgfx.display();}
    if (PitchIsActive[5]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[5]  ); organgfx.display();}
    if (PitchIsActive[6]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[6]  ); organgfx.display();}
    if (PitchIsActive[7]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[7]  ); organgfx.display();}
    if (PitchIsActive[8]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[8]  ); organgfx.display();}
    if (PitchIsActive[9]   == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[9]  ); organgfx.display();}
    if (PitchIsActive[10]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[10] ); organgfx.display();}
    if (PitchIsActive[11]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],   100, OrganNoteColor[11] ); organgfx.display();}
    if (PitchIsActive[12]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[12] ); organgfx.display();}
    if (PitchIsActive[13]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[13] ); organgfx.display();}
    if (PitchIsActive[14]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[14] ); organgfx.display();}
    if (PitchIsActive[15]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[15] ); organgfx.display();}
    if (PitchIsActive[16]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[16] ); organgfx.display();}
    if (PitchIsActive[17]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[17] ); organgfx.display();}
    if (PitchIsActive[18]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[18] ); organgfx.display();}
    if (PitchIsActive[19]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[19] ); organgfx.display();}
    if (PitchIsActive[20]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[20] ); organgfx.display();}
    if (PitchIsActive[21]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[21] ); organgfx.display();}
    if (PitchIsActive[22]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[22] ); organgfx.display();}
    if (PitchIsActive[23]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganNoteColor[23] ); organgfx.display();}
    if (PitchIsActive[24]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[24] ); organgfx.display();}
    if (PitchIsActive[25]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[25] ); organgfx.display();}
    if (PitchIsActive[26]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[26] ); organgfx.display();}
    if (PitchIsActive[27]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[27] ); organgfx.display();}
    if (PitchIsActive[28]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[28] ); organgfx.display();}
    if (PitchIsActive[29]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[29] ); organgfx.display();}
    if (PitchIsActive[30]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[30] ); organgfx.display();}
    if (PitchIsActive[31]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[31] ); organgfx.display();}
    if (PitchIsActive[32]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[32] ); organgfx.display();}
    if (PitchIsActive[33]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[33] ); organgfx.display();}
    if (PitchIsActive[34]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[34] ); organgfx.display();}
    if (PitchIsActive[35]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganNoteColor[35] ); organgfx.display();}
    if (PitchIsActive[36]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[36] ); organgfx.display();}
    if (PitchIsActive[37]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[37] ); organgfx.display();}
    if (PitchIsActive[38]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[38] ); organgfx.display();}
    if (PitchIsActive[39]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[39] ); organgfx.display();}
    if (PitchIsActive[40]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[40] ); organgfx.display();}
    if (PitchIsActive[41]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[41] ); organgfx.display();}
    if (PitchIsActive[42]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[42] ); organgfx.display();}
    if (PitchIsActive[43]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[43] ); organgfx.display();}
    if (PitchIsActive[44]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[44] ); organgfx.display();}
    if (PitchIsActive[45]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[45] ); organgfx.display();}
    if (PitchIsActive[46]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[46] ); organgfx.display();}
    if (PitchIsActive[47]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganNoteColor[47] ); organgfx.display();}
    if (PitchIsActive[48]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[48] ); organgfx.display();}
    if (PitchIsActive[49]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[49] ); organgfx.display();}
    if (PitchIsActive[50]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[50] ); organgfx.display();}
    if (PitchIsActive[51]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[51] ); organgfx.display();}
    if (PitchIsActive[52]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[52] ); organgfx.display();}
    if (PitchIsActive[53]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[53] ); organgfx.display();}
    if (PitchIsActive[54]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[54] ); organgfx.display();}
    if (PitchIsActive[55]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[55] ); organgfx.display();}
    if (PitchIsActive[56]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[56] ); organgfx.display();}
    if (PitchIsActive[57]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[57] ); organgfx.display();}
    if (PitchIsActive[58]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[58] ); organgfx.display();}
    if (PitchIsActive[59]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganNoteColor[59] ); organgfx.display();}
    if (PitchIsActive[60]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[60] ); organgfx.display();}
    if (PitchIsActive[61]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[61] ); organgfx.display();}
    if (PitchIsActive[62]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[62] ); organgfx.display();}
    if (PitchIsActive[63]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[63] ); organgfx.display();}
    if (PitchIsActive[64]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[64] ); organgfx.display();}
    if (PitchIsActive[65]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[65] ); organgfx.display();}
    if (PitchIsActive[66]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[66] ); organgfx.display();}
    if (PitchIsActive[67]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[67] ); organgfx.display();}
    if (PitchIsActive[68]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[68] ); organgfx.display();}
    if (PitchIsActive[69]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[69] ); organgfx.display();}
    if (PitchIsActive[70]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[70] ); organgfx.display();}
    if (PitchIsActive[71]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganNoteColor[71] ); organgfx.display();}
    if (PitchIsActive[72]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[72] ); organgfx.display();}
    if (PitchIsActive[73]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[73] ); organgfx.display();}
    if (PitchIsActive[74]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[74] ); organgfx.display();}
    if (PitchIsActive[75]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[75] ); organgfx.display();}
    if (PitchIsActive[76]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[76] ); organgfx.display();}
    if (PitchIsActive[77]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[77] ); organgfx.display();}
    if (PitchIsActive[78]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[78] ); organgfx.display();}
    if (PitchIsActive[79]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[79] ); organgfx.display();}
    if (PitchIsActive[80]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[80] ); organgfx.display();}
    if (PitchIsActive[81]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[81] ); organgfx.display();}
    if (PitchIsActive[82]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[82] ); organgfx.display();}
    if (PitchIsActive[83]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganNoteColor[83] ); organgfx.display();}
    if (PitchIsActive[84]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[84] ); organgfx.display();}
    if (PitchIsActive[85]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[85] ); organgfx.display();}
    if (PitchIsActive[86]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[86] ); organgfx.display();}
    if (PitchIsActive[87]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[87] ); organgfx.display();}
    if (PitchIsActive[88]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[88] ); organgfx.display();}
    if (PitchIsActive[89]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[89] ); organgfx.display();}
    if (PitchIsActive[90]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[90] ); organgfx.display();}
    if (PitchIsActive[91]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[91] ); organgfx.display();}
    if (PitchIsActive[92]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[92] ); organgfx.display();}
    if (PitchIsActive[93]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[93] ); organgfx.display();}
    if (PitchIsActive[94]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[94] ); organgfx.display();}
    if (PitchIsActive[95]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganNoteColor[95] ); organgfx.display();}
    if (PitchIsActive[96]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[96] ); organgfx.display();}
    if (PitchIsActive[97]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[97] ); organgfx.display();}
    if (PitchIsActive[98]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[98] ); organgfx.display();}
    if (PitchIsActive[99]  == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[99] ); organgfx.display();}
    if (PitchIsActive[100] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[100]); organgfx.display();}
    if (PitchIsActive[101] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[101]); organgfx.display();}
    if (PitchIsActive[102] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[102]); organgfx.display();}
    if (PitchIsActive[103] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[103]); organgfx.display();}
    if (PitchIsActive[104] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[104]); organgfx.display();}
    if (PitchIsActive[105] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[105]); organgfx.display();}
    if (PitchIsActive[106] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[106]); organgfx.display();}
    if (PitchIsActive[107] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganNoteColor[107]); organgfx.display();}
    if (PitchIsActive[108] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[108]); organgfx.display();}
    if (PitchIsActive[109] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[109]); organgfx.display();}
    if (PitchIsActive[110] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[110]); organgfx.display();}
    if (PitchIsActive[111] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[111]); organgfx.display();}
    if (PitchIsActive[112] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[112]); organgfx.display();}
    if (PitchIsActive[113] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[113]); organgfx.display();}
    if (PitchIsActive[114] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[114]); organgfx.display();}
    if (PitchIsActive[115] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[115]); organgfx.display();}
    if (PitchIsActive[116] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[116]); organgfx.display();}
    if (PitchIsActive[117] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[117]); organgfx.display();}
    if (PitchIsActive[118] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[118]); organgfx.display();}
    if (PitchIsActive[119] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganNoteColor[119]); organgfx.display();}
    if (PitchIsActive[120] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[120]); organgfx.display();}
    if (PitchIsActive[121] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[121]); organgfx.display();}
    if (PitchIsActive[122] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[122]); organgfx.display();}
    if (PitchIsActive[123] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[123]); organgfx.display();}
    if (PitchIsActive[124] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[124]); organgfx.display();}
    if (PitchIsActive[125] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[125]); organgfx.display();}
    if (PitchIsActive[126] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[126]); organgfx.display();}
    if (PitchIsActive[127] == true) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganNoteColor[127]); organgfx.display();}
  }
}
//Note on event
void noteOn(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel = channel;
  Pitch = pitch;
  Velocity = velocity;

  //Local variables
  float pitchX      =       map(pitch, 0,   127,  0, width);
  float pitchScaleX =       map(pitch, 0,   127, 50,    10);
  float pitchHue    =   int(map(pitch, 0,  127,  0,    255));
  float velocityY =         map(velocity, 0, 127, height-10, height/8);
  float velocityScaleY =    map(velocity, 0, 127, 5, 20);

  //Update local variables
  PitchX         = pitchX         ;
  PitchScaleX    = pitchScaleX    ;
  PitchHue       = pitchHue       ;
  VelocityY      = velocityY      ;
  VelocityScaleY = velocityScaleY*4 ;
  
  //Print global variables
  debug = new Debug();
  debug.noteOnReturn();
  
  //Update global variables
  //Channels
  if (channel ==   0) {
    ChannelIsActive[0] = true;
    
    if (pitch == 0  ) {PianoPitchX[0]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[0]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[0]   = velocity*2;}
    if (pitch == 1  ) {PianoPitchX[1]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[1]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[1]   = velocity*2;}
    if (pitch == 2  ) {PianoPitchX[2]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[2]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[2]   = velocity*2;}
    if (pitch == 3  ) {PianoPitchX[3]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[3]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[3]   = velocity*2;}
    if (pitch == 4  ) {PianoPitchX[4]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[4]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[4]   = velocity*2;}
    if (pitch == 5  ) {PianoPitchX[5]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[5]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[5]   = velocity*2;}
    if (pitch == 6  ) {PianoPitchX[6]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[6]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[6]   = velocity*2;}
    if (pitch == 7  ) {PianoPitchX[7]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[7]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[7]   = velocity*2;}
    if (pitch == 8  ) {PianoPitchX[8]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[8]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[8]   = velocity*2;}
    if (pitch == 9  ) {PianoPitchX[9]   = map(pitch, 0, 127, -width, width*2); PianoVelocityY[9]   = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[9]   = velocity*2;}
    if (pitch == 10 ) {PianoPitchX[10]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[10]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[10]  = velocity*2;}
    if (pitch == 11 ) {PianoPitchX[11]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[11]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[11]  = velocity*2;}
    if (pitch == 12 ) {PianoPitchX[12]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[12]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[12]  = velocity*2;}
    if (pitch == 13 ) {PianoPitchX[13]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[13]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[13]  = velocity*2;}
    if (pitch == 14 ) {PianoPitchX[14]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[14]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[14]  = velocity*2;}
    if (pitch == 15 ) {PianoPitchX[15]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[15]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[15]  = velocity*2;}
    if (pitch == 16 ) {PianoPitchX[16]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[16]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[16]  = velocity*2;}
    if (pitch == 17 ) {PianoPitchX[17]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[17]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[17]  = velocity*2;}
    if (pitch == 18 ) {PianoPitchX[18]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[18]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[18]  = velocity*2;}
    if (pitch == 19 ) {PianoPitchX[19]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[19]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[19]  = velocity*2;}
    if (pitch == 20 ) {PianoPitchX[20]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[20]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[20]  = velocity*2;}
    if (pitch == 21 ) {PianoPitchX[21]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[21]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[21]  = velocity*2;}
    if (pitch == 22 ) {PianoPitchX[22]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[22]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[22]  = velocity*2;}
    if (pitch == 23 ) {PianoPitchX[23]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[23]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[23]  = velocity*2;}
    if (pitch == 24 ) {PianoPitchX[24]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[24]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[24]  = velocity*2;}
    if (pitch == 25 ) {PianoPitchX[25]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[25]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[25]  = velocity*2;}
    if (pitch == 26 ) {PianoPitchX[26]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[26]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[26]  = velocity*2;}
    if (pitch == 27 ) {PianoPitchX[27]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[27]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[27]  = velocity*2;}
    if (pitch == 28 ) {PianoPitchX[28]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[28]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[28]  = velocity*2;}
    if (pitch == 29 ) {PianoPitchX[29]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[29]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[29]  = velocity*2;}
    if (pitch == 30 ) {PianoPitchX[30]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[30]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[30]  = velocity*2;}
    if (pitch == 31 ) {PianoPitchX[31]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[31]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[31]  = velocity*2;}
    if (pitch == 32 ) {PianoPitchX[32]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[32]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[32]  = velocity*2;}
    if (pitch == 33 ) {PianoPitchX[33]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[33]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[33]  = velocity*2;}
    if (pitch == 34 ) {PianoPitchX[34]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[34]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[34]  = velocity*2;}
    if (pitch == 35 ) {PianoPitchX[35]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[35]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[35]  = velocity*2;}
    if (pitch == 36 ) {PianoPitchX[36]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[36]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[36]  = velocity*2;}
    if (pitch == 37 ) {PianoPitchX[37]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[37]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[37]  = velocity*2;}
    if (pitch == 38 ) {PianoPitchX[38]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[38]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[38]  = velocity*2;}
    if (pitch == 39 ) {PianoPitchX[39]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[39]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[39]  = velocity*2;}
    if (pitch == 40 ) {PianoPitchX[40]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[40]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[40]  = velocity*2;}
    if (pitch == 41 ) {PianoPitchX[41]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[41]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[41]  = velocity*2;}
    if (pitch == 42 ) {PianoPitchX[42]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[42]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[42]  = velocity*2;}
    if (pitch == 43 ) {PianoPitchX[43]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[43]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[43]  = velocity*2;}
    if (pitch == 44 ) {PianoPitchX[44]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[44]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[44]  = velocity*2;}
    if (pitch == 45 ) {PianoPitchX[45]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[45]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[45]  = velocity*2;}
    if (pitch == 46 ) {PianoPitchX[46]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[46]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[46]  = velocity*2;}
    if (pitch == 47 ) {PianoPitchX[47]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[47]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[47]  = velocity*2;}
    if (pitch == 48 ) {PianoPitchX[48]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[48]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[48]  = velocity*2;}
    if (pitch == 49 ) {PianoPitchX[49]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[49]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[49]  = velocity*2;}
    if (pitch == 50 ) {PianoPitchX[50]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[50]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[50]  = velocity*2;}
    if (pitch == 51 ) {PianoPitchX[51]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[51]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[51]  = velocity*2;}
    if (pitch == 52 ) {PianoPitchX[52]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[52]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[52]  = velocity*2;}
    if (pitch == 53 ) {PianoPitchX[53]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[53]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[53]  = velocity*2;}
    if (pitch == 54 ) {PianoPitchX[54]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[54]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[54]  = velocity*2;}
    if (pitch == 55 ) {PianoPitchX[55]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[55]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[55]  = velocity*2;}
    if (pitch == 56 ) {PianoPitchX[56]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[56]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[56]  = velocity*2;}
    if (pitch == 57 ) {PianoPitchX[57]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[57]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[57]  = velocity*2;}
    if (pitch == 58 ) {PianoPitchX[58]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[58]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[58]  = velocity*2;}
    if (pitch == 59 ) {PianoPitchX[59]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[59]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[59]  = velocity*2;}
    if (pitch == 60 ) {PianoPitchX[60]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[60]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[60]  = velocity*2;}
    if (pitch == 61 ) {PianoPitchX[61]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[61]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[61]  = velocity*2;}
    if (pitch == 62 ) {PianoPitchX[62]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[62]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[62]  = velocity*2;}
    if (pitch == 63 ) {PianoPitchX[63]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[63]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[63]  = velocity*2;}
    if (pitch == 64 ) {PianoPitchX[64]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[64]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[64]  = velocity*2;}
    if (pitch == 65 ) {PianoPitchX[65]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[65]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[65]  = velocity*2;}
    if (pitch == 66 ) {PianoPitchX[66]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[66]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[66]  = velocity*2;}
    if (pitch == 67 ) {PianoPitchX[67]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[67]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[67]  = velocity*2;}
    if (pitch == 68 ) {PianoPitchX[68]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[68]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[68]  = velocity*2;}
    if (pitch == 69 ) {PianoPitchX[69]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[69]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[69]  = velocity*2;}
    if (pitch == 70 ) {PianoPitchX[70]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[70]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[70]  = velocity*2;}
    if (pitch == 71 ) {PianoPitchX[71]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[71]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[71]  = velocity*2;}
    if (pitch == 72 ) {PianoPitchX[72]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[72]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[72]  = velocity*2;}
    if (pitch == 73 ) {PianoPitchX[73]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[73]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[73]  = velocity*2;}
    if (pitch == 74 ) {PianoPitchX[74]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[74]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[74]  = velocity*2;}
    if (pitch == 75 ) {PianoPitchX[75]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[75]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[75]  = velocity*2;}
    if (pitch == 76 ) {PianoPitchX[76]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[76]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[76]  = velocity*2;}
    if (pitch == 77 ) {PianoPitchX[77]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[77]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[77]  = velocity*2;}
    if (pitch == 78 ) {PianoPitchX[78]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[78]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[78]  = velocity*2;}
    if (pitch == 79 ) {PianoPitchX[79]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[79]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[79]  = velocity*2;}
    if (pitch == 80 ) {PianoPitchX[80]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[80]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[80]  = velocity*2;}
    if (pitch == 81 ) {PianoPitchX[81]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[81]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[81]  = velocity*2;}
    if (pitch == 82 ) {PianoPitchX[82]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[82]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[82]  = velocity*2;}
    if (pitch == 83 ) {PianoPitchX[83]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[83]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[83]  = velocity*2;}
    if (pitch == 84 ) {PianoPitchX[84]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[84]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[84]  = velocity*2;}
    if (pitch == 85 ) {PianoPitchX[85]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[85]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[85]  = velocity*2;}
    if (pitch == 86 ) {PianoPitchX[86]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[86]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[86]  = velocity*2;}
    if (pitch == 87 ) {PianoPitchX[87]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[87]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[87]  = velocity*2;}
    if (pitch == 88 ) {PianoPitchX[88]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[88]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[88]  = velocity*2;}
    if (pitch == 89 ) {PianoPitchX[89]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[89]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[89]  = velocity*2;}
    if (pitch == 90 ) {PianoPitchX[90]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[90]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[90]  = velocity*2;}
    if (pitch == 91 ) {PianoPitchX[91]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[91]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[91]  = velocity*2;}
    if (pitch == 92 ) {PianoPitchX[92]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[92]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[92]  = velocity*2;}
    if (pitch == 93 ) {PianoPitchX[93]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[93]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[93]  = velocity*2;}
    if (pitch == 94 ) {PianoPitchX[94]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[94]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[94]  = velocity*2;}
    if (pitch == 95 ) {PianoPitchX[95]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[95]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[95]  = velocity*2;}
    if (pitch == 96 ) {PianoPitchX[96]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[96]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[96]  = velocity*2;}
    if (pitch == 97 ) {PianoPitchX[97]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[97]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[97]  = velocity*2;}
    if (pitch == 98 ) {PianoPitchX[98]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[98]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[98]  = velocity*2;}
    if (pitch == 99 ) {PianoPitchX[99]  = map(pitch, 0, 127, -width, width*2); PianoVelocityY[99]  = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[99]  = velocity*2;}
    if (pitch == 100) {PianoPitchX[100] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[100] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[100] = velocity*2;}
    if (pitch == 101) {PianoPitchX[101] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[101] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[101] = velocity*2;}
    if (pitch == 102) {PianoPitchX[102] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[102] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[102] = velocity*2;}
    if (pitch == 103) {PianoPitchX[103] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[103] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[103] = velocity*2;}
    if (pitch == 104) {PianoPitchX[104] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[104] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[104] = velocity*2;}
    if (pitch == 105) {PianoPitchX[105] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[105] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[105] = velocity*2;}
    if (pitch == 106) {PianoPitchX[106] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[106] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[106] = velocity*2;}
    if (pitch == 107) {PianoPitchX[107] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[107] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[107] = velocity*2;}
    if (pitch == 108) {PianoPitchX[108] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[108] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[108] = velocity*2;}
    if (pitch == 109) {PianoPitchX[109] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[109] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[109] = velocity*2;}
    if (pitch == 110) {PianoPitchX[110] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[110] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[110] = velocity*2;}
    if (pitch == 111) {PianoPitchX[111] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[111] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[111] = velocity*2;}
    if (pitch == 112) {PianoPitchX[112] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[112] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[112] = velocity*2;}
    if (pitch == 113) {PianoPitchX[113] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[113] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[113] = velocity*2;}
    if (pitch == 114) {PianoPitchX[114] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[114] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[114] = velocity*2;}
    if (pitch == 115) {PianoPitchX[115] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[115] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[115] = velocity*2;}
    if (pitch == 116) {PianoPitchX[116] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[116] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[116] = velocity*2;}
    if (pitch == 117) {PianoPitchX[117] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[117] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[117] = velocity*2;}
    if (pitch == 118) {PianoPitchX[118] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[118] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[118] = velocity*2;}
    if (pitch == 119) {PianoPitchX[119] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[119] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[119] = velocity*2;}
    if (pitch == 120) {PianoPitchX[120] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[120] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[120] = velocity*2;}
    if (pitch == 121) {PianoPitchX[121] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[121] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[121] = velocity*2;}
    if (pitch == 122) {PianoPitchX[122] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[122] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[122] = velocity*2;}
    if (pitch == 123) {PianoPitchX[123] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[123] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[123] = velocity*2;}
    if (pitch == 124) {PianoPitchX[124] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[124] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[124] = velocity*2;}
    if (pitch == 125) {PianoPitchX[125] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[125] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[125] = velocity*2;}
    if (pitch == 126) {PianoPitchX[126] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[126] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[126] = velocity*2;}
    if (pitch == 127) {PianoPitchX[127] = map(pitch, 0, 127, -width, width*2); PianoVelocityY[127] = map(velocity, 0, 127, height, 0);  PianoVelocityAlpha[127] = velocity*2;}
}

  //Pitches
  if (pitch ==   0) {PitchIsActive[0]   = true;}
  if (pitch ==   1) {PitchIsActive[1]   = true;}
  if (pitch ==   2) {PitchIsActive[2]   = true;}
  if (pitch ==   3) {PitchIsActive[3]   = true;}
  if (pitch ==   4) {PitchIsActive[4]   = true;}
  if (pitch ==   5) {PitchIsActive[5]   = true;}
  if (pitch ==   6) {PitchIsActive[6]   = true;}
  if (pitch ==   7) {PitchIsActive[7]   = true;}
  if (pitch ==   8) {PitchIsActive[8]   = true;}
  if (pitch ==   9) {PitchIsActive[9]   = true;}
  if (pitch ==  10) {PitchIsActive[10]  = true;}
  if (pitch ==  11) {PitchIsActive[11]  = true;}
  if (pitch ==  12) {PitchIsActive[12]  = true;}
  if (pitch ==  13) {PitchIsActive[13]  = true;}
  if (pitch ==  14) {PitchIsActive[14]  = true;}
  if (pitch ==  15) {PitchIsActive[15]  = true;}
  if (pitch ==  16) {PitchIsActive[16]  = true;}
  if (pitch ==  17) {PitchIsActive[17]  = true;}
  if (pitch ==  18) {PitchIsActive[18]  = true;}
  if (pitch ==  19) {PitchIsActive[19]  = true;}
  if (pitch ==  20) {PitchIsActive[20]  = true;}
  if (pitch ==  21) {PitchIsActive[21]  = true;}
  if (pitch ==  22) {PitchIsActive[22]  = true;}
  if (pitch ==  23) {PitchIsActive[23]  = true;}
  if (pitch ==  24) {PitchIsActive[24]  = true;}
  if (pitch ==  25) {PitchIsActive[25]  = true;}
  if (pitch ==  26) {PitchIsActive[26]  = true;}
  if (pitch ==  27) {PitchIsActive[27]  = true;}
  if (pitch ==  28) {PitchIsActive[28]  = true;}
  if (pitch ==  29) {PitchIsActive[29]  = true;}
  if (pitch ==  30) {PitchIsActive[30]  = true;}
  if (pitch ==  31) {PitchIsActive[31]  = true;}
  if (pitch ==  32) {PitchIsActive[32]  = true;}
  if (pitch ==  33) {PitchIsActive[33]  = true;}
  if (pitch ==  34) {PitchIsActive[34]  = true;}
  if (pitch ==  35) {PitchIsActive[35]  = true;}
  if (pitch ==  36) {PitchIsActive[36]  = true;}
  if (pitch ==  37) {PitchIsActive[37]  = true;}
  if (pitch ==  38) {PitchIsActive[38]  = true;}
  if (pitch ==  39) {PitchIsActive[39]  = true;}
  if (pitch ==  40) {PitchIsActive[40]  = true;}
  if (pitch ==  41) {PitchIsActive[41]  = true;}
  if (pitch ==  42) {PitchIsActive[42]  = true;}
  if (pitch ==  43) {PitchIsActive[43]  = true;}
  if (pitch ==  44) {PitchIsActive[44]  = true;}
  if (pitch ==  45) {PitchIsActive[45]  = true;}
  if (pitch ==  46) {PitchIsActive[46]  = true;}
  if (pitch ==  47) {PitchIsActive[47]  = true;}
  if (pitch ==  48) {PitchIsActive[48]  = true;}
  if (pitch ==  49) {PitchIsActive[49]  = true;}
  if (pitch ==  50) {PitchIsActive[50]  = true;}
  if (pitch ==  51) {PitchIsActive[51]  = true;}
  if (pitch ==  52) {PitchIsActive[52]  = true;}
  if (pitch ==  53) {PitchIsActive[53]  = true;}
  if (pitch ==  54) {PitchIsActive[54]  = true;}
  if (pitch ==  55) {PitchIsActive[55]  = true;}
  if (pitch ==  56) {PitchIsActive[56]  = true;}
  if (pitch ==  57) {PitchIsActive[57]  = true;}
  if (pitch ==  58) {PitchIsActive[58]  = true;}
  if (pitch ==  59) {PitchIsActive[59]  = true;}
  if (pitch ==  60) {PitchIsActive[60]  = true;}
  if (pitch ==  61) {PitchIsActive[61]  = true;}
  if (pitch ==  62) {PitchIsActive[62]  = true;}
  if (pitch ==  63) {PitchIsActive[63]  = true;}
  if (pitch ==  64) {PitchIsActive[64]  = true;}
  if (pitch ==  65) {PitchIsActive[65]  = true;}
  if (pitch ==  66) {PitchIsActive[66]  = true;}
  if (pitch ==  67) {PitchIsActive[67]  = true;}
  if (pitch ==  68) {PitchIsActive[68]  = true;}
  if (pitch ==  69) {PitchIsActive[69]  = true;}
  if (pitch ==  70) {PitchIsActive[70]  = true;}
  if (pitch ==  71) {PitchIsActive[71]  = true;}
  if (pitch ==  72) {PitchIsActive[72]  = true;}
  if (pitch ==  73) {PitchIsActive[73]  = true;}
  if (pitch ==  74) {PitchIsActive[74]  = true;}
  if (pitch ==  75) {PitchIsActive[75]  = true;}
  if (pitch ==  76) {PitchIsActive[76]  = true;}
  if (pitch ==  77) {PitchIsActive[77]  = true;}
  if (pitch ==  78) {PitchIsActive[78]  = true;}
  if (pitch ==  79) {PitchIsActive[79]  = true;}
  if (pitch ==  80) {PitchIsActive[80]  = true;}
  if (pitch ==  81) {PitchIsActive[81]  = true;}
  if (pitch ==  82) {PitchIsActive[82]  = true;}
  if (pitch ==  83) {PitchIsActive[83]  = true;}
  if (pitch ==  84) {PitchIsActive[84]  = true;}
  if (pitch ==  85) {PitchIsActive[85]  = true;}
  if (pitch ==  86) {PitchIsActive[86]  = true;}
  if (pitch ==  87) {PitchIsActive[87]  = true;}
  if (pitch ==  88) {PitchIsActive[88]  = true;}
  if (pitch ==  89) {PitchIsActive[89]  = true;}
  if (pitch ==  90) {PitchIsActive[90]  = true;}
  if (pitch ==  91) {PitchIsActive[91]  = true;}
  if (pitch ==  92) {PitchIsActive[92]  = true;}
  if (pitch ==  93) {PitchIsActive[93]  = true;}
  if (pitch ==  94) {PitchIsActive[94]  = true;}
  if (pitch ==  95) {PitchIsActive[95]  = true;}
  if (pitch ==  96) {PitchIsActive[96]  = true;}
  if (pitch ==  97) {PitchIsActive[97]  = true;}
  if (pitch ==  98) {PitchIsActive[98]  = true;}
  if (pitch ==  99) {PitchIsActive[99]  = true;}
  if (pitch == 100) {PitchIsActive[100] = true;}
  if (pitch == 101) {PitchIsActive[101] = true;}
  if (pitch == 102) {PitchIsActive[102] = true;}
  if (pitch == 103) {PitchIsActive[103] = true;}
  if (pitch == 104) {PitchIsActive[104] = true;}
  if (pitch == 105) {PitchIsActive[105] = true;}
  if (pitch == 106) {PitchIsActive[106] = true;}
  if (pitch == 107) {PitchIsActive[107] = true;}
  if (pitch == 108) {PitchIsActive[108] = true;}
  if (pitch == 109) {PitchIsActive[109] = true;}
  if (pitch == 110) {PitchIsActive[110] = true;}
  if (pitch == 111) {PitchIsActive[111] = true;}
  if (pitch == 112) {PitchIsActive[112] = true;}
  if (pitch == 113) {PitchIsActive[113] = true;}
  if (pitch == 114) {PitchIsActive[114] = true;}
  if (pitch == 115) {PitchIsActive[115] = true;}
  if (pitch == 116) {PitchIsActive[116] = true;}
  if (pitch == 117) {PitchIsActive[117] = true;}
  if (pitch == 118) {PitchIsActive[118] = true;}
  if (pitch == 119) {PitchIsActive[119] = true;}
  if (pitch == 120) {PitchIsActive[120] = true;}
  if (pitch == 121) {PitchIsActive[121] = true;}
  if (pitch == 122) {PitchIsActive[122] = true;}
  if (pitch == 123) {PitchIsActive[123] = true;}
  if (pitch == 124) {PitchIsActive[124] = true;}
  if (pitch == 125) {PitchIsActive[125] = true;}
  if (pitch == 126) {PitchIsActive[126] = true;}
  if (pitch == 127) {PitchIsActive[127] = true;}
}

//Note off event
void noteOff(int channel, int pitch, int velocity) {
  
  //Update global variables
  Channel = channel;
  Pitch = pitch;
  Velocity = velocity;
  
  debug = new Debug();
  debug.noteOffReturn();

  if (pitch ==   0) {PitchIsActive[0] = false;}
  if (pitch ==   1) {PitchIsActive[1] = false;}
  if (pitch ==   2) {PitchIsActive[2] = false;}
  if (pitch ==   3) {PitchIsActive[3] = false;}
  if (pitch ==   4) {PitchIsActive[4] = false;}
  if (pitch ==   5) {PitchIsActive[5] = false;}
  if (pitch ==   6) {PitchIsActive[6] = false;}
  if (pitch ==   7) {PitchIsActive[7] = false;}
  if (pitch ==   8) {PitchIsActive[8] = false;}
  if (pitch ==   9) {PitchIsActive[9] = false;}
  if (pitch ==  10) {PitchIsActive[10] = false;}
  if (pitch ==  11) {PitchIsActive[11] = false;}
  if (pitch ==  12) {PitchIsActive[12] = false;}
  if (pitch ==  13) {PitchIsActive[13] = false;}
  if (pitch ==  14) {PitchIsActive[14] = false;}
  if (pitch ==  15) {PitchIsActive[15] = false;}
  if (pitch ==  16) {PitchIsActive[16] = false;}
  if (pitch ==  17) {PitchIsActive[17] = false;}
  if (pitch ==  18) {PitchIsActive[18] = false;}
  if (pitch ==  19) {PitchIsActive[19] = false;}
  if (pitch ==  20) {PitchIsActive[20] = false;}
  if (pitch ==  21) {PitchIsActive[21] = false;}
  if (pitch ==  22) {PitchIsActive[22] = false;}
  if (pitch ==  23) {PitchIsActive[23] = false;}
  if (pitch ==  24) {PitchIsActive[24] = false;}
  if (pitch ==  25) {PitchIsActive[25] = false;}
  if (pitch ==  26) {PitchIsActive[26] = false;}
  if (pitch ==  27) {PitchIsActive[27] = false;}
  if (pitch ==  28) {PitchIsActive[28] = false;}
  if (pitch ==  29) {PitchIsActive[29] = false;}
  if (pitch ==  30) {PitchIsActive[30] = false;}
  if (pitch ==  31) {PitchIsActive[31] = false;}
  if (pitch ==  32) {PitchIsActive[32] = false;}
  if (pitch ==  33) {PitchIsActive[33] = false;}
  if (pitch ==  34) {PitchIsActive[34] = false;}
  if (pitch ==  35) {PitchIsActive[35] = false;}
  if (pitch ==  36) {PitchIsActive[36] = false;}
  if (pitch ==  37) {PitchIsActive[37] = false;}
  if (pitch ==  38) {PitchIsActive[38] = false;}
  if (pitch ==  39) {PitchIsActive[39] = false;}
  if (pitch ==  40) {PitchIsActive[40] = false;}
  if (pitch ==  41) {PitchIsActive[41] = false;}
  if (pitch ==  42) {PitchIsActive[42] = false;}
  if (pitch ==  43) {PitchIsActive[43] = false;}
  if (pitch ==  44) {PitchIsActive[44] = false;}
  if (pitch ==  45) {PitchIsActive[45] = false;}
  if (pitch ==  46) {PitchIsActive[46] = false;}
  if (pitch ==  47) {PitchIsActive[47] = false;}
  if (pitch ==  48) {PitchIsActive[48] = false;}
  if (pitch ==  49) {PitchIsActive[49] = false;}
  if (pitch ==  50) {PitchIsActive[50] = false;}
  if (pitch ==  51) {PitchIsActive[51] = false;}
  if (pitch ==  52) {PitchIsActive[52] = false;}
  if (pitch ==  53) {PitchIsActive[53] = false;}
  if (pitch ==  54) {PitchIsActive[54] = false;}
  if (pitch ==  55) {PitchIsActive[55] = false;}
  if (pitch ==  56) {PitchIsActive[56] = false;}
  if (pitch ==  57) {PitchIsActive[57] = false;}
  if (pitch ==  58) {PitchIsActive[58] = false;}
  if (pitch ==  59) {PitchIsActive[59] = false;}
  if (pitch ==  60) {PitchIsActive[60] = false;}
  if (pitch ==  61) {PitchIsActive[61] = false;}
  if (pitch ==  62) {PitchIsActive[62] = false;}
  if (pitch ==  63) {PitchIsActive[63] = false;}
  if (pitch ==  64) {PitchIsActive[64] = false;}
  if (pitch ==  65) {PitchIsActive[65] = false;}
  if (pitch ==  66) {PitchIsActive[66] = false;}
  if (pitch ==  67) {PitchIsActive[67] = false;}
  if (pitch ==  68) {PitchIsActive[68] = false;}
  if (pitch ==  69) {PitchIsActive[69] = false;}
  if (pitch ==  70) {PitchIsActive[70] = false;}
  if (pitch ==  71) {PitchIsActive[71] = false;}
  if (pitch ==  72) {PitchIsActive[72] = false;}
  if (pitch ==  73) {PitchIsActive[73] = false;}
  if (pitch ==  74) {PitchIsActive[74] = false;}
  if (pitch ==  75) {PitchIsActive[75] = false;}
  if (pitch ==  76) {PitchIsActive[76] = false;}
  if (pitch ==  77) {PitchIsActive[77] = false;}
  if (pitch ==  78) {PitchIsActive[78] = false;}
  if (pitch ==  79) {PitchIsActive[79] = false;}
  if (pitch ==  80) {PitchIsActive[80] = false;}
  if (pitch ==  81) {PitchIsActive[81] = false;}
  if (pitch ==  82) {PitchIsActive[82] = false;}
  if (pitch ==  83) {PitchIsActive[83] = false;}
  if (pitch ==  84) {PitchIsActive[84] = false;}
  if (pitch ==  85) {PitchIsActive[85] = false;}
  if (pitch ==  86) {PitchIsActive[86] = false;}
  if (pitch ==  87) {PitchIsActive[87] = false;}
  if (pitch ==  88) {PitchIsActive[88] = false;}
  if (pitch ==  89) {PitchIsActive[89] = false;}
  if (pitch ==  90) {PitchIsActive[90] = false;}
  if (pitch ==  91) {PitchIsActive[91] = false;}
  if (pitch ==  92) {PitchIsActive[92] = false;}
  if (pitch ==  93) {PitchIsActive[93] = false;}
  if (pitch ==  94) {PitchIsActive[94] = false;}
  if (pitch ==  95) {PitchIsActive[95] = false;}
  if (pitch ==  96) {PitchIsActive[96] = false;}
  if (pitch ==  97) {PitchIsActive[97] = false;}
  if (pitch ==  98) {PitchIsActive[98] = false;}
  if (pitch ==  99) {PitchIsActive[99] = false;}
  if (pitch == 100) {PitchIsActive[100] = false;}
  if (pitch == 101) {PitchIsActive[101] = false;}
  if (pitch == 102) {PitchIsActive[102] = false;}
  if (pitch == 103) {PitchIsActive[103] = false;}
  if (pitch == 104) {PitchIsActive[104] = false;}
  if (pitch == 105) {PitchIsActive[105] = false;}
  if (pitch == 106) {PitchIsActive[106] = false;}
  if (pitch == 107) {PitchIsActive[107] = false;}
  if (pitch == 108) {PitchIsActive[108] = false;}
  if (pitch == 109) {PitchIsActive[109] = false;}
  if (pitch == 110) {PitchIsActive[110] = false;}
  if (pitch == 111) {PitchIsActive[111] = false;}
  if (pitch == 112) {PitchIsActive[112] = false;}
  if (pitch == 113) {PitchIsActive[113] = false;}
  if (pitch == 114) {PitchIsActive[114] = false;}
  if (pitch == 115) {PitchIsActive[115] = false;}
  if (pitch == 116) {PitchIsActive[116] = false;}
  if (pitch == 117) {PitchIsActive[117] = false;}
  if (pitch == 118) {PitchIsActive[118] = false;}
  if (pitch == 119) {PitchIsActive[119] = false;}
  if (pitch == 120) {PitchIsActive[120] = false;}
  if (pitch == 121) {PitchIsActive[121] = false;}
  if (pitch == 122) {PitchIsActive[122] = false;}
  if (pitch == 123) {PitchIsActive[123] = false;}
  if (pitch == 124) {PitchIsActive[124] = false;}
  if (pitch == 125) {PitchIsActive[125] = false;}
  if (pitch == 126) {PitchIsActive[126] = false;}
  if (pitch == 127) {PitchIsActive[127] = false;}
}
