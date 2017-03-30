
//Synthesthesia
//MIDI music visualizer
//By Jonathan Arias
//MIDIBus by sparks - http://www.smallbutdigital.com/themidibus.php
//Starfield 3D by JimBrown - https://www.processing.org/discourse/beta/num_1209965886.html

//Import libraries
import themidibus.*; // MIDI interface bridge
import queasycam.*;  // Free view camera

//Create instances
Debug debug;                                    // Debug
Background background;                          // Background
QueasyCam cam;                                  // Dynamic camera
MidiBus myBus;                                  // MIDIBus
PianoGFX pianogfx;                              // Piano graphics
ChromaticPercussionGFX chromaticpercussiongfx;  // Chromatic Percussion graphics
OrganGFX organgfx;                              // Organ graphics

//Declare global Arrays
int[] Channels           = new int[128];
int[] Pitches            = new int[128];
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

//Color textures
  //Piano
  //Octave -1
  PImage PianoOctavem1CColor;
  PImage PianoOctavem1CSharpColor;
  PImage PianoOctavem1DColor;
  PImage PianoOctavem1DSharpColor;
  PImage PianoOctavem1EColor;
  PImage PianoOctavem1FColor;
  PImage PianoOctavem1FSharpColor;
  PImage PianoOctavem1GColor;
  PImage PianoOctavem1GSharpColor;
  PImage PianoOctavem1AColor;
  PImage PianoOctavem1ASharpColor;
  PImage PianoOctavem1BColor;
  //Octave 0
  PImage PianoOctave0CColor;
  PImage PianoOctave0CSharpColor;
  PImage PianoOctave0DColor;
  PImage PianoOctave0DSharpColor;
  PImage PianoOctave0EColor;
  PImage PianoOctave0FColor;
  PImage PianoOctave0FSharpColor;
  PImage PianoOctave0GColor;
  PImage PianoOctave0GSharpColor;
  PImage PianoOctave0AColor;
  PImage PianoOctave0ASharpColor;
  PImage PianoOctave0BColor;
  //Octave 1
  PImage PianoOctave1CColor;
  PImage PianoOctave1CSharpColor;
  PImage PianoOctave1DColor;
  PImage PianoOctave1DSharpColor;
  PImage PianoOctave1EColor;
  PImage PianoOctave1FColor;
  PImage PianoOctave1FSharpColor;
  PImage PianoOctave1GColor;
  PImage PianoOctave1GSharpColor;
  PImage PianoOctave1AColor;
  PImage PianoOctave1ASharpColor;
  PImage PianoOctave1BColor;
  //Octave 2
  PImage PianoOctave2CColor;
  PImage PianoOctave2CSharpColor;
  PImage PianoOctave2DColor;
  PImage PianoOctave2DSharpColor;
  PImage PianoOctave2EColor;
  PImage PianoOctave2FColor;
  PImage PianoOctave2FSharpColor;
  PImage PianoOctave2GColor;
  PImage PianoOctave2GSharpColor;
  PImage PianoOctave2AColor;
  PImage PianoOctave2ASharpColor;
  PImage PianoOctave2BColor;
  //Octave 3
  PImage PianoOctave3CColor;
  PImage PianoOctave3CSharpColor;
  PImage PianoOctave3DColor;
  PImage PianoOctave3DSharpColor;
  PImage PianoOctave3EColor;
  PImage PianoOctave3FColor;
  PImage PianoOctave3FSharpColor;
  PImage PianoOctave3GColor;
  PImage PianoOctave3GSharpColor;
  PImage PianoOctave3AColor;
  PImage PianoOctave3ASharpColor;
  PImage PianoOctave3BColor;
  //Octave 4
  PImage PianoOctave4CColor;
  PImage PianoOctave4CSharpColor;
  PImage PianoOctave4DColor;
  PImage PianoOctave4DSharpColor;
  PImage PianoOctave4EColor;
  PImage PianoOctave4FColor;
  PImage PianoOctave4FSharpColor;
  PImage PianoOctave4GColor;
  PImage PianoOctave4GSharpColor;
  PImage PianoOctave4AColor;
  PImage PianoOctave4ASharpColor;
  PImage PianoOctave4BColor;
  //Octave 5
  PImage PianoOctave5CColor;
  PImage PianoOctave5CSharpColor;
  PImage PianoOctave5DColor;
  PImage PianoOctave5DSharpColor;
  PImage PianoOctave5EColor;
  PImage PianoOctave5FColor;
  PImage PianoOctave5FSharpColor;
  PImage PianoOctave5GColor;
  PImage PianoOctave5GSharpColor;
  PImage PianoOctave5AColor;
  PImage PianoOctave5ASharpColor;
  PImage PianoOctave5BColor;
  //Octave 6
  PImage PianoOctave6CColor;
  PImage PianoOctave6CSharpColor;
  PImage PianoOctave6DColor;
  PImage PianoOctave6DSharpColor;
  PImage PianoOctave6EColor;
  PImage PianoOctave6FColor;
  PImage PianoOctave6FSharpColor;
  PImage PianoOctave6GColor;
  PImage PianoOctave6GSharpColor;
  PImage PianoOctave6AColor;
  PImage PianoOctave6ASharpColor;
  PImage PianoOctave6BColor;
  //Octave 7
  PImage PianoOctave7CColor;
  PImage PianoOctave7CSharpColor;
  PImage PianoOctave7DColor;
  PImage PianoOctave7DSharpColor;
  PImage PianoOctave7EColor;
  PImage PianoOctave7FColor;
  PImage PianoOctave7FSharpColor;
  PImage PianoOctave7GColor;
  PImage PianoOctave7GSharpColor;
  PImage PianoOctave7AColor;
  PImage PianoOctave7ASharpColor;
  PImage PianoOctave7BColor;
  //Octave 8
  PImage PianoOctave8CColor;
  PImage PianoOctave8CSharpColor;
  PImage PianoOctave8DColor;
  PImage PianoOctave8DSharpColor;
  PImage PianoOctave8EColor;
  PImage PianoOctave8FColor;
  PImage PianoOctave8FSharpColor;
  PImage PianoOctave8GColor;
  PImage PianoOctave8GSharpColor;
  PImage PianoOctave8AColor;
  PImage PianoOctave8ASharpColor;
  PImage PianoOctave8BColor;
  //Octave 9
  PImage PianoOctave9CColor;
  PImage PianoOctave9CSharpColor;
  PImage PianoOctave9DColor;
  PImage PianoOctave9DSharpColor;
  PImage PianoOctave9EColor;
  PImage PianoOctave9FColor;
  PImage PianoOctave9FSharpColor;
  PImage PianoOctave9GColor;

  //ChromaticPercussion
  //Octave -1
  PImage ChromaticPercussionOctavem1CColor;
  PImage ChromaticPercussionOctavem1CSharpColor;
  PImage ChromaticPercussionOctavem1DColor;
  PImage ChromaticPercussionOctavem1DSharpColor;
  PImage ChromaticPercussionOctavem1EColor;
  PImage ChromaticPercussionOctavem1FColor;
  PImage ChromaticPercussionOctavem1FSharpColor;
  PImage ChromaticPercussionOctavem1GColor;
  PImage ChromaticPercussionOctavem1GSharpColor;
  PImage ChromaticPercussionOctavem1AColor;
  PImage ChromaticPercussionOctavem1ASharpColor;
  PImage ChromaticPercussionOctavem1BColor;
  //Octave 0
  PImage ChromaticPercussionOctave0CColor;
  PImage ChromaticPercussionOctave0CSharpColor;
  PImage ChromaticPercussionOctave0DColor;
  PImage ChromaticPercussionOctave0DSharpColor;
  PImage ChromaticPercussionOctave0EColor;
  PImage ChromaticPercussionOctave0FColor;
  PImage ChromaticPercussionOctave0FSharpColor;
  PImage ChromaticPercussionOctave0GColor;
  PImage ChromaticPercussionOctave0GSharpColor;
  PImage ChromaticPercussionOctave0AColor;
  PImage ChromaticPercussionOctave0ASharpColor;
  PImage ChromaticPercussionOctave0BColor;
  //Octave 1
  PImage ChromaticPercussionOctave1CColor;
  PImage ChromaticPercussionOctave1CSharpColor;
  PImage ChromaticPercussionOctave1DColor;
  PImage ChromaticPercussionOctave1DSharpColor;
  PImage ChromaticPercussionOctave1EColor;
  PImage ChromaticPercussionOctave1FColor;
  PImage ChromaticPercussionOctave1FSharpColor;
  PImage ChromaticPercussionOctave1GColor;
  PImage ChromaticPercussionOctave1GSharpColor;
  PImage ChromaticPercussionOctave1AColor;
  PImage ChromaticPercussionOctave1ASharpColor;
  PImage ChromaticPercussionOctave1BColor;
  //Octave 2
  PImage ChromaticPercussionOctave2CColor;
  PImage ChromaticPercussionOctave2CSharpColor;
  PImage ChromaticPercussionOctave2DColor;
  PImage ChromaticPercussionOctave2DSharpColor;
  PImage ChromaticPercussionOctave2EColor;
  PImage ChromaticPercussionOctave2FColor;
  PImage ChromaticPercussionOctave2FSharpColor;
  PImage ChromaticPercussionOctave2GColor;
  PImage ChromaticPercussionOctave2GSharpColor;
  PImage ChromaticPercussionOctave2AColor;
  PImage ChromaticPercussionOctave2ASharpColor;
  PImage ChromaticPercussionOctave2BColor;
  //Octave 3
  PImage ChromaticPercussionOctave3CColor;
  PImage ChromaticPercussionOctave3CSharpColor;
  PImage ChromaticPercussionOctave3DColor;
  PImage ChromaticPercussionOctave3DSharpColor;
  PImage ChromaticPercussionOctave3EColor;
  PImage ChromaticPercussionOctave3FColor;
  PImage ChromaticPercussionOctave3FSharpColor;
  PImage ChromaticPercussionOctave3GColor;
  PImage ChromaticPercussionOctave3GSharpColor;
  PImage ChromaticPercussionOctave3AColor;
  PImage ChromaticPercussionOctave3ASharpColor;
  PImage ChromaticPercussionOctave3BColor;
  //Octave 4
  PImage ChromaticPercussionOctave4CColor;
  PImage ChromaticPercussionOctave4CSharpColor;
  PImage ChromaticPercussionOctave4DColor;
  PImage ChromaticPercussionOctave4DSharpColor;
  PImage ChromaticPercussionOctave4EColor;
  PImage ChromaticPercussionOctave4FColor;
  PImage ChromaticPercussionOctave4FSharpColor;
  PImage ChromaticPercussionOctave4GColor;
  PImage ChromaticPercussionOctave4GSharpColor;
  PImage ChromaticPercussionOctave4AColor;
  PImage ChromaticPercussionOctave4ASharpColor;
  PImage ChromaticPercussionOctave4BColor;
  //Octave 5
  PImage ChromaticPercussionOctave5CColor;
  PImage ChromaticPercussionOctave5CSharpColor;
  PImage ChromaticPercussionOctave5DColor;
  PImage ChromaticPercussionOctave5DSharpColor;
  PImage ChromaticPercussionOctave5EColor;
  PImage ChromaticPercussionOctave5FColor;
  PImage ChromaticPercussionOctave5FSharpColor;
  PImage ChromaticPercussionOctave5GColor;
  PImage ChromaticPercussionOctave5GSharpColor;
  PImage ChromaticPercussionOctave5AColor;
  PImage ChromaticPercussionOctave5ASharpColor;
  PImage ChromaticPercussionOctave5BColor;
  //Octave 6
  PImage ChromaticPercussionOctave6CColor;
  PImage ChromaticPercussionOctave6CSharpColor;
  PImage ChromaticPercussionOctave6DColor;
  PImage ChromaticPercussionOctave6DSharpColor;
  PImage ChromaticPercussionOctave6EColor;
  PImage ChromaticPercussionOctave6FColor;
  PImage ChromaticPercussionOctave6FSharpColor;
  PImage ChromaticPercussionOctave6GColor;
  PImage ChromaticPercussionOctave6GSharpColor;
  PImage ChromaticPercussionOctave6AColor;
  PImage ChromaticPercussionOctave6ASharpColor;
  PImage ChromaticPercussionOctave6BColor;
  //Octave 7
  PImage ChromaticPercussionOctave7CColor;
  PImage ChromaticPercussionOctave7CSharpColor;
  PImage ChromaticPercussionOctave7DColor;
  PImage ChromaticPercussionOctave7DSharpColor;
  PImage ChromaticPercussionOctave7EColor;
  PImage ChromaticPercussionOctave7FColor;
  PImage ChromaticPercussionOctave7FSharpColor;
  PImage ChromaticPercussionOctave7GColor;
  PImage ChromaticPercussionOctave7GSharpColor;
  PImage ChromaticPercussionOctave7AColor;
  PImage ChromaticPercussionOctave7ASharpColor;
  PImage ChromaticPercussionOctave7BColor;
  //Octave 8
  PImage ChromaticPercussionOctave8CColor;
  PImage ChromaticPercussionOctave8CSharpColor;
  PImage ChromaticPercussionOctave8DColor;
  PImage ChromaticPercussionOctave8DSharpColor;
  PImage ChromaticPercussionOctave8EColor;
  PImage ChromaticPercussionOctave8FColor;
  PImage ChromaticPercussionOctave8FSharpColor;
  PImage ChromaticPercussionOctave8GColor;
  PImage ChromaticPercussionOctave8GSharpColor;
  PImage ChromaticPercussionOctave8AColor;
  PImage ChromaticPercussionOctave8ASharpColor;
  PImage ChromaticPercussionOctave8BColor;
  //Octave 9
  PImage ChromaticPercussionOctave9CColor;
  PImage ChromaticPercussionOctave9CSharpColor;
  PImage ChromaticPercussionOctave9DColor;
  PImage ChromaticPercussionOctave9DSharpColor;
  PImage ChromaticPercussionOctave9EColor;
  PImage ChromaticPercussionOctave9FColor;
  PImage ChromaticPercussionOctave9FSharpColor;
  PImage ChromaticPercussionOctave9GColor;

  //Organ
  //Octave -1
  PImage OrganOctavem1CColor;
  PImage OrganOctavem1CSharpColor;
  PImage OrganOctavem1DColor;
  PImage OrganOctavem1DSharpColor;
  PImage OrganOctavem1EColor;
  PImage OrganOctavem1FColor;
  PImage OrganOctavem1FSharpColor;
  PImage OrganOctavem1GColor;
  PImage OrganOctavem1GSharpColor;
  PImage OrganOctavem1AColor;
  PImage OrganOctavem1ASharpColor;
  PImage OrganOctavem1BColor;
  //Octave 0
  PImage OrganOctave0CColor;
  PImage OrganOctave0CSharpColor;
  PImage OrganOctave0DColor;
  PImage OrganOctave0DSharpColor;
  PImage OrganOctave0EColor;
  PImage OrganOctave0FColor;
  PImage OrganOctave0FSharpColor;
  PImage OrganOctave0GColor;
  PImage OrganOctave0GSharpColor;
  PImage OrganOctave0AColor;
  PImage OrganOctave0ASharpColor;
  PImage OrganOctave0BColor;
  //Octave 1
  PImage OrganOctave1CColor;
  PImage OrganOctave1CSharpColor;
  PImage OrganOctave1DColor;
  PImage OrganOctave1DSharpColor;
  PImage OrganOctave1EColor;
  PImage OrganOctave1FColor;
  PImage OrganOctave1FSharpColor;
  PImage OrganOctave1GColor;
  PImage OrganOctave1GSharpColor;
  PImage OrganOctave1AColor;
  PImage OrganOctave1ASharpColor;
  PImage OrganOctave1BColor;
  //Octave 2
  PImage OrganOctave2CColor;
  PImage OrganOctave2CSharpColor;
  PImage OrganOctave2DColor;
  PImage OrganOctave2DSharpColor;
  PImage OrganOctave2EColor;
  PImage OrganOctave2FColor;
  PImage OrganOctave2FSharpColor;
  PImage OrganOctave2GColor;
  PImage OrganOctave2GSharpColor;
  PImage OrganOctave2AColor;
  PImage OrganOctave2ASharpColor;
  PImage OrganOctave2BColor;
  //Octave 3
  PImage OrganOctave3CColor;
  PImage OrganOctave3CSharpColor;
  PImage OrganOctave3DColor;
  PImage OrganOctave3DSharpColor;
  PImage OrganOctave3EColor;
  PImage OrganOctave3FColor;
  PImage OrganOctave3FSharpColor;
  PImage OrganOctave3GColor;
  PImage OrganOctave3GSharpColor;
  PImage OrganOctave3AColor;
  PImage OrganOctave3ASharpColor;
  PImage OrganOctave3BColor;
  //Octave 4
  PImage OrganOctave4CColor;
  PImage OrganOctave4CSharpColor;
  PImage OrganOctave4DColor;
  PImage OrganOctave4DSharpColor;
  PImage OrganOctave4EColor;
  PImage OrganOctave4FColor;
  PImage OrganOctave4FSharpColor;
  PImage OrganOctave4GColor;
  PImage OrganOctave4GSharpColor;
  PImage OrganOctave4AColor;
  PImage OrganOctave4ASharpColor;
  PImage OrganOctave4BColor;
  //Octave 5
  PImage OrganOctave5CColor;
  PImage OrganOctave5CSharpColor;
  PImage OrganOctave5DColor;
  PImage OrganOctave5DSharpColor;
  PImage OrganOctave5EColor;
  PImage OrganOctave5FColor;
  PImage OrganOctave5FSharpColor;
  PImage OrganOctave5GColor;
  PImage OrganOctave5GSharpColor;
  PImage OrganOctave5AColor;
  PImage OrganOctave5ASharpColor;
  PImage OrganOctave5BColor;
  //Octave 6
  PImage OrganOctave6CColor;
  PImage OrganOctave6CSharpColor;
  PImage OrganOctave6DColor;
  PImage OrganOctave6DSharpColor;
  PImage OrganOctave6EColor;
  PImage OrganOctave6FColor;
  PImage OrganOctave6FSharpColor;
  PImage OrganOctave6GColor;
  PImage OrganOctave6GSharpColor;
  PImage OrganOctave6AColor;
  PImage OrganOctave6ASharpColor;
  PImage OrganOctave6BColor;
  //Octave 7
  PImage OrganOctave7CColor;
  PImage OrganOctave7CSharpColor;
  PImage OrganOctave7DColor;
  PImage OrganOctave7DSharpColor;
  PImage OrganOctave7EColor;
  PImage OrganOctave7FColor;
  PImage OrganOctave7FSharpColor;
  PImage OrganOctave7GColor;
  PImage OrganOctave7GSharpColor;
  PImage OrganOctave7AColor;
  PImage OrganOctave7ASharpColor;
  PImage OrganOctave7BColor;
  //Octave 8
  PImage OrganOctave8CColor;
  PImage OrganOctave8CSharpColor;
  PImage OrganOctave8DColor;
  PImage OrganOctave8DSharpColor;
  PImage OrganOctave8EColor;
  PImage OrganOctave8FColor;
  PImage OrganOctave8FSharpColor;
  PImage OrganOctave8GColor;
  PImage OrganOctave8GSharpColor;
  PImage OrganOctave8AColor;
  PImage OrganOctave8ASharpColor;
  PImage OrganOctave8BColor;
  //Octave 9
  PImage OrganOctave9CColor;
  PImage OrganOctave9CSharpColor;
  PImage OrganOctave9DColor;
  PImage OrganOctave9DSharpColor;
  PImage OrganOctave9EColor;
  PImage OrganOctave9FColor;
  PImage OrganOctave9FSharpColor;
  PImage OrganOctave9GColor;

