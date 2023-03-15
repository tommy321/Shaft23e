void Colour_Picker(){
  //get the desired colour from the radio channel 1 position.
  radio_colour();

  
  
//  Serial.print(RadioIn);
//  Serial.print("\t");
//  Serial.print(RedWheel);
//  Serial.print("\t");
//  Serial.print(GreenWheel);
//  Serial.print("\t");
//  Serial.print(BlueWheel);
  
  //GreenWheel = RedWheel + 8533;
  //if (GreenWheel > 25400) {GreenWheel -= 25400;}
  //BlueWheel = GreenWheel + 8533;
  //if (BlueWheel > 25400) {BlueWheel -= 25400;}
  if (FadeComplete == 1) {
    for (int i = 0; i < 12; i++) {
      RedTarget[i] = RedWheel;
      GreenTarget[i] = GreenWheel;
      BlueTarget[i] = BlueWheel;
    }
    Serial.print("New Target Red: ");
    Serial.print(RedTarget[0]);
    Serial.print("\tGreen: ");
    Serial.print(Green[0]);
    Serial.print("\tBlue: ");
    Serial.println(Blue[0]);
    NewTarget = 1;
  }
  
  
  
  
  
  
}

