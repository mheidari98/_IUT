

 #include <myheader.h>



int adc_old_data=0;

unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];


// ADC interrupt service routine
// with auto input scanning
interrupt [ADC_INT] void adc_isr(void)
{
static unsigned char input_index=0;
// Read the AD conversion result
adc_data[input_index]=ADCW;
// Select next ADC input
if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT))
   input_index=0;
ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);

}

 void adc_send_to_spi(void)

 { char scr[20];
 adc_data[0]= read_adc(0);
 if (adc_data[0]!=  adc_old_data)
{
    SPDR=adc_data[0]&0x00ff;
    delay_ms(10);
    SPDR=adc_data[0]>>8;
    adc_old_data=adc_data[0];
    sprintf(scr,"\r\n ADC0=%d\r\n",adc_old_data);
    puts(scr);
}
}


 
 
void adc_init_no_intterupt(void)
{
ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

}
 

void adc_init_interrupt(void)
{
ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);

}




// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | ADC_VREF_TYPE;
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=(1<<ADSC);
// Wait for the AD conversion to complete
while ((ADCSRA & (1<<ADIF))==0);
ADCSRA|=(1<<ADIF);
return ADCW;
}
