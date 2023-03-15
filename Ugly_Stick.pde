void UglyStick() {
  Serial.println("UglyStick");
  
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

  //Set the correct bays to white colour
  RedTarget[1] = ON;
  GreenTarget[1] = ON;
  BlueTarget[1] = ON;
  
  RedTarget[6] = ON;
  GreenTarget[6] = ON;
  BlueTarget[6] = ON;
  
  RedTarget[9] = ON;
  GreenTarget[9] = ON;
  BlueTarget[9] = ON;
  
}

