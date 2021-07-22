#ifndef _myheader_INCLUDED_
#define _myheader_INCLUDED_

#include <mega16.h>
#include <alcd.h>  // Alphanumeric LCD functions
#include <delay.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 7

extern unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))  // Voltage Reference: AVCC pin

#define POSITION_SET 4
#define LED_LOW      5
#define LED_NORMAL   6
#define LED_HIGH     7

extern unsigned int MyAdcData[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

#endif