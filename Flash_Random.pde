void flash_random() {

  if (Complete == 1) {
    //Randomly pick a new colour
    for (int i = 0; i<10; i++) {
     RedTarget[i] = random(0, 25400);
     GreenTarget[i] = random(0,25400);
     BlueTarget[i] = random(0,25100);
    }
    Complete = 0;
    FadeFlag = 0;
  }
  
  if (Complete == 0) {
    
    if (FadeFlag == 0) { //Turn off all the lights
      for (int i = 0; i<10; i++) {
       Red[i] = OFF;
       Green[i] = OFF;
       Blue[i] = OFF;
      }
    }
    if (FadeFlag == FLASH_OFF) {//Turn on the lights
      for (int i = 0; i<10; i++) {
        Red[i] = RedTarget[i];
        Green[i] = GreenTarget[i];
        Blue[i] = BlueTarget[i];
      }
   
    }  
    if (FadeFlag == FLASH_OFF + FLASH_ON) {//Turn off the lights and restart.
      for (int i = 0; i<10; i++) {
        Red[i] = OFF;
        Green[i] = OFF;
        Blue[i] = OFF;
      }
      Complete = 1;
    }
    FadeFlag += 1;
  }
}

