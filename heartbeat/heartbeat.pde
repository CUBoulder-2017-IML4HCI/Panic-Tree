import processing.serial.*;
import vsync.*;
import oscP5.*;
import netP5.*;

ValueReceiver receiver;
OscP5 oscP5;
NetAddress wekinator;

public int stress; // calculated from heart rate and moisture sensor
//public int stagnant; // how long the stress value has been close to 0 or 100
//public boolean on = true; // whether wekinator is running
//public ArrayList val = new ArrayList(); // the last 50 values of input

void setup() 
{
  oscP5 = new OscP5(this,9000);
  wekinator = new NetAddress("127.0.0.1",6448);

  Serial serial = new Serial(this, "/dev/ttyACM0", 19200);
  receiver = new ValueReceiver(this, serial);
  receiver.observe("stress");
}

void draw() 
{  
  // stop running if stress is at the maximum or minimum, with no potential to continue growing/shrinking
  /*if ((stress > 90 || stress < 10) && on){
    stagnant++;
    if (stagnant > 100){
      OscMessage off = new OscMessage("/wekinator/control/stopRunning/");
      oscP5.send(off, wekinator);
      delay(500);
    }
  }
  else{
    stagnant = 0;
    val.add(stress);
    if (val.size() > 100){
      int average = 0;
      for (int i = 0; val.size() > i; i += 5){
        int value = (int) val.get(i);
        average += value;
      }
      // stop running if the stress level isn't changing
      if (((stress - average/20) < 2 || (stress - average/20) > 2) && on){
        OscMessage off = new OscMessage("/wekinator/control/stopRunning/");
        oscP5.send(off, wekinator);
        on = false;
        delay(500);
      }
      // start running if the value is changing
      else if (!on){
        OscMessage turnOn = new OscMessage("/wekinator/control/startRunning/");
        oscP5.send(turnOn, wekinator);
        on = true;
        delay(500);
      }
      val.remove(0);
    }
  }*/
  // send stress level to wekinator if running
  //if (on){
    OscMessage wek = new OscMessage("/wek/inputs");
    wek.add((float)stress);
    oscP5.send(wek, wekinator);
    println(stress);
  //}
}