


int send8byte(int address1, int value1, int address2, int value2, int address3, int value3, int address4, int value4) {

  // take the SS pin low to select the chip:
  digitalWrite(slaveSelectPin,LOW);
  //  send in the address and value via SPI:
  SPI.transfer(address4);
  SPI.transfer(value4);
  SPI.transfer(address3);
  SPI.transfer(value3);
  SPI.transfer(address2);
  SPI.transfer(value2);
  SPI.transfer(address1);
  SPI.transfer(value1);
  // take the SS pin high to de-select the chip:
  digitalWrite(slaveSelectPin,HIGH); 

}

void updatechannels() {
  int RedOut[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the red value for each of the 10 wing bays channels.
  int GreenOut[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the green value for each of the 10 wing bays channels.
  int BlueOut[12] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};//holds the blue value for each of the 10 wing bays channels.
  //if any values are greater than 253, or less than 300, set them to on, or off respectively. 
  for (int i = 0; i<13; i++) {
    RedOut[i] = Red[i];
    GreenOut[i] = Green[i];
    BlueOut[i] = Blue[i];
    if (RedOut[i]<300) {RedOut[i] = ON;} else if (RedOut[i]>25300) {RedOut[i] = OFF;}
    if (GreenOut[i]<300) {GreenOut[i] = ON;} else if (GreenOut[i]>25300) {GreenOut[i] = OFF;}
    if (BlueOut[i]<300) {BlueOut[i] = ON;} else if (BlueOut[i]>25300) {BlueOut[i] = OFF;}
  }

  
  
  //loop through all channels and update the lights. 
  send8byte(0x00, RedOut[3]/100,      0x00, RedOut[9]/100,    0x00, GreenOut[8]/100,     0x00, BlueOut[6]/100);
  send8byte(0x01, GreenOut[2]/100,    0x01, GreenOut[9]/100,  0x01, BlueOut[10]/100,       0x01, GreenOut[6]/100);
  send8byte(0x02, BlueOut[2]/100,     0x02, BlueOut[11]/100,  0x02, RedOut[10]/100,        0x02, RedOut[5]/100);
  send8byte(0x03, RedOut[1]/100,      0x03, RedOut[11]/100,   0x03, GreenOut[10]/100,      0x03, GreenOut[4]/100);
  send8byte(0x04, RedOut[0]/100,      0x04, GreenOut[11]/100, 0x04, BlueOut[9]/100,       0x04, BlueOut[4]/100);
  send8byte(0x05, BlueOut[1]/100,     0x05, RedOut[7]/100,    0x05, RedOut[8]/100,       0x05, GreenOut[7]/100);
  send8byte(0x06, GreenOut[1]/100,    0x06, BlueOut[7]/100,   0x06, BlueOut[8]/100,      0x06, RedOut[6]/100);
  send8byte(0x07, RedOut[2]/100,      0x07, OFF,              0x07, OFF,                  0x07, BlueOut[5]/100);
  send8byte(0x08, GreenOut[3]/100,    0x08, BlueOut[0]/100,   0x08, OFF,                  0x08, GreenOut[5]/100);
  send8byte(0x09, BlueOut[3]/100,     0x09, GreenOut[0]/100,  0x09, OFF,                  0x09, RedOut[4]/100);
}
















