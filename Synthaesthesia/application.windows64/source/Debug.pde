class Debug {
  void framerate() {
    println(frameRate); // Return framerate
  }
  void clickToPrintVariables() {
     if (mousePressed == true) {
    println("---------------- In -----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
    }
  }
  void noteOnReturn() { //MIDI Note on values
    println("---------------- On -----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
  }
  
  void noteOffReturn() { //MIDI Note off values
    println("---------------- Off ----------------");
    println("Channel: " + Channel);
    println("Pitch: " + Pitch);
    println("Velocity: " + Velocity);
  }
}

