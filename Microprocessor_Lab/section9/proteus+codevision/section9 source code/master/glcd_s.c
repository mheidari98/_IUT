#include <myheader.h>
#include <clock.h>
#include <timer.h>



void glcd_init_func(void)
{
 GLCDINIT_t glcd_init_data;


glcd_init_data.font=font5x7;
glcd_init_data.readxmem=NULL;
glcd_init_data.writexmem=NULL;
glcd_init(&glcd_init_data);



}

/**************************************************/

void clock_display(void)
{
glcd_init_func();
glcd_putimagef(0,0,clock,GLCD_PUTCOPY); 
}
/***********************************************/
void deleteclock(char data,char xxold,char yyold)
 {
 char i,x,y;
 //????????????????????????????
 for (i=1;i<(data+1);i++)
 {
 x=x_center_clock +i*cos6data[xxold]/100;
 y=y_center_clock-i*sin6data[yyold]/100;

 glcd_clrpixel(x,y);
 glcd_clrpixel(x,y+1);
 glcd_clrpixel(x,y-1);

 glcd_clrpixel(x-1,y);
 glcd_clrpixel(x+1,y);
 glcd_clrpixel(x+1,y+1);
 glcd_clrpixel(x+1,y-1);
  }
  }