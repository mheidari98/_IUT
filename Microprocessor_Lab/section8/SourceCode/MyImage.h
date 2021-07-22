#ifndef _MyImage_INCLUDED_
#define _MyImage_INCLUDED_

flash unsigned char img1[]=
{
/* Image width: 128 pixels */
0x80, 0x00,
/* Image height: 64 pixels */
0x40, 0x00,
#ifndef _GLCD_DATA_BYTEY_
/* Image data for monochrome displays organized
   as horizontal rows of bytes */
0x00, 0x0C, 0x00, 0xF8, 0xFD, 0xFD, 0xFC, 0x01, 
0x3F, 0xFF, 0x77, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x04, 0xF8, 0x8F, 0xFE, 0x8F, 0x07, 0xFF, 
0xE1, 0xFF, 0xDF, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x2C, 0x07, 0xFA, 0xFF, 0xFF, 0xFC, 0xFF, 
0xFF, 0xFF, 0x7F, 0x01, 0x00, 0x00, 0x00, 0x00, 
0x00, 0xED, 0xFB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x06, 0x00, 0x00, 0x00, 0x00, 
0x80, 0x6E, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x0F, 0x00, 0x00, 0x00, 0x00, 
0x80, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x1B, 0x00, 0x00, 0x00, 0x00, 
0x40, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x37, 0x00, 0x00, 0x00, 0x00, 
0xC0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x6F, 0x00, 0x00, 0x00, 0x00, 
0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xDF, 0x00, 0x00, 0x00, 0x00, 
0xD0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xBF, 0x01, 0x00, 0x00, 0x00, 
0xD0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x02, 0x00, 0x00, 0x00, 
0xE8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x05, 0x00, 0x00, 0x00, 
0xF4, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x0B, 0x00, 0x00, 0x00, 
0xF4, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x17, 0x00, 0x00, 0x00, 
0xFA, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x2F, 0x00, 0x00, 0x00, 
0xFA, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x2F, 0x00, 0x00, 0x00, 
0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x5F, 0x00, 0x00, 0x00, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x00, 0x00, 0x00, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x01, 0x00, 0xB0, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x03, 0x00, 0x90, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x7F, 0xFF, 0x02, 0x00, 0xF4, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x7F, 0xFF, 0x05, 0x00, 0xF4, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x7F, 0xFD, 0x0B, 0x00, 0xF4, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFA, 0x17, 0x00, 0xF4, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xF6, 0x2F, 0x00, 0xF4, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xED, 0x5F, 0x00, 0xF4, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xDD, 0xBF, 0x00, 0xFA, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xF5, 0x7F, 0x01, 0xFA, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xAB, 0xFF, 0x02, 0xFA, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x4B, 0xFF, 0x05, 0xFA, 
0xFF, 0xDF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x97, 0xFE, 0x1B, 0xFE, 
0xFF, 0xEF, 0xFB, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x17, 0xFD, 0xF7, 0xFD, 
0xFF, 0x17, 0xF6, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFB, 0xFF, 0x2F, 0xFA, 0xDF, 0xFE, 
0xFF, 0x0B, 0xD8, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xF5, 0xFF, 0x5F, 0xF4, 0xFF, 0x7F, 
0xFF, 0x05, 0xB0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xEA, 0xFF, 0x7F, 0xEC, 0xFF, 0x7F, 
0xFF, 0x05, 0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xD3, 0xFF, 0xBF, 0xD8, 0xFF, 0xBF, 
0xF7, 0x02, 0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0x7F, 0xA1, 0xFF, 0x7F, 0xB1, 0xFF, 0xBF, 
0xEC, 0x00, 0xA0, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 
0xFF, 0xBF, 0x40, 0xFF, 0xFF, 0x42, 0xFF, 0xBF, 
0x90, 0x00, 0xD0, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 
0xFF, 0xBF, 0x80, 0xFD, 0xFF, 0x8F, 0xFD, 0x5F, 
0xE0, 0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFE, 0x5F, 0x00, 0xFB, 0xFF, 0x1B, 0xFB, 0x2F, 
0x00, 0x00, 0xE8, 0xFF, 0xFF, 0xFF, 0xFF, 0xBB, 
0xFE, 0x5F, 0x00, 0xFE, 0xFF, 0x1F, 0xFC, 0x17, 
0x00, 0x00, 0xF4, 0xFF, 0xEF, 0xFF, 0xFF, 0x8D, 
0xFE, 0x5F, 0x00, 0xE8, 0xFF, 0x5F, 0x18, 0x0C, 
0x00, 0x00, 0xFA, 0xFF, 0xEF, 0xFF, 0x1F, 0x83, 
0xFE, 0x2F, 0x00, 0xD8, 0xFF, 0x3F, 0xE0, 0x07, 
0x00, 0x00, 0xFA, 0xFF, 0xD7, 0xFF, 0xEB, 0x80, 
0xFE, 0x2F, 0x00, 0x60, 0xFF, 0xBF, 0x00, 0x00, 
0x00, 0x00, 0xFD, 0xFF, 0xB7, 0xFF, 0x1F, 0x80, 
0xFE, 0x2F, 0x00, 0xC0, 0xF9, 0xBF, 0x00, 0x00, 
0x00, 0x80, 0xFE, 0xFF, 0x4B, 0xFF, 0x17, 0x80, 
0xFE, 0x2F, 0x00, 0x00, 0xFE, 0x7F, 0x01, 0x00, 
0x00, 0x80, 0xFE, 0xFF, 0x8B, 0xFE, 0x07, 0x00, 
0xFD, 0x17, 0x00, 0x00, 0xF4, 0x7F, 0x01, 0x00, 
0x00, 0x40, 0xFF, 0xFF, 0x85, 0xFE, 0x2F, 0x00, 
0xFD, 0x17, 0x00, 0x00, 0xE8, 0x7F, 0x01, 0x00, 
0x00, 0x40, 0xFF, 0xFF, 0x82, 0xFE, 0x2F, 0x00, 
0xFD, 0x17, 0x00, 0x00, 0xD0, 0xFF, 0x02, 0x00, 
0x00, 0xA0, 0xFF, 0x7F, 0x01, 0xFD, 0x5F, 0x00, 
0xFA, 0x17, 0x00, 0x00, 0xA0, 0xFF, 0x02, 0x00, 
0x00, 0xD0, 0xFF, 0xBF, 0x00, 0xFD, 0xDF, 0x00, 
0xF8, 0x17, 0x00, 0x00, 0x40, 0xFF, 0x02, 0x00, 
0x00, 0xD0, 0xFF, 0x7F, 0x00, 0xFD, 0xFF, 0x00, 
0xFD, 0x17, 0x00, 0x00, 0x40, 0xFF, 0x0B, 0x00, 
0x00, 0xE8, 0xFF, 0x37, 0x00, 0xFA, 0xFF, 0x02, 
0xFD, 0x17, 0x00, 0x00, 0x80, 0xFE, 0x0B, 0x00, 
0x00, 0xE8, 0xFF, 0x0E, 0x00, 0xF4, 0xFF, 0x01, 
0xFD, 0x17, 0x00, 0x00, 0x00, 0xFD, 0x0B, 0x00, 
0x00, 0xF4, 0x7F, 0x07, 0x00, 0xD8, 0xFF, 0x85, 
0xFE, 0x13, 0x00, 0x00, 0x00, 0xFA, 0x17, 0x00, 
0x00, 0xFA, 0x7F, 0x01, 0x00, 0x60, 0xFF, 0xCB, 
0xFF, 0x0B, 0x00, 0x00, 0x00, 0xF4, 0x17, 0x00, 
0x00, 0xFF, 0xBF, 0x00, 0x00, 0xC0, 0xFF, 0x6B, 
0xFF, 0x05, 0x00, 0x00, 0x00, 0xF4, 0x07, 0x00, 
0xE0, 0xFE, 0x5F, 0x00, 0x00, 0x00, 0xFB, 0xD7, 
0xFF, 0x05, 0x00, 0x00, 0x00, 0xE8, 0x2F, 0x00, 
0x70, 0xFF, 0x2F, 0x00, 0x00, 0x00, 0xF6, 0xF7, 
0xFF, 0x02, 0x00, 0x00, 0x00, 0xE8, 0x2F, 0x00, 
0xF0, 0xFF, 0x17, 0x00, 0x00, 0x00, 0xE8, 0xFF, 
0x7F, 0x01, 0x00, 0x00, 0x00, 0xD0, 0x5F, 0x00, 
0xF4, 0xFF, 0x0B, 0x00, 0x00, 0x00, 0xE0, 0xFF, 
0x7F, 0x01, 0x00, 0x00, 0x00, 0xD0, 0x5F, 0x00, 
0xFA, 0xFF, 0x0B, 0x00, 0x00, 0x00, 0xA0, 0xFE, 
0xBF, 0x00, 0x00, 0x00, 0x00, 0xA0, 0x5F, 0x00, 
0xFA, 0xFF, 0x0B, 0x00, 0x00, 0x00, 0x40, 0xFF, 
0xBF, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 
0xFA, 0xFF, 0x05, 0x00, 0x00, 0x00, 0x40, 0xFF, 
0xBF, 0x00, 0x00, 0x00, 0x00, 0x80, 0x1F, 0x00, 
#else
/* Image data for monochrome displays organized
   as rows of vertical bytes */
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0xB0, 
0xC8, 0xF0, 0xFF, 0xFD, 0xE0, 0xFC, 0xF8, 0xE8, 
0xFC, 0xFC, 0xF4, 0xFA, 0xFA, 0xFA, 0xFA, 0xFA, 
0xFA, 0xFE, 0xFA, 0xFF, 0xFD, 0xFD, 0xFD, 0xFF, 
0xFD, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFE, 0xFF, 0xFF, 0xFD, 0xFD, 0xFD, 0xFF, 
0xFA, 0xFA, 0xFF, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 
0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 
0xFF, 0xFD, 0xFD, 0xFD, 0xFD, 0xFF, 0xFE, 0xFE, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFD, 0xFF, 0xFA, 
0xF4, 0xF8, 0xD8, 0xB0, 0x60, 0xC0, 0x80, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0xC0, 0x30, 0xC8, 0xF6, 0xF9, 0xFE, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFD, 0xFF, 
0xFA, 0xF4, 0xE8, 0xD0, 0x20, 0xC0, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x01, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x8F, 
0x7F, 0xBF, 0x7F, 0xFF, 0xFF, 0xFE, 0xFD, 0xF2, 
0xEC, 0xD8, 0xA0, 0x40, 0x80, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0xF0, 0x00, 0xFC, 0xF4, 0xF0, 0xFC, 
0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0xBF, 0xFF, 0xFF, 
0xBF, 0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFE, 0xF1, 0xCF, 0x36, 0xCD, 0x1B, 0x2F, 0x5F, 
0xBF, 0x7F, 0xFF, 0xFF, 0xFE, 0xFD, 0xFA, 0xF4, 
0xE8, 0xD0, 0xA0, 0x40, 0xC0, 0x80, 0x80, 0x80, 
0x80, 0x7C, 0xC3, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 
0x1F, 0x1F, 0x3F, 0x2F, 0x5F, 0xBF, 0xBF, 0xFF, 
0x0F, 0x13, 0x0D, 0x02, 0x01, 0x00, 0x00, 0x00, 
0x00, 0x01, 0x01, 0x02, 0xC7, 0xBD, 0xC3, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x9F, 
0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x9F, 0x6F, 
0x1B, 0x0D, 0x02, 0x05, 0x0B, 0x17, 0x2F, 0x5F, 
0xFF, 0xBF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFD, 0xF6, 0xE8, 
0xD0, 0xE1, 0x46, 0xCD, 0x9B, 0x17, 0x2F, 0x5F, 
0xFF, 0xBF, 0x7F, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 
0xFE, 0xFF, 0xFF, 0xFF, 0x7F, 0xBF, 0x47, 0x39, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x60, 
0x90, 0xEC, 0xF2, 0xFD, 0xFE, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0x7F, 0x9F, 0x67, 0x19, 0x17, 0x2F, 0xDF, 
0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xF7, 0x9F, 0x37, 0x8B, 0x0B, 0x0B, 
0x07, 0x05, 0x02, 0x03, 0x01, 0x01, 0x00, 0x3F, 
0xC0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0x3F, 0xC3, 0x3C, 0x03, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x01, 0x01, 0x07, 0x05, 0x0B, 0x1F, 0x17, 
0x1F, 0x2F, 0x6F, 0xBF, 0x7F, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFC, 0xE2, 0x18, 
0xE0, 0x00, 0x01, 0x03, 0x03, 0x05, 0x05, 0x05, 
0x05, 0x05, 0x07, 0x02, 0x01, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x80, 0x40, 0xB0, 0xCC, 0xF2, 0xFD, 0xFE, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 
0xDF, 0x7F, 0x7F, 0x2F, 0x1F, 0x1F, 0x0B, 0x05, 
0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 
0x0E, 0x11, 0x2F, 0x5F, 0x7F, 0xBF, 0xFF, 0x7F, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xF9, 0xFE, 0xFC, 
0xE0, 0x90, 0x40, 0x80, 0x00, 0x00, 0x80, 0xC0, 
0xB9, 0xC2, 0xF9, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0x3F, 0x80, 0x7F, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x0D, 0x13, 
0x2F, 0x5F, 0xBF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 
0xF8, 0xFF, 0xC0, 0x38, 0xC0, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0xE0, 0x10, 0xE0, 0xFC, 0xFE, 0xFE, 0xFA, 
0xFD, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0x7F, 0x8F, 0x77, 0x0B, 0x05, 0x02, 0x01, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 
0x03, 0x07, 0x05, 0x0B, 0x07, 0x3F, 0xDF, 0x3F, 
0xDF, 0xFF, 0xFE, 0xF9, 0xFE, 0xFD, 0xFF, 0xFE, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x1F, 0xE7, 
0x1B, 0x04, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x01, 0x06, 0x19, 0x27, 0x5F, 0xBF, 
0xBF, 0xBF, 0xBF, 0xBE, 0xB8, 0x06, 0x38, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
#endif
};