//Instrument masks
  PImage PianoMask;
  PImage ChromaticPercussionMask;
  PImage OrganMask;

//Animation
  //Noise
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
  
//  //Image sequence
//  PImage[] OrganAnimation;
//  int imageCount;
//  int frame;

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

  /// 3D Starfield
  int numstars=400;
  final int SPREAD=64;
  int CX,CY;
  final float SPEED=1.9;
  Star[] s = new Star[numstars];

//Setup
void setup() {
//  size(950, 540);        // 1/4 1080p
//  size(950, 540, P3D);     // 1/4 1080p 3D
//  size(1280, 720);       // 720p 2D
  size(1280, 720, P3D);  // 720p 3D
  smooth(8);             // 8X Antialiasing
  
  background(32);
  
  //Camera
//  cam = new QueasyCam(this);
//  cam.speed = 2;                    //Default is 2
//  cam.sensitivity = 0.25;              //Default is 0.25
  
  //MIDI data
  MidiBus.list();                     // List available Midi devices
  myBus = new MidiBus(this, 0, -1);   // Create a new MidiBus using the device names to select the Midi input and output devices respectively.
  
  //Sphere - Inner (Sky dome)
  dome = createShape(SPHERE, 2500);
  sky = loadImage("sky.jpg");
  dome.setTexture(sky);
  
  //Starfield
    CX=width/2 ; CY=height/2;
 /// s = new Star[numstars];
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

  //Colors
  //Piano
  PianoOctavem1CColor = loadImage("Octavem1CColor.png");
  PianoOctavem1CSharpColor = loadImage("Octavem1CSharpColor.png");
  PianoOctavem1DColor = loadImage("Octavem1DColor.png");
  PianoOctavem1DSharpColor = loadImage("Octavem1DSharpColor.png");
  PianoOctavem1EColor = loadImage("Octavem1EColor.png");
  PianoOctavem1FColor = loadImage("Octavem1FColor.png");
  PianoOctavem1FSharpColor = loadImage("Octavem1FSharpColor.png");
  PianoOctavem1GColor = loadImage("Octavem1GColor.png");
  PianoOctavem1GSharpColor = loadImage("Octavem1GSharpColor.png");
  PianoOctavem1AColor = loadImage("Octavem1AColor.png");
  PianoOctavem1ASharpColor = loadImage("Octavem1ASharpColor.png");
  PianoOctavem1BColor = loadImage("Octavem1BColor.png");
  PianoOctave0CColor = loadImage("Octave0CColor.png");
  PianoOctave0CSharpColor = loadImage("Octave0CSharpColor.png");
  PianoOctave0DColor = loadImage("Octave0DColor.png");
  PianoOctave0DSharpColor = loadImage("Octave0DSharpColor.png");
  PianoOctave0EColor = loadImage("Octave0EColor.png");
  PianoOctave0FColor = loadImage("Octave0FColor.png");
  PianoOctave0FSharpColor = loadImage("Octave0FSharpColor.png");
  PianoOctave0GColor = loadImage("Octave0GColor.png");
  PianoOctave0GSharpColor = loadImage("Octave0GSharpColor.png");
  PianoOctave0AColor = loadImage("Octave0AColor.png");
  PianoOctave0ASharpColor = loadImage("Octave0ASharpColor.png");
  PianoOctave0BColor = loadImage("Octave0BColor.png");
  PianoOctave1CColor = loadImage("Octave1CColor.png");
  PianoOctave1CSharpColor = loadImage("Octave1CSharpColor.png");
  PianoOctave1DColor = loadImage("Octave1DColor.png");
  PianoOctave1DSharpColor = loadImage("Octave1DSharpColor.png");
  PianoOctave1EColor = loadImage("Octave1EColor.png");
  PianoOctave1FColor = loadImage("Octave1FColor.png");
  PianoOctave1FSharpColor = loadImage("Octave1FSharpColor.png");
  PianoOctave1GColor = loadImage("Octave1GColor.png");
  PianoOctave1GSharpColor = loadImage("Octave1GSharpColor.png");
  PianoOctave1AColor = loadImage("Octave1AColor.png");
  PianoOctave1ASharpColor = loadImage("Octave1ASharpColor.png");
  PianoOctave1BColor = loadImage("Octave1BColor.png");
  PianoOctave2CColor = loadImage("Octave2CColor.png");
  PianoOctave2CSharpColor = loadImage("Octave2CSharpColor.png");
  PianoOctave2DColor = loadImage("Octave2DColor.png");
  PianoOctave2DSharpColor = loadImage("Octave2DSharpColor.png");
  PianoOctave2EColor = loadImage("Octave2EColor.png");
  PianoOctave2FColor = loadImage("Octave2FColor.png");
  PianoOctave2FSharpColor = loadImage("Octave2FSharpColor.png");
  PianoOctave2GColor = loadImage("Octave2GColor.png");
  PianoOctave2GSharpColor = loadImage("Octave2GSharpColor.png");
  PianoOctave2AColor = loadImage("Octave2AColor.png");
  PianoOctave2ASharpColor = loadImage("Octave2ASharpColor.png");
  PianoOctave2BColor = loadImage("Octave2BColor.png");
  PianoOctave3CColor = loadImage("Octave3CColor.png");
  PianoOctave3CSharpColor = loadImage("Octave3CSharpColor.png");
  PianoOctave3DColor = loadImage("Octave3DColor.png");
  PianoOctave3DSharpColor = loadImage("Octave3DSharpColor.png");
  PianoOctave3EColor = loadImage("Octave3EColor.png");
  PianoOctave3FColor = loadImage("Octave3FColor.png");
  PianoOctave3FSharpColor = loadImage("Octave3FSharpColor.png");
  PianoOctave3GColor = loadImage("Octave3GColor.png");
  PianoOctave3GSharpColor = loadImage("Octave3GSharpColor.png");
  PianoOctave3AColor = loadImage("Octave3AColor.png");
  PianoOctave3ASharpColor = loadImage("Octave3ASharpColor.png");
  PianoOctave3BColor = loadImage("Octave3BColor.png");
  PianoOctave4CColor = loadImage("Octave4CColor.png");
  PianoOctave4CSharpColor = loadImage("Octave4CSharpColor.png");
  PianoOctave4DColor = loadImage("Octave4DColor.png");
  PianoOctave4DSharpColor = loadImage("Octave4DSharpColor.png");
  PianoOctave4EColor = loadImage("Octave4EColor.png");
  PianoOctave4FColor = loadImage("Octave4FColor.png");
  PianoOctave4FSharpColor = loadImage("Octave4FSharpColor.png");
  PianoOctave4GColor = loadImage("Octave4GColor.png");
  PianoOctave4GSharpColor = loadImage("Octave4GSharpColor.png");
  PianoOctave4AColor = loadImage("Octave4AColor.png");
  PianoOctave4ASharpColor = loadImage("Octave4ASharpColor.png");
  PianoOctave4BColor = loadImage("Octave4BColor.png");
  PianoOctave5CColor = loadImage("Octave5CColor.png");
  PianoOctave5CSharpColor = loadImage("Octave5CSharpColor.png");
  PianoOctave5DColor = loadImage("Octave5DColor.png");
  PianoOctave5DSharpColor = loadImage("Octave5DSharpColor.png");
  PianoOctave5EColor = loadImage("Octave5EColor.png");
  PianoOctave5FColor = loadImage("Octave5FColor.png");
  PianoOctave5FSharpColor = loadImage("Octave5FSharpColor.png");
  PianoOctave5GColor = loadImage("Octave5GColor.png");
  PianoOctave5GSharpColor = loadImage("Octave5GSharpColor.png");
  PianoOctave5AColor = loadImage("Octave5AColor.png");
  PianoOctave5ASharpColor = loadImage("Octave5ASharpColor.png");
  PianoOctave5BColor = loadImage("Octave5BColor.png");
  PianoOctave6CColor = loadImage("Octave6CColor.png");
  PianoOctave6CSharpColor = loadImage("Octave6CSharpColor.png");
  PianoOctave6DColor = loadImage("Octave6DColor.png");
  PianoOctave6DSharpColor = loadImage("Octave6DSharpColor.png");
  PianoOctave6EColor = loadImage("Octave6EColor.png");
  PianoOctave6FColor = loadImage("Octave6FColor.png");
  PianoOctave6FSharpColor = loadImage("Octave6FSharpColor.png");
  PianoOctave6GColor = loadImage("Octave6GColor.png");
  PianoOctave6GSharpColor = loadImage("Octave6GSharpColor.png");
  PianoOctave6AColor = loadImage("Octave6AColor.png");
  PianoOctave6ASharpColor = loadImage("Octave6ASharpColor.png");
  PianoOctave6BColor = loadImage("Octave6BColor.png");
  PianoOctave7CColor = loadImage("Octave7CColor.png");
  PianoOctave7CSharpColor = loadImage("Octave7CSharpColor.png");
  PianoOctave7DColor = loadImage("Octave7DColor.png");
  PianoOctave7DSharpColor = loadImage("Octave7DSharpColor.png");
  PianoOctave7EColor = loadImage("Octave7EColor.png");
  PianoOctave7FColor = loadImage("Octave7FColor.png");
  PianoOctave7FSharpColor = loadImage("Octave7FSharpColor.png");
  PianoOctave7GColor = loadImage("Octave7GColor.png");
  PianoOctave7GSharpColor = loadImage("Octave7GSharpColor.png");
  PianoOctave7AColor = loadImage("Octave7AColor.png");
  PianoOctave7ASharpColor = loadImage("Octave7ASharpColor.png");
  PianoOctave7BColor = loadImage("Octave7BColor.png");
  PianoOctave8CColor = loadImage("Octave8CColor.png");
  PianoOctave8CSharpColor = loadImage("Octave8CSharpColor.png");
  PianoOctave8DColor = loadImage("Octave8DColor.png");
  PianoOctave8DSharpColor = loadImage("Octave8DSharpColor.png");
  PianoOctave8EColor = loadImage("Octave8EColor.png");
  PianoOctave8FColor = loadImage("Octave8FColor.png");
  PianoOctave8FSharpColor = loadImage("Octave8FSharpColor.png");
  PianoOctave8GColor = loadImage("Octave8GColor.png");
  PianoOctave8GSharpColor = loadImage("Octave8GSharpColor.png");
  PianoOctave8AColor = loadImage("Octave8AColor.png");
  PianoOctave8ASharpColor = loadImage("Octave8ASharpColor.png");
  PianoOctave8BColor = loadImage("Octave8BColor.png");
  PianoOctave9CColor = loadImage("Octave9CColor.png");
  PianoOctave9CSharpColor = loadImage("Octave9CSharpColor.png");
  PianoOctave9DColor = loadImage("Octave9DColor.png");
  PianoOctave9DSharpColor = loadImage("Octave9DSharpColor.png");
  PianoOctave9EColor = loadImage("Octave9EColor.png");
  PianoOctave9FColor = loadImage("Octave9FColor.png");
  PianoOctave9FSharpColor = loadImage("Octave9FSharpColor.png");
  PianoOctave9GColor = loadImage("Octave9GColor.png");
  
  //ChromaticPercussion
  ChromaticPercussionOctavem1CColor = loadImage("Octavem1CColor.png");
  ChromaticPercussionOctavem1CSharpColor = loadImage("Octavem1CSharpColor.png");
  ChromaticPercussionOctavem1DColor = loadImage("Octavem1DColor.png");
  ChromaticPercussionOctavem1DSharpColor = loadImage("Octavem1DSharpColor.png");
  ChromaticPercussionOctavem1EColor = loadImage("Octavem1EColor.png");
  ChromaticPercussionOctavem1FColor = loadImage("Octavem1FColor.png");
  ChromaticPercussionOctavem1FSharpColor = loadImage("Octavem1FSharpColor.png");
  ChromaticPercussionOctavem1GColor = loadImage("Octavem1GColor.png");
  ChromaticPercussionOctavem1GSharpColor = loadImage("Octavem1GSharpColor.png");
  ChromaticPercussionOctavem1AColor = loadImage("Octavem1AColor.png");
  ChromaticPercussionOctavem1ASharpColor = loadImage("Octavem1ASharpColor.png");
  ChromaticPercussionOctavem1BColor = loadImage("Octavem1BColor.png");
  ChromaticPercussionOctave0CColor = loadImage("Octave0CColor.png");
  ChromaticPercussionOctave0CSharpColor = loadImage("Octave0CSharpColor.png");
  ChromaticPercussionOctave0DColor = loadImage("Octave0DColor.png");
  ChromaticPercussionOctave0DSharpColor = loadImage("Octave0DSharpColor.png");
  ChromaticPercussionOctave0EColor = loadImage("Octave0EColor.png");
  ChromaticPercussionOctave0FColor = loadImage("Octave0FColor.png");
  ChromaticPercussionOctave0FSharpColor = loadImage("Octave0FSharpColor.png");
  ChromaticPercussionOctave0GColor = loadImage("Octave0GColor.png");
  ChromaticPercussionOctave0GSharpColor = loadImage("Octave0GSharpColor.png");
  ChromaticPercussionOctave0AColor = loadImage("Octave0AColor.png");
  ChromaticPercussionOctave0ASharpColor = loadImage("Octave0ASharpColor.png");
  ChromaticPercussionOctave0BColor = loadImage("Octave0BColor.png");
  ChromaticPercussionOctave1CColor = loadImage("Octave1CColor.png");
  ChromaticPercussionOctave1CSharpColor = loadImage("Octave1CSharpColor.png");
  ChromaticPercussionOctave1DColor = loadImage("Octave1DColor.png");
  ChromaticPercussionOctave1DSharpColor = loadImage("Octave1DSharpColor.png");
  ChromaticPercussionOctave1EColor = loadImage("Octave1EColor.png");
  ChromaticPercussionOctave1FColor = loadImage("Octave1FColor.png");
  ChromaticPercussionOctave1FSharpColor = loadImage("Octave1FSharpColor.png");
  ChromaticPercussionOctave1GColor = loadImage("Octave1GColor.png");
  ChromaticPercussionOctave1GSharpColor = loadImage("Octave1GSharpColor.png");
  ChromaticPercussionOctave1AColor = loadImage("Octave1AColor.png");
  ChromaticPercussionOctave1ASharpColor = loadImage("Octave1ASharpColor.png");
  ChromaticPercussionOctave1BColor = loadImage("Octave1BColor.png");
  ChromaticPercussionOctave2CColor = loadImage("Octave2CColor.png");
  ChromaticPercussionOctave2CSharpColor = loadImage("Octave2CSharpColor.png");
  ChromaticPercussionOctave2DColor = loadImage("Octave2DColor.png");
  ChromaticPercussionOctave2DSharpColor = loadImage("Octave2DSharpColor.png");
  ChromaticPercussionOctave2EColor = loadImage("Octave2EColor.png");
  ChromaticPercussionOctave2FColor = loadImage("Octave2FColor.png");
  ChromaticPercussionOctave2FSharpColor = loadImage("Octave2FSharpColor.png");
  ChromaticPercussionOctave2GColor = loadImage("Octave2GColor.png");
  ChromaticPercussionOctave2GSharpColor = loadImage("Octave2GSharpColor.png");
  ChromaticPercussionOctave2AColor = loadImage("Octave2AColor.png");
  ChromaticPercussionOctave2ASharpColor = loadImage("Octave2ASharpColor.png");
  ChromaticPercussionOctave2BColor = loadImage("Octave2BColor.png");
  ChromaticPercussionOctave3CColor = loadImage("Octave3CColor.png");
  ChromaticPercussionOctave3CSharpColor = loadImage("Octave3CSharpColor.png");
  ChromaticPercussionOctave3DColor = loadImage("Octave3DColor.png");
  ChromaticPercussionOctave3DSharpColor = loadImage("Octave3DSharpColor.png");
  ChromaticPercussionOctave3EColor = loadImage("Octave3EColor.png");
  ChromaticPercussionOctave3FColor = loadImage("Octave3FColor.png");
  ChromaticPercussionOctave3FSharpColor = loadImage("Octave3FSharpColor.png");
  ChromaticPercussionOctave3GColor = loadImage("Octave3GColor.png");
  ChromaticPercussionOctave3GSharpColor = loadImage("Octave3GSharpColor.png");
  ChromaticPercussionOctave3AColor = loadImage("Octave3AColor.png");
  ChromaticPercussionOctave3ASharpColor = loadImage("Octave3ASharpColor.png");
  ChromaticPercussionOctave3BColor = loadImage("Octave3BColor.png");
  ChromaticPercussionOctave4CColor = loadImage("Octave4CColor.png");
  ChromaticPercussionOctave4CSharpColor = loadImage("Octave4CSharpColor.png");
  ChromaticPercussionOctave4DColor = loadImage("Octave4DColor.png");
  ChromaticPercussionOctave4DSharpColor = loadImage("Octave4DSharpColor.png");
  ChromaticPercussionOctave4EColor = loadImage("Octave4EColor.png");
  ChromaticPercussionOctave4FColor = loadImage("Octave4FColor.png");
  ChromaticPercussionOctave4FSharpColor = loadImage("Octave4FSharpColor.png");
  ChromaticPercussionOctave4GColor = loadImage("Octave4GColor.png");
  ChromaticPercussionOctave4GSharpColor = loadImage("Octave4GSharpColor.png");
  ChromaticPercussionOctave4AColor = loadImage("Octave4AColor.png");
  ChromaticPercussionOctave4ASharpColor = loadImage("Octave4ASharpColor.png");
  ChromaticPercussionOctave4BColor = loadImage("Octave4BColor.png");
  ChromaticPercussionOctave5CColor = loadImage("Octave5CColor.png");
  ChromaticPercussionOctave5CSharpColor = loadImage("Octave5CSharpColor.png");
  ChromaticPercussionOctave5DColor = loadImage("Octave5DColor.png");
  ChromaticPercussionOctave5DSharpColor = loadImage("Octave5DSharpColor.png");
  ChromaticPercussionOctave5EColor = loadImage("Octave5EColor.png");
  ChromaticPercussionOctave5FColor = loadImage("Octave5FColor.png");
  ChromaticPercussionOctave5FSharpColor = loadImage("Octave5FSharpColor.png");
  ChromaticPercussionOctave5GColor = loadImage("Octave5GColor.png");
  ChromaticPercussionOctave5GSharpColor = loadImage("Octave5GSharpColor.png");
  ChromaticPercussionOctave5AColor = loadImage("Octave5AColor.png");
  ChromaticPercussionOctave5ASharpColor = loadImage("Octave5ASharpColor.png");
  ChromaticPercussionOctave5BColor = loadImage("Octave5BColor.png");
  ChromaticPercussionOctave6CColor = loadImage("Octave6CColor.png");
  ChromaticPercussionOctave6CSharpColor = loadImage("Octave6CSharpColor.png");
  ChromaticPercussionOctave6DColor = loadImage("Octave6DColor.png");
  ChromaticPercussionOctave6DSharpColor = loadImage("Octave6DSharpColor.png");
  ChromaticPercussionOctave6EColor = loadImage("Octave6EColor.png");
  ChromaticPercussionOctave6FColor = loadImage("Octave6FColor.png");
  ChromaticPercussionOctave6FSharpColor = loadImage("Octave6FSharpColor.png");
  ChromaticPercussionOctave6GColor = loadImage("Octave6GColor.png");
  ChromaticPercussionOctave6GSharpColor = loadImage("Octave6GSharpColor.png");
  ChromaticPercussionOctave6AColor = loadImage("Octave6AColor.png");
  ChromaticPercussionOctave6ASharpColor = loadImage("Octave6ASharpColor.png");
  ChromaticPercussionOctave6BColor = loadImage("Octave6BColor.png");
  ChromaticPercussionOctave7CColor = loadImage("Octave7CColor.png");
  ChromaticPercussionOctave7CSharpColor = loadImage("Octave7CSharpColor.png");
  ChromaticPercussionOctave7DColor = loadImage("Octave7DColor.png");
  ChromaticPercussionOctave7DSharpColor = loadImage("Octave7DSharpColor.png");
  ChromaticPercussionOctave7EColor = loadImage("Octave7EColor.png");
  ChromaticPercussionOctave7FColor = loadImage("Octave7FColor.png");
  ChromaticPercussionOctave7FSharpColor = loadImage("Octave7FSharpColor.png");
  ChromaticPercussionOctave7GColor = loadImage("Octave7GColor.png");
  ChromaticPercussionOctave7GSharpColor = loadImage("Octave7GSharpColor.png");
  ChromaticPercussionOctave7AColor = loadImage("Octave7AColor.png");
  ChromaticPercussionOctave7ASharpColor = loadImage("Octave7ASharpColor.png");
  ChromaticPercussionOctave7BColor = loadImage("Octave7BColor.png");
  ChromaticPercussionOctave8CColor = loadImage("Octave8CColor.png");
  ChromaticPercussionOctave8CSharpColor = loadImage("Octave8CSharpColor.png");
  ChromaticPercussionOctave8DColor = loadImage("Octave8DColor.png");
  ChromaticPercussionOctave8DSharpColor = loadImage("Octave8DSharpColor.png");
  ChromaticPercussionOctave8EColor = loadImage("Octave8EColor.png");
  ChromaticPercussionOctave8FColor = loadImage("Octave8FColor.png");
  ChromaticPercussionOctave8FSharpColor = loadImage("Octave8FSharpColor.png");
  ChromaticPercussionOctave8GColor = loadImage("Octave8GColor.png");
  ChromaticPercussionOctave8GSharpColor = loadImage("Octave8GSharpColor.png");
  ChromaticPercussionOctave8AColor = loadImage("Octave8AColor.png");
  ChromaticPercussionOctave8ASharpColor = loadImage("Octave8ASharpColor.png");
  ChromaticPercussionOctave8BColor = loadImage("Octave8BColor.png");
  ChromaticPercussionOctave9CColor = loadImage("Octave9CColor.png");
  ChromaticPercussionOctave9CSharpColor = loadImage("Octave9CSharpColor.png");
  ChromaticPercussionOctave9DColor = loadImage("Octave9DColor.png");
  ChromaticPercussionOctave9DSharpColor = loadImage("Octave9DSharpColor.png");
  ChromaticPercussionOctave9EColor = loadImage("Octave9EColor.png");
  ChromaticPercussionOctave9FColor = loadImage("Octave9FColor.png");
  ChromaticPercussionOctave9FSharpColor = loadImage("Octave9FSharpColor.png");
  ChromaticPercussionOctave9GColor = loadImage("Octave9GColor.png");

  //Organ
  OrganOctavem1CColor = loadImage("Octavem1CColor.png");
  OrganOctavem1CSharpColor = loadImage("Octavem1CSharpColor.png");
  OrganOctavem1DColor = loadImage("Octavem1DColor.png");
  OrganOctavem1DSharpColor = loadImage("Octavem1DSharpColor.png");
  OrganOctavem1EColor = loadImage("Octavem1EColor.png");
  OrganOctavem1FColor = loadImage("Octavem1FColor.png");
  OrganOctavem1FSharpColor = loadImage("Octavem1FSharpColor.png");
  OrganOctavem1GColor = loadImage("Octavem1GColor.png");
  OrganOctavem1GSharpColor = loadImage("Octavem1GSharpColor.png");
  OrganOctavem1AColor = loadImage("Octavem1AColor.png");
  OrganOctavem1ASharpColor = loadImage("Octavem1ASharpColor.png");
  OrganOctavem1BColor = loadImage("Octavem1BColor.png");
  OrganOctave0CColor = loadImage("Octave0CColor.png");
  OrganOctave0CSharpColor = loadImage("Octave0CSharpColor.png");
  OrganOctave0DColor = loadImage("Octave0DColor.png");
  OrganOctave0DSharpColor = loadImage("Octave0DSharpColor.png");
  OrganOctave0EColor = loadImage("Octave0EColor.png");
  OrganOctave0FColor = loadImage("Octave0FColor.png");
  OrganOctave0FSharpColor = loadImage("Octave0FSharpColor.png");
  OrganOctave0GColor = loadImage("Octave0GColor.png");
  OrganOctave0GSharpColor = loadImage("Octave0GSharpColor.png");
  OrganOctave0AColor = loadImage("Octave0AColor.png");
  OrganOctave0ASharpColor = loadImage("Octave0ASharpColor.png");
  OrganOctave0BColor = loadImage("Octave0BColor.png");
  OrganOctave1CColor = loadImage("Octave1CColor.png");
  OrganOctave1CSharpColor = loadImage("Octave1CSharpColor.png");
  OrganOctave1DColor = loadImage("Octave1DColor.png");
  OrganOctave1DSharpColor = loadImage("Octave1DSharpColor.png");
  OrganOctave1EColor = loadImage("Octave1EColor.png");
  OrganOctave1FColor = loadImage("Octave1FColor.png");
  OrganOctave1FSharpColor = loadImage("Octave1FSharpColor.png");
  OrganOctave1GColor = loadImage("Octave1GColor.png");
  OrganOctave1GSharpColor = loadImage("Octave1GSharpColor.png");
  OrganOctave1AColor = loadImage("Octave1AColor.png");
  OrganOctave1ASharpColor = loadImage("Octave1ASharpColor.png");
  OrganOctave1BColor = loadImage("Octave1BColor.png");
  OrganOctave2CColor = loadImage("Octave2CColor.png");
  OrganOctave2CSharpColor = loadImage("Octave2CSharpColor.png");
  OrganOctave2DColor = loadImage("Octave2DColor.png");
  OrganOctave2DSharpColor = loadImage("Octave2DSharpColor.png");
  OrganOctave2EColor = loadImage("Octave2EColor.png");
  OrganOctave2FColor = loadImage("Octave2FColor.png");
  OrganOctave2FSharpColor = loadImage("Octave2FSharpColor.png");
  OrganOctave2GColor = loadImage("Octave2GColor.png");
  OrganOctave2GSharpColor = loadImage("Octave2GSharpColor.png");
  OrganOctave2AColor = loadImage("Octave2AColor.png");
  OrganOctave2ASharpColor = loadImage("Octave2ASharpColor.png");
  OrganOctave2BColor = loadImage("Octave2BColor.png");
  OrganOctave3CColor = loadImage("Octave3CColor.png");
  OrganOctave3CSharpColor = loadImage("Octave3CSharpColor.png");
  OrganOctave3DColor = loadImage("Octave3DColor.png");
  OrganOctave3DSharpColor = loadImage("Octave3DSharpColor.png");
  OrganOctave3EColor = loadImage("Octave3EColor.png");
  OrganOctave3FColor = loadImage("Octave3FColor.png");
  OrganOctave3FSharpColor = loadImage("Octave3FSharpColor.png");
  OrganOctave3GColor = loadImage("Octave3GColor.png");
  OrganOctave3GSharpColor = loadImage("Octave3GSharpColor.png");
  OrganOctave3AColor = loadImage("Octave3AColor.png");
  OrganOctave3ASharpColor = loadImage("Octave3ASharpColor.png");
  OrganOctave3BColor = loadImage("Octave3BColor.png");
  OrganOctave4CColor = loadImage("Octave4CColor.png");
  OrganOctave4CSharpColor = loadImage("Octave4CSharpColor.png");
  OrganOctave4DColor = loadImage("Octave4DColor.png");
  OrganOctave4DSharpColor = loadImage("Octave4DSharpColor.png");
  OrganOctave4EColor = loadImage("Octave4EColor.png");
  OrganOctave4FColor = loadImage("Octave4FColor.png");
  OrganOctave4FSharpColor = loadImage("Octave4FSharpColor.png");
  OrganOctave4GColor = loadImage("Octave4GColor.png");
  OrganOctave4GSharpColor = loadImage("Octave4GSharpColor.png");
  OrganOctave4AColor = loadImage("Octave4AColor.png");
  OrganOctave4ASharpColor = loadImage("Octave4ASharpColor.png");
  OrganOctave4BColor = loadImage("Octave4BColor.png");
  OrganOctave5CColor = loadImage("Octave5CColor.png");
  OrganOctave5CSharpColor = loadImage("Octave5CSharpColor.png");
  OrganOctave5DColor = loadImage("Octave5DColor.png");
  OrganOctave5DSharpColor = loadImage("Octave5DSharpColor.png");
  OrganOctave5EColor = loadImage("Octave5EColor.png");
  OrganOctave5FColor = loadImage("Octave5FColor.png");
  OrganOctave5FSharpColor = loadImage("Octave5FSharpColor.png");
  OrganOctave5GColor = loadImage("Octave5GColor.png");
  OrganOctave5GSharpColor = loadImage("Octave5GSharpColor.png");
  OrganOctave5AColor = loadImage("Octave5AColor.png");
  OrganOctave5ASharpColor = loadImage("Octave5ASharpColor.png");
  OrganOctave5BColor = loadImage("Octave5BColor.png");
  OrganOctave6CColor = loadImage("Octave6CColor.png");
  OrganOctave6CSharpColor = loadImage("Octave6CSharpColor.png");
  OrganOctave6DColor = loadImage("Octave6DColor.png");
  OrganOctave6DSharpColor = loadImage("Octave6DSharpColor.png");
  OrganOctave6EColor = loadImage("Octave6EColor.png");
  OrganOctave6FColor = loadImage("Octave6FColor.png");
  OrganOctave6FSharpColor = loadImage("Octave6FSharpColor.png");
  OrganOctave6GColor = loadImage("Octave6GColor.png");
  OrganOctave6GSharpColor = loadImage("Octave6GSharpColor.png");
  OrganOctave6AColor = loadImage("Octave6AColor.png");
  OrganOctave6ASharpColor = loadImage("Octave6ASharpColor.png");
  OrganOctave6BColor = loadImage("Octave6BColor.png");
  OrganOctave7CColor = loadImage("Octave7CColor.png");
  OrganOctave7CSharpColor = loadImage("Octave7CSharpColor.png");
  OrganOctave7DColor = loadImage("Octave7DColor.png");
  OrganOctave7DSharpColor = loadImage("Octave7DSharpColor.png");
  OrganOctave7EColor = loadImage("Octave7EColor.png");
  OrganOctave7FColor = loadImage("Octave7FColor.png");
  OrganOctave7FSharpColor = loadImage("Octave7FSharpColor.png");
  OrganOctave7GColor = loadImage("Octave7GColor.png");
  OrganOctave7GSharpColor = loadImage("Octave7GSharpColor.png");
  OrganOctave7AColor = loadImage("Octave7AColor.png");
  OrganOctave7ASharpColor = loadImage("Octave7ASharpColor.png");
  OrganOctave7BColor = loadImage("Octave7BColor.png");
  OrganOctave8CColor = loadImage("Octave8CColor.png");
  OrganOctave8CSharpColor = loadImage("Octave8CSharpColor.png");
  OrganOctave8DColor = loadImage("Octave8DColor.png");
  OrganOctave8DSharpColor = loadImage("Octave8DSharpColor.png");
  OrganOctave8EColor = loadImage("Octave8EColor.png");
  OrganOctave8FColor = loadImage("Octave8FColor.png");
  OrganOctave8FSharpColor = loadImage("Octave8FSharpColor.png");
  OrganOctave8GColor = loadImage("Octave8GColor.png");
  OrganOctave8GSharpColor = loadImage("Octave8GSharpColor.png");
  OrganOctave8AColor = loadImage("Octave8AColor.png");
  OrganOctave8ASharpColor = loadImage("Octave8ASharpColor.png");
  OrganOctave8BColor = loadImage("Octave8BColor.png");
  OrganOctave9CColor = loadImage("Octave9CColor.png");
  OrganOctave9CSharpColor = loadImage("Octave9CSharpColor.png");
  OrganOctave9DColor = loadImage("Octave9DColor.png");
  OrganOctave9DSharpColor = loadImage("Octave9DSharpColor.png");
  OrganOctave9EColor = loadImage("Octave9EColor.png");
  OrganOctave9FColor = loadImage("Octave9FColor.png");
  OrganOctave9FSharpColor = loadImage("Octave9FSharpColor.png");
  OrganOctave9GColor = loadImage("Octave9GColor.png");

  //Common mask
  PianoMask         = loadImage("PianoMask.png");
  ChromaticPercussionMask = loadImage("ChromaticPercussionMask.png");
  OrganMask         = loadImage("OrganMask.png");
  
  //Masks
  //Piano
  PianoOctavem1CColor.mask(PianoMask);
  PianoOctavem1CSharpColor.mask(PianoMask);
  PianoOctavem1DColor.mask(PianoMask);
  PianoOctavem1DSharpColor.mask(PianoMask);
  PianoOctavem1EColor.mask(PianoMask);
  PianoOctavem1FColor.mask(PianoMask);
  PianoOctavem1FSharpColor.mask(PianoMask);
  PianoOctavem1GColor.mask(PianoMask);
  PianoOctavem1GSharpColor.mask(PianoMask);
  PianoOctavem1AColor.mask(PianoMask);
  PianoOctavem1ASharpColor.mask(PianoMask);
  PianoOctavem1BColor.mask(PianoMask);
  PianoOctave0CColor.mask(PianoMask);
  PianoOctave0CSharpColor.mask(PianoMask);
  PianoOctave0DColor.mask(PianoMask);
  PianoOctave0DSharpColor.mask(PianoMask);
  PianoOctave0EColor.mask(PianoMask);
  PianoOctave0FColor.mask(PianoMask);
  PianoOctave0FSharpColor.mask(PianoMask);
  PianoOctave0GColor.mask(PianoMask);
  PianoOctave0GSharpColor.mask(PianoMask);
  PianoOctave0AColor.mask(PianoMask);
  PianoOctave0ASharpColor.mask(PianoMask);
  PianoOctave0BColor.mask(PianoMask);
  PianoOctave1CColor.mask(PianoMask);
  PianoOctave1CSharpColor.mask(PianoMask);
  PianoOctave1DColor.mask(PianoMask);
  PianoOctave1DSharpColor.mask(PianoMask);
  PianoOctave1EColor.mask(PianoMask);
  PianoOctave1FColor.mask(PianoMask);
  PianoOctave1FSharpColor.mask(PianoMask);
  PianoOctave1GColor.mask(PianoMask);
  PianoOctave1GSharpColor.mask(PianoMask);
  PianoOctave1AColor.mask(PianoMask);
  PianoOctave1ASharpColor.mask(PianoMask);
  PianoOctave1BColor.mask(PianoMask);
  PianoOctave2CColor.mask(PianoMask);
  PianoOctave2CSharpColor.mask(PianoMask);
  PianoOctave2DColor.mask(PianoMask);
  PianoOctave2DSharpColor.mask(PianoMask);
  PianoOctave2EColor.mask(PianoMask);
  PianoOctave2FColor.mask(PianoMask);
  PianoOctave2FSharpColor.mask(PianoMask);
  PianoOctave2GColor.mask(PianoMask);
  PianoOctave2GSharpColor.mask(PianoMask);
  PianoOctave2AColor.mask(PianoMask);
  PianoOctave2ASharpColor.mask(PianoMask);
  PianoOctave2BColor.mask(PianoMask);
  PianoOctave3CColor.mask(PianoMask);
  PianoOctave3CSharpColor.mask(PianoMask);
  PianoOctave3DColor.mask(PianoMask);
  PianoOctave3DSharpColor.mask(PianoMask);
  PianoOctave3EColor.mask(PianoMask);
  PianoOctave3FColor.mask(PianoMask);
  PianoOctave3FSharpColor.mask(PianoMask);
  PianoOctave3GColor.mask(PianoMask);
  PianoOctave3GSharpColor.mask(PianoMask);
  PianoOctave3AColor.mask(PianoMask);
  PianoOctave3ASharpColor.mask(PianoMask);
  PianoOctave3BColor.mask(PianoMask);
  PianoOctave4CColor.mask(PianoMask);
  PianoOctave4CSharpColor.mask(PianoMask);
  PianoOctave4DColor.mask(PianoMask);
  PianoOctave4DSharpColor.mask(PianoMask);
  PianoOctave4EColor.mask(PianoMask);
  PianoOctave4FColor.mask(PianoMask);
  PianoOctave4FSharpColor.mask(PianoMask);
  PianoOctave4GColor.mask(PianoMask);
  PianoOctave4GSharpColor.mask(PianoMask);
  PianoOctave4AColor.mask(PianoMask);
  PianoOctave4ASharpColor.mask(PianoMask);
  PianoOctave4BColor.mask(PianoMask);
  PianoOctave5CColor.mask(PianoMask);
  PianoOctave5CSharpColor.mask(PianoMask);
  PianoOctave5DColor.mask(PianoMask);
  PianoOctave5DSharpColor.mask(PianoMask);
  PianoOctave5EColor.mask(PianoMask);
  PianoOctave5FColor.mask(PianoMask);
  PianoOctave5FSharpColor.mask(PianoMask);
  PianoOctave5GColor.mask(PianoMask);
  PianoOctave5GSharpColor.mask(PianoMask);
  PianoOctave5AColor.mask(PianoMask);
  PianoOctave5ASharpColor.mask(PianoMask);
  PianoOctave5BColor.mask(PianoMask);
  PianoOctave6CColor.mask(PianoMask);
  PianoOctave6CSharpColor.mask(PianoMask);
  PianoOctave6DColor.mask(PianoMask);
  PianoOctave6DSharpColor.mask(PianoMask);
  PianoOctave6EColor.mask(PianoMask);
  PianoOctave6FColor.mask(PianoMask);
  PianoOctave6FSharpColor.mask(PianoMask);
  PianoOctave6GColor.mask(PianoMask);
  PianoOctave6GSharpColor.mask(PianoMask);
  PianoOctave6AColor.mask(PianoMask);
  PianoOctave6ASharpColor.mask(PianoMask);
  PianoOctave6BColor.mask(PianoMask);
  PianoOctave7CColor.mask(PianoMask);
  PianoOctave7CSharpColor.mask(PianoMask);
  PianoOctave7DColor.mask(PianoMask);
  PianoOctave7DSharpColor.mask(PianoMask);
  PianoOctave7EColor.mask(PianoMask);
  PianoOctave7FColor.mask(PianoMask);
  PianoOctave7FSharpColor.mask(PianoMask);
  PianoOctave7GColor.mask(PianoMask);
  PianoOctave7GSharpColor.mask(PianoMask);
  PianoOctave7AColor.mask(PianoMask);
  PianoOctave7ASharpColor.mask(PianoMask);
  PianoOctave7BColor.mask(PianoMask);
  PianoOctave8CColor.mask(PianoMask);
  PianoOctave8CSharpColor.mask(PianoMask);
  PianoOctave8DColor.mask(PianoMask);
  PianoOctave8DSharpColor.mask(PianoMask);
  PianoOctave8EColor.mask(PianoMask);
  PianoOctave8FColor.mask(PianoMask);
  PianoOctave8FSharpColor.mask(PianoMask);
  PianoOctave8GColor.mask(PianoMask);
  PianoOctave8GSharpColor.mask(PianoMask);
  PianoOctave8AColor.mask(PianoMask);
  PianoOctave8ASharpColor.mask(PianoMask);
  PianoOctave8BColor.mask(PianoMask);
  PianoOctave9CColor.mask(PianoMask);
  PianoOctave9CSharpColor.mask(PianoMask);
  PianoOctave9DColor.mask(PianoMask);
  PianoOctave9DSharpColor.mask(PianoMask);
  PianoOctave9EColor.mask(PianoMask);
  PianoOctave9FColor.mask(PianoMask);
  PianoOctave9FSharpColor.mask(PianoMask);
  PianoOctave9GColor.mask(PianoMask);
  //Chromatic Percussion
  ChromaticPercussionOctavem1CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctavem1BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave0BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave1BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave2BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave3BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave4BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave5BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave6BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave7BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8GColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8GSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8AColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8ASharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave8BColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9CColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9CSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9DColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9DSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9EColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9FColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9FSharpColor.mask(ChromaticPercussionMask);
  ChromaticPercussionOctave9GColor.mask(ChromaticPercussionMask);
  //Organ
  OrganOctavem1CColor.mask(OrganMask);
  OrganOctavem1CSharpColor.mask(OrganMask);
  OrganOctavem1DColor.mask(OrganMask);
  OrganOctavem1DSharpColor.mask(OrganMask);
  OrganOctavem1EColor.mask(OrganMask);
  OrganOctavem1FColor.mask(OrganMask);
  OrganOctavem1FSharpColor.mask(OrganMask);
  OrganOctavem1GColor.mask(OrganMask);
  OrganOctavem1GSharpColor.mask(OrganMask);
  OrganOctavem1AColor.mask(OrganMask);
  OrganOctavem1ASharpColor.mask(OrganMask);
  OrganOctavem1BColor.mask(OrganMask);
  OrganOctave0CColor.mask(OrganMask);
  OrganOctave0CSharpColor.mask(OrganMask);
  OrganOctave0DColor.mask(OrganMask);
  OrganOctave0DSharpColor.mask(OrganMask);
  OrganOctave0EColor.mask(OrganMask);
  OrganOctave0FColor.mask(OrganMask);
  OrganOctave0FSharpColor.mask(OrganMask);
  OrganOctave0GColor.mask(OrganMask);
  OrganOctave0GSharpColor.mask(OrganMask);
  OrganOctave0AColor.mask(OrganMask);
  OrganOctave0ASharpColor.mask(OrganMask);
  OrganOctave0BColor.mask(OrganMask);
  OrganOctave1CColor.mask(OrganMask);
  OrganOctave1CSharpColor.mask(OrganMask);
  OrganOctave1DColor.mask(OrganMask);
  OrganOctave1DSharpColor.mask(OrganMask);
  OrganOctave1EColor.mask(OrganMask);
  OrganOctave1FColor.mask(OrganMask);
  OrganOctave1FSharpColor.mask(OrganMask);
  OrganOctave1GColor.mask(OrganMask);
  OrganOctave1GSharpColor.mask(OrganMask);
  OrganOctave1AColor.mask(OrganMask);
  OrganOctave1ASharpColor.mask(OrganMask);
  OrganOctave1BColor.mask(OrganMask);
  OrganOctave2CColor.mask(OrganMask);
  OrganOctave2CSharpColor.mask(OrganMask);
  OrganOctave2DColor.mask(OrganMask);
  OrganOctave2DSharpColor.mask(OrganMask);
  OrganOctave2EColor.mask(OrganMask);
  OrganOctave2FColor.mask(OrganMask);
  OrganOctave2FSharpColor.mask(OrganMask);
  OrganOctave2GColor.mask(OrganMask);
  OrganOctave2GSharpColor.mask(OrganMask);
  OrganOctave2AColor.mask(OrganMask);
  OrganOctave2ASharpColor.mask(OrganMask);
  OrganOctave2BColor.mask(OrganMask);
  OrganOctave3CColor.mask(OrganMask);
  OrganOctave3CSharpColor.mask(OrganMask);
  OrganOctave3DColor.mask(OrganMask);
  OrganOctave3DSharpColor.mask(OrganMask);
  OrganOctave3EColor.mask(OrganMask);
  OrganOctave3FColor.mask(OrganMask);
  OrganOctave3FSharpColor.mask(OrganMask);
  OrganOctave3GColor.mask(OrganMask);
  OrganOctave3GSharpColor.mask(OrganMask);
  OrganOctave3AColor.mask(OrganMask);
  OrganOctave3ASharpColor.mask(OrganMask);
  OrganOctave3BColor.mask(OrganMask);
  OrganOctave4CColor.mask(OrganMask);
  OrganOctave4CSharpColor.mask(OrganMask);
  OrganOctave4DColor.mask(OrganMask);
  OrganOctave4DSharpColor.mask(OrganMask);
  OrganOctave4EColor.mask(OrganMask);
  OrganOctave4FColor.mask(OrganMask);
  OrganOctave4FSharpColor.mask(OrganMask);
  OrganOctave4GColor.mask(OrganMask);
  OrganOctave4GSharpColor.mask(OrganMask);
  OrganOctave4AColor.mask(OrganMask);
  OrganOctave4ASharpColor.mask(OrganMask);
  OrganOctave4BColor.mask(OrganMask);
  OrganOctave5CColor.mask(OrganMask);
  OrganOctave5CSharpColor.mask(OrganMask);
  OrganOctave5DColor.mask(OrganMask);
  OrganOctave5DSharpColor.mask(OrganMask);
  OrganOctave5EColor.mask(OrganMask);
  OrganOctave5FColor.mask(OrganMask);
  OrganOctave5FSharpColor.mask(OrganMask);
  OrganOctave5GColor.mask(OrganMask);
  OrganOctave5GSharpColor.mask(OrganMask);
  OrganOctave5AColor.mask(OrganMask);
  OrganOctave5ASharpColor.mask(OrganMask);
  OrganOctave5BColor.mask(OrganMask);
  OrganOctave6CColor.mask(OrganMask);
  OrganOctave6CSharpColor.mask(OrganMask);
  OrganOctave6DColor.mask(OrganMask);
  OrganOctave6DSharpColor.mask(OrganMask);
  OrganOctave6EColor.mask(OrganMask);
  OrganOctave6FColor.mask(OrganMask);
  OrganOctave6FSharpColor.mask(OrganMask);
  OrganOctave6GColor.mask(OrganMask);
  OrganOctave6GSharpColor.mask(OrganMask);
  OrganOctave6AColor.mask(OrganMask);
  OrganOctave6ASharpColor.mask(OrganMask);
  OrganOctave6BColor.mask(OrganMask);
  OrganOctave7CColor.mask(OrganMask);
  OrganOctave7CSharpColor.mask(OrganMask);
  OrganOctave7DColor.mask(OrganMask);
  OrganOctave7DSharpColor.mask(OrganMask);
  OrganOctave7EColor.mask(OrganMask);
  OrganOctave7FColor.mask(OrganMask);
  OrganOctave7FSharpColor.mask(OrganMask);
  OrganOctave7GColor.mask(OrganMask);
  OrganOctave7GSharpColor.mask(OrganMask);
  OrganOctave7AColor.mask(OrganMask);
  OrganOctave7ASharpColor.mask(OrganMask);
  OrganOctave7BColor.mask(OrganMask);
  OrganOctave8CColor.mask(OrganMask);
  OrganOctave8CSharpColor.mask(OrganMask);
  OrganOctave8DColor.mask(OrganMask);
  OrganOctave8DSharpColor.mask(OrganMask);
  OrganOctave8EColor.mask(OrganMask);
  OrganOctave8FColor.mask(OrganMask);
  OrganOctave8FSharpColor.mask(OrganMask);
  OrganOctave8GColor.mask(OrganMask);
  OrganOctave8GSharpColor.mask(OrganMask);
  OrganOctave8AColor.mask(OrganMask);
  OrganOctave8ASharpColor.mask(OrganMask);
  OrganOctave8BColor.mask(OrganMask);
  OrganOctave9CColor.mask(OrganMask);
  OrganOctave9CSharpColor.mask(OrganMask);
  OrganOctave9DColor.mask(OrganMask);
  OrganOctave9DSharpColor.mask(OrganMask);
  OrganOctave9EColor.mask(OrganMask);
  OrganOctave9FColor.mask(OrganMask);
  OrganOctave9FSharpColor.mask(OrganMask);
  OrganOctave9GColor.mask(OrganMask);
  
//  //Organ GFX
//  organgfx = new OrganGFX("OrganMask_", 60);
}

