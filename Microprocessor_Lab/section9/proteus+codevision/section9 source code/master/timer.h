#ifndef _timer_INCLUDED_
#define _timer_INCLUDED_

extern flash int cos6data[];

extern flash int sin6data[];


void hms_display(void);
interrupt [TIM1_OVF] void timer1_ovf_isr(void);
void timer1_init(void);
void clockdisplay(void);






#endif

