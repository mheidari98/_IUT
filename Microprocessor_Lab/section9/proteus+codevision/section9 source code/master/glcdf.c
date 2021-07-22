#include <myheader.h>
#include <mandala2.h>

void glcddisplay(void)
{
 GLCDINIT_t glcd_init_data;


glcd_init_data.font=font5x7;
glcd_init_data.readxmem=NULL;
glcd_init_data.writexmem=NULL;
glcd_init(&glcd_init_data);


glcd_putimagef(0,0,mandalapic,GLCD_PUTCOPY);


}
void glcd_init_func(void)
{
 GLCDINIT_t glcd_init_data;


glcd_init_data.font=font5x7;
glcd_init_data.readxmem=NULL;
glcd_init_data.writexmem=NULL;
glcd_init(&glcd_init_data);

//glcd_putimagef(0,0,mandalapic,GLCD_PUTCOPY);

}

void glcddisplay2(void)
{
 GLCDINIT_t glcd_init_data;


glcd_init_data.font=font5x7;
glcd_init_data.readxmem=NULL;
glcd_init_data.writexmem=NULL;
glcd_init(&glcd_init_data);

glcd_putimagee(0,0,data_rec,GLCD_PUTCOPY);

}

//void clock_display(void)
//{
//glcd_init_func();
//glcd_putimagef(0,0,clock,GLCD_PUTCOPY); 
//}
