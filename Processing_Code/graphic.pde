import processing.serial.*;

Serial myPort;
float angle = 0;
float distance = 0;

void setup() { 
 fullScreen();
 myPort = new Serial(this, "COM7", 9600);
 myPort.bufferUntil('\n');
}

void draw() {
  background(0); // background color 0 - black
  
  translate(width/2, height - 100); // move drawing center
  
  noFill();
  stroke(0, 100, 0); // colour dark green
  strokeWeight(2); // line thickness
  for (int i = 1; i <= 5; i++) {
    // Rysujemy łuk od PI do TWO_PI (górna połowa)
    arc(0, 0, i * 380, i * 380, PI, TWO_PI);
  }
  
  fill(0, 255, 0); // green text color
  textSize(32);
  text("Angle: " + angle, -180, 50);
  text("Distance: " + distance, 20, 50);
  
  float r = 10 * distance;
  float x = -r * cos(radians(angle));
  float y = -r * sin(radians(angle));
  
  float a = y / x;
  
  float x2 = 950.0 / sqrt(a * a + 1);
  if (x < 0) x2 = -x2;
  float y2 = a * x2;
  
  stroke(0, 255, 0); // green colour
  
  if (x * x + y * y >= 950 * 950) { // point is outside of a circle
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