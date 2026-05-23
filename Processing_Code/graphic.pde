import processing.serial.*;

// Hardware Data Variables
Serial myPort;
float angle = 0; 
float distance = 0;

// UI & Layout Customization
int distanceBetweenArcs = 300;
int BigArchRadius = 5 * distanceBetweenArcs / 2;

// Text Position Offsets
int angleTextXPos = -180;
int angleTextYPos = 50;
int distanceTextXPos = 20;
int distanceTextYPos = 50;

void setup() {
  size(1536, 864);
  
  // Serial Configuration 
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  // THE TRAIL EFFECT
  noStroke();
  fill(0, 15); // '15' is the alpha transparency(nieprzezroczystosc). 0 is completely invisible, 255 is completely solid.
  rect(0, 0, width, height);
  
  // 2. Shift the drawing origin to the bottom-center
  translate(width/2, height - 100); 
  
  // 3. Render all individual components
  drawRadarGrid();
  drawSweepLine();
  drawTextUI();
}

// Draws the background sonar radar arcs
void drawRadarGrid() {
  noFill();
  stroke(0, 100, 0); // Dark Green
  strokeWeight(2);
  
  for (int i = 1; i <= 5; i++) {
    // Draws the 5 half circles 
    arc(0, 0, i * distanceBetweenArcs, i * distanceBetweenArcs, PI, TWO_PI);
  }
}

// Calculates and draws the radar line
void drawSweepLine() {
  // Target coordinates based on sensor distance
  float targetRadius = 10 * distance; 
  float targetX = -targetRadius * cos(radians(angle));
  float targetY = -targetRadius * sin(radians(angle));
  
  // Maximal coordinates of the radar grid scope
  float edgeX = -BigArchRadius * cos(radians(angle));
  float edgeY = -BigArchRadius * sin(radians(angle));
  
  // Check if target falls within our maximum radar boundary range
  if (targetRadius >= BigArchRadius) {
    // Draw safe green line out to the edge
    stroke(0, 255, 0);
    line(0, 0, edgeX, edgeY);  
  } else {
    // Green up to object, Red showing the blocked zone behind it
    stroke(0, 255, 0); // Green
    line(0, 0, targetX, targetY);
    
    stroke(255, 0, 0); // Red
    line(targetX, targetY, edgeX, edgeY);
  }
}

// Renders the data text readouts
void drawTextUI() {
  // Pick up pure, 100% solid black paint (no transparency)
  noStroke();
  fill(0);
  
  // Draw solid black rectangles over the text areas to erase the old numbers(they do not overlay with previous)
  rect(angleTextXPos - 10, angleTextYPos - 32, 220, 45); 
  rect(distanceTextXPos - 10, distanceTextYPos - 32, 320, 45);
  
  fill(0, 255, 0); // Bright Green
  textSize(32);
  
  text("Angle: " + angle + "°", angleTextXPos, angleTextYPos);
  text("Distance: " + distance + " cm", distanceTextXPos, distanceTextYPos);
}

// Listens to incoming hardware input from Arduino
void serialEvent(Serial myPort) {
  String input = myPort.readStringUntil('\n');
  
  if (input != null) {
    input = trim(input); // Clear out hidden white spaces
    String[] dataList = split(input, ',');
    
    if (dataList.length >= 2) {
      angle = float(dataList[0]);
      distance = float(dataList[1]);
    }
  }
}
