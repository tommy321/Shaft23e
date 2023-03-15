#if 0
void randomcolours() {
  int diff;
  int rdiff;
  int gdiff;
  int bdiff;
  if (Complete == 1) {
    //Randomly pick a new colour
    Red = random(300, 25400);
    Green = random(300,25400);
    Blue = random(300,25400);
    if (Red>Colour[RedLed]) {RedDelta = 1000;} else {RedDelta = -1000;}
    if (Green>Colour[GreenLed]) {GreenDelta = 1000;} else {GreenDelta = -1000;}
    if (Blue>Colour[BlueLed]) {BlueDelta = 1000;} else {BlueDelta = -1000;}
    Complete = 0;
    Serial.println("New Colour:");
    Serial.print(Red);
    Serial.print(":");
    Serial.print(Green);
    Serial.print(":");
    Serial.println(Blue);
  }
  diff = Red-Colour[RedLed];
  if(abs(diff)>2000) Colour[RedLed] = Colour[RedLed] + RedDelta;
  diff = Green-Colour[GreenLed];
  if(abs(diff)>2000) Colour[GreenLed] = Colour[GreenLed] + GreenDelta;
  diff = Blue-Colour[BlueLed];
  if(abs(diff)>2000) Colour[BlueLed] = Colour[BlueLed] + BlueDelta;
  
  rdiff = Colour[RedLed]-Red;
  gdiff = Colour[GreenLed]-Green;
  bdiff = Colour[BlueLed]-Blue;
  
  if (abs(rdiff)<=2000) {
    if (abs(gdiff)<=2000) {
      if (abs(bdiff)<=2000) {
        Complete = 1;
        Serial.println("Transition Complete ***");
        delay(1);
        }
      }
    }


}


void ArrayRandom() {
  int j = 0;
  for (j = 0; j<10; j++) {
    //fill the colour array with random numbers
    Colour[j] = random(3, 254);
   }
 }
 #endif
 
void randomcolours() {
//pick a random Red, Green and Blue LED to turn on
int i = random(0,10);
int j = random(0,10);
int k = random(0,10);
Serial.print(i);
Serial.print(",");
Serial.print(j);
Serial.print(",");
Serial.println(k);

for (int m = 0; m<=9; m++) {
  if (m == i) {Red[m] = ON;} else {Red[m] = OFF;}
  if (m == j) {Green[m] = ON;} else {Green[m] = OFF;}
  if (m == k) {Blue[m] = ON;} else {Blue[m] = OFF;}
}

}
