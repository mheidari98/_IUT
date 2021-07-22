#include "myheader.h"

char buf[100];
char TimerStatus=0;

void PrintTimer(void)
{
    lcd_gotoxy(2,0);   
    sprintf(buf,"%02d:%02d:%02d,%02d",Hour, Minute, Second, USec); 
    lcd_puts(buf);
}

void UpdateTimer(void)
{
    if(USec==99)
    {
        if(Second==59)
        {
            if(Minute==59)
            {
                Hour = (Hour+1)%24;
                lcd_gotoxy(2,0); sprintf(buf,"%02d",Hour); ; lcd_puts(buf);
            }
            Minute = (Minute+1)%60;
            lcd_gotoxy(5,0); sprintf(buf,"%02d",Minute); lcd_puts(buf);
        }
        Second = (Second+1)%60;
        lcd_gotoxy(8,0); sprintf(buf,"%02d",Second); lcd_puts(buf);
    }
    USec = (USec+1)%100;
    lcd_gotoxy(11,0); sprintf(buf,"%02d",USec); lcd_puts(buf);
}

interrupt [EXT_INT0] void ext_int0_isr(void)
{
    if( PINB.4 == 0) // Start
    {
        TimerStatus=2;
    }
    else if(PINB.5 == 0) // STOP
    {
        if(TimerStatus==2)
            TimerStatus=1;
        else if(TimerStatus==1)
        {
            TimerStatus=0;
            Hour = Minute = Second = USec = 0;
            PrintTimer();
        }
    }
}

interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
    TCNT2=0x06; // Reinitialize Timer2 value
    
    if(TimerStatus == 2)
        UpdateTimer();
}

void PrintCapacity(void)
{
    lcd_gotoxy(0,1);
    if(!CurCap)
        sprintf(buf,"CE:FULL"); 
    else
        sprintf(buf,"CE:%4d",CurCap);       
    lcd_puts(buf);
}

interrupt [EXT_INT1] void ext_int1_isr(void)
{
    if( PINB.2 == 0) // CAR_IN
    {
        if(CurCap>0)
            CurCap = CurCap-1;
    }
    else if( PINB.3 == 0) // CAR_OUT
    {
        if(CurCap < MAX_CAP)
            CurCap = CurCap+1;
    }
    PrintCapacity();
}
          
void ChangePeriod(char a)
{
    long int tmp,jozEsahih,diff, val = 1 + 40*a;
     
    
    lcd_gotoxy(8,1); 
    if(val<1000)
        sprintf(buf,"%3dUS00", val); 
    else
    {
        jozEsahih = (val/1000)*1000;
        diff = val-jozEsahih;
        tmp = diff*100/jozEsahih;
        sprintf(buf,"%3dMS%2d", val/1000,tmp);
    }     
    lcd_puts(buf); 
    
    val*=4;
    
    OCR1BH = OCR1AH= ((val-1)>>8)&0xff;
    OCR1BL = OCR1AL=      (val-1)&0xff;

}