//Draw
void draw() {
  debug = new Debug();
//  debug.framerate();
  debug.clickToPrintVariables();
  
//  background = new Background(width, height, 500, width, height, 500, PitchHue, 50, 15, 25);
//  background.fadeOut();

//  //Sky
  noStroke();
//  translate(width/2,-100,-100);
  rotateY(radians(sphereRotateY));
  noStroke();
  shape(dome);
//  sphereRotateY = sphereRotateY+0.05; //Animation/Gyro drift fix
  
  //Starfield
  for(int i=0;i<numstars;i++){
    s[i].DrawStar();
  }
  
  //Gridssssssssf
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
//    //Image sequence
//    frame = (frame+1) % imageCount;

  
  //Piano
if (Channels[0] == 0) { // Piano Channel graphics      X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha    Texture
  if (Pitches[0]   ==   0) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1CColor); pianogfx.display();}
  if (Pitches[1]   ==   1) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1CSharpColor); pianogfx.display();}
  if (Pitches[2]   ==   2) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1DColor); pianogfx.display();}
  if (Pitches[3]   ==   3) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1DSharpColor); pianogfx.display();}
  if (Pitches[4]   ==   4) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1EColor); pianogfx.display();}
  if (Pitches[5]   ==   5) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1FColor); pianogfx.display();}
  if (Pitches[6]   ==   6) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1FSharpColor); pianogfx.display();}
  if (Pitches[7]   ==   7) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1GColor); pianogfx.display();}
  if (Pitches[8]   ==   8) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1GSharpColor); pianogfx.display();}
  if (Pitches[9]   ==   9) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1AColor); pianogfx.display();}
  if (Pitches[10]  ==  10) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1ASharpColor); pianogfx.display();}
  if (Pitches[11]  ==  11) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  100, PianoOctavem1BColor); pianogfx.display();}
  if (Pitches[12]  ==  12) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0CColor); pianogfx.display();}
  if (Pitches[13]  ==  13) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0CSharpColor); pianogfx.display();}
  if (Pitches[14]  ==  14) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0DColor); pianogfx.display();}
  if (Pitches[15]  ==  15) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0DSharpColor); pianogfx.display();}
  if (Pitches[16]  ==  16) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0EColor); pianogfx.display();}
  if (Pitches[17]  ==  17) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0FColor); pianogfx.display();}
  if (Pitches[18]  ==  18) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0FSharpColor); pianogfx.display();}
  if (Pitches[19]  ==  19) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0GColor); pianogfx.display();}
  if (Pitches[20]  ==  20) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0GSharpColor); pianogfx.display();}
  if (Pitches[21]  ==  21) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0AColor); pianogfx.display();}
  if (Pitches[22]  ==  22) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0ASharpColor); pianogfx.display();}
  if (Pitches[23]  ==  23) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],   100, PianoOctave0BColor); pianogfx.display();}
  if (Pitches[24]  ==  24) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1CColor); pianogfx.display();}
  if (Pitches[25]  ==  25) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1CSharpColor); pianogfx.display();}
  if (Pitches[26]  ==  26) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1DColor); pianogfx.display();}
  if (Pitches[27]  ==  27) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1DSharpColor); pianogfx.display();}
  if (Pitches[28]  ==  28) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1EColor); pianogfx.display();}
  if (Pitches[29]  ==  29) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1FColor); pianogfx.display();}
  if (Pitches[30]  ==  30) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1FSharpColor); pianogfx.display();}
  if (Pitches[31]  ==  31) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1GColor); pianogfx.display();}
  if (Pitches[32]  ==  32) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1GSharpColor); pianogfx.display();}
  if (Pitches[33]  ==  33) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1AColor); pianogfx.display();}
  if (Pitches[34]  ==  34) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1ASharpColor); pianogfx.display();}
  if (Pitches[35]  ==  35) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],   100, PianoOctave1BColor); pianogfx.display();}
  if (Pitches[36]  ==  36) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2CColor); pianogfx.display();}
  if (Pitches[37]  ==  37) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2CSharpColor); pianogfx.display();}
  if (Pitches[38]  ==  38) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2DColor); pianogfx.display();}
  if (Pitches[39]  ==  39) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2DSharpColor); pianogfx.display();}
  if (Pitches[40]  ==  40) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2EColor); pianogfx.display();}
  if (Pitches[41]  ==  41) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2FColor); pianogfx.display();}
  if (Pitches[42]  ==  42) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2FSharpColor); pianogfx.display();}
  if (Pitches[43]  ==  43) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2GColor); pianogfx.display();}
  if (Pitches[44]  ==  44) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2GSharpColor); pianogfx.display();}
  if (Pitches[45]  ==  45) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2AColor); pianogfx.display();}
  if (Pitches[46]  ==  46) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2ASharpColor); pianogfx.display();}
  if (Pitches[47]  ==  47) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],   100, PianoOctave2BColor); pianogfx.display();}
  if (Pitches[48]  ==  48) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3CColor); pianogfx.display();}
  if (Pitches[49]  ==  49) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3CSharpColor); pianogfx.display();}
  if (Pitches[50]  ==  50) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3DColor); pianogfx.display();}
  if (Pitches[51]  ==  51) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3DSharpColor); pianogfx.display();}
  if (Pitches[52]  ==  52) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3EColor); pianogfx.display();}
  if (Pitches[53]  ==  53) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3FColor); pianogfx.display();}
  if (Pitches[54]  ==  54) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3FSharpColor); pianogfx.display();}
  if (Pitches[55]  ==  55) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3GColor); pianogfx.display();}
  if (Pitches[56]  ==  56) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3GSharpColor); pianogfx.display();}
  if (Pitches[57]  ==  57) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3AColor); pianogfx.display();}
  if (Pitches[58]  ==  58) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3ASharpColor); pianogfx.display();}
  if (Pitches[59]  ==  59) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],   100, PianoOctave3BColor); pianogfx.display();}
  if (Pitches[60]  ==  60) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4CColor); pianogfx.display();}
  if (Pitches[61]  ==  61) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4CSharpColor); pianogfx.display();}
  if (Pitches[62]  ==  62) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4DColor); pianogfx.display();}
  if (Pitches[63]  ==  63) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4DSharpColor); pianogfx.display();}
  if (Pitches[64]  ==  64) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4EColor); pianogfx.display();}
  if (Pitches[65]  ==  65) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4FColor); pianogfx.display();}
  if (Pitches[66]  ==  66) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4FSharpColor); pianogfx.display();}
  if (Pitches[67]  ==  67) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4GColor); pianogfx.display();}
  if (Pitches[68]  ==  68) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4GSharpColor); pianogfx.display();}
  if (Pitches[69]  ==  69) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4AColor); pianogfx.display();}
  if (Pitches[70]  ==  70) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4ASharpColor); pianogfx.display();}
  if (Pitches[71]  ==  71) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],   100, PianoOctave4BColor); pianogfx.display();}
  if (Pitches[72]  ==  72) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5CColor); pianogfx.display();}
  if (Pitches[73]  ==  73) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5CSharpColor); pianogfx.display();}
  if (Pitches[74]  ==  74) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5DColor); pianogfx.display();}
  if (Pitches[75]  ==  75) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5DSharpColor); pianogfx.display();}
  if (Pitches[76]  ==  76) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5EColor); pianogfx.display();}
  if (Pitches[77]  ==  77) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5FColor); pianogfx.display();}
  if (Pitches[78]  ==  78) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5FSharpColor); pianogfx.display();}
  if (Pitches[79]  ==  79) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5GColor); pianogfx.display();}
  if (Pitches[80]  ==  80) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5GSharpColor); pianogfx.display();}
  if (Pitches[81]  ==  81) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5AColor); pianogfx.display();}
  if (Pitches[82]  ==  82) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5ASharpColor); pianogfx.display();}
  if (Pitches[83]  ==  83) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],   100, PianoOctave5BColor); pianogfx.display();}
  if (Pitches[84]  ==  84) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6CColor); pianogfx.display();}
  if (Pitches[85]  ==  85) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6CSharpColor); pianogfx.display();}
  if (Pitches[86]  ==  86) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6DColor); pianogfx.display();}
  if (Pitches[87]  ==  87) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6DSharpColor); pianogfx.display();}
  if (Pitches[88]  ==  88) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6EColor); pianogfx.display();}
  if (Pitches[89]  ==  89) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6FColor); pianogfx.display();}
  if (Pitches[90]  ==  90) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6FSharpColor); pianogfx.display();}
  if (Pitches[91]  ==  91) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6GColor); pianogfx.display();}
  if (Pitches[92]  ==  92) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6GSharpColor); pianogfx.display();}
  if (Pitches[93]  ==  93) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6AColor); pianogfx.display();}
  if (Pitches[94]  ==  94) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6ASharpColor); pianogfx.display();}
  if (Pitches[95]  ==  95) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],   100, PianoOctave6BColor); pianogfx.display();}
  if (Pitches[96]  ==  96) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7CColor); pianogfx.display();}
  if (Pitches[97]  ==  97) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7CSharpColor); pianogfx.display();}
  if (Pitches[98]  ==  98) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7DColor); pianogfx.display();}
  if (Pitches[99]  ==  99) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7DSharpColor); pianogfx.display();}
  if (Pitches[100] == 100) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7EColor); pianogfx.display();}
  if (Pitches[101] == 101) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7FColor); pianogfx.display();}
  if (Pitches[102] == 102) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7FSharpColor); pianogfx.display();}
  if (Pitches[103] == 103) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7GColor); pianogfx.display();}
  if (Pitches[104] == 104) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7GSharpColor); pianogfx.display();}
  if (Pitches[105] == 105) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7AColor); pianogfx.display();}
  if (Pitches[106] == 106) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7ASharpColor); pianogfx.display();}
  if (Pitches[107] == 107) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],   100, PianoOctave7BColor); pianogfx.display();}
  if (Pitches[108] == 108) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8CColor); pianogfx.display();}
  if (Pitches[109] == 109) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8CSharpColor); pianogfx.display();}
  if (Pitches[110] == 110) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8DColor); pianogfx.display();}
  if (Pitches[111] == 111) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8DSharpColor); pianogfx.display();}
  if (Pitches[112] == 112) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8EColor); pianogfx.display();}
  if (Pitches[113] == 113) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8FColor); pianogfx.display();}
  if (Pitches[114] == 114) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8FSharpColor); pianogfx.display();}
  if (Pitches[115] == 115) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8GColor); pianogfx.display();}
  if (Pitches[116] == 116) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8GSharpColor); pianogfx.display();}
  if (Pitches[117] == 117) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8AColor); pianogfx.display();}
  if (Pitches[118] == 118) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8ASharpColor); pianogfx.display();}
  if (Pitches[119] == 119) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],   100, PianoOctave8BColor); pianogfx.display();}
  if (Pitches[120] == 120) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9CColor); pianogfx.display();}
  if (Pitches[121] == 121) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9CSharpColor); pianogfx.display();}
  if (Pitches[122] == 122) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9DColor); pianogfx.display();}
  if (Pitches[123] == 123) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9DSharpColor); pianogfx.display();}
  if (Pitches[124] == 124) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9EColor); pianogfx.display();}
  if (Pitches[125] == 125) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9FColor); pianogfx.display();}
  if (Pitches[126] == 126) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9FSharpColor); pianogfx.display();}
  if (Pitches[127] == 127) {pianogfx = new PianoGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10],  100, PianoOctave9GColor); pianogfx.display();}
}

  //Chromatic Percussion
