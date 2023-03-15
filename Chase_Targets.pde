void chase_target() {
  //this function drives Red/Green/Blue towards the Red/Green/Blue Targets. 
  if (NewTarget == 1) {
    //There are new targets available
    //Calculate the RGB Deltas required.
    for (int i = 0; i <=11; i++) {
      RedDelta[i] = (RedTarget[i] - Red[i])/FADE_STEP;
      GreenDelta[i] = (GreenTarget[i] - Green[i])/FADE_STEP;
      BlueDelta[i] = (BlueTarget[i] - Blue[i])/FADE_STEP;   
    }
    NewTarget = 0;
    StepNumber = 0;
    FadeComplete = 0;
  }
  
  //Update the Colours
  if (StepNumber <= FADE_STEP) {
    for (int i = 0; i <=11; i++) {
      Red[i] += RedDelta[i];
      Green[i] += GreenDelta[i];
      Blue[i] += BlueDelta[i];
    }
  //Count the number of steps done
  StepNumber ++;

  }
  
//Check to see if the fade is complete
  if (StepNumber >= FADE_STEP) {
   //Set the fade complete flag to done
   FadeComplete = 1; 
   //Set the RGB Values to their target colours
   //this should result in a relatively small jump
   for (int i = 0; i <=11; i++) {
     Red[i] = RedTarget[i];
     Green[i] = GreenTarget[i];
     Blue[i] = BlueTarget[i];     
   }
  } 
 
 
 
 
  
}
