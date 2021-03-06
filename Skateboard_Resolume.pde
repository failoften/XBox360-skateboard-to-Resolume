

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ControlIO control;
ControlDevice stick;

int layerNum;
int clipNum;

public void setup() {
  size(200, 200);
  
  colorMode(RGB);
  background(0);
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  stick = control.getMatchedDevice("skateboard");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 7001);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 7000); 


  /* print your osc properties */
  //println(properties.toString());
}

public void draw() {
  // Start drawing now
  background(0);
  
  if (stick.getButton("START").pressed()) {
    beatTap(3,6);
  }
  else if (stick.getButton("UP").pressed()) {
    
  }
  else if (stick.getButton("LEFT").pressed()) {
    
  }
  else if (stick.getButton("RIGHT").pressed()) {
    
  }
  else if (stick.getButton("DOWN").pressed()) {
    
  }
  else if (stick.getButton("YELLOW").pressed()) {
    beatTap(3,1);
  }
  else if (stick.getButton("BLUE").pressed()) {
    beatTap(3,2);
  }
  else if (stick.getButton("RED").pressed()) {
    beatTap(3,3);
  }
  else if (stick.getButton("GREEN").pressed()) {
    beatTap(3,4);
  }
  else if (stick.getButton("BACK").pressed()) {
    beatTap(3,5);
  }
  else if (stick.getButton("KICK").pressed()) {
    //
  }
  else if (stick.getButton("KICK2").pressed()) {
    //
  }
  
  stick.getSlider("X").getValue(); //IR Front
  stick.getSlider("Y").getValue(); //IR Back
  stick.getSlider("RX").getValue(); //IR Left
  stick.getSlider("RY").getValue(); //IR Right
  stick.getSlider("Z").getValue(); //ROLL
  stick.getSlider("RZ").getValue(); //PITCH (kick)
  
}


void beatTap(int layerNum,int clipNum) {
  // create OSC message
  OscMessage myMessage = new OscMessage("/layer"+layerNum+"/clip"+clipNum+"/connect");

  myMessage.add(1); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
  
  myMessage.add(0); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}