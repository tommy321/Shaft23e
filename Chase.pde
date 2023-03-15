
void chase_RGB(int ColourFlag) {
  //Start of a new sweep
  if (FadeComplete == 1 & directionflag == 8) {
    //Set the center bays to the colour determined by ColourFlag
    if (ColourFlag == 0) {
      Serial.println("Red");
      RedTarget[3] = ON;
      RedTarget[4] = ON;
    } else {
      RedTarget[3] = 25400;
      RedTarget[4] = 25400;
    }
    if (ColourFlag == 1) {
      Serial.println("Green");
      GreenTarget[3] = ON;
      GreenTarget[4] = ON;
    } else {
      GreenTarget[3] = 25400;
      GreenTarget[4] = 25400;
    }
    if (ColourFlag == 2) {
      Serial.println("Blue");
      BlueTarget[3] = ON;
      BlueTarget[4] = ON;
    } else {
      BlueTarget[3] = 25400;
      BlueTarget[4] = 25400;
    }
    
    
    
    Serial.println("New RGB Sweep Started");
    //all other bay targets are OFF;
    for (int i = 0; i < 3; i++) {
      RedTarget[i] = ON;
      GreenTarget[i] = ON;
      BlueTarget[i] = ON;
      RedTarget[i+5] = ON;
      GreenTarget[i+5] = ON;
      BlueTarget[i+5] = ON;
    }
    NewTarget = 1;//This flag indicates new targets are available to fade to.
    directionflag = 4;//This flag what bay the colours have reached.
    return;
  }
  
  if (FadeComplete == 1 & directionflag < 8) {
        //move all targets out by one bay.
        for (int i = 0; i < 4; i++) {
          RedTarget[i] = RedTarget[i+1];
          GreenTarget[i] = GreenTarget[i+1];
          BlueTarget[i] = BlueTarget[i+1];
        }
        for (int i = 7; i > 4; i--) {
          RedTarget[i] = RedTarget[i-1];
          GreenTarget[i] = GreenTarget[i-1];
          BlueTarget[i] = BlueTarget[i-1];
        }
        
        //set the current faded bay to off;
        RedTarget[directionflag] = ON;
        BlueTarget[directionflag] = ON;
        GreenTarget[directionflag] = ON;
        int mirror = directionflag*-1+7;
        RedTarget[mirror] = ON;
        BlueTarget[mirror] = ON;
        GreenTarget[mirror] = ON;        
        //make the fuse bays the same as the three wing bays: 
        for (int i = 0; i < 5; i++) {
          RedTarget[i+8] = RedTarget[i+4];
          GreenTarget[i+8] = GreenTarget[i+4];
          BlueTarget[i+8] = BlueTarget[i+4];
        }
        
        //increment the direction flag
        directionflag++;
        NewTarget = 1; 
      }
}




void chase_colour_picker() {
  //Start of a new sweep
//  Serial.print("directionflag: ");
//  Serial.println(directionflag);
  if (FadeComplete == 1 & directionflag == 8) {
    //use the colour wheel values to pick a new colour for bays 3/4
    radio_colour();
    RedTarget[3] = RedWheel;
    GreenTarget[3] = GreenWheel;
    BlueTarget[3] = BlueWheel;
    RedTarget[4] = RedTarget[3];
    GreenTarget[4] = GreenTarget[3];
    BlueTarget[4] = BlueTarget[3];

    //all other bay targets are OFF;
    for (int i = 0; i < 3; i++) {
      RedTarget[i] = ON;
      GreenTarget[i] = ON;
      BlueTarget[i] = ON;
      RedTarget[i+5] = ON;
      GreenTarget[i+5] = ON;
      BlueTarget[i+5] = ON;
    }
    Serial.print("New Targets Picked: ");
    Serial.print(RedWheel);
    Serial.print("\t");
    Serial.print(GreenWheel);
    Serial.print("\t");
    Serial.println(BlueWheel);
    NewTarget = 1;//This flag indicates new targets are available to fade to.
    directionflag = 4;//This flag what bay the colours have reached.
    return;
  }
  
  if (FadeComplete == 1 & directionflag < 8) {
        //move all targets out by one bay.
        for (int i = 0; i < 4; i++) {
          RedTarget[i] = RedTarget[i+1];
          GreenTarget[i] = GreenTarget[i+1];
          BlueTarget[i] = BlueTarget[i+1];
        }
        for (int i = 7; i > 4; i--) {
          RedTarget[i] = RedTarget[i-1];
          GreenTarget[i] = GreenTarget[i-1];
          BlueTarget[i] = BlueTarget[i-1];
        }
        //set the current faded bay to off;
        RedTarget[directionflag] = ON;
        BlueTarget[directionflag] = ON;
        GreenTarget[directionflag] = ON;
        int mirror = directionflag*-1+7;
        RedTarget[mirror] = ON;
        BlueTarget[mirror] = ON;
        GreenTarget[mirror] = ON;        
        //increment the direction flag
        directionflag++;
        NewTarget = 1; 
      }
}
  
  

