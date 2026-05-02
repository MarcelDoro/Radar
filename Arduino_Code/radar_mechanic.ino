#include <Servo.h>

#define trigPin 11  // pin responsible for sending the signal to the ultrasonic sensor
#define echoPin 10  // pin responsible for receiving the signal from the ultrasonic sensor

Servo servoMechanism; // variable to control the servo mechanism
int position = 11;  // position - current position from 10 to 170 (servo can rotate from 0 to 180)
int change = 2;     // change, how much should servo move

void setup() { // this code is executed once when the program starts
  Serial.begin(9600);
  servoMechanism.attach(9);  // connect servo to pin 9

  pinMode(trigPin, OUTPUT); // set trigPin as output
  pinMode(echoPin, INPUT); // set echoPin as input
}

void loop() { // this code is executed repeatedly in a loop (unlike a setup() function)
  servoMechanism.write(position); // set servo to the current position
  position += change; // change position for the next loop

  digitalWrite(trigPin, LOW); // set trigPin to LOW for a short time to ensure a clean signal
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH); // set trigPin to HIGH to send the signal (start of the signal)
  delayMicroseconds(2);
  digitalWrite(trigPin, LOW); // set trigPin to LOW to end the signal (end of the signal)

  long time = 0; // variable to store the time it takes for the signal to return
  double distance = 0; // variable to store the calculated distance (in cm)
  double velocity = 0.0343; // speed of sound in cm/µs (343 m/s converted to cm/µs)
  time = pulseIn(echoPin, HIGH); // wait for the signal to return and measure the time it takes (in microseconds)
  distance = velocity * time / 2; // calculate the distance based on the time (elaboration in readme.md, why we divide by 2)
  Serial.print(position); // print the current position of the servo
  Serial.print(","); // print a comma to separate the position and distance values
  Serial.println(distance); // print the calculated distance and move to the next line for the next measurement

  delay(50);
  if (position <= 10 || position >= 170) change = -change; // if the servo reaches the limits (10 or 170), change the direction of movement
}
