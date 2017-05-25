// Adapted from Daniel Shiffman's Simple Particle example
// for Processing.js by John Keston
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
class ParticleSystem {
  ArrayList particles;    // An arraylist for all the particles
  PVector origin;         // An origin point for where particles are born

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList();              // Initialize the arraylist
    origin = v.get();                         // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist
    }
  }
  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = (Particle) particles.get(i);
      p.run();
      if (p.dead()) {
        particles.remove(i);
      }
    }
  }
  void addParticle(float x, float y) {
    particles.add(new Particle(new PVector(x,y)));
  }
  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}

// A simple Particle class
class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer;
  // Another constructor (the one we are using here)
  Particle(PVector l) {
    acc = new PVector(0,0.05,0);
    vel = new PVector(random(-1,1),random(-2,0),0);
    loc = l.get();
    r = rad;
    timer = 160.0;
  }
  void run() {
    update();
    render();
  }
  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 1.0;
  }
  // Method to display
  void render() {
    translate(loc.x, loc.y, 0);
    beginShape();
        texture(Smoke);
        vertex(-100, -100, 0, 0,   0);
        vertex( 100, -100, 0, 512, 0);
        vertex( 100,  100, 0, 512, 512);
        vertex(-100,  100, 0, 0,   512);
      endShape();
    
  }
  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}