flash unsigned char img2[]=
{
/* Image width: 64 pixels */
0x40, 0x00,
/* Image height: 64 pixels */
0x40, 0x00,
#ifndef _GLCD_DATA_BYTEY_
/* Image data for monochrome displays organized
   as horizontal rows of bytes */
0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0x80, 0x01, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xC0, 0x01, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xC1, 0x03, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xE3, 0x03, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xE7, 0x03, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x03, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x03, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x07, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x0F, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x0F, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFF, 0x0F, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xFC, 0xFF, 0x0F, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 0xFF, 0x0F, 
0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x1F, 
0x00, 0x00, 0x00, 0x00, 0x80, 0xFF, 0xFF, 0x3F, 
0x00, 0x00, 0x00, 0x00, 0x80, 0xFF, 0xFF, 0x7F, 
0x00, 0x00, 0x00, 0x00, 0xC0, 0xFF, 0xFF, 0x7F, 
0x00, 0x00, 0x00, 0x00, 0xE0, 0xFF, 0xFF, 0xFF, 
0x00, 0x00, 0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 
0x00, 0x00, 0x00, 0x00, 0xFE, 0xFF, 0xFF, 0x7F, 
0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x7F, 0x7E, 
0x00, 0x00, 0x00, 0xF0, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x00, 0x00, 0xFE, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x00, 0xC0, 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x00, 0xFE, 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x00, 
0x00, 0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 0x00, 
0x00, 0xE0, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 0x00, 
0x00, 0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 0x00, 
0x00, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 0x00, 
0x00, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 0x1F, 0x00, 
0x00, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x1F, 0x00, 
0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x1F, 0x00, 
0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0F, 0x00, 
0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 
0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 
0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 
0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 
0xC0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x03, 0x00, 
0xC0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x03, 0x00, 
0xE0, 0xFF, 0xFF, 0x1F, 0xE0, 0xFF, 0x03, 0x00, 
0xC0, 0xFF, 0xFF, 0x0F, 0xC0, 0xFF, 0x03, 0x00, 
0xC0, 0xFF, 0xFF, 0x0F, 0x80, 0xFF, 0x03, 0x00, 
0xC0, 0xFF, 0xFF, 0x0F, 0x80, 0xFF, 0x03, 0x00, 
0xC0, 0xFF, 0xFF, 0x0F, 0x80, 0xFF, 0x01, 0x00, 
0xC0, 0xFF, 0xFB, 0x0F, 0xC0, 0xF7, 0x01, 0x00, 
0x80, 0xFF, 0xE7, 0x0F, 0xC0, 0xFF, 0x01, 0x00, 
0x00, 0xFF, 0xE7, 0x1F, 0xC0, 0xFF, 0x01, 0x00, 
0x80, 0xFF, 0xE7, 0x3F, 0xE0, 0xFB, 0x01, 0x00, 
0x80, 0xFF, 0x87, 0x3F, 0xE0, 0xFB, 0x01, 0x00, 
0x80, 0xFF, 0x07, 0x7E, 0xE0, 0xFB, 0x01, 0x00, 
0x80, 0xF7, 0x07, 0xFC, 0xC0, 0xFF, 0x07, 0x00, 
0x80, 0x07, 0x07, 0xFC, 0xF7, 0xFF, 0x1F, 0x00, 
0x80, 0x07, 0xC0, 0xF9, 0xFF, 0xFF, 0x7F, 0x00, 
0x80, 0x07, 0xF8, 0xFD, 0xFF, 0xFF, 0xFF, 0x00, 
0x80, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0F, 
0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0x80, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xE0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xF0, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFC, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
#else
/* Image data for monochrome displays organized
   as rows of vertical bytes */
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFE, 
0xFC, 0xF8, 0xF0, 0xE0, 0xE0, 0xF8, 0xFE, 0xFF, 
0xFF, 0xFC, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 
0xE0, 0xF0, 0xF8, 0xF8, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0xC0, 0x80, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 
0x80, 0xC0, 0xC0, 0xC0, 0xE0, 0xE0, 0xE0, 0xE0, 
0xF0, 0xF8, 0xF8, 0xFC, 0xFC, 0xFE, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x0F, 
0x0F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x06, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x80, 0xC0, 0xE0, 0xF0, 0xF0, 0xF8, 
0xFC, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x07, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xF0, 
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0x7F, 0x07, 0x03, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x7F, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xBF, 0x7F, 0x7F, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0x03, 0x01, 0x01, 0x01, 
0x01, 0x01, 0x01, 0x01, 0x01, 0x03, 0xC7, 0xFF, 
0xFF, 0xFF, 0xFF, 0xBF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0x1F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFE, 
0xFF, 0xFF, 0xFF, 0x0F, 0x1F, 0x1F, 0x1F, 0x1F, 
0x3F, 0x3F, 0x3F, 0x80, 0x80, 0x83, 0xC3, 0xC7, 
0xC7, 0x0F, 0xBF, 0xFF, 0xFF, 0xFE, 0xF8, 0xF0, 
0xE0, 0xE0, 0xE0, 0xC0, 0xE0, 0xEE, 0xFF, 0xFF, 
0xFF, 0xFF, 0xF1, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xF0, 0xF0, 0xE0, 0xE0, 0xC0, 0xC0, 0x80, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
0x00, 0x80, 0xC0, 0xC0, 0xF0, 0xF8, 0xF8, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 
#endif
};

#endif