if (Channels[1] == 1) { // Chromatic Percussion Channel graphics                   X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha
   if (Pitches[0]   ==   0) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1CColor); chromaticpercussiongfx.display();}
  if (Pitches[1]   ==   1) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[2]   ==   2) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1DColor); chromaticpercussiongfx.display();}
  if (Pitches[3]   ==   3) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[4]   ==   4) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1EColor); chromaticpercussiongfx.display();}
  if (Pitches[5]   ==   5) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1FColor); chromaticpercussiongfx.display();}
  if (Pitches[6]   ==   6) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[7]   ==   7) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1GColor); chromaticpercussiongfx.display();}
  if (Pitches[8]   ==   8) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[9]   ==   9) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1AColor); chromaticpercussiongfx.display();}
  if (Pitches[10]  ==  10) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[11]  ==  11) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  100, ChromaticPercussionOctavem1BColor); chromaticpercussiongfx.display();}
  if (Pitches[12]  ==  12) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0CColor); chromaticpercussiongfx.display();}
  if (Pitches[13]  ==  13) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[14]  ==  14) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0DColor); chromaticpercussiongfx.display();}
  if (Pitches[15]  ==  15) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[16]  ==  16) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0EColor); chromaticpercussiongfx.display();}
  if (Pitches[17]  ==  17) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0FColor); chromaticpercussiongfx.display();}
  if (Pitches[18]  ==  18) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[19]  ==  19) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0GColor); chromaticpercussiongfx.display();}
  if (Pitches[20]  ==  20) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[21]  ==  21) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0AColor); chromaticpercussiongfx.display();}
  if (Pitches[22]  ==  22) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[23]  ==  23) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise0, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],   100, ChromaticPercussionOctave0BColor); chromaticpercussiongfx.display();}
  if (Pitches[24]  ==  24) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1CColor); chromaticpercussiongfx.display();}
  if (Pitches[25]  ==  25) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[26]  ==  26) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1DColor); chromaticpercussiongfx.display();}
  if (Pitches[27]  ==  27) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[28]  ==  28) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1EColor); chromaticpercussiongfx.display();}
  if (Pitches[29]  ==  29) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1FColor); chromaticpercussiongfx.display();}
  if (Pitches[30]  ==  30) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[31]  ==  31) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1GColor); chromaticpercussiongfx.display();}
  if (Pitches[32]  ==  32) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[33]  ==  33) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1AColor); chromaticpercussiongfx.display();}
  if (Pitches[34]  ==  34) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[35]  ==  35) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise1, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],   100, ChromaticPercussionOctave1BColor); chromaticpercussiongfx.display();}
  if (Pitches[36]  ==  36) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2CColor); chromaticpercussiongfx.display();}
  if (Pitches[37]  ==  37) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[38]  ==  38) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2DColor); chromaticpercussiongfx.display();}
  if (Pitches[39]  ==  39) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[40]  ==  40) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2EColor); chromaticpercussiongfx.display();}
  if (Pitches[41]  ==  41) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2FColor); chromaticpercussiongfx.display();}
  if (Pitches[42]  ==  42) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[43]  ==  43) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2GColor); chromaticpercussiongfx.display();}
  if (Pitches[44]  ==  44) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[45]  ==  45) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2AColor); chromaticpercussiongfx.display();}
  if (Pitches[46]  ==  46) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[47]  ==  47) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise2, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],   100, ChromaticPercussionOctave2BColor); chromaticpercussiongfx.display();}
  if (Pitches[48]  ==  48) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3CColor); chromaticpercussiongfx.display();}
  if (Pitches[49]  ==  49) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[50]  ==  50) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3DColor); chromaticpercussiongfx.display();}
  if (Pitches[51]  ==  51) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[52]  ==  52) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3EColor); chromaticpercussiongfx.display();}
  if (Pitches[53]  ==  53) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3FColor); chromaticpercussiongfx.display();}
  if (Pitches[54]  ==  54) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[55]  ==  55) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3GColor); chromaticpercussiongfx.display();}
  if (Pitches[56]  ==  56) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[57]  ==  57) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3AColor); chromaticpercussiongfx.display();}
  if (Pitches[58]  ==  58) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[59]  ==  59) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise3, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],   100, ChromaticPercussionOctave3BColor); chromaticpercussiongfx.display();}
  if (Pitches[60]  ==  60) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4CColor); chromaticpercussiongfx.display();}
  if (Pitches[61]  ==  61) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[62]  ==  62) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4DColor); chromaticpercussiongfx.display();}
  if (Pitches[63]  ==  63) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[64]  ==  64) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4EColor); chromaticpercussiongfx.display();}
  if (Pitches[65]  ==  65) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4FColor); chromaticpercussiongfx.display();}
  if (Pitches[66]  ==  66) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[67]  ==  67) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4GColor); chromaticpercussiongfx.display();}
  if (Pitches[68]  ==  68) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[69]  ==  69) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4AColor); chromaticpercussiongfx.display();}
  if (Pitches[70]  ==  70) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[71]  ==  71) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise4, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],   100, ChromaticPercussionOctave4BColor); chromaticpercussiongfx.display();}
  if (Pitches[72]  ==  72) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5CColor); chromaticpercussiongfx.display();}
  if (Pitches[73]  ==  73) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[74]  ==  74) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5DColor); chromaticpercussiongfx.display();}
  if (Pitches[75]  ==  75) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[76]  ==  76) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5EColor); chromaticpercussiongfx.display();}
  if (Pitches[77]  ==  77) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5FColor); chromaticpercussiongfx.display();}
  if (Pitches[78]  ==  78) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[79]  ==  79) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5GColor); chromaticpercussiongfx.display();}
  if (Pitches[80]  ==  80) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[81]  ==  81) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5AColor); chromaticpercussiongfx.display();}
  if (Pitches[82]  ==  82) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[83]  ==  83) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise5, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],   100, ChromaticPercussionOctave5BColor); chromaticpercussiongfx.display();}
  if (Pitches[84]  ==  84) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6CColor); chromaticpercussiongfx.display();}
  if (Pitches[85]  ==  85) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[86]  ==  86) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6DColor); chromaticpercussiongfx.display();}
  if (Pitches[87]  ==  87) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[88]  ==  88) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6EColor); chromaticpercussiongfx.display();}
  if (Pitches[89]  ==  89) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6FColor); chromaticpercussiongfx.display();}
  if (Pitches[90]  ==  90) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[91]  ==  91) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6GColor); chromaticpercussiongfx.display();}
  if (Pitches[92]  ==  92) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[93]  ==  93) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6AColor); chromaticpercussiongfx.display();}
  if (Pitches[94]  ==  94) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[95]  ==  95) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise6, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],   100, ChromaticPercussionOctave6BColor); chromaticpercussiongfx.display();}
  if (Pitches[96]  ==  96) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7CColor); chromaticpercussiongfx.display();}
  if (Pitches[97]  ==  97) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[98]  ==  98) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7DColor); chromaticpercussiongfx.display();}
  if (Pitches[99]  ==  99) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[100] == 100) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7EColor); chromaticpercussiongfx.display();}
  if (Pitches[101] == 101) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7FColor); chromaticpercussiongfx.display();}
  if (Pitches[102] == 102) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[103] == 103) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7GColor); chromaticpercussiongfx.display();}
  if (Pitches[104] == 104) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[105] == 105) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7AColor); chromaticpercussiongfx.display();}
  if (Pitches[106] == 106) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[107] == 107) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise7, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],   100, ChromaticPercussionOctave7BColor); chromaticpercussiongfx.display();}
  if (Pitches[108] == 108) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8CColor); chromaticpercussiongfx.display();}
  if (Pitches[109] == 109) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[110] == 110) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8DColor); chromaticpercussiongfx.display();}
  if (Pitches[111] == 111) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[112] == 112) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8EColor); chromaticpercussiongfx.display();}
  if (Pitches[113] == 113) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8FColor); chromaticpercussiongfx.display();}
  if (Pitches[114] == 114) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[115] == 115) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8GColor); chromaticpercussiongfx.display();}
  if (Pitches[116] == 116) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8GSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[117] == 117) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8AColor); chromaticpercussiongfx.display();}
  if (Pitches[118] == 118) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8ASharpColor); chromaticpercussiongfx.display();}
  if (Pitches[119] == 119) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise8, VelocityScaleY, VelocityScaleY, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],   100, ChromaticPercussionOctave8BColor); chromaticpercussiongfx.display();}
  if (Pitches[120] == 120) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9CColor); chromaticpercussiongfx.display();}
  if (Pitches[121] == 121) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9CSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[122] == 122) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9DColor); chromaticpercussiongfx.display();}
  if (Pitches[123] == 123) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9DSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[124] == 124) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9EColor); chromaticpercussiongfx.display();}
  if (Pitches[125] == 125) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9FColor); chromaticpercussiongfx.display();}
  if (Pitches[126] == 126) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9FSharpColor); chromaticpercussiongfx.display();}
  if (Pitches[127] == 127) {chromaticpercussiongfx = new ChromaticPercussionGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noise9, VelocityScaleY, VelocityScaleY, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10],  100, ChromaticPercussionOctave9GColor); chromaticpercussiongfx.display();}
}

 //Organ
