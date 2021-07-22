#ifndef _SubProgram_INCLUDED_
#define _SubProgram_INCLUDED_

interrupt [EXT_INT0] void ext_int0_isr(void);
interrupt [EXT_INT1] void ext_int1_isr(void);
interrupt [TIM1_CAPT] void timer1_capt_isr(void);
interrupt [TIM2_OVF] void timer2_ovf_isr(void);

void ChangeDutyCycle(char percent);
char Number2Percent(char A);

#endif