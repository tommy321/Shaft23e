


// inslude the SPI library:
#include <SPI.h>

#define OFF 000
#define ON 100
#define ONE_MAX  0
#define TWO_MAX  0
#define FOUR_MAX 1
#define FADE_STEP_MIN 1
#define FADE_STEP_MAX 50
#define FADE_PAUSE 0
#define FLASH_ON 5
#define FLASH_OFF 5
#define MODE_TIMER 10000

int Red[12] =        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the red value for each of the 10 wing bays channels.
int Green[12] =      {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the green value for each of the 10 wing bays channels.
int Blue[12] =       {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the blue value for each of the 10 wing bays channels.
int RedTarget[12] =  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the red target value for each of the 10 wing bays channels.
int GreenTarget[12] ={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the green target value for each of the 10 wing bays channels.
int BlueTarget[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the blue target value for each of the 10 wing bays channels.



int Complete = 0;
int FadeFlag = 0;
int RedDelta[12] =   {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int GreenDelta[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int BlueDelta[12] =  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};


int patternCounter = 0;
int directionflag = 4;
int sweepComplete = 0;

int update_SPI_delay = 10;
unsigned long last_SPI_update;
unsigned long last_colour_update;
int update_colour_delay = 10;
int breathflag = 0;
int modestart = 0;
int modeswitchcount = 0;
int modeflag = 0;
unsigned long last_radio = 0;
unsigned int ch1_temp = 0;
unsigned int ch2_temp = 0;
unsigned int ch3_temp = 0;
unsigned int CH1_MAX = 2000;
unsigned int CH2_MAX = 2000;
unsigned int CH3_MAX = 1000;
unsigned int CH1_MIN = 1000;
unsigned int CH2_MIN = 1000;
unsigned int CH3_MIN = 1000;
float CH1_SLOPE = 0;
int LIGHT_MAX = 25400;
int LIGHT_MIN = 300;
unsigned int timer1diff		= 1500 * 2;
unsigned int timer2diff		= 1500 * 2;
unsigned int timer3diff		= 1500* 2;
unsigned int timer4diff		= 1500 * 2;
int RedWheel = 0;
int GreenWheel = 0;
int BlueWheel = 0;
int NewTarget = 0; 
int StepNumber = 0;
int FadeComplete = 0;
int FADE_STEP = 2;
int debugMode = 9;

// set pin 10 as the slave select for the digital pot:
const int slaveSelectPin = 10;

void setup() {
  // set the slaveSelectPin as an output:
  pinMode (slaveSelectPin, OUTPUT);
  pinMode(9, OUTPUT);
  digitalWrite(slaveSelectPin, HIGH);
  // initialize SPI:
    
  SPI.begin();
  Serial.begin(9600);
  Serial.println("Tom's Colour Flasher");
  Serial.print("freeRAM: ");
  Serial.println(freeRAM(),DEC);
  
  send8byte(0x10, 0x00, 0x10, 0x00, 0x10, 0x00, 0x10, 0x00); //set unit to shutdown.
  send8byte(0x15, 0x00, 0x15, 0x00, 0x15, 0x00, 0x15, 0x00); // set global full current to 2.5mA
  send8byte(0x13, 0x00, 0x13, 0x00, 0x13, 0x00, 0x13, 0x00); // set all ports to half full current (1.25mA)
  send8byte(0x14, 0x00, 0x14, 0x00, 0x14, 0x00, 0x14, 0x00);
  send8byte(0x0A, 0x00, 0x0A, 0x00, 0x0A, 0x00, 0x0A, 0x00); //Set all ports to on
  send8byte(0x10, 0x21, 0x10, 0x21, 0x10, 0x21, 0x10, 0x21); //set the chip to run mode with staggered PWM
  init_radio();
}

void loop() {


  //Use CH3_temp to update the modeflag. 
  //Change the mode when the CH3_temp is greater than 1500 for at least 2 loops.
  if (ch3_temp>1500) {
    modeswitchcount++;
  } else if (ch3_temp<1500) {
    modeswitchcount = 0;
  }
  if (modeswitchcount==7) {// || millis()-last_radio>30000) {
    modeflag++;
    last_radio = millis();
    if (modeflag == 9) {modeflag = 1;}
    Serial.print("Mode Update: ");
    Serial.println(modeflag);
  }
  
 
if (millis()-last_colour_update>update_colour_delay) {
  //play with the colour matrices in here
  read_radio();
  //Use Ch2_temp to drive the FADE_STEP value. 
  //Map CH2_MIN ->CH2_MAX onto FADE_STEP = 2 through 100;
  FADE_STEP = (float)(FADE_STEP_MAX-FADE_STEP_MIN)/(float)(CH2_MAX-CH2_MIN)*(float)(ch2_temp-CH2_MIN)+FADE_STEP_MIN;  

  switch(modeflag) { 
    case 1:
      UglyStick();
      break;
    case 2:
      chase_RGB(0);//Chase_RGB Red
      break;
    case 3:
      chase_RGB(1);//Chase_RGB Green
      break;
    case 4:
      chase_RGB(2);//Chase_RGB Blue
      break;
    case 5:
      chase_colour_picker();  
      break;
    case 6:
      Colour_Picker();
      break;
    case 7:
      Rainbow_Chase();
      break;
    case 8:
      Rainbow();
      break;
    case 9:
      //Debug Case
      
      if (FadeComplete == 1) {

        //for (int i = 0; i <= 11; i++) {
          if (modeflag>=1) {
          RedTarget[modeflag-1] = 200;
          GreenTarget[modeflag-1] = 200;
          BlueTarget[modeflag-1] = 200;
          }
          RedTarget[modeflag] = 25400;
          GreenTarget[modeflag] = 25400;
          BlueTarget[modeflag] = 25400;
        //}
        Serial.print("Modeflag: ");
        Serial.println(modeflag);
        NewTarget = 1;
      }

      break;
      
     }  
last_colour_update = millis();
}

//        Serial.print("NewTarget: ");
//        Serial.print(NewTarget);
//        Serial.print("\tRedTarget 0: ");
//        Serial.print(RedTarget[0]);
//        Serial.print("\tRed 0: ");
//        Serial.print(Red[0]);
//        Serial.print("\tRedTarget 1: ");
//        Serial.print(RedTarget[1]);
//        Serial.print("\tRed 1: ");
//        Serial.print(Red[1]);
//        Serial.print("\tFade Step: ");
//        Serial.println(FADE_STEP);


//Update the output ports.
if (millis()-last_SPI_update>update_SPI_delay) {
  chase_target();
  updatechannels();
  last_SPI_update = millis();
}









}//end main loop
