void SweepRandom() {
    if (directionflag == 0) {
      if (patternCounter == 10) {
        directionflag = 1;
      }
      
      if (patternCounter > 0) {
        Red[patternCounter] = Red[patternCounter - 1];
        Green[patternCounter] = Green[patternCounter - 1];
        Blue[patternCounter] = Blue[patternCounter - 1];
        patternCounter++;
      }
      
      if (patternCounter <= 0) {
        Red[0] = RedWheel;
        Green[0] = GreenWheel;
        Blue[0] = BlueWheel;
        patternCounter++;
      }
    }
  
  if (directionflag == 1) {
    if (patternCounter == 0) {
      directionflag = 0;
    }
    
    if (patternCounter < 10) {
      Red[patternCounter] = Red[patternCounter + 1];
      Green[patternCounter] = Green[patternCounter + 1];
      Blue[patternCounter] = Blue[patternCounter + 1];
      patternCounter--;
    }
    
    if (patternCounter >= 10) {
      Red[9] = RedWheel;
      Green[9] = GreenWheel;
      Blue[9] = BlueWheel;
      patternCounter--;
    }
  }
}


void sweep_out() {
 
  if (sweepComplete == 0) {
    //pick new targets. 
    //move all the targets outwards by one. 
    for (int i = 1; i < 5; i++) {
      RedTarget[i-1] = RedTarget[i];
      GreenTarget[i-1] = GreenTarget[i];
      BlueTarget[i-1] = BlueTarget[i];
      RedDelta[i-1] = (RedTarget[i-1] - Red[i-1])/FADE_STEP;
      GreenDelta[i-1] = (GreenTarget[i-1] - Green[i-1])/FADE_STEP;
      BlueDelta[i-1] = (BlueTarget[i-1] - Blue[i-1])/FADE_STEP;      
    }
    for (int i = 9; i > 5; i--) {
      RedTarget[i] = RedTarget[i-1];
      GreenTarget[i] = GreenTarget[i-1];
      BlueTarget[i] = BlueTarget[i-1];
      RedDelta[i] = (RedTarget[i] - Red[i])/FADE_STEP;
      GreenDelta[i] = (GreenTarget[i] - Green[i])/FADE_STEP;
      BlueDelta[i] = (BlueTarget[i] - Blue[i])/FADE_STEP;      

    }
    //Cycle through RGB in Bay 4/5
    if (directionflag == 0) {
      RedTarget[4] = 300;
      GreenTarget[4] = 25400;
      BlueTarget[4] = 25400;
    } else if (directionflag ==1) {
      RedTarget[4] = 25400;
      GreenTarget[4] = 25400;
      BlueTarget[4] = 25400;
    } else if (directionflag ==4) {
      RedTarget[4] = 25400;
      GreenTarget[4] = 300;
      BlueTarget[4] = 25400;
    } else if (directionflag ==5) {
      RedTarget[4] = 25400;
      GreenTarget[4] = 25400;
      BlueTarget[4] = 25400;
    } else if (directionflag ==7) {
      RedTarget[4] = 25400;
      GreenTarget[4] = 25400;
      BlueTarget[4] = 300;
    } else if (directionflag ==8) {
      RedTarget[4] = 25400;
      GreenTarget[4] = 25400;
      BlueTarget[4] = 25400;
 }     
    RedDelta[4] = (RedTarget[4] - Red[4])/FADE_STEP;
    GreenDelta[4] = (GreenTarget[4] - Green[4])/FADE_STEP;
    BlueDelta[4] = (BlueTarget[4] - Blue[4])/FADE_STEP;
    
    RedTarget[5] = RedTarget[4];
    GreenTarget[5] = GreenTarget[4];
    BlueTarget[5] = BlueTarget[4];
    RedDelta[5] = RedDelta[4];
    GreenDelta[5] = GreenDelta[4];
    BlueDelta[5] = BlueDelta[4];
    sweepComplete = 1;
    patternCounter = 0;
    Serial.println("New Colour:");
    Serial.print(RedTarget[4]);
    Serial.print(":");
    Serial.print(GreenTarget[4]);
    Serial.print(":");
    Serial.println(BlueTarget[5]);
  }
  
  //drive the 10 bays towards the targets
  if (sweepComplete == 1) {
    for (int i = 0; i < 10; i++) {
      Red[i] += RedDelta[i];
      Green[i] += GreenDelta[i];
      Blue[i] += BlueDelta[i];
    }
    patternCounter++;
    if (patternCounter>FADE_STEP-1) {
      sweepComplete = 0;
      directionflag++;
      if (directionflag==10) {directionflag=0;}
    }
    
   
      
  }
}
