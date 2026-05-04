import processing.serial.*; // enable reading from serial monitor

Serial myPort; // port variable
float angle = 0; 
float distance = 0;

void setup() { //this is executed only once
 size(1536, 864); // set size of a window (btw fullScreen(); is often the best choice)
 myPort = new Serial(this, "COM6", 9600); // Creating new instance with essential data (You may have to change "COM6")
 myPort.bufferUntil('\n'); // when single line, information ends
}

int distanceBetweenArches = 300;
int angleTextXPos = -180;
int angleTextYPos = 50;
int distanceTextXPos = 20;
int distanceTextYPos = 50;
int BigArchRadius = 5 * distanceBetweenArches / 2;

void draw() { // this is executed in infinite loop
  background(0); // background color 0 - black
  
  translate(width/2, height - 100); // move drawing center
  
  noFill();
  stroke(0, 100, 0); // colour dark green
  strokeWeight(2); // line thickness
  for (int i = 1; i <= 5; i++) {
    // We draw 5 arches spaced distanceBetweenArches between each other and we draw only top half(we want arch not a full circle)
    arc(0, 0, i * distanceBetweenArches, i * distanceBetweenArches, PI, TWO_PI);
  }
  
  // printing informations below
  fill(0, 255, 0); // text colour - green
  textSize(32);
  text("Angle: " + angle, angleTextXPos, angleTextYPos); // print angle on specified position
  text("Distance: " + distance, distanceTextXPos, distanceTextYPos); // print distance on specified position
  
  float r = 10 * distance; // radius (multiplied by 10 to be better visible)
  float x = -r * cos(radians(angle)); 
  float y = -r * sin(radians(angle));
  
  float a = y / x; 
  
  float x2 = BigArchRadius / sqrt(a * a + 1);
  if (x < 0) x2 = -x2;
  float y2 = a * x2;
  
  stroke(0, 255, 0); // green colour
  
  if (x * x + y * y >= BigArchRadius * BigArchRadius) { // point is outside of a circle
    line(0, 0, x2, y2); // draw green line  
  } else {
    line(0, 0, x, y); // draw green line
    fill(255, 0, 0); // red colour
    stroke(255, 0 ,0);
    line(x, y, x2, y2);
  }
}

void serialEvent(Serial myPort) {
  String input = myPort.readStringUntil('\n');
  
  if (input != null) input = trim(input); // delete useless symbols
  
  String[] list = split(input, ',');
  
  if (list.length >= 2) {
    angle = float(list[0]);
    distance = float(list[1]);
  }
}