if (Channels[2] == 2) { // Organ         Channel graphics      X                  Y                Z         Width          Height           Depth             Hue           Saturation             Brightness       Alpha    Texture
if (Pitches[0]   ==   0) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1CColor); organgfx.display();}
if (Pitches[1]   ==   1) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1CSharpColor); organgfx.display();}
if (Pitches[2]   ==   2) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1DColor); organgfx.display();}
if (Pitches[3]   ==   3) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1DSharpColor); organgfx.display();}
if (Pitches[4]   ==   4) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1EColor); organgfx.display();}
if (Pitches[5]   ==   5) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1FColor); organgfx.display();}
if (Pitches[6]   ==   6) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1FSharpColor); organgfx.display();}
if (Pitches[7]   ==   7) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1GColor); organgfx.display();}
if (Pitches[8]   ==   8) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1GSharpColor); organgfx.display();}
if (Pitches[9]   ==   9) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1AColor); organgfx.display();}
if (Pitches[10]  ==  10) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1ASharpColor); organgfx.display();}
if (Pitches[11]  ==  11) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3, Depth+Noisem1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[0],  OctaveBrightnesses[0],  100, OrganOctavem1BColor); organgfx.display();}
if (Pitches[12]  ==  12) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0CColor); organgfx.display();}
if (Pitches[13]  ==  13) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0CSharpColor); organgfx.display();}
if (Pitches[14]  ==  14) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0DColor); organgfx.display();}
if (Pitches[15]  ==  15) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0DSharpColor); organgfx.display();}
if (Pitches[16]  ==  16) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0EColor); organgfx.display();}
if (Pitches[17]  ==  17) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0FColor); organgfx.display();}
if (Pitches[18]  ==  18) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0FSharpColor); organgfx.display();}
if (Pitches[19]  ==  19) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0GColor); organgfx.display();}
if (Pitches[20]  ==  20) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0GSharpColor); organgfx.display();}
if (Pitches[21]  ==  21) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0AColor); organgfx.display();}
if (Pitches[22]  ==  22) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0ASharpColor); organgfx.display();}
if (Pitches[23]  ==  23) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise0, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[1],  OctaveBrightnesses[1],   100, OrganOctave0BColor); organgfx.display();}
if (Pitches[24]  ==  24) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1CColor); organgfx.display();}
if (Pitches[25]  ==  25) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1CSharpColor); organgfx.display();}
if (Pitches[26]  ==  26) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1DColor); organgfx.display();}
if (Pitches[27]  ==  27) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1DSharpColor); organgfx.display();}
if (Pitches[28]  ==  28) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1EColor); organgfx.display();}
if (Pitches[29]  ==  29) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1FColor); organgfx.display();}
if (Pitches[30]  ==  30) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1FSharpColor); organgfx.display();}
if (Pitches[31]  ==  31) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1GColor); organgfx.display();}
if (Pitches[32]  ==  32) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1GSharpColor); organgfx.display();}
if (Pitches[33]  ==  33) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1AColor); organgfx.display();}
if (Pitches[34]  ==  34) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1ASharpColor); organgfx.display();}
if (Pitches[35]  ==  35) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise1, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[2],  OctaveBrightnesses[2],   100, OrganOctave1BColor); organgfx.display();}
if (Pitches[36]  ==  36) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2CColor); organgfx.display();}
if (Pitches[37]  ==  37) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2CSharpColor); organgfx.display();}
if (Pitches[38]  ==  38) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2DColor); organgfx.display();}
if (Pitches[39]  ==  39) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2DSharpColor); organgfx.display();}
if (Pitches[40]  ==  40) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2EColor); organgfx.display();}
if (Pitches[41]  ==  41) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2FColor); organgfx.display();}
if (Pitches[42]  ==  42) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2FSharpColor); organgfx.display();}
if (Pitches[43]  ==  43) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2GColor); organgfx.display();}
if (Pitches[44]  ==  44) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2GSharpColor); organgfx.display();}
if (Pitches[45]  ==  45) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2AColor); organgfx.display();}
if (Pitches[46]  ==  46) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2ASharpColor); organgfx.display();}
if (Pitches[47]  ==  47) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise2, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[3],  OctaveBrightnesses[3],   100, OrganOctave2BColor); organgfx.display();}
if (Pitches[48]  ==  48) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3CColor); organgfx.display();}
if (Pitches[49]  ==  49) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3CSharpColor); organgfx.display();}
if (Pitches[50]  ==  50) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3DColor); organgfx.display();}
if (Pitches[51]  ==  51) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3DSharpColor); organgfx.display();}
if (Pitches[52]  ==  52) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3EColor); organgfx.display();}
if (Pitches[53]  ==  53) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3FColor); organgfx.display();}
if (Pitches[54]  ==  54) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3FSharpColor); organgfx.display();}
if (Pitches[55]  ==  55) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3GColor); organgfx.display();}
if (Pitches[56]  ==  56) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3GSharpColor); organgfx.display();}
if (Pitches[57]  ==  57) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3AColor); organgfx.display();}
if (Pitches[58]  ==  58) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3ASharpColor); organgfx.display();}
if (Pitches[59]  ==  59) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise3, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[4],  OctaveBrightnesses[4],   100, OrganOctave3BColor); organgfx.display();}
if (Pitches[60]  ==  60) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4CColor); organgfx.display();}
if (Pitches[61]  ==  61) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4CSharpColor); organgfx.display();}
if (Pitches[62]  ==  62) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4DColor); organgfx.display();}
if (Pitches[63]  ==  63) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4DSharpColor); organgfx.display();}
if (Pitches[64]  ==  64) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4EColor); organgfx.display();}
if (Pitches[65]  ==  65) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4FColor); organgfx.display();}
if (Pitches[66]  ==  66) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4FSharpColor); organgfx.display();}
if (Pitches[67]  ==  67) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4GColor); organgfx.display();}
if (Pitches[68]  ==  68) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4GSharpColor); organgfx.display();}
if (Pitches[69]  ==  69) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4AColor); organgfx.display();}
if (Pitches[70]  ==  70) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4ASharpColor); organgfx.display();}
if (Pitches[71]  ==  71) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise4, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[5],  OctaveBrightnesses[5],   100, OrganOctave4BColor); organgfx.display();}
if (Pitches[72]  ==  72) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5CColor); organgfx.display();}
if (Pitches[73]  ==  73) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5CSharpColor); organgfx.display();}
if (Pitches[74]  ==  74) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5DColor); organgfx.display();}
if (Pitches[75]  ==  75) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5DSharpColor); organgfx.display();}
if (Pitches[76]  ==  76) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5EColor); organgfx.display();}
if (Pitches[77]  ==  77) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5FColor); organgfx.display();}
if (Pitches[78]  ==  78) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5FSharpColor); organgfx.display();}
if (Pitches[79]  ==  79) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5GColor); organgfx.display();}
if (Pitches[80]  ==  80) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5GSharpColor); organgfx.display();}
if (Pitches[81]  ==  81) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5AColor); organgfx.display();}
if (Pitches[82]  ==  82) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5ASharpColor); organgfx.display();}
if (Pitches[83]  ==  83) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise5, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[6],  OctaveBrightnesses[6],   100, OrganOctave5BColor); organgfx.display();}
if (Pitches[84]  ==  84) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6CColor); organgfx.display();}
if (Pitches[85]  ==  85) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6CSharpColor); organgfx.display();}
if (Pitches[86]  ==  86) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6DColor); organgfx.display();}
if (Pitches[87]  ==  87) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6DSharpColor); organgfx.display();}
if (Pitches[88]  ==  88) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6EColor); organgfx.display();}
if (Pitches[89]  ==  89) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6FColor); organgfx.display();}
if (Pitches[90]  ==  90) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6FSharpColor); organgfx.display();}
if (Pitches[91]  ==  91) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6GColor); organgfx.display();}
if (Pitches[92]  ==  92) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6GSharpColor); organgfx.display();}
if (Pitches[93]  ==  93) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6AColor); organgfx.display();}
if (Pitches[94]  ==  94) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6ASharpColor); organgfx.display();}
if (Pitches[95]  ==  95) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise6, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[7],  OctaveBrightnesses[7],   100, OrganOctave6BColor); organgfx.display();}
if (Pitches[96]  ==  96) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7CColor); organgfx.display();}
if (Pitches[97]  ==  97) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7CSharpColor); organgfx.display();}
if (Pitches[98]  ==  98) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7DColor); organgfx.display();}
if (Pitches[99]  ==  99) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7DSharpColor); organgfx.display();}
if (Pitches[100] == 100) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7EColor); organgfx.display();}
if (Pitches[101] == 101) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7FColor); organgfx.display();}
if (Pitches[102] == 102) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7FSharpColor); organgfx.display();}
if (Pitches[103] == 103) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7GColor); organgfx.display();}
if (Pitches[104] == 104) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7GSharpColor); organgfx.display();}
if (Pitches[105] == 105) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7AColor); organgfx.display();}
if (Pitches[106] == 106) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7ASharpColor); organgfx.display();}
if (Pitches[107] == 107) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise7, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[8],  OctaveBrightnesses[8],   100, OrganOctave7BColor); organgfx.display();}
if (Pitches[108] == 108) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8CColor); organgfx.display();}
if (Pitches[109] == 109) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8CSharpColor); organgfx.display();}
if (Pitches[110] == 110) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8DColor); organgfx.display();}
if (Pitches[111] == 111) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8DSharpColor); organgfx.display();}
if (Pitches[112] == 112) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8EColor); organgfx.display();}
if (Pitches[113] == 113) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8FColor); organgfx.display();}
if (Pitches[114] == 114) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8FSharpColor); organgfx.display();}
if (Pitches[115] == 115) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8GColor); organgfx.display();}
if (Pitches[116] == 116) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[8], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8GSharpColor); organgfx.display();}
if (Pitches[117] == 117) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[9], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8AColor); organgfx.display();}
if (Pitches[118] == 118) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[10], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8ASharpColor); organgfx.display();}
if (Pitches[119] == 119) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise8, VelocityScaleY, VelocityScaleY*10, VelocityScaleY, PitchHues[11], OctaveSaturations[9],  OctaveBrightnesses[9],   100, OrganOctave8BColor); organgfx.display();}
if (Pitches[120] == 120) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[0], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9CColor); organgfx.display();}
if (Pitches[121] == 121) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[1], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9CSharpColor); organgfx.display();}
if (Pitches[122] == 122) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[2], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9DColor); organgfx.display();}
if (Pitches[123] == 123) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[3], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9DSharpColor); organgfx.display();}
if (Pitches[124] == 124) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[4], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9EColor); organgfx.display();}
if (Pitches[125] == 125) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[5], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9FColor); organgfx.display();}
if (Pitches[126] == 126) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[6], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9FSharpColor); organgfx.display();}
if (Pitches[127] == 127) {organgfx = new OrganGFX (PitchX, VelocityY+VelocityScaleY/3,  Depth+Noise9, VelocityScaleY, VelocityScaleY*10, VelocityScaleY,  PitchHues[7], OctaveSaturations[10], OctaveBrightnesses[10],  100, OrganOctave9GColor); organgfx.display();}
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
  //Pitches
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
