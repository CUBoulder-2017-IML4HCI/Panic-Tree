#include <Wire.h>
#include <VSync.h>
#include <SoftwareSerial.h>
#include "Ultrasonic.h"

Ultrasonic ultrasonic(7);
ValueSender<1> sender;

int sensorPin = A1; // select the input pin for the potentiometer
int moisture = 0; // variable to store the value coming from the sensor7
int heartBeat;
int stress;

void setup() {
    Serial.begin(19200);
    Wire.begin();
    sender.observe(stress);
}
void loop() {
    Wire.requestFrom(0xA0 >> 1, 1);    // request 1 bytes from slave device
    while(Wire.available()) {          // slave may send less than requested
      heartBeat = Wire.read(); // receive heart rate value (a byte)
    }
    
    // read the value from the sensor:
    moisture = analogRead(sensorPin);
    //heartBeat = (int) (ultrasonic.MeasureInCentimeters() * 2);
    stressYes();
    
    sender.sync();
    
    delay(1000);
}

void stressYes() {
  // take the "stress value", which is a modified average of the two
  stress = ((((float)heartBeat - 70)/30)*((float)moisture/500))*100;
  if (stress < 0){
    stress = 0;
  }
  if (stress > 100){
    stress = 100;
  }
  
  
  /*Serial.print(stress);
   
    Serial.print(" / ");
    Serial.print(heartBeat);
    Serial.print(" / ");
    Serial.println(moisture);*/
}
