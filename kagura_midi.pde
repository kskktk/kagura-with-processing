import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

// Global Variable
PFont sans;
PImage title;
PImage go;
PImage mamonaku;
PImage result;

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

// init scene
int scene = 0;

// init resul tcount
int counter1Result = 0;
int counter2Result = 0;
int counter3Result = 0;
int counter4Result = 0;

// init result ratio
float ratio1Result = 0.25;
float ratio2Result = 0.25;
float ratio3Result = 0.25;
float ratio4Result = 0.25;

//init inplayflag
int inplay =0;

void setup() {
  
  fullScreen();
  
  sans = loadFont("ProcessingSansPro-Regular-48.vlw");
  
  title = loadImage("title.png");
  go = loadImage("go.png");
  mamonaku = loadImage("mamonaku.png");
  result = loadImage("result.png");
  
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

  background(0,0,0);

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
  
   switch (scene){
      case 0:
        showWait();
        break;
      case 1:
        showPlay();
        inplay = 1;
        break;
      case 2:
        if (inplay==1){
          counter1Result = counter1;
          counter2Result = counter2;
          counter3Result = counter3;
          counter4Result = counter4;
          sum = counter1Result + counter2Result + counter3Result + counter4Result;
          ratio1Result = counter1Result / sum;
          ratio2Result = counter2Result / sum;
          ratio3Result = counter3Result / sum;
          ratio4Result = counter4Result / sum;
          inplay = 0;  
          }
        showResultRatio(); //<>//
        break;
      case 3:
        showResult();
        break;
      default:
        showWait();
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
      break;
    case 2:
      counter3++;
      break;
    case 3:
      counter4++;
      break;
    default:
  }
    
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

void showPlay() {
    
    fill(83,109,254);
    noStroke();
    rect(0, 0, ratio1*displayWidth, displayHeight);
    fill(0,150,136);
    noStroke();
    rect(ratio1*displayWidth, 0, ratio2*displayWidth, displayHeight);
    fill(123,31,162);
    noStroke();
    rect((ratio1+ratio2)*displayWidth, 0, ratio3*displayWidth, displayHeight);
    fill(211,47,47);
    noStroke();
    rect((ratio1+ratio2+ratio3)*displayWidth, 0, ratio4*displayWidth, displayHeight);
    
    //imageMode(CENTER); //
    //image(go, displayWidth / 2, displayHeight / 2);

}

void showResultRatio(){
   //<>//
    fill(83,109,254);
    noStroke();
    rect(0, 0, ratio1Result*displayWidth, displayHeight);
    fill(0,150,136);
    noStroke();
    rect(ratio1Result*displayWidth, 0, ratio2Result*displayWidth, displayHeight);
    fill(123,31,162);
    noStroke();
    rect((ratio1Result+ratio2Result)*displayWidth, 0, ratio3Result*displayWidth, displayHeight);
    fill(211,47,47);
    noStroke();
    rect((ratio1Result+ratio2Result+ratio3Result)*displayWidth, 0, ratio4Result*displayWidth, displayHeight);
    
    imageMode(CENTER); //
    image(mamonaku, displayWidth / 2, displayHeight / 2);
    
}

void showResult() {
  
    // Background
    fill(83,109,254);
    noStroke();
    rect(0, 0, displayWidth/4 , displayHeight);
    fill(0,150,136);
    noStroke();
    rect(displayWidth/4, 0, displayWidth/4 , displayHeight);
    fill(123,31,162);
    noStroke();
    rect(displayWidth/2, 0, displayWidth/4 , displayHeight);
    fill(211,47,47);
    noStroke();
    rect(displayWidth*3/4, 0, displayWidth/4 , displayHeight);
  
    // Result 
    fill(255,255,255);  
    textFont(sans,150);
    textAlign(CENTER);
    text(counter1Result, displayWidth/8, displayHeight*3.3/4);
    text(counter2Result, displayWidth*3/8, displayHeight*3.3/4);
    text(counter3Result, displayWidth*5/8, displayHeight*3.3/4);
    text(counter4Result, displayWidth*7/8, displayHeight*3.3/4); //<>//
    
    imageMode(CENTER); //
    image(result, displayWidth / 2, displayHeight / 2);
  
}

void showWait() {
  
    // Background
    fill(83,109,254);
    noStroke();
    rect(0, 0, displayWidth/4 , displayHeight);
    fill(0,150,136);
    noStroke();
    rect(displayWidth/4, 0, displayWidth/4 , displayHeight);
    fill(123,31,162);
    noStroke();
    rect(displayWidth/2, 0, displayWidth/4 , displayHeight);
    fill(211,47,47);
    noStroke();
    rect(displayWidth*3/4, 0, displayWidth/4 , displayHeight);
    
    imageMode(CENTER); //
    image(title, displayWidth / 2, displayHeight / 2);
    
}

void keyPressed() {
  println("Press:");
  
  switch( key ){
    case ENTER:
    case RETURN:
      scene++;
    default:
      break;
  }

}
