#ifndef _myheader_INCLUDED_
#define _myheader_INCLUDED_


#include <mega16.h>
#include <delay.h>
#include <stdio.h>
#include <adcf.h>
#include <spif.h>
#include <portf.h>
#include <twi.h>
#include <glcd.h>
#include <font5x7.h>
#include <i2c_f.h>
#include <stdlib.h>
#include <uartf.h>
#include <glcd_s.h>
#include <math.h>

// Declare your global variables here

extern volatile eeprom char data_rec[512];
extern bit master_micro;

#endif
