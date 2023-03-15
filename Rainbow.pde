void Rainbow() {
  int Red;
  int Blue;
  int Green;
  //This function fades the whole wing through the rainbow colours.
  if (FadeComplete == 1) {
    //directionflag represents which colour of the rainbow the chase has reached.
    directionflag++;
    if (directionflag >=7) {directionflag = 0;}
    //set the center two bays to the next rainbow colour. 
    switch(directionflag) {
      case 0:
        Serial.println("Red");
        Red = 0;
        Green = 25500;
        Blue = 25500;
        break;
      case 1:
        Serial.println("Orange");
        Red = 0;
        Green = 9000;
        Blue = 25500;
        break;
      case 2:
        Serial.println("Yellow");
        Red = 0; 
        Green = 0;
        Blue = 25500;
        break;
      case 3:
        Serial.println("Green");
        Red = 25500;
        Green = 0;
        Blue = 25500;
        break;
      case 4:
        Serial.println("Blue");
        Red = 25500;
        Green = 25500;
        Blue = 0;
        break;
      case 5:
        Serial.println("Indigo");
        Red = 18000;
        Green = 25500;
        Blue = 12500;
        break;
      case 6:
        Serial.println("Violet");
        Red = 1700;
        Green = 12500;
        Blue = 1700;
        break;
    }
    //set all bays to the colour of bays to the colour selected above;
    for (int i = 0; i<12; i++) {
      RedTarget[i] = Red;
      GreenTarget[i] = Green;
      BlueTarget[i] = Blue;
    }
    NewTarget = 1;//This flag indicates new targets are available to fade to.
   }
}


void Rainbow_Chase() {
  //scroll throuhg the rainbow colours out from the center
    //Start of a new sweep
//  Serial.print("directionflag: ");
//  Serial.println(directionflag);
  if (FadeComplete == 1) {
    //directionflag represents which colour of the rainbow the chase has reached.
    directionflag++;
    if (directionflag >=7) {directionflag = 0;}
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
        //make the fuse bays the same as the three wing bays: 
        for (int i = 0; i < 4; i++) {
          RedTarget[i+8] = RedTarget[i+4];
          GreenTarget[i+8] = GreenTarget[i+4];
          BlueTarget[i+8] = BlueTarget[i+4];
        }
        
    //set the center two bays to the next rainbow colour. 
    switch(directionflag) {
      case 0:
        Serial.println("Red");
        SetRGB(0,25500,25500);
        break;
      case 1:
        Serial.println("Orange");
        SetRGB(0,9000,25500);
        break;
      case 2:
        Serial.println("Yellow");
        SetRGB(0,0,25500);
        break;
      case 3:
        Serial.println("Green");
        SetRGB(25500,0,25500);
        break;
      case 4:
        Serial.println("Blue");
        SetRGB(25500,25500,0);
        break;
      case 5:
        Serial.println("Indigo");
        SetRGB(18000,25500,12500);
        break;
      case 6:
        Serial.println("Violet");
        SetRGB(1700,12500,1700);
        break;
    }

        

    //all other bay targets are OFF;
    NewTarget = 1;//This flag indicates new targets are available to fade to.
   
  }
}

void SetRGB(int Red, int Green, int Blue) {
    RedTarget[3] = Red;
    GreenTarget[3] = Green;
    BlueTarget[3] = Blue;
    RedTarget[4] = RedTarget[3];
    GreenTarget[4] = GreenTarget[3];
    BlueTarget[4] = BlueTarget[3];
}

  
