#ifndef _SubProgram_INCLUDED_
#define _SubProgram_INCLUDED_

void MyShow();
unsigned int read_adc(unsigned char adc_input);
void SubProgram1();

interrupt [ADC_INT] void adc_isr(void);
void CheckChanges(char i);

void ChangeDutyCycle(char percent);
char Number2Percent(unsigned int A);

void charkhesh(char jahat);
void Optional_1(unsigned int ADC_1);

void Optional_2(unsigned int ADC_2);

#endif