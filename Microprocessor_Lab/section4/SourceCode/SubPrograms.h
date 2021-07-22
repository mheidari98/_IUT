#ifndef _SubProgram_INCLUDED_
#define _SubProgram_INCLUDED_
 
void PrintTimer(void);
void UpdateTimer(void);
interrupt [EXT_INT0] void ext_int0_isr(void);
interrupt [TIM2_OVF] void timer2_ovf_isr(void);

void PrintCapacity(void);
interrupt [EXT_INT1] void ext_int1_isr(void);

void ChangePeriod(char a);

#endif