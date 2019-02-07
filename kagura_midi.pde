import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

// Global Variable
PFont sans;

// init counter
int counterRed = 0;
int counterBlue = 0;

// init midi variable
int channel = 0;
int pitch = 64;
int velocity = 127;

// init winner flag
int winner = 0;
 //<>//
void setup() {

  size(1000, 600);
  
  sans = loadFont("ProcessingSansPro-Regular-48.vlw");
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "loopMIDI Port", "loopMIDI Port"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
  frameRate(60);

}

void draw() {
  
  
//   myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
//   delay(200);
//   myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
//   int number = 0;
//   int value = 90;
//   myBus.sendControllerChange(4, 1, 100); // Send a controllerChange
//   delay(2000);

  // change backgrundcolor
  switch(winner){
     case 1:
       background(255,0,0);
       break;
     case 2:
       background(0,0,255);
       break;
     default:
       background(0,0,0);
       break;
  }

  // change kagura scene
  switch(counterRed){
     case 100:
       myBus.sendControllerChange(3, 1, 100); // Send a controllerChange
       break;
     default:
       break;
  }
  
  // change kagura scene
  switch(counterBlue){
     case 100:
       myBus.sendControllerChange(4, 1, 100); // Send a controllerChange
       break;
     default:
       break;
  }

  textFont(sans,100);
  text("Blue", 300, 100);
  text(counterBlue, 300, 300);
  text("Red", 800, 100);
  text(counterRed, 800, 300);

}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);

  if (channel == 1) {
    counterBlue++;
  } else {
    counterRed++;
  }
  
  if (counterRed > counterBlue){
    winner = 1;
  } else if (counterBlue > counterRed) {
    winner = 2;
  } else {
    winner = 0;
  }
  
  println("CounterRed:"+counterRed);  
  println("CounterBlue:"+counterBlue);
  println("winner:"+winner);
     //<>//
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
