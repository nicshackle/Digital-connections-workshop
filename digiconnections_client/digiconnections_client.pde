import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioInput in;

Serial myPort;
boolean serial_success = false;

void setup()
{
  String portName = Serial.list()[0];
  try{
  myPort = new Serial(this, portName, 9600);
  serial_success = true;
  }
  catch(Exception e){
    println("could not open serial port. Program will still run, but not talk to Arduino");
  }
  
  size(200, 100, P3D);

  minim = new Minim(this);

  in = minim.getLineIn();
  fill(255);
}

int thresh = 6;
boolean above_thresh = false;

void draw()
{
  background(0);
  stroke(255);

  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    if ((in.left.get(i)*50)>thresh) {
      above_thresh = true;
    }
  }

  if (above_thresh) {
    if(serial_success)myPort.write('y');
    ellipse(100, 50, 50, 50);
    above_thresh=false;
  } 
  else{
    if(serial_success)myPort.write('n');
  }
  

  text("Threshold: " + str(thresh), 5, 15 );
  text("'w' and 's' to change threshold", 5, 90 );
}

void keyPressed()
{
  if ( key == 'w' || key == 'W' )
  {
    thresh+=1;
  }

  if ( key == 's' || key == 'S' )
  {
    thresh-=1;
    if (thresh<0)thresh=0;
  }
}

/*
//Arduino Code:

 char val; // Data received from the serial port
 int ledPin = 13; // Set the pin to digital I/O 4
 
 void setup() {
 pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
 Serial.begin(9600); // Start serial communication at 9600 bps
 }
 
 void loop() {
 if (Serial.available()) { // If data is available to read,
 val = Serial.read(); // read it and store it in val
 }
 if (val == 'y') { // If H was received
 digitalWrite(ledPin, HIGH); // turn the LED on
 } else {
 digitalWrite(ledPin, LOW); // Otherwise turn it OFF
 }
 delay(1); // sanity
 }
 
 */

