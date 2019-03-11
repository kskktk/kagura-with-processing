import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

// Global Variable
PFont sans;

// init counter
int counter1 = 0;
int counter2 = 0;
int counter3 = 0;
int counter4 = 0;

// init velocity value
int velo1 = 0;
int velo2 = 0;
int velo3 = 0;
int velo4 = 0;

// init velocity value
int tmpvelo1 = 0;
int tmpvelo2 = 0;
int tmpvelo3 = 0;
int tmpvelo4 = 0;

// init sum
float sum = 0;

// init ratio
float ratio1 = 0.25;
float ratio2 = 0.25;
float ratio3 = 0.25;
float ratio4 = 0.25;

// init rect startpoint
float start = 0;

// init timecounter
int timecounter = 0;

// init midi variable
int channel = 0;
int pitch = 64;
int velocity = 127;

// init winner flag
int winner = 0;

void setup() {

  size(1000, 600);
  
  sans = loadFont("ProcessingSansPro-Regular-48.vlw");
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, "katsuki-windows", "katsuki-windows"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
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

  // timecounter countup
  timecounter++;

  // calc wariai
  if( counter1 > 0 || counter2 > 0 || counter3 > 0 || counter4 > 0){
    sum = counter1 + counter2 + counter3 + counter4;
    ratio1 = counter1 / sum;
    ratio2 = counter2 / sum;
    ratio3 = counter3 / sum;
    ratio4 = counter4 / sum;
  }

  
  // calc move velocity
  if ( timecounter == 0 ){
    tmpvelo1 = counter1;     
    tmpvelo2 = counter2;     
    tmpvelo3 = counter3;     
    tmpvelo4 = counter4;  
 }

  if ( timecounter == 60 ) { 
    velo1 = counter1 - tmpvelo1;
    velo2 = counter2 - tmpvelo2;
    velo3 = counter3 - tmpvelo3;
    velo4 = counter4 - tmpvelo4;
    timecounter = 0;
    tmpvelo1 = counter1;
    tmpvelo2 = counter2;
    tmpvelo3 = counter3;
    tmpvelo4 = counter4;
  }
  
  // change backgrundcolor
  switch(winner){
     case 1:
       background(0,0,0);
       break;
     case 2:
       background(0,0,0);
       break;
     default:
       background(0,0,0);
       break;
  }

  //// change kagura scene
  //switch(counterRed){
  //   case 100:
  //     myBus.sendControllerChange(3, 1, 100); // Send a controllerChange
  //     break;
  //   default:
  //     break;
  //}
  
  //// change kagura scene
  //switch(counterBlue){
  //   case 100:
  //     myBus.sendControllerChange(4, 1, 100); // Send a controllerChange
  //     break;
  //   default:
  //     break;
  //}
  
  // display
  textFont(sans,20);
  fill(255,255,255);
  text("MIRAINO UNDOUKAI FUKUOKA", 50, 50);
  text("timecounter="+timecounter, 50, 100);
  
  text("1", 50, 200);
  text("counter="+counter1, 50, 250);
  text("ratio="+ratio1, 50, 300);
  text(velo1+"moves / sec", 50, 350); //<>//
  
  text("2", 250, 200);
  text("counter="+counter2, 250, 250);
  text("ratio="+ratio2, 250, 300);
  text(velo2+"moves / sec", 250, 350);
  
  text("3", 450, 200);
  text("counter="+counter3, 450, 250);
  text("ratio="+ratio3, 450, 300);
  text(velo3+"moves / sec", 450, 350);
  
  text("4", 650, 200);
  text("counter="+counter4, 650, 250);
  text("ratio="+ratio4, 650, 300);
  text(velo3+"moves / sec", 650, 350);

  if( counter1 > 0 || counter2 > 0 || counter3 > 0 || counter4 > 0){
    fill(0,0,255);
    noStroke();
    rect(0, 500, ratio1*1000, 100);
    fill(0,255,0);
    noStroke();
    rect(ratio1*1000, 500, ratio2*1000, 100);
    fill(167,87,168);
    noStroke();
    rect((ratio1+ratio2)*1000, 500, ratio3*1000, 100);
    fill(255,0,0);
    noStroke();
    rect((ratio1+ratio2+ratio3)*1000, 500, ratio4*1000, 100);
  } else {
    fill(0,0,255);
    noStroke();
    rect(0, 500, 500, 100);
    fill(0,255,0);
    noStroke();
    rect(250, 500, 500, 100);
    fill(167,87,168);
    noStroke();
    rect(500, 500, 500, 100);
    fill(255,0,0);
    noStroke();
    rect(750, 500, 500, 100);
  }
  
  // stdout     
  //println("--------");
  //println("ratioRed:"+ratioRed); 
  //println("rationBlue:"+ratioBlue);
  //println("sum:"+sum);
  
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  
  switch (channel){
    case 0:
      counter1++;
      break;
    case 1:
      counter2++;
      break; //<>//
    case 2:
      counter3++;
      break;
    case 3:
      counter4++;
      break;
    default:
  }
  
  //if (counterRed > counterBlue){
  //  winner = 1;
  //} else if (counterBlue > counterRed) {
  //  winner = 2;
  //} else {
  //  winner = 0;
  //}
  
  //println("CounterRed:"+counterRed);  
  //println("CounterBlue:"+counterBlue);
  //println("winner:"+winner);
    
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
  //println();
  //println("Controller Change:");
  //println("--------");
  //println("Channel:"+channel);
  //println("Number:"+number);
  //println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
