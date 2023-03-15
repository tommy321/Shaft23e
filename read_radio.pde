
unsigned int timer1count	= 0;
unsigned int timer2count	= 0;
unsigned int timer3count	= 0;
unsigned int timer4count    = 0;


byte ch_read = 0;
boolean ch1_read = 0;
boolean ch2_read = 0;
boolean ch3_read = 0;
boolean ch4_read = 0;

void read_radio()
{
  if (timer1diff>CH1_MAX & timer1diff<2500) {CH1_MAX = timer1diff;}
  if (timer2diff>CH2_MAX & timer2diff<2500) {CH2_MAX = timer2diff;}
  if (timer3diff>CH3_MAX & timer3diff<2500) {CH3_MAX = timer3diff;}
  if (timer1diff<CH1_MIN) {CH1_MIN = timer1diff;}
  if (timer2diff<CH2_MIN) {CH2_MIN = timer2diff;}
  if (timer3diff<CH3_MIN) {CH3_MIN = timer3diff;}
  
  ch1_temp = timer1diff;
  ch2_temp = timer2diff;
  ch3_temp = timer3diff;
  CH1_SLOPE = (float)1/(CH1_MAX-CH1_MIN);
  
  //Print Radio Values
//  Serial.print("CH1_min: ");
//  Serial.print(CH1_MIN);
//  Serial.print("\tCH1: ");
//  Serial.print(ch1_temp);
//  Serial.print("\tCH1_MAX: ");
//  Serial.println(CH1_MAX);
  //ch1_temp = timer1diff;
  //ch2_temp = timer2diff;
  //ch3_temp = timer3diff;
}

void radio_colour() {
  float RadioIn = (float)(ch1_temp-CH1_MIN)*CH1_SLOPE*6.2831;  //Pick the three colour wheel colours 
  //Serial.println(sin(RadioIn));
  RedWheel = sin(RadioIn)*12800;
  GreenWheel = sin(RadioIn+2.094)*12800;
  BlueWheel = sin(RadioIn+4.1887)*12800;
  RedWheel += 12800;
  GreenWheel += 12800;
  BlueWheel += 12800;
  
}

ISR(PCINT2_vect) {
	int cnt = TCNT1;
	//Serial.println(TCNT1);
	if(PIND & B0001000){ 		// PD3 is high
		if (ch1_read == 0){
                        //Serial.println("CH3 High");
                        ch1_read = 1;
			timer1count = cnt;
		}
	}else if (ch1_read == 1){	// PD3 is Low
                //Serial.println("CH3 Low");
		ch1_read = 0;
		if (cnt < timer1count)   // Timer1 reset during the read of this pulse
		   timer1diff = (cnt + 40000 - timer1count);    // Timer1 TOP = 40000
		else
		  timer1diff = (cnt - timer1count);
	}
	
	if(PIND & B00010000){ 		// PD4 is high
		if (ch2_read==0){
			ch2_read = 1;
			timer2count = cnt;
		}
	}else if (ch2_read == 1){	// PD4 is Low
		ch2_read = 0;
		if (cnt < timer2count)   // Timer1 reset during the read of this pulse
		   timer2diff = (cnt + 40000 - timer2count);    // Timer1 TOP = 40000
		else
		  timer2diff = (cnt - timer2count);
	}

	if(PIND & B00100000){ 		// PD5 is high
		if (ch3_read==0){
			ch3_read = 1;
			timer3count = cnt;
		}
	}else if (ch3_read == 1){	// PD5 is Low
		ch3_read = 0;
		if (cnt < timer3count)   // Timer1 reset during the read of this pulse
		   timer3diff = (cnt + 40000 - timer3count);    // Timer1 TOP = 40000
		else
		  timer3diff = (cnt - timer3count);
	}
}





void init_radio()
{
  pinMode(2,INPUT);	// Channel A input
  pinMode(3,INPUT);	// Channel B input
  pinMode(4,INPUT);	// Channel C input	
  
  // Timer 1
	TCCR1A = ((1<<WGM11) | (1<<COM1B1) | (1<<COM1A1)); //Fast PWM: ICR1=TOP, OCR1x=BOTTOM,TOV1=TOP
	TCCR1B = (1<<WGM13) | (1<<WGM12) | (1<<CS11); // Clock scaler = 8, 2,000,000 counts per second
	ICR1 = 40000; 	//50hz freq...Datasheet says	(system_freq/prescaler)/target frequency. So (16000000hz/8)/50hz = 40000,	
// enable pin change interrupt on PD2,PD3 (digital pin 2,3)
PCMSK2 = _BV(PCINT19) | _BV(PCINT20)| _BV(PCINT21);
// enable pin change interrupt 2 - PCINT23..16
PCICR = _BV(PCIE2);

}
