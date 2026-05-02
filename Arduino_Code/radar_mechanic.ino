#include <Servo.h>

#define trigPin 11
#define echoPin 10

Servo servoMechanism;
int position = 11;  // position - current position from 10 to 170
int change = 2;     // change, how much should servo move

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  servoMechanism.attach(9);  // connect servo to pin 9

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  servoMechanism.write(position);
  position += change;

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(2);
  digitalWrite(trigPin, LOW);

  long time = 0;
  double distance = 0;
  time = pulseIn(echoPin, HIGH);
  distance = time / 58.0;
  Serial.print(position);
  Serial.print(",");
  Serial.println(distance);

  delay(50);
  if (position <= 10 || position >= 170) change = -change;
}
