
void fade_random() {
  int diff;
  int RedLevel;
  int GreenLevel;
  int BlueLevel;
  if (Complete == 1) {
    FadeFlag = 0; //Fade up
    //Randomly pick a new colour
    RedLevel = random(0, 25400);
    GreenLevel = random(0,25400);
    BlueLevel = random(0,25400);
    RedDelta[0] = (25400-RedLevel) / FADE_STEP;//calculate how to get to this colour in FADE_STEP steps.
    GreenDelta[0] = (25400-GreenLevel) / FADE_STEP;
    BlueDelta[0] = (25400-BlueLevel) / FADE_STEP;
    for (int i = 0; i < 10; i++) {
      Red[i] = 25400;//turn off all three colours
      Green[i] = 25400;
      Blue[i] = 25400;
    }
    Complete = 0;
    Serial.println("New Colour:");
    Serial.print(RedLevel);
    Serial.print(":");
    Serial.print(GreenLevel);
    Serial.print(":");
    Serial.println(BlueLevel);
  }
  
  if (Complete == 0) {
    FadeFlag += 1;
    if (FadeFlag < FADE_STEP) { //Fade Up
      for (int i = 0; i < 10; i++) {
        Red[i] -= RedDelta[0];
        Green[i] -= GreenDelta[0];
        Blue[i] -= BlueDelta[0];
      }
    }
      
    
    if (FadeFlag >= (FADE_STEP)*2+FADE_PAUSE) {
      Serial.println("Done");
      Complete = 1;
      FadeFlag = 0;//Fade Done
    }  
    if (FadeFlag > FADE_STEP+FADE_PAUSE) { //Fade Down
      for (int i = 0; i < 10; i++) {
        Red[i] += RedDelta[0];
        Green[i] += GreenDelta[0];
        Blue[i] += BlueDelta[0];
      }
      
    }

  }
  Serial.print(Red[0]);
  Serial.print(",");
  Serial.print(Green[0]);
  Serial.print(",");
  Serial.println(Blue[0]);
}
