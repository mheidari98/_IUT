#ifndef _adcf_INCLUDED_
#define _adcf_INCLUDED_

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))
#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 0

extern unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
// Voltage Reference: AVCC pin


void adc_init_no_intterupt(void);

void adc_init_interrupt(void);

unsigned int read_adc(unsigned char adc_input);
interrupt [ADC_INT] void adc_isr(void);
void adc_send_to_spi(void);
 
#endif

