
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _adc_old_data=R4
	.DEF _adc_old_data_msb=R5
	.DEF _rx_wr_index=R7
	.DEF _rx_rd_index=R6
	.DEF _rx_counter=R8
	.DEF _rx_counter_msb=R9
	.DEF _tx_wr_index=R11
	.DEF _tx_rd_index=R10
	.DEF _tx_counter=R12
	.DEF _tx_counter_msb=R13

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _spi_isr
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  _adc_isr
	JMP  0x00
	JMP  0x00
	JMP  _twi_int_handler
	JMP  0x00
	JMP  0x00
	JMP  0x00

_font5x7:
	.DB  0x5,0x7,0x20,0x60,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x5F,0x0,0x0,0x0,0x7
	.DB  0x0,0x7,0x0,0x14,0x7F,0x14,0x7F,0x14
	.DB  0x24,0x2A,0x7F,0x2A,0x12,0x23,0x13,0x8
	.DB  0x64,0x62,0x36,0x49,0x55,0x22,0x50,0x0
	.DB  0x5,0x3,0x0,0x0,0x0,0x1C,0x22,0x41
	.DB  0x0,0x0,0x41,0x22,0x1C,0x0,0x8,0x2A
	.DB  0x1C,0x2A,0x8,0x8,0x8,0x3E,0x8,0x8
	.DB  0x0,0x50,0x30,0x0,0x0,0x8,0x8,0x8
	.DB  0x8,0x8,0x0,0x30,0x30,0x0,0x0,0x20
	.DB  0x10,0x8,0x4,0x2,0x3E,0x51,0x49,0x45
	.DB  0x3E,0x0,0x42,0x7F,0x40,0x0,0x42,0x61
	.DB  0x51,0x49,0x46,0x21,0x41,0x45,0x4B,0x31
	.DB  0x18,0x14,0x12,0x7F,0x10,0x27,0x45,0x45
	.DB  0x45,0x39,0x3C,0x4A,0x49,0x49,0x30,0x1
	.DB  0x71,0x9,0x5,0x3,0x36,0x49,0x49,0x49
	.DB  0x36,0x6,0x49,0x49,0x29,0x1E,0x0,0x36
	.DB  0x36,0x0,0x0,0x0,0x56,0x36,0x0,0x0
	.DB  0x0,0x8,0x14,0x22,0x41,0x14,0x14,0x14
	.DB  0x14,0x14,0x41,0x22,0x14,0x8,0x0,0x2
	.DB  0x1,0x51,0x9,0x6,0x32,0x49,0x79,0x41
	.DB  0x3E,0x7E,0x11,0x11,0x11,0x7E,0x7F,0x49
	.DB  0x49,0x49,0x36,0x3E,0x41,0x41,0x41,0x22
	.DB  0x7F,0x41,0x41,0x22,0x1C,0x7F,0x49,0x49
	.DB  0x49,0x41,0x7F,0x9,0x9,0x1,0x1,0x3E
	.DB  0x41,0x41,0x51,0x32,0x7F,0x8,0x8,0x8
	.DB  0x7F,0x0,0x41,0x7F,0x41,0x0,0x20,0x40
	.DB  0x41,0x3F,0x1,0x7F,0x8,0x14,0x22,0x41
	.DB  0x7F,0x40,0x40,0x40,0x40,0x7F,0x2,0x4
	.DB  0x2,0x7F,0x7F,0x4,0x8,0x10,0x7F,0x3E
	.DB  0x41,0x41,0x41,0x3E,0x7F,0x9,0x9,0x9
	.DB  0x6,0x3E,0x41,0x51,0x21,0x5E,0x7F,0x9
	.DB  0x19,0x29,0x46,0x46,0x49,0x49,0x49,0x31
	.DB  0x1,0x1,0x7F,0x1,0x1,0x3F,0x40,0x40
	.DB  0x40,0x3F,0x1F,0x20,0x40,0x20,0x1F,0x7F
	.DB  0x20,0x18,0x20,0x7F,0x63,0x14,0x8,0x14
	.DB  0x63,0x3,0x4,0x78,0x4,0x3,0x61,0x51
	.DB  0x49,0x45,0x43,0x0,0x0,0x7F,0x41,0x41
	.DB  0x2,0x4,0x8,0x10,0x20,0x41,0x41,0x7F
	.DB  0x0,0x0,0x4,0x2,0x1,0x2,0x4,0x40
	.DB  0x40,0x40,0x40,0x40,0x0,0x1,0x2,0x4
	.DB  0x0,0x20,0x54,0x54,0x54,0x78,0x7F,0x48
	.DB  0x44,0x44,0x38,0x38,0x44,0x44,0x44,0x20
	.DB  0x38,0x44,0x44,0x48,0x7F,0x38,0x54,0x54
	.DB  0x54,0x18,0x8,0x7E,0x9,0x1,0x2,0x8
	.DB  0x14,0x54,0x54,0x3C,0x7F,0x8,0x4,0x4
	.DB  0x78,0x0,0x44,0x7D,0x40,0x0,0x20,0x40
	.DB  0x44,0x3D,0x0,0x0,0x7F,0x10,0x28,0x44
	.DB  0x0,0x41,0x7F,0x40,0x0,0x7C,0x4,0x18
	.DB  0x4,0x78,0x7C,0x8,0x4,0x4,0x78,0x38
	.DB  0x44,0x44,0x44,0x38,0x7C,0x14,0x14,0x14
	.DB  0x8,0x8,0x14,0x14,0x18,0x7C,0x7C,0x8
	.DB  0x4,0x4,0x8,0x48,0x54,0x54,0x54,0x20
	.DB  0x4,0x3F,0x44,0x40,0x20,0x3C,0x40,0x40
	.DB  0x20,0x7C,0x1C,0x20,0x40,0x20,0x1C,0x3C
	.DB  0x40,0x30,0x40,0x3C,0x44,0x28,0x10,0x28
	.DB  0x44,0xC,0x50,0x50,0x50,0x3C,0x44,0x64
	.DB  0x54,0x4C,0x44,0x0,0x8,0x36,0x41,0x0
	.DB  0x0,0x0,0x7F,0x0,0x0,0x0,0x41,0x36
	.DB  0x8,0x0,0x2,0x1,0x2,0x4,0x2,0x7F
	.DB  0x41,0x41,0x41,0x7F
_mandalapic:
	.DB  0x80,0x0,0x40,0x0,0xFE,0xFE,0xFE,0xFC
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0x9F,0xB,0x37,0xE7,0x9F
	.DB  0xCF,0xE9,0xF2,0xFE,0x3D,0xBE,0xDF,0xFF
	.DB  0xFF,0xBF,0x7D,0xF1,0xEB,0xCB,0xED,0x8E
	.DB  0x75,0xEC,0xB7,0xD4,0x5D,0x1B,0xB7,0x9F
	.DB  0xFE,0xFF,0xFC,0xF2,0xEF,0xFF,0xFF,0xFF
	.DB  0xF5,0xE2,0xF2,0xFF,0x3F,0x5F,0x5F,0x2F
	.DB  0xBF,0xB7,0x23,0x5F,0x5B,0x7,0xB7,0xBF
	.DB  0xB7,0xEF,0xDF,0x3F,0x5F,0x3E,0x3D,0xFF
	.DB  0x1F,0xBF,0x1E,0x6F,0xBE,0x9E,0x6F,0x1F
	.DB  0xFF,0x9D,0x3C,0x7A,0x7D,0xFF,0xF7,0xEF
	.DB  0xD3,0xCD,0xFB,0xFF,0x3E,0x5C,0xB9,0x7B
	.DB  0xFE,0x7F,0xFF,0xFF,0xF6,0xD3,0xED,0xFC
	.DB  0xFF,0xFF,0xFF,0xEF,0xF7,0xE7,0xF7,0xFF
	.DB  0xFF,0xE9,0xE6,0xFD,0x7F,0xBF,0x3F,0xFF
	.DB  0xDF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0x81,0xE4,0xFB,0x4,0x3
	.DB  0xF8,0xF3,0xFF,0xFF,0xFD,0xFF,0xFB,0xF7
	.DB  0xFB,0xFB,0xE1,0xFC,0xE5,0xC3,0xB7,0xA7
	.DB  0xDF,0x5E,0xFC,0xFB,0xFD,0xFF,0xDF,0x37
	.DB  0xCB,0x9,0xF5,0x90,0xDF,0xD9,0xD,0xEC
	.DB  0xAF,0xA9,0x4F,0xD2,0xD7,0xEF,0xEB,0xF7
	.DB  0xFA,0xFD,0x7B,0xFB,0xFD,0xFD,0xFE,0xFE
	.DB  0xFF,0xFE,0xFE,0xFF,0xFE,0xEF,0x7F,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFE,0xFF,0xFF,0x7F
	.DB  0x3C,0x7C,0xBF,0xFC,0xF9,0xFC,0xF8,0xFF
	.DB  0xFF,0x3F,0x4F,0x9B,0x64,0x93,0xF8,0xFD
	.DB  0xFF,0xFB,0x7C,0x7A,0xFD,0xFB,0xF5,0xE5
	.DB  0xF1,0xD1,0xE7,0xE3,0xEB,0xBB,0xB3,0xD7
	.DB  0x53,0x77,0x37,0x8E,0xDE,0x1F,0x9F,0xBF
	.DB  0x3F,0x3F,0xFF,0x7F,0xE7,0xFF,0xEF,0xEF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0x3F,0xE1,0x27,0xF8,0x7E
	.DB  0x60,0x6F,0x1F,0xFC,0xFF,0xF7,0xFF,0x77
	.DB  0xFE,0xF6,0xEE,0xF6,0xF7,0xE9,0xE7,0xFF
	.DB  0xE7,0xF7,0xF7,0x7F,0xFF,0xBF,0x5E,0x2A
	.DB  0x55,0x37,0x88,0x66,0xD2,0xFE,0xF0,0xFC
	.DB  0xFE,0xBE,0x7F,0xCF,0xF7,0xF7,0xFB,0xFF
	.DB  0xFB,0xFB,0xF3,0xF7,0xFF,0xBF,0xAF,0x97
	.DB  0xEF,0xF5,0xFB,0xFC,0xFF,0xFD,0xFE,0xFD
	.DB  0xFE,0xFF,0xFD,0x77,0x33,0x7F,0xFF,0x3E
	.DB  0xFF,0xFF,0xFF,0x3F,0x5F,0x67,0xB5,0x6A
	.DB  0xD1,0xED,0xFB,0x7E,0x9F,0xBF,0xAF,0x63
	.DB  0xBC,0x6E,0x9D,0x35,0xCA,0x6A,0xF5,0xFD
	.DB  0x4A,0x4C,0x4B,0xB,0x3D,0xF5,0xF3,0xC3
	.DB  0xCF,0xD7,0x6F,0x56,0x1F,0xAF,0xDF,0xBC
	.DB  0xFB,0xF9,0xF6,0xC9,0xBE,0x1A,0x5F,0xED
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xE0,0xAF,0x30,0xBF,0x4C
	.DB  0xD0,0xCF,0xBF,0xBF,0xBF,0xFE,0xFF,0xFF
	.DB  0xFF,0xFF,0xF2,0xF3,0x74,0xFC,0xFF,0xFF
	.DB  0xF,0x63,0x15,0xCB,0x74,0xB2,0x90,0xD1
	.DB  0xFA,0xFF,0xFE,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xF4,0xEF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0x5F,0x4F,0xC7,0xEF,0xF7,0xFB,0xFB
	.DB  0xFB,0xFB,0xFD,0xF9,0xF7,0xEB,0xF7,0xEF
	.DB  0xDF,0xDD,0xFD,0xFE,0xFF,0xFF,0xFF,0xFF
	.DB  0xBF,0x31,0x8A,0xB9,0xC6,0xF2,0xFE,0x3F
	.DB  0xDF,0xB3,0xCD,0x44,0xFE,0x9B,0xC4,0x7B
	.DB  0x8D,0x6C,0x91,0x9B,0x3F,0xDF,0x7E,0xF4
	.DB  0xE3,0xC8,0x4A,0xC3,0x3,0x78,0x4,0xFE
	.DB  0xFE,0xFC,0xF3,0xC9,0xD,0xCE,0xCC,0xEF
	.DB  0xE8,0xD6,0xED,0xCB,0xCF,0xEF,0xC3,0x6B
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0xFC,0xFF
	.DB  0xFE,0xFA,0x65,0x17,0xB0,0x8F,0xFF,0xFF
	.DB  0xFE,0xFF,0xF7,0xFF,0x7B,0x7F,0xBF,0xFF
	.DB  0xFC,0xF8,0xF3,0x89,0xB4,0x5B,0xA4,0xFE
	.DB  0xFF,0xFF,0xFF,0xBF,0xFF,0xFF,0x5F,0xAF
	.DB  0xEB,0xF3,0xFD,0xFD,0xFC,0xFE,0xFF,0xFF
	.DB  0xCC,0x52,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xBF,0x3F,0x47,0xCB,0xE3,0xFD,0xF3,0xFD
	.DB  0xF8,0xFD,0xFA,0xFA,0xFF,0xFF,0x4F,0x3C
	.DB  0x2,0x1B,0xC5,0xFE,0xFF,0x1F,0xCC,0x33
	.DB  0xE6,0x76,0x9A,0x62,0xDB,0xB4,0xEF,0xDE
	.DB  0xB9,0x73,0xEC,0xF1,0x82,0x4B,0xB4,0x2F
	.DB  0xFF,0xFF,0xFC,0xE1,0x9E,0xF0,0x8A,0x27
	.DB  0xFF,0xFF,0xC8,0x37,0x14,0x7C,0xEC,0xFF
	.DB  0x3F,0xAB,0x44,0xCB,0xFF,0xFD,0xF5,0xFB
	.DB  0xFE,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xBF,0x7F,0x9F,0xEF,0xD3
	.DB  0xE9,0xFD,0x79,0xBF,0xFD,0x7C,0xAE,0xFE
	.DB  0xFF,0xFF,0xDF,0x67,0x32,0x9,0xE7,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF3,0xEA
	.DB  0xDF,0x9F,0x7F,0xFF,0xFF,0xBF,0x37,0xEB
	.DB  0xF7,0xFF,0xFE,0xFC,0xFD,0xFF,0xFF,0xEF
	.DB  0xCA,0xC7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF3,0x7B
	.DB  0x95,0x6B,0x90,0xDF,0xFF,0xFE,0xD4,0x68
	.DB  0x34,0x56,0xAD,0x5F,0x7A,0xB5,0x79,0xE4
	.DB  0xFA,0xF1,0xCE,0xB7,0xAF,0x3F,0xDF,0x7D
	.DB  0xFA,0xF9,0xCF,0xDF,0xFF,0xFE,0x7D,0xF3
	.DB  0x3F,0xBF,0x79,0xB0,0xB3,0x7F,0xFF,0xE7
	.DB  0xFC,0xFC,0xFE,0x7F,0x7F,0xFF,0xF6,0x3D
	.DB  0x86,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xF6,0xFA,0xFF,0x5F,0xE7,0x2F
	.DB  0xD7,0xF2,0xFC,0x7D,0x1C,0x3F,0x7,0xAF
	.DB  0xDF,0xFF,0xFE,0xFD,0xF1,0xDC,0xB1,0xB
	.DB  0xDF,0x7F,0xFF,0xFF,0xE7,0xFF,0xF9,0xFF
	.DB  0xFF,0x7F,0x7F,0xBF,0xDF,0x1E,0x2E,0xDF
	.DB  0x67,0xF,0xB3,0xB7,0xC7,0xE3,0xED,0xE5
	.DB  0xF3,0xF7,0xF4,0xF8,0xE3,0x61,0x6D,0xFC
	.DB  0xF2,0xE2,0xED,0xD1,0xCB,0xBF,0xFF,0xFE
	.DB  0xF1,0xEE,0x5B,0x54,0xAB,0xB7,0xEF,0xFF
	.DB  0xFE,0xF3,0xFC,0x38,0x7B,0xBD,0xF8,0x7A
	.DB  0xBD,0xBB,0xFF,0x7B,0xE7,0xEF,0xFE,0xFF
	.DB  0xAF,0x83,0x6D,0x4B,0x56,0x7D,0xAB,0xA6
	.DB  0x68,0x6A,0x84,0xB4,0x9B,0xB0,0xFD,0xCC
	.DB  0xA3,0xB3,0x6F,0x1F,0xFE,0xFF,0xFF,0xFE
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
	.DB  0xFF,0xFF,0x4B,0xA,0x74,0xF3,0xFC,0x3F
	.DB  0xB7,0xF5,0x8A,0xE5,0xFB,0xFF,0x3F,0xFF
	.DB  0xEB,0xF2,0xFB,0x77,0xB7,0x3F,0xFF,0xBF
	.DB  0x3E,0x9E,0xAF,0x4F,0xD7,0xB3,0xE9,0xE6
	.DB  0xE2,0xF2,0x75,0xF8,0x3E,0xDD,0x2E,0xAF
	.DB  0xD7,0x2F,0xBF,0x3,0x6D,0x45,0xD3,0x93
	.DB  0xF5,0x5D,0x8A,0xAA,0x6D,0xDD,0xB2,0x6A
	.DB  0xDC,0x7A,0xEC,0xE1,0xD3,0x2B,0xF3,0x2B
	.DB  0xC7,0xFF,0xFF,0xFF,0x5F,0x9F,0x4B,0x91
	.DB  0x69,0x2A,0x6D,0x35,0xDD,0x6C,0x36,0x9A
	.DB  0x71,0x63,0xF4,0x99,0xE6,0xC9,0xEF,0xFF
	.DB  0xFE,0xF6,0xAB,0x95,0xF9,0xFF,0xBC,0xFE
	.DB  0x2F,0x57,0xE3,0xE7,0xFF,0xF1,0xF5,0xEB
	.DB  0xDF,0xE3,0x97,0x2F
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0
__glcd_mask:
	.DB  0x0,0x1,0x3,0x7,0xF,0x1F,0x3F,0x7F
	.DB  0xFF

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0002

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x0:
	.DB  0x48,0x65,0x6C,0x6C,0x6F,0x2C,0x20,0x20
	.DB  0x57,0x65,0x6C,0x63,0x6F,0x6D,0x65,0x20
	.DB  0x74,0x6F,0x20,0x6C,0x61,0x73,0x74,0x20
	.DB  0x6F,0x6E,0x6C,0x69,0x6E,0x65,0x20,0x63
	.DB  0x6C,0x61,0x73,0x73,0x20,0x69,0x6E,0x20
	.DB  0x31,0x33,0x39,0x39,0xD,0xA,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x2A,0x2A,0x2A,0x20,0x20,0x20,0x20
	.DB  0x20,0x4D,0x41,0x53,0x54,0x45,0x52,0x20
	.DB  0x4D,0x49,0x43,0x52,0x4F,0x20,0x20,0x20
	.DB  0x20,0x2A,0x2A,0x2A,0xD,0xD,0xD,0xA
	.DB  0x0,0x57,0x20,0x45,0x45,0x50,0x52,0x4F
	.DB  0x4D,0xD,0xA,0x0,0x52,0x20,0x45,0x45
	.DB  0x50,0x52,0x4F,0x4D,0xD,0xA,0x0,0x44
	.DB  0x69,0x73,0x70,0x6C,0x61,0x79,0xD,0xA
	.DB  0x0,0xD,0xA,0x20,0x53,0x65,0x6E,0x64
	.DB  0x69,0x6E,0x67,0x20,0x3A,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x0,0x25,0x64,0x20
	.DB  0x20,0x20,0x20,0x0,0xD,0xA,0x20,0x52
	.DB  0x65,0x63,0x65,0x69,0x76,0x69,0x6E,0x67
	.DB  0x20,0x3A,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x0
_0x20000:
	.DB  0xD,0xA,0x20,0x41,0x44,0x43,0x30,0x3D
	.DB  0x25,0x64,0xD,0xA,0x0
_0x40003:
	.DB  0x63,0x0,0x63
_0x40000:
	.DB  0xD,0xA,0x20,0x41,0x44,0x43,0x30,0x3D
	.DB  0x25,0x64,0x20,0x61,0x70,0x64,0x61,0x74
	.DB  0x65,0x64,0x21,0x21,0x20,0xD,0xA,0x0
_0xE0000:
	.DB  0x65,0x72,0x72,0x6F,0x72,0x20,0x5B,0x25
	.DB  0x64,0x5D,0x3D,0x25,0x64,0xD,0xA,0x0
	.DB  0x65,0x72,0x72,0x6F,0x72,0x20,0x5B,0x25
	.DB  0x64,0x5D,0x3D,0x25,0x64,0x2D,0x2D,0x25
	.DB  0x64,0xD,0xA,0x0,0x64,0x61,0x74,0x61
	.DB  0x20,0x63,0x6F,0x72,0x72,0x65,0x63,0x74
	.DB  0xD,0xA,0x0
_0x2020003:
	.DB  0x7
_0x20C0060:
	.DB  0x1
_0x20C0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x59
	.DW  _0x3
	.DW  _0x0*2

	.DW  0x0B
	.DW  _0x3+89
	.DW  _0x0*2+89

	.DW  0x0B
	.DW  _0x3+100
	.DW  _0x0*2+100

	.DW  0x0A
	.DW  _0x3+111
	.DW  _0x0*2+111

	.DW  0x14
	.DW  _0x3+121
	.DW  _0x0*2+121

	.DW  0x16
	.DW  _0x3+141
	.DW  _0x0*2+148

	.DW  0x03
	.DW  _data_spi
	.DW  _0x40003*2

	.DW  0x01
	.DW  _twi_result
	.DW  _0x2020003*2

	.DW  0x01
	.DW  __seed_G106
	.DW  _0x20C0060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;
;#include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <i2c_e.h>
;#include <mandala2.h>
;#include <glcdf.h>
;
;void main(void)
; 0000 0008 {

	.CSEG
_main:
; .FSTART _main
; 0000 0009 
; 0000 000A 
; 0000 000B     int i;
; 0000 000C     char buffer[12];
; 0000 000D 
; 0000 000E     port_init();
	SBIW R28,12
;	i -> R16,R17
;	buffer -> Y+0
	CALL _port_init
; 0000 000F     spi_init();
	CALL _spi_init
; 0000 0010     uart_init();
	CALL _uart_init
; 0000 0011 
; 0000 0012 
; 0000 0013 
; 0000 0014     puts("Hello,  Welcome to last online class in 1399\r\n           ***     MASTER MICRO    ***\r\r\r\n");
	__POINTW2MN _0x3,0
	CALL _puts
; 0000 0015     adc_init_no_intterupt();
	RCALL _adc_init_no_intterupt
; 0000 0016 
; 0000 0017 
; 0000 0018     #asm("sei")
	sei
; 0000 0019 
; 0000 001A 
; 0000 001B     glcddisplay();
	CALL _glcddisplay
; 0000 001C     delay_ms(1000);
	LDI  R26,LOW(1000)
	LDI  R27,HIGH(1000)
	CALL _delay_ms
; 0000 001D 
; 0000 001E     puts("W EEPROM\r\n");
	__POINTW2MN _0x3,89
	CALL _puts
; 0000 001F     i2c_24lc32_frame();   //write to eeprom
	CALL _i2c_24lc32_frame
; 0000 0020 
; 0000 0021     puts("R EEPROM\r\n");
	__POINTW2MN _0x3,100
	CALL _puts
; 0000 0022     puts("Display\r\n");
	__POINTW2MN _0x3,111
	CALL _puts
; 0000 0023 
; 0000 0024     i2c_24lc32_read_frame();  //read eeprom
	CALL _i2c_24lc32_read_frame
; 0000 0025 
; 0000 0026 
; 0000 0027     while (1)
_0x4:
; 0000 0028     {
; 0000 0029         I2C_Init2();
	CALL _I2C_Init2
; 0000 002A         puts( "\r\n Sending :       ");
	__POINTW2MN _0x3,121
	CALL _puts
; 0000 002B         I2C_Start_Wait(Slave_Write_Address);/* Start I2C communication with SLA+W */
	LDI  R26,LOW(32)
	CALL _I2C_Start_Wait
; 0000 002C 		delay_ms(5);
	CALL SUBOPT_0x0
; 0000 002D 		for ( i = 0; i < count ; i++)
_0x8:
	__CPWRN 16,17,10
	BRGE _0x9
; 0000 002E 		{
; 0000 002F 			sprintf(buffer, "%d    ",i);
	CALL SUBOPT_0x1
	MOVW R30,R16
	CALL SUBOPT_0x2
; 0000 0030 			puts(buffer);
; 0000 0031 			I2C_Write2(i);					/* Send Incrementing count */
	MOV  R26,R16
	CALL _I2C_Write2
; 0000 0032 			delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 0033 		}
	__ADDWRN 16,17,1
	RJMP _0x8
_0x9:
; 0000 0034 		puts("\r\n Receiving :       ");
	__POINTW2MN _0x3,141
	CALL _puts
; 0000 0035 		I2C_Repeated_Start(Slave_Read_Address);	/* Repeated Start I2C communication with SLA+R */
	LDI  R26,LOW(33)
	CALL _I2C_Repeated_Start
; 0000 0036 		delay_ms(5);
	CALL SUBOPT_0x0
; 0000 0037 		for ( i = 0; i < count; i++)
_0xB:
	__CPWRN 16,17,10
	BRGE _0xC
; 0000 0038 		{
; 0000 0039 			if(i < count - 1)
	__CPWRN 16,17,9
	BRGE _0xD
; 0000 003A 				sprintf(buffer, "%d    ", I2C_Read_Ack());/* Read and send Acknowledge of data */
	CALL SUBOPT_0x1
	CALL _I2C_Read_Ack
	RJMP _0x10
; 0000 003B 			else
_0xD:
; 0000 003C 				sprintf(buffer, "%d    ", I2C_Read_Nack());/* Read and Not Acknowledge to data */
	CALL SUBOPT_0x1
	CALL _I2C_Read_Nack
_0x10:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0000 003D 			puts(buffer);
	MOVW R26,R28
	CALL _puts
; 0000 003E 			delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 003F 		}
	__ADDWRN 16,17,1
	RJMP _0xB
_0xC:
; 0000 0040 		I2C_Stop2();   /* Stop I2C */
	CALL _I2C_Stop2
; 0000 0041         adc_send_to_spi();	// check the adc value change
	RCALL _adc_send_to_spi
; 0000 0042 	}
	RJMP _0x4
; 0000 0043 }
_0xF:
	RJMP _0xF
; .FEND

	.DSEG
_0x3:
	.BYTE 0xA3
;
;
;
;
;
; #include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;
;int adc_old_data=0;
;
;unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
;
;
;// ADC interrupt service routine
;// with auto input scanning
;interrupt [ADC_INT] void adc_isr(void)
; 0001 000F {

	.CSEG
_adc_isr:
; .FSTART _adc_isr
	ST   -Y,R24
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0001 0010 static unsigned char input_index=0;
; 0001 0011 // Read the AD conversion result
; 0001 0012 adc_data[input_index]=ADCW;
	LDS  R30,_input_index_S0010000000
	LDI  R26,LOW(_adc_data)
	LDI  R27,HIGH(_adc_data)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	IN   R30,0x4
	IN   R31,0x4+1
	ST   X+,R30
	ST   X,R31
; 0001 0013 // Select next ADC input
; 0001 0014 if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT))
	LDS  R26,_input_index_S0010000000
	SUBI R26,-LOW(1)
	STS  _input_index_S0010000000,R26
	CPI  R26,LOW(0x1)
	BRLO _0x20003
; 0001 0015    input_index=0;
	LDI  R30,LOW(0)
	STS  _input_index_S0010000000,R30
; 0001 0016 ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
_0x20003:
	LDS  R30,_input_index_S0010000000
	SUBI R30,-LOW(64)
	OUT  0x7,R30
; 0001 0017 // Delay needed for the stabilization of the ADC input voltage
; 0001 0018 delay_us(10);
	__DELAY_USB 27
; 0001 0019 // Start the AD conversion
; 0001 001A ADCSRA|=(1<<ADSC);
	SBI  0x6,6
; 0001 001B 
; 0001 001C }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R24,Y+
	RETI
; .FEND
;
; void adc_send_to_spi(void)
; 0001 001F 
; 0001 0020  { char scr[20];
_adc_send_to_spi:
; .FSTART _adc_send_to_spi
; 0001 0021  adc_data[0]= read_adc(0);
	SBIW R28,20
;	scr -> Y+0
	LDI  R26,LOW(0)
	RCALL _read_adc
	STS  _adc_data,R30
	STS  _adc_data+1,R31
; 0001 0022  if (adc_data[0]!=  adc_old_data)
	LDS  R26,_adc_data
	LDS  R27,_adc_data+1
	CP   R4,R26
	CPC  R5,R27
	BREQ _0x20004
; 0001 0023 {
; 0001 0024     SPDR=adc_data[0]&0x00ff;
	LDS  R30,_adc_data
	OUT  0xF,R30
; 0001 0025     delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0001 0026     SPDR=adc_data[0]>>8;
	LDS  R30,_adc_data+1
	ANDI R31,HIGH(0x0)
	OUT  0xF,R30
; 0001 0027     adc_old_data=adc_data[0];
	__GETWRMN 4,5,0,_adc_data
; 0001 0028     sprintf(scr,"\r\n ADC0=%d\r\n",adc_old_data);
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x20000,0
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R4
	CALL SUBOPT_0x2
; 0001 0029     puts(scr);
; 0001 002A }
; 0001 002B }
_0x20004:
	JMP  _0x214000E
; .FEND
;
;
;
;
;void adc_init_no_intterupt(void)
; 0001 0031 {
_adc_init_no_intterupt:
; .FSTART _adc_init_no_intterupt
; 0001 0032 ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
	LDI  R30,LOW(64)
	OUT  0x7,R30
; 0001 0033 ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(231)
	OUT  0x6,R30
; 0001 0034 SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0001 0035 
; 0001 0036 }
	RET
; .FEND
;
;
;void adc_init_interrupt(void)
; 0001 003A {
; 0001 003B ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
; 0001 003C ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
; 0001 003D SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
; 0001 003E 
; 0001 003F }
;
;
;
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0001 0046 {
_read_adc:
; .FSTART _read_adc
; 0001 0047 ADMUX=adc_input | ADC_VREF_TYPE;
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,0x40
	OUT  0x7,R30
; 0001 0048 // Delay needed for the stabilization of the ADC input voltage
; 0001 0049 delay_us(10);
	__DELAY_USB 27
; 0001 004A // Start the AD conversion
; 0001 004B ADCSRA|=(1<<ADSC);
	SBI  0x6,6
; 0001 004C // Wait for the AD conversion to complete
; 0001 004D while ((ADCSRA & (1<<ADIF))==0);
_0x20005:
	SBIS 0x6,4
	RJMP _0x20005
; 0001 004E ADCSRA|=(1<<ADIF);
	SBI  0x6,4
; 0001 004F return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	JMP  _0x214000B
; 0001 0050 }
; .FEND
;
; #include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
; int data_spi[2]={99,99};

	.DSEG
; char num_data_spi=0;
; bit new_data_spi=0;
; bit master_micro=1;
;
; void spi_init(void)
; 0002 000A {

	.CSEG
_spi_init:
; .FSTART _spi_init
; 0002 000B // SPI initialization
; 0002 000C // SPI Type: Master
; 0002 000D // SPI Clock Rate: 2000.000 kHz
; 0002 000E // SPI Clock Phase: Cycle Start
; 0002 000F // SPI Clock Polarity: Low
; 0002 0010 // SPI Data Order: MSB First
; 0002 0011 SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (1<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(208)
	OUT  0xD,R30
; 0002 0012 SPSR=(0<<SPI2X);
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0002 0013 
; 0002 0014 // Clear the SPI interrupt flag
; 0002 0015 #asm
; 0002 0016     in   r30,spsr
    in   r30,spsr
; 0002 0017     in   r30,spdr
    in   r30,spdr
; 0002 0018 #endasm
; 0002 0019 
; 0002 001A 
; 0002 001B }
	RET
; .FEND
; void spi_init_slave(void)
; 0002 001D {
; 0002 001E 
; 0002 001F 
; 0002 0020 
; 0002 0021 // SPI initialization
; 0002 0022 // SPI Type: Slave
; 0002 0023 // SPI Clock Rate: 2000.000 kHz
; 0002 0024 // SPI Clock Phase: Cycle Start
; 0002 0025 // SPI Clock Polarity: Low
; 0002 0026 // SPI Data Order: MSB First
; 0002 0027 SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
; 0002 0028 SPSR=(0<<SPI2X);
; 0002 0029 
; 0002 002A #asm
; 0002 002B     in   r30,spsr
; 0002 002C     in   r30,spdr
; 0002 002D #endasm
; 0002 002E 
; 0002 002F 
; 0002 0030 
; 0002 0031 }
;
;interrupt [SPI_STC] void spi_isr(void)
; 0002 0034 {
_spi_isr:
; .FSTART _spi_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0002 0035 //unsigned char data;
; 0002 0036 //data_spi[0]=SPDR;
; 0002 0037 char scr[20];
; 0002 0038 
; 0002 0039 
; 0002 003A data_spi[num_data_spi]=SPDR;
	SBIW R28,20
;	scr -> Y+0
	LDS  R30,_num_data_spi
	LDI  R26,LOW(_data_spi)
	LDI  R27,HIGH(_data_spi)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	IN   R30,0xF
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 0002 003B num_data_spi++;
	LDS  R30,_num_data_spi
	SUBI R30,-LOW(1)
	STS  _num_data_spi,R30
; 0002 003C if (num_data_spi==2)
	LDS  R26,_num_data_spi
	CPI  R26,LOW(0x2)
	BRNE _0x40004
; 0002 003D {
; 0002 003E new_data_spi=1;
	SET
	BLD  R2,0
; 0002 003F num_data_spi=0;
	LDI  R30,LOW(0)
	STS  _num_data_spi,R30
; 0002 0040 }
; 0002 0041 if (master_micro==0)
_0x40004:
	SBRC R2,1
	RJMP _0x40005
; 0002 0042 {
; 0002 0043             if (new_data_spi==1)
	SBRS R2,0
	RJMP _0x40006
; 0002 0044        {
; 0002 0045        sprintf(scr,"\r\n ADC0=%d apdated!! \r\n",((data_spi[0]&0x00ff)|(data_spi[1]<<8)));
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x40000,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_data_spi
	LDS  R31,_data_spi+1
	ANDI R31,HIGH(0xFF)
	MOVW R26,R30
	__GETB1HMN _data_spi,2
	LDI  R30,LOW(0)
	OR   R30,R26
	OR   R31,R27
	CALL SUBOPT_0x2
; 0002 0046         puts(scr);
; 0002 0047        new_data_spi=0;
	CLT
	BLD  R2,0
; 0002 0048        }
; 0002 0049  }
_0x40006:
; 0002 004A }
_0x40005:
	ADIW R28,20
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
; #include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;void port_init(void)
; 0003 0005 {

	.CSEG
_port_init:
; .FSTART _port_init
; 0003 0006 // Declare your local variables here
; 0003 0007 
; 0003 0008 // Input/Output Ports initialization
; 0003 0009 // Port A initialization
; 0003 000A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0003 000B DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0003 000C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0003 000D PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0003 000E 
; 0003 000F // Port B initialization
; 0003 0010 // Function: Bit7=Out Bit6=In Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0003 0011 DDRB=(1<<DDB7) | (0<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(176)
	OUT  0x17,R30
; 0003 0012 // State: Bit7=0 Bit6=T Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0003 0013 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0003 0014 
; 0003 0015 // Port C initialization
; 0003 0016 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0003 0017 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0003 0018 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0003 0019 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0003 001A 
; 0003 001B // Port D initialization
; 0003 001C // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0003 001D DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0003 001E // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0003 001F PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0003 0020  }
	RET
; .FEND
;
;/****************************************************************************
;Image data created by the LCD Vision V1.05 font & image editor/converter
;(C) Copyright 2011-2013 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Graphic LCD controller: KS0108 128x64 /CS1,/CS2
;Image width: 425 pixels
;Image height: 425 pixels
;Color depth: 1 bits/pixel
;Imported image file name: 61Z2JVe10wL._SX425_.jpg
;
;Exported monochrome image data size:
;1028 bytes for displays organized as horizontal rows of bytes
;1028 bytes for displays organized as rows of vertical bytes.
;****************************************************************************/
;
;
;
;
;flash unsigned char mandalapic[]=
;{
;/* Image width: 128 pixels */
;0x80, 0x00,
;/* Image height: 64 pixels */
;0x40, 0x00,
;//#ifndef _GLCD_DATA_BYTEY_
;///* Image data for monochrome displays organized
;//   as horizontal rows of bytes */
;//0xF0, 0xFF, 0x3F, 0xFD, 0x57, 0x2F, 0x9F, 0xFF,
;//0xFF, 0xBD, 0x3C, 0xFF, 0xEC, 0xF6, 0xBF, 0xFF,
;//0xF7, 0xFF, 0xDF, 0x3E, 0x4B, 0xBE, 0xEF, 0xFF,
;//0xFF, 0xFB, 0x9F, 0xDE, 0xF9, 0xF3, 0x5F, 0xFF,
;//0xFF, 0xFF, 0x9E, 0x7F, 0xFC, 0x7D, 0x9F, 0xBF,
;//0xFE, 0xFF, 0x7F, 0xAF, 0xF3, 0xFD, 0xDF, 0xFF,
;//0xFF, 0xFF, 0xB9, 0x7F, 0x2F, 0x7B, 0x8F, 0x9F,
;//0xE9, 0xFF, 0xFF, 0xEB, 0xFF, 0xFC, 0xB8, 0xFF,
;//0xFF, 0xFF, 0xCA, 0xFF, 0xD0, 0xFF, 0xDE, 0xB7,
;//0xDD, 0x7F, 0xFB, 0xD7, 0xFF, 0x7B, 0x9D, 0xFF,
;//0xFF, 0x7F, 0xE6, 0xFB, 0x75, 0xF4, 0xFF, 0x79,
;//0xBC, 0xAE, 0xD5, 0xCF, 0xFD, 0xFD, 0xFF, 0xEF,
;//0xFF, 0x7F, 0xF4, 0xDC, 0xB7, 0xF1, 0xFF, 0x86,
;//0x61, 0x89, 0x94, 0xFF, 0xFA, 0xFF, 0xFF, 0xF9,
;//0xFF, 0xFF, 0xFC, 0xBE, 0xEF, 0xFC, 0xFF, 0x30,
;//0x7C, 0x28, 0x33, 0xFE, 0xD4, 0xFF, 0xFF, 0xFA,
;//0xFF, 0xFF, 0xEA, 0x7F, 0x9F, 0x7F, 0x77, 0xEF,
;//0x93, 0xFE, 0x4E, 0xF9, 0x3A, 0xFF, 0x7F, 0xFE,
;//0xFF, 0x7F, 0xEA, 0x3E, 0xBE, 0x1E, 0xD1, 0xDF,
;//0xFC, 0xFF, 0x4F, 0xF8, 0xB2, 0xC2, 0xFF, 0xFF,
;//0xFF, 0x7F, 0xC5, 0x8B, 0x7D, 0x4F, 0x5D, 0x2B,
;//0xFF, 0xFF, 0xFF, 0x7A, 0x59, 0x4D, 0xE8, 0xFF,
;//0xFF, 0x7F, 0xD2, 0xB7, 0xF0, 0x37, 0x7F, 0xF6,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFC, 0x03, 0x83, 0xFF,
;//0xFF, 0x7F, 0xF2, 0xBF, 0xF4, 0xCF, 0x83, 0xF9,
;//0xFF, 0xFD, 0xFF, 0xBF, 0xFE, 0x37, 0x7E, 0xFF,
;//0xFF, 0x7F, 0xF3, 0xFF, 0xCD, 0x4B, 0x38, 0xFE,
;//0xFF, 0xFF, 0xFF, 0x3F, 0xFD, 0xDF, 0x67, 0xF8,
;//0xFF, 0x7F, 0xF3, 0xFF, 0xF3, 0x57, 0xCB, 0xFF,
;//0xFF, 0xFF, 0xAF, 0x5F, 0xFD, 0xFF, 0x39, 0xC1,
;//0xFF, 0xFF, 0xF3, 0xFF, 0xDF, 0xD7, 0xBB, 0xBF,
;//0xFF, 0xFB, 0xC7, 0x9F, 0x3E, 0xFF, 0x8F, 0x4D,
;//0xFF, 0xFF, 0x63, 0x0F, 0xFF, 0x33, 0xC0, 0xFF,
;//0x7F, 0xEB, 0xF7, 0x77, 0xCF, 0xCC, 0x7F, 0xB7,
;//0xFF, 0xFF, 0x6A, 0xFF, 0xFD, 0xAF, 0xF3, 0xFF,
;//0x5F, 0xB5, 0xFF, 0xCB, 0x2F, 0xD3, 0xFC, 0x57,
;//0xFF, 0xFF, 0xEA, 0xFF, 0xFD, 0xB7, 0xFA, 0x8B,
;//0xBF, 0xFF, 0xFE, 0xA7, 0xF7, 0x2C, 0xF3, 0x4F,
;//0xFE, 0xFF, 0xEC, 0x55, 0x8A, 0x4F, 0xFA, 0x3C,
;//0xD7, 0x7F, 0xFE, 0xE9, 0x77, 0xFB, 0x51, 0xBF,
;//0xF2, 0xFF, 0xCC, 0xBF, 0xE9, 0x37, 0x7F, 0xFF,
;//0xEB, 0xFF, 0xFF, 0xD5, 0xD3, 0x0C, 0xA7, 0x7D,
;//0xFF, 0xFF, 0xBF, 0xFF, 0xFF, 0xAB, 0x7E, 0xFF,
;//0xF7, 0xFF, 0xFF, 0xEE, 0xBE, 0x0E, 0x47, 0x7A,
;//0xFF, 0x7F, 0xBD, 0xFF, 0xFF, 0x95, 0xDF, 0xFF,
;//0xF1, 0xFF, 0x76, 0xFB, 0x28, 0x7F, 0xFE, 0xF4,
;//0xFF, 0x7F, 0x85, 0xF7, 0x7F, 0x43, 0xBF, 0xFF,
;//0xFF, 0x7F, 0x74, 0x74, 0x57, 0x0D, 0x3E, 0xFE,
;//0xFC, 0x7F, 0xE5, 0xBD, 0xFC, 0xA8, 0xDF, 0xFF,
;//0xFF, 0x7F, 0xBF, 0x78, 0xDA, 0x93, 0xC1, 0xC9,
;//0xF7, 0x7F, 0xE5, 0xFF, 0xBC, 0xF2, 0xDF, 0xFF,
;//0x3F, 0x9F, 0x5F, 0x3F, 0x8B, 0xD7, 0x59, 0xAA,
;//0xFD, 0x7F, 0xED, 0x3F, 0x5F, 0xE1, 0xFF, 0xFF,
;//0x43, 0xFD, 0x1F, 0xDD, 0x35, 0x0F, 0x3C, 0x6F,
;//0xFF, 0x7F, 0xED, 0x3F, 0x9E, 0xF0, 0xDF, 0x7F,
;//0xFD, 0xFA, 0xDF, 0x5C, 0xBB, 0x67, 0xBA, 0xDF,
;//0xF7, 0x7F, 0xD6, 0xFF, 0x4F, 0xFF, 0xBF, 0x3F,
;//0xFE, 0xF5, 0xBF, 0x3E, 0xCB, 0x0F, 0x7A, 0x20,
;//0xF9, 0xFF, 0xC7, 0xFF, 0x2F, 0xF3, 0xFF, 0x1F,
;//0xFF, 0xCF, 0xBF, 0x2E, 0x29, 0x1D, 0x7A, 0x58,
;//0xFC, 0xFF, 0x38, 0xFE, 0xAF, 0xF9, 0xFF, 0xFF,
;//0xFF, 0xFF, 0x0F, 0xD7, 0x2D, 0xFE, 0xFA, 0xFE,
;//0xF9, 0xFF, 0xF5, 0xFF, 0x8E, 0xFE, 0xFF, 0x9F,
;//0xFF, 0xFF, 0xDF, 0x77, 0xD7, 0xBA, 0xF8, 0xFE,
;//0xFF, 0xFF, 0xC9, 0xEE, 0xCF, 0xF2, 0xFF, 0xCC,
;//0xFF, 0x2F, 0x67, 0x0B, 0xB5, 0xBA, 0xB8, 0xB8,
;//0xFF, 0xFF, 0xBB, 0xFE, 0x4F, 0xFA, 0x3F, 0xEE,
;//0xFF, 0xC5, 0xB7, 0xFB, 0x2D, 0x3B, 0xBD, 0xB8,
;//0xF3, 0xFF, 0xDF, 0xFE, 0x1E, 0xFD, 0xCF, 0xDF,
;//0x7F, 0x2A, 0xCF, 0x37, 0x4E, 0x7C, 0xB9, 0x5F,
;//0xFB, 0xFF, 0x3F, 0xBE, 0xBF, 0xFA, 0xDF, 0xDF,
;//0xBF, 0xFA, 0xAF, 0x47, 0x5D, 0x7A, 0x75, 0xBE,
;//0xF0, 0xFF, 0xBF, 0xFD, 0x7F, 0xFB, 0xE7, 0xEF,
;//0x3F, 0xFE, 0xAB, 0x6B, 0xBB, 0x74, 0xB3, 0x1B,
;//0xFA, 0xFF, 0x7F, 0xFD, 0x7F, 0xFD, 0xFB, 0xCF,
;//0x3F, 0xFF, 0x8B, 0xB9, 0xF6, 0xFC, 0xBA, 0x3E,
;//0xFF, 0xFF, 0x7F, 0xFC, 0x7B, 0x7A, 0xF7, 0xFF,
;//0xCF, 0xFF, 0xC7, 0xB5, 0xED, 0xF2, 0x72, 0xCE,
;//0xF7, 0xFF, 0x3F, 0xFF, 0xFC, 0xFD, 0xFB, 0xDF,
;//0x9F, 0xFF, 0xC3, 0x55, 0xDF, 0xF5, 0x77, 0xAC,
;//0xEF, 0xFF, 0xFF, 0xFF, 0xF1, 0xFE, 0xF7, 0x3F,
;//0xEF, 0xFF, 0xBF, 0xC1, 0xA6, 0xEF, 0x7D, 0x8F,
;//0xF9, 0xFF, 0xFF, 0x8F, 0xFC, 0xFD, 0xFF, 0x7F,
;//0xFE, 0xFF, 0xAF, 0xA3, 0xD1, 0xD7, 0x3B, 0xCF,
;//0xF7, 0xFF, 0xFF, 0xA7, 0xFF, 0xFC, 0xF3, 0xF7,
;//0xEF, 0xFF, 0x93, 0xF7, 0xCA, 0xCF, 0x37, 0xFE,
;//0xFB, 0xFF, 0xFF, 0xF7, 0x7F, 0xFA, 0xFB, 0xEB,
;//0xDF, 0xFF, 0xAB, 0xCB, 0x55, 0xFF, 0x77, 0xF6,
;//0xFF, 0xFF, 0xFF, 0xEB, 0x7B, 0xF9, 0xF7, 0xF7,
;//0xC7, 0xFF, 0xDF, 0xB7, 0xB7, 0xBE, 0xFF, 0xF7,
;//0xFF, 0xFF, 0xFF, 0xF5, 0xBF, 0xFD, 0xCF, 0xFF,
;//0xCF, 0xFF, 0x2F, 0x5B, 0xBF, 0x3B, 0xFF, 0xFF,
;//0xFF, 0xFF, 0x7F, 0x7D, 0xFB, 0xFC, 0xDF, 0xF9,
;//0xFF, 0xFF, 0xAF, 0xAF, 0x7D, 0xFC, 0x4F, 0xFE,
;//0xFF, 0xFF, 0xFF, 0xBE, 0x7D, 0xFC, 0xBF, 0xFB,
;//0xFF, 0xFF, 0xD7, 0x47, 0xFA, 0xF5, 0xAB, 0x7D,
;//0xEB, 0xFF, 0x3F, 0x9F, 0xBE, 0xFD, 0xFF, 0xF9,
;//0x3F, 0xC7, 0x57, 0x2F, 0xF3, 0xFB, 0x06, 0xF5,
;//0xF7, 0xFF, 0xFF, 0x3F, 0x7E, 0xF8, 0xFB, 0xFF,
;//0x33, 0x31, 0x6F, 0x3F, 0xE9, 0xBF, 0x2D, 0xF1,
;//0xFF, 0xFF, 0x7F, 0xDF, 0xFF, 0xF2, 0xFB, 0xBF,
;//0x6D, 0x4C, 0xAE, 0x5E, 0x52, 0x5F, 0xCB, 0xCC,
;//0xEB, 0xFF, 0xBF, 0xCB, 0xFB, 0xFA, 0xFE, 0x2F,
;//0x84, 0x4C, 0x6F, 0xDD, 0xFF, 0xDE, 0x36, 0xCD,
;//0xEF, 0xFF, 0xFF, 0xF3, 0xF3, 0xF7, 0xFE, 0xCB,
;//0xF0, 0x98, 0xDE, 0xFA, 0xFF, 0x0C, 0x83, 0xA7,
;//0xEF, 0xFF, 0xFF, 0xED, 0xEA, 0xE5, 0xFF, 0xD4,
;//0xFE, 0x7F, 0x3E, 0xFF, 0xFF, 0x5F, 0xBE, 0x76,
;//0xE7, 0xFF, 0xFF, 0xF7, 0xF0, 0xF3, 0x7F, 0x19,
;//0xFF, 0xFF, 0xFD, 0x7C, 0xCD, 0xCF, 0x33, 0x4C,
;//0xF6, 0xFF, 0xFF, 0x75, 0xF8, 0xD7, 0x9F, 0xC9,
;//0xFF, 0xF9, 0x3F, 0x7F, 0x76, 0x3F, 0xCC, 0x3F,
;//0xF6, 0xFF, 0x7F, 0xBA, 0xDF, 0xCF, 0x47, 0xFA,
;//0x3F, 0x83, 0xFF, 0xDF, 0xB1, 0xCE, 0xF3, 0xFF,
;//0xFF, 0xFF, 0xFF, 0x5A, 0xFF, 0xFF, 0x3B, 0xFD,
;//0xCC, 0x2C, 0xFF, 0x27, 0x2C, 0x7D, 0xFA, 0xF9,
;//0xFF, 0xFF, 0x3F, 0xBD, 0x8E, 0xFF, 0x49, 0x7F,
;//0x33, 0x53, 0xF0, 0xC3, 0x47, 0xBD, 0xBE, 0xD5,
;//0xFF, 0xFF, 0xFF, 0x4C, 0x5F, 0xFE, 0x84, 0x6F,
;//0xE1, 0x7B, 0xEA, 0x77, 0x8B, 0x5E, 0x1F, 0x99,
;//0xFF, 0xFF, 0x3F, 0x3F, 0xEF, 0x3F, 0xE3, 0x53,
;//0x3C, 0x36, 0xE5, 0x8B, 0xDD, 0xB8, 0x2F, 0x57,
;//0xFF, 0xFF, 0x3F, 0xBF, 0xFF, 0x5F, 0xFE, 0x6D,
;//0x91, 0xED, 0xEE, 0xF0, 0x76, 0x7D, 0xDF, 0xAF,
;//0xFF, 0xFF, 0x7F, 0xA7, 0xFB, 0x84, 0xFD, 0x12,
;//0x37, 0xFB, 0xF5, 0x55, 0x73, 0x3F, 0xEB, 0x3F,
;//0xFF, 0xFF, 0x3F, 0xF6, 0x7B, 0x6D, 0xBF, 0x5A,
;//0xDC, 0xD6, 0xF5, 0x0A, 0xC9, 0xFF, 0xCF, 0x7F,
;//#else
;///* Image data for monochrome displays organized
;//   as rows of vertical bytes */
;
;0xFE, 0xFE, 0xFE, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x9F,
;0x0B, 0x37, 0xE7, 0x9F, 0xCF, 0xE9, 0xF2, 0xFE,
;0x3D, 0xBE, 0xDF, 0xFF, 0xFF, 0xBF, 0x7D, 0xF1,
;0xEB, 0xCB, 0xED, 0x8E, 0x75, 0xEC, 0xB7, 0xD4,
;0x5D, 0x1B, 0xB7, 0x9F, 0xFE, 0xFF, 0xFC, 0xF2,
;0xEF, 0xFF, 0xFF, 0xFF, 0xF5, 0xE2, 0xF2, 0xFF,
;0x3F, 0x5F, 0x5F, 0x2F, 0xBF, 0xB7, 0x23, 0x5F,
;0x5B, 0x07, 0xB7, 0xBF, 0xB7, 0xEF, 0xDF, 0x3F,
;0x5F, 0x3E, 0x3D, 0xFF, 0x1F, 0xBF, 0x1E, 0x6F,
;0xBE, 0x9E, 0x6F, 0x1F, 0xFF, 0x9D, 0x3C, 0x7A,
;0x7D, 0xFF, 0xF7, 0xEF, 0xD3, 0xCD, 0xFB, 0xFF,
;0x3E, 0x5C, 0xB9, 0x7B, 0xFE, 0x7F, 0xFF, 0xFF,
;0xF6, 0xD3, 0xED, 0xFC, 0xFF, 0xFF, 0xFF, 0xEF,
;0xF7, 0xE7, 0xF7, 0xFF, 0xFF, 0xE9, 0xE6, 0xFD,
;0x7F, 0xBF, 0x3F, 0xFF, 0xDF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x81,
;0xE4, 0xFB, 0x04, 0x03, 0xF8, 0xF3, 0xFF, 0xFF,
;0xFD, 0xFF, 0xFB, 0xF7, 0xFB, 0xFB, 0xE1, 0xFC,
;0xE5, 0xC3, 0xB7, 0xA7, 0xDF, 0x5E, 0xFC, 0xFB,
;0xFD, 0xFF, 0xDF, 0x37, 0xCB, 0x09, 0xF5, 0x90,
;0xDF, 0xD9, 0x0D, 0xEC, 0xAF, 0xA9, 0x4F, 0xD2,
;0xD7, 0xEF, 0xEB, 0xF7, 0xFA, 0xFD, 0x7B, 0xFB,
;0xFD, 0xFD, 0xFE, 0xFE, 0xFF, 0xFE, 0xFE, 0xFF,
;0xFE, 0xEF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFE, 0xFF, 0xFF, 0x7F, 0x3C, 0x7C, 0xBF, 0xFC,
;0xF9, 0xFC, 0xF8, 0xFF, 0xFF, 0x3F, 0x4F, 0x9B,
;0x64, 0x93, 0xF8, 0xFD, 0xFF, 0xFB, 0x7C, 0x7A,
;0xFD, 0xFB, 0xF5, 0xE5, 0xF1, 0xD1, 0xE7, 0xE3,
;0xEB, 0xBB, 0xB3, 0xD7, 0x53, 0x77, 0x37, 0x8E,
;0xDE, 0x1F, 0x9F, 0xBF, 0x3F, 0x3F, 0xFF, 0x7F,
;0xE7, 0xFF, 0xEF, 0xEF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F,
;0xE1, 0x27, 0xF8, 0x7E, 0x60, 0x6F, 0x1F, 0xFC,
;0xFF, 0xF7, 0xFF, 0x77, 0xFE, 0xF6, 0xEE, 0xF6,
;0xF7, 0xE9, 0xE7, 0xFF, 0xE7, 0xF7, 0xF7, 0x7F,
;0xFF, 0xBF, 0x5E, 0x2A, 0x55, 0x37, 0x88, 0x66,
;0xD2, 0xFE, 0xF0, 0xFC, 0xFE, 0xBE, 0x7F, 0xCF,
;0xF7, 0xF7, 0xFB, 0xFF, 0xFB, 0xFB, 0xF3, 0xF7,
;0xFF, 0xBF, 0xAF, 0x97, 0xEF, 0xF5, 0xFB, 0xFC,
;0xFF, 0xFD, 0xFE, 0xFD, 0xFE, 0xFF, 0xFD, 0x77,
;0x33, 0x7F, 0xFF, 0x3E, 0xFF, 0xFF, 0xFF, 0x3F,
;0x5F, 0x67, 0xB5, 0x6A, 0xD1, 0xED, 0xFB, 0x7E,
;
;0x9F, 0xBF, 0xAF, 0x63, 0xBC, 0x6E, 0x9D, 0x35,
;0xCA, 0x6A, 0xF5, 0xFD, 0x4A, 0x4C, 0x4B, 0x0B,
;
;0x3D, 0xF5, 0xF3, 0xC3, 0xCF, 0xD7, 0x6F, 0x56,
;0x1F, 0xAF, 0xDF, 0xBC, 0xFB, 0xF9, 0xF6, 0xC9,
;0xBE, 0x1A, 0x5F, 0xED, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0,
;
;0xAF, 0x30, 0xBF, 0x4C, 0xD0, 0xCF, 0xBF, 0xBF,
;0xBF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xF2, 0xF3,
;0x74, 0xFC, 0xFF, 0xFF, 0x0F, 0x63, 0x15, 0xCB,
;0x74, 0xB2, 0x90, 0xD1, 0xFA, 0xFF, 0xFE, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF4, 0xEF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x5F, 0x4F, 0xC7,
;
;0xEF, 0xF7, 0xFB, 0xFB, 0xFB, 0xFB, 0xFD, 0xF9,
;0xF7, 0xEB, 0xF7, 0xEF, 0xDF, 0xDD, 0xFD, 0xFE,
;
;0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x31, 0x8A, 0xB9,
;0xC6, 0xF2, 0xFE, 0x3F, 0xDF, 0xB3, 0xCD, 0x44,
;0xFE, 0x9B, 0xC4, 0x7B, 0x8D, 0x6C, 0x91, 0x9B,
;0x3F, 0xDF, 0x7E, 0xF4, 0xE3, 0xC8, 0x4A, 0xC3,
;0x03, 0x78, 0x04, 0xFE, 0xFE, 0xFC, 0xF3, 0xC9,
;0x0D, 0xCE, 0xCC, 0xEF, 0xE8, 0xD6, 0xED, 0xCB,
;
;0xCF, 0xEF, 0xC3, 0x6B, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFE, 0xFC, 0xFF, 0xFE, 0xFA, 0x65, 0x17,
;0xB0, 0x8F, 0xFF, 0xFF, 0xFE, 0xFF, 0xF7, 0xFF,
;
;0x7B, 0x7F, 0xBF, 0xFF, 0xFC, 0xF8, 0xF3, 0x89,
;0xB4, 0x5B, 0xA4, 0xFE, 0xFF, 0xFF, 0xFF, 0xBF,
;0xFF, 0xFF, 0x5F, 0xAF, 0xEB, 0xF3, 0xFD, 0xFD,
;0xFC, 0xFE, 0xFF, 0xFF, 0xCC, 0x52, 0xFF, 0xFF,
;
;0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x3F, 0x47, 0xCB,
;0xE3, 0xFD, 0xF3, 0xFD, 0xF8, 0xFD, 0xFA, 0xFA,
;0xFF, 0xFF, 0x4F, 0x3C, 0x02, 0x1B, 0xC5, 0xFE,
;0xFF, 0x1F, 0xCC, 0x33, 0xE6, 0x76, 0x9A, 0x62,
;0xDB, 0xB4, 0xEF, 0xDE, 0xB9, 0x73, 0xEC, 0xF1,
;0x82, 0x4B, 0xB4, 0x2F, 0xFF, 0xFF, 0xFC, 0xE1,
;0x9E, 0xF0, 0x8A, 0x27, 0xFF, 0xFF, 0xC8, 0x37,
;0x14, 0x7C, 0xEC, 0xFF, 0x3F, 0xAB, 0x44, 0xCB,
;
;0xFF, 0xFD, 0xF5, 0xFB, 0xFE, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xBF,
;0x7F, 0x9F, 0xEF, 0xD3, 0xE9, 0xFD, 0x79, 0xBF,
;0xFD, 0x7C, 0xAE, 0xFE, 0xFF, 0xFF, 0xDF, 0x67,
;0x32, 0x09, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xF3, 0xEA, 0xDF, 0x9F, 0x7F, 0xFF,
;0xFF, 0xBF, 0x37, 0xEB, 0xF7, 0xFF, 0xFE, 0xFC,
;0xFD, 0xFF, 0xFF, 0xEF, 0xCA, 0xC7, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xF3, 0x7B, 0x95, 0x6B, 0x90, 0xDF,
;0xFF, 0xFE, 0xD4, 0x68, 0x34, 0x56, 0xAD, 0x5F,
;
;0x7A, 0xB5, 0x79, 0xE4, 0xFA, 0xF1, 0xCE, 0xB7,
;0xAF, 0x3F, 0xDF, 0x7D, 0xFA, 0xF9, 0xCF, 0xDF,
;0xFF, 0xFE, 0x7D, 0xF3, 0x3F, 0xBF, 0x79, 0xB0,
;0xB3, 0x7F, 0xFF, 0xE7, 0xFC, 0xFC, 0xFE, 0x7F,
;0x7F, 0xFF, 0xF6, 0x3D, 0x86, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF6, 0xFA,
;0xFF, 0x5F, 0xE7, 0x2F, 0xD7, 0xF2, 0xFC, 0x7D,
;
;0x1C, 0x3F, 0x07, 0xAF, 0xDF, 0xFF, 0xFE, 0xFD,
;0xF1, 0xDC, 0xB1, 0x0B, 0xDF, 0x7F, 0xFF, 0xFF,
;0xE7, 0xFF, 0xF9, 0xFF, 0xFF, 0x7F, 0x7F, 0xBF,
;0xDF, 0x1E, 0x2E, 0xDF, 0x67, 0x0F, 0xB3, 0xB7,
;
;0xC7, 0xE3, 0xED, 0xE5, 0xF3, 0xF7, 0xF4, 0xF8,
;0xE3, 0x61, 0x6D, 0xFC, 0xF2, 0xE2, 0xED, 0xD1,
;0xCB, 0xBF, 0xFF, 0xFE, 0xF1, 0xEE, 0x5B, 0x54,
;0xAB, 0xB7, 0xEF, 0xFF, 0xFE, 0xF3, 0xFC, 0x38,
;0x7B, 0xBD, 0xF8, 0x7A, 0xBD, 0xBB, 0xFF, 0x7B,
;0xE7, 0xEF, 0xFE, 0xFF, 0xAF, 0x83, 0x6D, 0x4B,
;0x56, 0x7D, 0xAB, 0xA6, 0x68, 0x6A, 0x84, 0xB4,
;0x9B, 0xB0, 0xFD, 0xCC, 0xA3, 0xB3, 0x6F, 0x1F,
;0xFE, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x4B, 0x0A,
;0x74, 0xF3, 0xFC, 0x3F, 0xB7, 0xF5, 0x8A, 0xE5,
;
;0xFB, 0xFF, 0x3F, 0xFF, 0xEB, 0xF2, 0xFB, 0x77,
;0xB7, 0x3F, 0xFF, 0xBF, 0x3E, 0x9E, 0xAF, 0x4F,
;0xD7, 0xB3, 0xE9, 0xE6, 0xE2, 0xF2, 0x75, 0xF8,
;0x3E, 0xDD, 0x2E, 0xAF, 0xD7, 0x2F, 0xBF, 0x03,
;0x6D, 0x45, 0xD3, 0x93, 0xF5, 0x5D, 0x8A, 0xAA,
;0x6D, 0xDD, 0xB2, 0x6A, 0xDC, 0x7A, 0xEC, 0xE1,
;0xD3, 0x2B, 0xF3, 0x2B, 0xC7, 0xFF, 0xFF, 0xFF,
;0x5F, 0x9F, 0x4B, 0x91, 0x69, 0x2A, 0x6D, 0x35,
;0xDD, 0x6C, 0x36, 0x9A, 0x71, 0x63, 0xF4, 0x99,
;0xE6, 0xC9, 0xEF, 0xFF, 0xFE, 0xF6, 0xAB, 0x95,
;0xF9, 0xFF, 0xBC, 0xFE, 0x2F, 0x57, 0xE3, 0xE7,
;0xFF, 0xF1, 0xF5, 0xEB, 0xDF, 0xE3, 0x97, 0x2F,
;//#endif
;};
;
;//
;// flash unsigned char mandalapic[]=
;//{
;//0xFE, 0xFE, 0xFE, 0xFC, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x9F,
;//0x0B, 0x37, 0xE7, 0x9F, 0xCF, 0xE9, 0xF2, 0xFE,
;//0x3D, 0xBE, 0xDF, 0xFF, 0xFF, 0xBF, 0x7D, 0xF1,
;//0xEB, 0xCB, 0xED, 0x8E, 0x75, 0xEC, 0xB7, 0xD4,
;//0x5D, 0x1B, 0xB7, 0x9F, 0xFE, 0xFF, 0xFC, 0xF2,
;//0xEF, 0xFF, 0xFF, 0xFF, 0xF5, 0xE2, 0xF2, 0xFF,
;//0x3F, 0x5F, 0x5F, 0x2F, 0xBF, 0xB7, 0x23, 0x5F,
;//0x5B, 0x07, 0xB7, 0xBF, 0xB7, 0xEF, 0xDF, 0x3F,
;//0x5F, 0x3E, 0x3D, 0xFF, 0x1F, 0xBF, 0x1E, 0x6F,
;//0xBE, 0x9E, 0x6F, 0x1F, 0xFF, 0x9D, 0x3C, 0x7A,
;//0x7D, 0xFF, 0xF7, 0xEF, 0xD3, 0xCD, 0xFB, 0xFF,
;//0x3E, 0x5C, 0xB9, 0x7B, 0xFE, 0x7F, 0xFF, 0xFF,
;//0xF6, 0xD3, 0xED, 0xFC, 0xFF, 0xFF, 0xFF, 0xEF,
;//0xF7, 0xE7, 0xF7, 0xFF, 0xFF, 0xE9, 0xE6, 0xFD,
;//0x7F, 0xBF, 0x3F, 0xFF, 0xDF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x81,
;//0xE4, 0xFB, 0x04, 0x03, 0xF8, 0xF3, 0xFF, 0xFF,
;//0xFD, 0xFF, 0xFB, 0xF7, 0xFB, 0xFB, 0xE1, 0xFC,
;//0xE5, 0xC3, 0xB7, 0xA7, 0xDF, 0x5E, 0xFC, 0xFB,
;//0xFD, 0xFF, 0xDF, 0x37, 0xCB, 0x09, 0xF5, 0x90,
;//0xDF, 0xD9, 0x0D, 0xEC, 0xAF, 0xA9, 0x4F, 0xD2,
;//0xD7, 0xEF, 0xEB, 0xF7, 0xFA, 0xFD, 0x7B, 0xFB,
;//0xFD, 0xFD, 0xFE, 0xFE, 0xFF, 0xFE, 0xFE, 0xFF,
;//0xFE, 0xEF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFE, 0xFF, 0xFF, 0x7F, 0x3C, 0x7C, 0xBF, 0xFC,
;//0xF9, 0xFC, 0xF8, 0xFF, 0xFF, 0x3F, 0x4F, 0x9B,
;//0x64, 0x93, 0xF8, 0xFD, 0xFF, 0xFB, 0x7C, 0x7A,
;//0xFD, 0xFB, 0xF5, 0xE5, 0xF1, 0xD1, 0xE7, 0xE3,
;//0xEB, 0xBB, 0xB3, 0xD7, 0x53, 0x77, 0x37, 0x8E,
;//0xDE, 0x1F, 0x9F, 0xBF, 0x3F, 0x3F, 0xFF, 0x7F,
;//0xE7, 0xFF, 0xEF, 0xEF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F,
;//0xE1, 0x27, 0xF8, 0x7E, 0x60, 0x6F, 0x1F, 0xFC,
;//0xFF, 0xF7, 0xFF, 0x77, 0xFE, 0xF6, 0xEE, 0xF6,
;//0xF7, 0xE9, 0xE7, 0xFF, 0xE7, 0xF7, 0xF7, 0x7F,
;//0xFF, 0xBF, 0x5E, 0x2A, 0x55, 0x37, 0x88, 0x66,
;//0xD2, 0xFE, 0xF0, 0xFC, 0xFE, 0xBE, 0x7F, 0xCF,
;//0xF7, 0xF7, 0xFB, 0xFF, 0xFB, 0xFB, 0xF3, 0xF7,
;//0xFF, 0xBF, 0xAF, 0x97, 0xEF, 0xF5, 0xFB, 0xFC,
;//0xFF, 0xFD, 0xFE, 0xFD, 0xFE, 0xFF, 0xFD, 0x77,
;//0x33, 0x7F, 0xFF, 0x3E, 0xFF, 0xFF, 0xFF, 0x3F,
;//0x5F, 0x67, 0xB5, 0x6A, 0xD1, 0xED, 0xFB, 0x7E,
;//0x9F, 0xBF, 0xAF, 0x63, 0xBC, 0x6E, 0x9D, 0x35,
;//0xCA, 0x6A, 0xF5, 0xFD, 0x4A, 0x4C, 0x4B, 0x0B,
;//0x3D, 0xF5, 0xF3, 0xC3, 0xCF, 0xD7, 0x6F, 0x56,
;//0x1F, 0xAF, 0xDF, 0xBC, 0xFB, 0xF9, 0xF6, 0xC9,
;//0xBE, 0x1A, 0x5F, 0xED, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0,
;//0xAF, 0x30, 0xBF, 0x4C, 0xD0, 0xCF, 0xBF, 0xBF,
;//0xBF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xF2, 0xF3,
;//0x74, 0xFC, 0xFF, 0xFF, 0x0F, 0x63, 0x15, 0xCB,
;//0x74, 0xB2, 0x90, 0xD1, 0xFA, 0xFF, 0xFE, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF4, 0xEF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x5F, 0x4F, 0xC7,
;//0xEF, 0xF7, 0xFB, 0xFB, 0xFB, 0xFB, 0xFD, 0xF9,
;//0xF7, 0xEB, 0xF7, 0xEF, 0xDF, 0xDD, 0xFD, 0xFE,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x31, 0x8A, 0xB9,
;//0xC6, 0xF2, 0xFE, 0x3F, 0xDF, 0xB3, 0xCD, 0x44,
;//0xFE, 0x9B, 0xC4, 0x7B, 0x8D, 0x6C, 0x91, 0x9B,
;//0x3F, 0xDF, 0x7E, 0xF4, 0xE3, 0xC8, 0x4A, 0xC3,
;//0x03, 0x78, 0x04, 0xFE, 0xFE, 0xFC, 0xF3, 0xC9,
;//0x0D, 0xCE, 0xCC, 0xEF, 0xE8, 0xD6, 0xED, 0xCB,
;//0xCF, 0xEF, 0xC3, 0x6B, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFE, 0xFC, 0xFF, 0xFE, 0xFA, 0x65, 0x17,
;//0xB0, 0x8F, 0xFF, 0xFF, 0xFE, 0xFF, 0xF7, 0xFF,
;//0x7B, 0x7F, 0xBF, 0xFF, 0xFC, 0xF8, 0xF3, 0x89,
;//0xB4, 0x5B, 0xA4, 0xFE, 0xFF, 0xFF, 0xFF, 0xBF,
;//0xFF, 0xFF, 0x5F, 0xAF, 0xEB, 0xF3, 0xFD, 0xFD,
;//0xFC, 0xFE, 0xFF, 0xFF, 0xCC, 0x52, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xBF, 0x3F, 0x47, 0xCB,
;//0xE3, 0xFD, 0xF3, 0xFD, 0xF8, 0xFD, 0xFA, 0xFA,
;//0xFF, 0xFF, 0x4F, 0x3C, 0x02, 0x1B, 0xC5, 0xFE,
;//0xFF, 0x1F, 0xCC, 0x33, 0xE6, 0x76, 0x9A, 0x62,
;//0xDB, 0xB4, 0xEF, 0xDE, 0xB9, 0x73, 0xEC, 0xF1,
;//0x82, 0x4B, 0xB4, 0x2F, 0xFF, 0xFF, 0xFC, 0xE1,
;//0x9E, 0xF0, 0x8A, 0x27, 0xFF, 0xFF, 0xC8, 0x37,
;//0x14, 0x7C, 0xEC, 0xFF, 0x3F, 0xAB, 0x44, 0xCB,
;//0xFF, 0xFD, 0xF5, 0xFB, 0xFE, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xBF,
;//0x7F, 0x9F, 0xEF, 0xD3, 0xE9, 0xFD, 0x79, 0xBF,
;//0xFD, 0x7C, 0xAE, 0xFE, 0xFF, 0xFF, 0xDF, 0x67,
;//0x32, 0x09, 0xE7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xF3, 0xEA, 0xDF, 0x9F, 0x7F, 0xFF,
;//0xFF, 0xBF, 0x37, 0xEB, 0xF7, 0xFF, 0xFE, 0xFC,
;//0xFD, 0xFF, 0xFF, 0xEF, 0xCA, 0xC7, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xF3, 0x7B, 0x95, 0x6B, 0x90, 0xDF,
;//0xFF, 0xFE, 0xD4, 0x68, 0x34, 0x56, 0xAD, 0x5F,
;//0x7A, 0xB5, 0x79, 0xE4, 0xFA, 0xF1, 0xCE, 0xB7,
;//0xAF, 0x3F, 0xDF, 0x7D, 0xFA, 0xF9, 0xCF, 0xDF,
;//0xFF, 0xFE, 0x7D, 0xF3, 0x3F, 0xBF, 0x79, 0xB0,
;//0xB3, 0x7F, 0xFF, 0xE7, 0xFC, 0xFC, 0xFE, 0x7F,
;//0x7F, 0xFF, 0xF6, 0x3D, 0x86, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF6, 0xFA,
;//0xFF, 0x5F, 0xE7, 0x2F, 0xD7, 0xF2, 0xFC, 0x7D,
;//0x1C, 0x3F, 0x07, 0xAF, 0xDF, 0xFF, 0xFE, 0xFD,
;//0xF1, 0xDC, 0xB1, 0x0B, 0xDF, 0x7F, 0xFF, 0xFF,
;//0xE7, 0xFF, 0xF9, 0xFF, 0xFF, 0x7F, 0x7F, 0xBF,
;//0xDF, 0x1E, 0x2E, 0xDF, 0x67, 0x0F, 0xB3, 0xB7,
;//0xC7, 0xE3, 0xED, 0xE5, 0xF3, 0xF7, 0xF4, 0xF8,
;//0xE3, 0x61, 0x6D, 0xFC, 0xF2, 0xE2, 0xED, 0xD1,
;//0xCB, 0xBF, 0xFF, 0xFE, 0xF1, 0xEE, 0x5B, 0x54,
;//0xAB, 0xB7, 0xEF, 0xFF, 0xFE, 0xF3, 0xFC, 0x38,
;//0x7B, 0xBD, 0xF8, 0x7A, 0xBD, 0xBB, 0xFF, 0x7B,
;//0xE7, 0xEF, 0xFE, 0xFF, 0xAF, 0x83, 0x6D, 0x4B,
;//0x56, 0x7D, 0xAB, 0xA6, 0x68, 0x6A, 0x84, 0xB4,
;//0x9B, 0xB0, 0xFD, 0xCC, 0xA3, 0xB3, 0x6F, 0x1F,
;//0xFE, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
;//0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x4B, 0x0A,
;//0x74, 0xF3, 0xFC, 0x3F, 0xB7, 0xF5, 0x8A, 0xE5,
;//0xFB, 0xFF, 0x3F, 0xFF, 0xEB, 0xF2, 0xFB, 0x77,
;//0xB7, 0x3F, 0xFF, 0xBF, 0x3E, 0x9E, 0xAF, 0x4F,
;//0xD7, 0xB3, 0xE9, 0xE6, 0xE2, 0xF2, 0x75, 0xF8,
;//0x3E, 0xDD, 0x2E, 0xAF, 0xD7, 0x2F, 0xBF, 0x03,
;//0x6D, 0x45, 0xD3, 0x93, 0xF5, 0x5D, 0x8A, 0xAA,
;//0x6D, 0xDD, 0xB2, 0x6A, 0xDC, 0x7A, 0xEC, 0xE1,
;//0xD3, 0x2B, 0xF3, 0x2B, 0xC7, 0xFF, 0xFF, 0xFF,
;//0x5F, 0x9F, 0x4B, 0x91, 0x69, 0x2A, 0x6D, 0x35,
;//0xDD, 0x6C, 0x36, 0x9A, 0x71, 0x63, 0xF4, 0x99,
;//0xE6, 0xC9, 0xEF, 0xFF, 0xFE, 0xF6, 0xAB, 0x95,
;//0xF9, 0xFF, 0xBC, 0xFE, 0x2F, 0x57, 0xE3, 0xE7,
;//0xFF, 0xF1, 0xF5, 0xEB, 0xDF, 0xE3, 0x97, 0x2F,};
;//
;
; #include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;// Declare your global variables here
;
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 256
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE <= 256
;unsigned char rx_wr_index=0,rx_rd_index=0;
;#else
;unsigned int rx_wr_index=0,rx_rd_index=0;
;#endif
;
;#if RX_BUFFER_SIZE < 256
;unsigned char rx_counter=0;
;#else
;unsigned int rx_counter=0;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0005 0022 {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0005 0023 char status,data;
; 0005 0024 status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0005 0025 data=UDR;
	IN   R16,12
; 0005 0026 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0xA0003
; 0005 0027    {
; 0005 0028    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0005 0029 #if RX_BUFFER_SIZE == 256
; 0005 002A    // special case for receiver buffer size=256
; 0005 002B    if (++rx_counter == 0) rx_buffer_overflow=1;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	BRNE _0xA0004
	SET
	BLD  R2,2
; 0005 002C #else
; 0005 002D    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
; 0005 002E    if (++rx_counter == RX_BUFFER_SIZE)
; 0005 002F       {
; 0005 0030       rx_counter=0;
; 0005 0031       rx_buffer_overflow=1;
; 0005 0032       }
; 0005 0033 #endif
; 0005 0034    }
_0xA0004:
; 0005 0035 }
_0xA0003:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0005 003C {
; 0005 003D char data;
; 0005 003E while (rx_counter==0);
;	data -> R17
; 0005 003F data=rx_buffer[rx_rd_index++];
; 0005 0040 #if RX_BUFFER_SIZE != 256
; 0005 0041 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0005 0042 #endif
; 0005 0043 #asm("cli")
; 0005 0044 --rx_counter;
; 0005 0045 #asm("sei")
; 0005 0046 return data;
; 0005 0047 }
;#pragma used-
;#endif
;
;// USART Transmitter buffer
;#define TX_BUFFER_SIZE 256
;char tx_buffer[TX_BUFFER_SIZE];
;
;#if TX_BUFFER_SIZE <= 256
;unsigned char tx_wr_index=0,tx_rd_index=0;
;#else
;unsigned int tx_wr_index=0,tx_rd_index=0;
;#endif
;
;#if TX_BUFFER_SIZE < 256
;unsigned char tx_counter=0;
;#else
;unsigned int tx_counter=0;
;#endif
;
;// USART Transmitter interrupt service routine
;interrupt [USART_TXC] void usart_tx_isr(void)
; 0005 005D {
_usart_tx_isr:
; .FSTART _usart_tx_isr
	ST   -Y,R0
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0005 005E if (tx_counter)
	MOV  R0,R12
	OR   R0,R13
	BREQ _0xA0008
; 0005 005F    {
; 0005 0060    --tx_counter;
	MOVW R30,R12
	SBIW R30,1
	MOVW R12,R30
; 0005 0061    UDR=tx_buffer[tx_rd_index++];
	MOV  R30,R10
	INC  R10
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
; 0005 0062 #if TX_BUFFER_SIZE != 256
; 0005 0063    if (tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
; 0005 0064 #endif
; 0005 0065    }
; 0005 0066 }
_0xA0008:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Write a character to the USART Transmitter buffer
;#define _ALTERNATE_PUTCHAR_
;#pragma used+
;void putchar(char c)
; 0005 006D {
_putchar:
; .FSTART _putchar
; 0005 006E while (tx_counter == TX_BUFFER_SIZE);
	ST   -Y,R26
;	c -> Y+0
_0xA0009:
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CP   R30,R12
	CPC  R31,R13
	BREQ _0xA0009
; 0005 006F #asm("cli")
	cli
; 0005 0070 if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY)==0))
	MOV  R0,R12
	OR   R0,R13
	BRNE _0xA000D
	SBIC 0xB,5
	RJMP _0xA000C
_0xA000D:
; 0005 0071    {
; 0005 0072    tx_buffer[tx_wr_index++]=c;
	MOV  R30,R11
	INC  R11
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
; 0005 0073 #if TX_BUFFER_SIZE != 256
; 0005 0074    if (tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
; 0005 0075 #endif
; 0005 0076    ++tx_counter;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0005 0077    }
; 0005 0078 else
	RJMP _0xA000F
_0xA000C:
; 0005 0079    UDR=c;
	LD   R30,Y
	OUT  0xC,R30
; 0005 007A #asm("sei")
_0xA000F:
	sei
; 0005 007B }
	JMP  _0x214000B
; .FEND
;#pragma used-
;#endif
;
;
;
;
;
;void uart_init(void)
; 0005 0084 {
_uart_init:
; .FSTART _uart_init
; 0005 0085 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0005 0086 UCSRB=(1<<RXCIE) | (1<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0005 0087 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0005 0088 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0005 0089 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0005 008A  }
	RET
; .FEND
;
;
;
;
;
;
;/*
; * I2C_Master_C_file.c
; *
; */
;
;#include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;
;
;                            /* Include I2C header file */
;
;void I2C_Init2()                                                /* I2C initialize function */
; 0006 000D {

	.CSEG
_I2C_Init2:
; .FSTART _I2C_Init2
; 0006 000E     TWBR = BITRATE(TWSR = 0x00);                            /* Get bit rate register value by formula */
	__GETD1N 0x40800000
	CALL __PUTPARD1
	OUT  0x1,R30
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL _pow
	__GETD2N 0x40000000
	CALL __MULF12
	__GETD2N 0x42800000
	CALL __DIVF21
	CALL __CFD1U
	OUT  0x0,R30
; 0006 000F }
	RET
; .FEND
;
;
;char I2C_Start2(char write_address)                        /* I2C start function */
; 0006 0013 {
; 0006 0014     char status;                                            /* Declare variable */
; 0006 0015     TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interru ...
;	write_address -> Y+1
;	status -> R17
; 0006 0016     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition)  ...
; 0006 0017     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0006 0018     if (status != 0x08)                                        /* Check weather start condition transmitted successfully ...
; 0006 0019     return 0;                                                /* If not then return 0 to indicate start condition fail */
; 0006 001A     TWDR = write_address;                                    /* If yes then write SLA+W in TWI data register */
; 0006 001B     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0006 001C     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
; 0006 001D     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0006 001E     if (status == 0x18)                                        /* Check weather SLA+W transmitted & ack received or not? ...
; 0006 001F     return 1;                                                /* If yes then return 1 to indicate ack received i.e. ready ...
; 0006 0020     if (status == 0x20)                                        /* Check weather SLA+W transmitted & nack received or not ...
; 0006 0021     return 2;                                                /* If yes then return 2 to indicate nack received i.e. devi ...
; 0006 0022     else
; 0006 0023     return 3;                                                /* Else return 3 to indicate SLA+W failed */
; 0006 0024 }
;
;char I2C_Repeated_Start(char read_address)                /* I2C repeated start function */
; 0006 0027 {
_I2C_Repeated_Start:
; .FSTART _I2C_Repeated_Start
; 0006 0028     char status;                                            /* Declare variable */
; 0006 0029     TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interru ...
	ST   -Y,R26
	ST   -Y,R17
;	read_address -> Y+1
;	status -> R17
	LDI  R30,LOW(164)
	OUT  0x36,R30
; 0006 002A     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition)  ...
_0xC000D:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC000D
; 0006 002B     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0006 002C     if (status != 0x10)                                        /* Check weather repeated start condition transmitted suc ...
	CPI  R17,16
	BREQ _0xC0010
; 0006 002D     return 0;                                                /* If no then return 0 to indicate repeated start condition ...
	LDI  R30,LOW(0)
	JMP  _0x214000C
; 0006 002E     TWDR = read_address;                                    /* If yes then write SLA+R in TWI data register */
_0xC0010:
	CALL SUBOPT_0x3
; 0006 002F     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0006 0030     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
_0xC0011:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC0011
; 0006 0031     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0006 0032     if (status == 0x40)                                        /* Check weather SLA+R transmitted & ack received or not? ...
	CPI  R17,64
	BRNE _0xC0014
; 0006 0033     return 1;                                                /* If yes then return 1 to indicate ack received */
	LDI  R30,LOW(1)
	JMP  _0x214000C
; 0006 0034     if (status == 0x20)                                        /* Check weather SLA+R transmitted & nack received or not ...
_0xC0014:
	CPI  R17,32
	BRNE _0xC0015
; 0006 0035     return 2;                                                /* If yes then return 2 to indicate nack received i.e. devi ...
	LDI  R30,LOW(2)
	JMP  _0x214000C
; 0006 0036     else
_0xC0015:
; 0006 0037     return 3;                                                /* Else return 3 to indicate SLA+W failed */
	LDI  R30,LOW(3)
	JMP  _0x214000C
; 0006 0038 }
; .FEND
;
;void I2C_Stop2()                                                /* I2C stop function */
; 0006 003B {
_I2C_Stop2:
; .FSTART _I2C_Stop2
; 0006 003C     TWCR=(1<<TWSTO)|(1<<TWINT)|(1<<TWEN);                    /* Enable TWI, generate stop condition and clear interrupt  ...
	LDI  R30,LOW(148)
	OUT  0x36,R30
; 0006 003D     while(TWCR & (1<<TWSTO));                                /* Wait until stop condition execution */
_0xC0017:
	IN   R30,0x36
	SBRC R30,4
	RJMP _0xC0017
; 0006 003E }
	RET
; .FEND
;
;void I2C_Start_Wait(char write_address)                        /* I2C start wait function */
; 0006 0041 {
_I2C_Start_Wait:
; .FSTART _I2C_Start_Wait
; 0006 0042     char status;                                            /* Declare variable */
; 0006 0043     while (1)
	ST   -Y,R26
	ST   -Y,R17
;	write_address -> Y+1
;	status -> R17
_0xC001A:
; 0006 0044     {
; 0006 0045         TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                /* Enable TWI, generate start condition and clear interru ...
	LDI  R30,LOW(164)
	OUT  0x36,R30
; 0006 0046         while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (start condition)  ...
_0xC001D:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC001D
; 0006 0047         status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits * ...
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0006 0048         if (status != 0x08)                                    /* Check weather start condition transmitted successfully ...
	CPI  R17,8
	BRNE _0xC001A
; 0006 0049         continue;                                            /* If no then continue with start loop again */
; 0006 004A         TWDR = write_address;                                /* If yes then write SLA+W in TWI data register */
	CALL SUBOPT_0x3
; 0006 004B         TWCR = (1<<TWEN)|(1<<TWINT);                        /* Enable TWI and clear interrupt flag */
; 0006 004C         while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (Write operation)  ...
_0xC0021:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC0021
; 0006 004D         status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits * ...
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0006 004E         if (status != 0x18 )                                /* Check weather SLA+W transmitted & ack received or not? */
	CPI  R17,24
	BREQ _0xC0024
; 0006 004F         {
; 0006 0050             I2C_Stop2();                                        /* If not then generate stop condition */
	RCALL _I2C_Stop2
; 0006 0051             //i2c_stop();
; 0006 0052             continue;                                        /* continue with start loop again */
	RJMP _0xC001A
; 0006 0053         }
; 0006 0054         break;                                                /* If yes then break loop */
_0xC0024:
; 0006 0055     }
; 0006 0056 }
	JMP  _0x214000C
; .FEND
;
;char I2C_Write2(char data)                                /* I2C write function */
; 0006 0059 {
_I2C_Write2:
; .FSTART _I2C_Write2
; 0006 005A     char status;                                            /* Declare variable */
; 0006 005B     TWDR = data;                                            /* Copy data in TWI data register */
	ST   -Y,R26
	ST   -Y,R17
;	data -> Y+1
;	status -> R17
	CALL SUBOPT_0x3
; 0006 005C     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0006 005D     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
_0xC0025:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC0025
; 0006 005E     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0006 005F     if (status == 0x28)                                        /* Check weather data transmitted & ack received or not?  ...
	CPI  R17,40
	BRNE _0xC0028
; 0006 0060     return 0;                                                /* If yes then return 0 to indicate ack received */
	LDI  R30,LOW(0)
	JMP  _0x214000C
; 0006 0061     if (status == 0x30)                                        /* Check weather data transmitted & nack received or not? ...
_0xC0028:
	CPI  R17,48
	BRNE _0xC0029
; 0006 0062     return 1;                                                /* If yes then return 1 to indicate nack received */
	LDI  R30,LOW(1)
	JMP  _0x214000C
; 0006 0063     else
_0xC0029:
; 0006 0064     return 2;                                                /* Else return 2 to indicate data transmission failed */
	LDI  R30,LOW(2)
	JMP  _0x214000C
; 0006 0065 }
; .FEND
;
;char I2C_Read_Ack()                                            /* I2C read ack function */
; 0006 0068 {
_I2C_Read_Ack:
; .FSTART _I2C_Read_Ack
; 0006 0069     TWCR=(1<<TWEN)|(1<<TWINT)|(1<<TWEA);                    /* Enable TWI, generation of ack and clear interrupt flag */
	LDI  R30,LOW(196)
	OUT  0x36,R30
; 0006 006A     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) * ...
_0xC002B:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC002B
; 0006 006B     return TWDR;                                            /* Return received data */
	RJMP _0x2140010
; 0006 006C }
; .FEND
;
;char I2C_Read_Nack()                                        /* I2C read nack function */
; 0006 006F {
_I2C_Read_Nack:
; .FSTART _I2C_Read_Nack
; 0006 0070     TWCR=(1<<TWEN)|(1<<TWINT);                                /* Enable TWI and clear interrupt flag */
	LDI  R30,LOW(132)
	OUT  0x36,R30
; 0006 0071     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) * ...
_0xC002E:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xC002E
; 0006 0072     return TWDR;                                            /* Return received data */
_0x2140010:
	IN   R30,0x3
	RET
; 0006 0073 }
; .FEND
;
;
;
;void I2C_Slave_Init(char slave_address)
; 0006 0078 {
; 0006 0079 	TWAR = slave_address;						/* Assign address in TWI address register */
;	slave_address -> Y+0
; 0006 007A 	TWCR = (1<<TWEN) | (1<<TWEA) | (1<<TWINT);	/* Enable TWI, Enable ack generation, clear TWI interrupt */
; 0006 007B }
;
;char I2C_Slave_Listen()
; 0006 007E {
; 0006 007F 	while(1)
; 0006 0080 	{
; 0006 0081 		char status;							/* Declare variable */
; 0006 0082 		while (!(TWCR & (1<<TWINT)));			/* Wait to be addressed */
;	status -> Y+0
; 0006 0083 		status = TWSR & 0xF8;					/* Read TWI status register with masking lower three bits */
; 0006 0084 		if (status == 0x60 || status == 0x68)	/* Check weather own SLA+W received & ack returned (TWEA = 1) */
; 0006 0085 		return 0;								/* If yes then return 0 to indicate ack returned */
; 0006 0086 		if (status == 0xA8 || status == 0xB0)	/* Check weather own SLA+R received & ack returned (TWEA = 1) */
; 0006 0087 		return 1;								/* If yes then return 1 to indicate ack returned */
; 0006 0088 		if (status == 0x70 || status == 0x78)	/* Check weather general call received & ack returned (TWEA = 1) */
; 0006 0089 		return 2;								/* If yes then return 2 to indicate ack returned */
; 0006 008A 		else
; 0006 008B 		continue;								/* Else continue */
; 0006 008C 	}
; 0006 008D }
;
;char I2C_Slave_Transmit(char data)
; 0006 0090 {
; 0006 0091 	char status;
; 0006 0092 	TWDR = data;								/* Write data to TWDR to be transmitted */
;	data -> Y+1
;	status -> R17
; 0006 0093 	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWEA);		/* Enable TWI and clear interrupt flag */
; 0006 0094 	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (Write operation) */
; 0006 0095 	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
; 0006 0096 	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
; 0006 0097 	{
; 0006 0098 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -1 */
; 0006 0099 		return -1;
; 0006 009A 	}
; 0006 009B 	if (status == 0xB8)							/* Check weather data transmitted & ack received */
; 0006 009C 		return 0;									/* If yes then return 0 */
; 0006 009D 	if (status == 0xC0)							/* Check weather data transmitted & nack received */
; 0006 009E 	{
; 0006 009F 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -2 */
; 0006 00A0 		return -2;
; 0006 00A1 	}
; 0006 00A2 	if (status == 0xC8)							/* If last data byte transmitted with ack received TWEA = 0 */
; 0006 00A3 	return -3;									/* If yes then return -3 */
; 0006 00A4 	else										/* else return -4 */
; 0006 00A5 	return -4;
; 0006 00A6 }
;
;char I2C_Slave_Receive()
; 0006 00A9 {
; 0006 00AA 	char status;								/* Declare variable */
; 0006 00AB 	TWCR=(1<<TWEN)|(1<<TWEA)|(1<<TWINT);		/* Enable TWI, generation of ack and clear interrupt flag */
;	status -> R17
; 0006 00AC 	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (read operation) */
; 0006 00AD 	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
; 0006 00AE 	if (status == 0x80 || status == 0x90)		/* Check weather data received & ack returned (TWEA = 1) */
; 0006 00AF 	return TWDR;								/* If yes then return received data */
; 0006 00B0 	if (status == 0x88 || status == 0x98)		/* Check weather data received, nack returned and switched to not addressed slav ...
; 0006 00B1 	return TWDR;								/* If yes then return received data */
; 0006 00B2 	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
; 0006 00B3 	{
; 0006 00B4 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return 0 */
; 0006 00B5 		return -1;
; 0006 00B6 	}
; 0006 00B7 	else
; 0006 00B8 	return -2;									/* Else return 1 */
; 0006 00B9 }
;  #include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;  #include <i2c_e.h>
;  #include <mandala2.h>
;
;volatile eeprom char data_rec[512];
;
;/* read a byte from the EEPROM */
;unsigned char eeprom_read(unsigned int address)
; 0007 0009 {

	.CSEG
; 0007 000A unsigned char data;
; 0007 000B i2c_start();
;	address -> Y+1
;	data -> R17
; 0007 000C i2c_write(EEPROM_BUS_ADDRESS | 0);
; 0007 000D /* send MSB of address */
; 0007 000E i2c_write(address >> 8);
; 0007 000F /* send LSB of address */
; 0007 0010 i2c_write((unsigned char) address);
; 0007 0011 i2c_start();
; 0007 0012 i2c_write(EEPROM_BUS_ADDRESS | 1);
; 0007 0013 data=i2c_read(0);
; 0007 0014 i2c_stop();
; 0007 0015 return data;
; 0007 0016 }
;
;/*********************************************/
;/* read a byte from the EEPROM */
;unsigned char eeprom_read_frame(unsigned int address,int num)
; 0007 001B {
_eeprom_read_frame:
; .FSTART _eeprom_read_frame
; 0007 001C int i,j;
; 0007 001D 
; 0007 001E unsigned char data;
; 0007 001F 
; 0007 0020 if (address!=0)j=4;
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR6
;	address -> Y+8
;	num -> Y+6
;	i -> R16,R17
;	j -> R18,R19
;	data -> R21
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BREQ _0xE0003
	__GETWRN 18,19,4
; 0007 0021 else j=0;
	RJMP _0xE0004
_0xE0003:
	__GETWRN 18,19,0
; 0007 0022 
; 0007 0023 i2c_start();
_0xE0004:
	CALL _i2c_start
; 0007 0024 i2c_write(EEPROM_BUS_ADDRESS | 0);
	LDI  R26,LOW(160)
	CALL _i2c_write
; 0007 0025 /* send MSB of address */
; 0007 0026 i2c_write(address >> 8);
	LDD  R26,Y+9
	CALL _i2c_write
; 0007 0027 /* send LSB of address */
; 0007 0028 //i2c_write((unsigned char) address);
; 0007 0029 i2c_write( address&0x00ff);
	LDD  R30,Y+8
	MOV  R26,R30
	CALL _i2c_write
; 0007 002A i2c_start();
	CALL _i2c_start
; 0007 002B i2c_write(EEPROM_BUS_ADDRESS | 1);
	LDI  R26,LOW(161)
	CALL _i2c_write
; 0007 002C for(i=j;i<num;i++)
	MOVW R16,R18
_0xE0006:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0xE0007
; 0007 002D {
; 0007 002E if(i==(num-1))data_rec[i]=i2c_read(0);
	SBIW R30,1
	CP   R30,R16
	CPC  R31,R17
	BRNE _0xE0008
	MOVW R30,R16
	SUBI R30,LOW(-_data_rec)
	SBCI R31,HIGH(-_data_rec)
	PUSH R31
	PUSH R30
	LDI  R26,LOW(0)
	CALL _i2c_read
	POP  R26
	POP  R27
	RJMP _0xE001F
; 0007 002F else data_rec[i]=i2c_read(1);
_0xE0008:
	MOVW R30,R16
	SUBI R30,LOW(-_data_rec)
	SBCI R31,HIGH(-_data_rec)
	PUSH R31
	PUSH R30
	LDI  R26,LOW(1)
	CALL _i2c_read
	POP  R26
	POP  R27
_0xE001F:
	CALL __EEPROMWRB
; 0007 0030 data=data_rec[i];
	LDI  R26,LOW(_data_rec)
	LDI  R27,HIGH(_data_rec)
	ADD  R26,R16
	ADC  R27,R17
	CALL __EEPROMRDB
	MOV  R21,R30
; 0007 0031 }
	__ADDWRN 16,17,1
	RJMP _0xE0006
_0xE0007:
; 0007 0032 i2c_stop();
	CALL _i2c_stop
; 0007 0033 return data;
	MOV  R30,R21
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; 0007 0034 }
; .FEND
;/*************************************/
;
;/* write a byte to the EEPROM */
;void eeprom_write(unsigned int address, unsigned char data)
; 0007 0039 {
; 0007 003A i2c_start();
;	address -> Y+1
;	data -> Y+0
; 0007 003B i2c_write(EEPROM_BUS_ADDRESS | 0);
; 0007 003C /* send MSB of address */
; 0007 003D i2c_write(address >> 8);
; 0007 003E /* send LSB of address */
; 0007 003F i2c_write((unsigned char) address);
; 0007 0040 i2c_write(data);
; 0007 0041 i2c_stop();
; 0007 0042 /* 10ms delay to complete the write operation */
; 0007 0043 delay_ms(10);
; 0007 0044 }
;
;
;/* write a frame to the EEPROM */
;void eeprom_write_frame(unsigned int address, char *data,char num )
; 0007 0049 {
; 0007 004A char i;
; 0007 004B char *ip;
; 0007 004C ip=data;
;	address -> Y+7
;	*data -> Y+5
;	num -> Y+4
;	i -> R17
;	*ip -> R18,R19
; 0007 004D 
; 0007 004E i2c_start();
; 0007 004F i2c_write(EEPROM_BUS_ADDRESS | 0);
; 0007 0050 /* send MSB of address */
; 0007 0051 i2c_write(address >> 8);
; 0007 0052 /* send LSB of address */
; 0007 0053 i2c_write((unsigned char) address);
; 0007 0054 for (i=0;i<num;i++)
; 0007 0055 {
; 0007 0056 i2c_write(*(ip+i));
; 0007 0057 }
; 0007 0058 i2c_stop();
; 0007 0059 /* 10ms delay to complete the write operation */
; 0007 005A delay_ms(10);
; 0007 005B }
;
;
;void eeprom_write_pic(unsigned int address )
; 0007 005F {
_eeprom_write_pic:
; .FSTART _eeprom_write_pic
; 0007 0060 char i;
; 0007 0061 
; 0007 0062 
; 0007 0063 
; 0007 0064 i2c_start();
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
;	address -> Y+1
;	i -> R17
	CALL _i2c_start
; 0007 0065 i2c_write(EEPROM_BUS_ADDRESS | 0);
	LDI  R26,LOW(160)
	CALL _i2c_write
; 0007 0066 //I2C_Write2(EEPROM_BUS_ADDRESS | 0);
; 0007 0067 
; 0007 0068 /* send MSB of address */
; 0007 0069 i2c_write(address >> 8);
	LDD  R26,Y+2
	CALL _i2c_write
; 0007 006A /* send LSB of address */
; 0007 006B i2c_write((unsigned char) address);
	LDD  R26,Y+1
	CALL _i2c_write
; 0007 006C for (i=0;i<16;i++)
	LDI  R17,LOW(0)
_0xE000E:
	CPI  R17,16
	BRSH _0xE000F
; 0007 006D {
; 0007 006E i2c_write(mandalapic[i+address]);
	MOV  R30,R17
	LDI  R31,0
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADD  R30,R26
	ADC  R31,R27
	SUBI R30,LOW(-_mandalapic*2)
	SBCI R31,HIGH(-_mandalapic*2)
	LPM  R26,Z
	CALL _i2c_write
; 0007 006F 
; 0007 0070 }
	SUBI R17,-1
	RJMP _0xE000E
_0xE000F:
; 0007 0071 i2c_stop();
	CALL _i2c_stop
; 0007 0072 /* 10ms delay to complete the write operation */
; 0007 0073 delay_ms(10);
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0007 0074 }
	JMP  _0x214000F
; .FEND
;
;
;void i2c_24lc32(void)
; 0007 0078 {
; 0007 0079 unsigned char j;
; 0007 007A  char data[]={1,2,3};
; 0007 007B 
; 0007 007C i2c_init();
;	j -> R17
;	data -> Y+1
; 0007 007D 
; 0007 007E 
; 0007 007F 
; 0007 0080 
; 0007 0081 
; 0007 0082 
; 0007 0083 /* write the byte 55h at address AAh */
; 0007 0084 eeprom_write(0xaa,data[0]);
; 0007 0085 eeprom_write(0xab,data[1]);
; 0007 0086 eeprom_write(0xac,data[2]);
; 0007 0087 
; 0007 0088 
; 0007 0089 /* read the byte from address AAh */
; 0007 008A j=eeprom_read(0xaa);
; 0007 008B j=eeprom_read(0xab);
; 0007 008C j=eeprom_read(0xac);
; 0007 008D }
;
;
;void i2c_24lc32_frame(void)
; 0007 0091 {
_i2c_24lc32_frame:
; .FSTART _i2c_24lc32_frame
; 0007 0092 int i;
; 0007 0093 long int data2;
; 0007 0094 
; 0007 0095 
; 0007 0096 i2c_init();
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
;	data2 -> Y+2
	CALL _i2c_init
; 0007 0097 
; 0007 0098 for (i=0;i<64;i++)
	__GETWRN 16,17,0
_0xE0011:
	__CPWRN 16,17,64
	BRGE _0xE0012
; 0007 0099 {
; 0007 009A data2=i*0x0010;
	MOVW R30,R16
	CALL __LSLW4
	CALL __CWD1
	CALL SUBOPT_0x4
; 0007 009B eeprom_write_pic(data2);
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL _eeprom_write_pic
; 0007 009C }
	__ADDWRN 16,17,1
	RJMP _0xE0011
_0xE0012:
; 0007 009D }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x214000A
; .FEND
;
;
;void i2c_24lc32_read_frame(void)
; 0007 00A1 {
_i2c_24lc32_read_frame:
; .FSTART _i2c_24lc32_read_frame
; 0007 00A2  int i;
; 0007 00A3  char scr[20];
; 0007 00A4 
; 0007 00A5 glcd_clear();
	SBIW R28,20
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16,R17
;	scr -> Y+2
	CALL _glcd_clear
; 0007 00A6 
; 0007 00A7 eeprom_read_frame(0,512);  //4  508
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x5
; 0007 00A8 glcd_putimagee(4,0,data_rec,GLCD_PUTCOPY);
	LDI  R30,LOW(0)
	CALL SUBOPT_0x6
; 0007 00A9 
; 0007 00AA eeprom_read_frame(516,512);
	LDI  R30,LOW(516)
	LDI  R31,HIGH(516)
	CALL SUBOPT_0x5
; 0007 00AB glcd_putimagee(4,32,data_rec,GLCD_PUTCOPY);
	LDI  R30,LOW(32)
	CALL SUBOPT_0x6
; 0007 00AC }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,22
	RET
; .FEND
;
;
;/*************************************/
;void i2c_24lc32_read_byte(void)
; 0007 00B1 {
; 0007 00B2  char i;
; 0007 00B3  char data=0xff;
; 0007 00B4  char scr[20];
; 0007 00B5  for (i=0;i<1024;i++)
;	i -> R17
;	data -> R16
;	scr -> Y+2
; 0007 00B6  {
; 0007 00B7  data=eeprom_read(i);
; 0007 00B8  if (data !=mandalapic[i])
; 0007 00B9   {
; 0007 00BA     sprintf(scr,"error [%d]=%d\r\n",i,data);
; 0007 00BB     puts(scr);
; 0007 00BC 
; 0007 00BD     }
; 0007 00BE     }
; 0007 00BF 
; 0007 00C0 
; 0007 00C1 }
;
;void i2c_24lc32_read_byte2(void)
; 0007 00C4 {
; 0007 00C5  int i;
; 0007 00C6  char data=0xff;
; 0007 00C7  char scr[20];
; 0007 00C8  for (i=0;i<512;i++)
;	i -> R16,R17
;	data -> R19
;	scr -> Y+4
; 0007 00C9  {
; 0007 00CA  data_rec[i]=eeprom_read(i);
; 0007 00CB  if (data_rec[i] ==mandalapic[i])
; 0007 00CC   {
; 0007 00CD     sprintf(scr,"error [%d]=%d--%d\r\n",i,data_rec[i],mandalapic[i]);
; 0007 00CE     puts(scr);
; 0007 00CF 
; 0007 00D0     }
; 0007 00D1     }
; 0007 00D2      sprintf(scr,"data correct\r\n");
; 0007 00D3     puts(scr);
; 0007 00D4 
; 0007 00D5  for (i=512;i<1024;i++)
; 0007 00D6  {
; 0007 00D7  data_rec[i]=eeprom_read(i+512);
; 0007 00D8  if (data_rec[i] ==mandalapic[i+512])
; 0007 00D9   {
; 0007 00DA     sprintf(scr,"error [%d]=%d--%d\r\n",i,data_rec[i],mandalapic[i+512]);
; 0007 00DB     puts(scr);
; 0007 00DC 
; 0007 00DD     }
; 0007 00DE     }
; 0007 00DF 
; 0007 00E0       sprintf(scr,"data correct\r\n");
; 0007 00E1     puts(scr);
; 0007 00E2 }
;
;
;
;/*
;Programming steps in the master device
;
;    Initialize I2C.
;    Generate START condition.
;    Write device Write address (SLA+W) and check for acknowledgement.
;    After acknowledgement write data to slave device.
;    Generate REPEATED START condition with SLA+R.
;    Receive data from slave device.
;
;
;Programming steps in slave device
;
;    Initialize I2C with slave device address.
;    Listen to bus for get addressed by master.
;    While addressed with SLA+W by master device, receive data from master device.
;    Return acknowledgement after each byte received.
;    Clear interrupt flag after REPEATED START/STOP received.
;    Print received data on LCD.
;    Again listen to bus for get addressed by master.
;    While addressed with SLA+R by master device, transmit data to master device.
;    Transmit data till NACK/REPEATED START/STOP receive from master.
;    Clear interrupt flag after NACK/REPEATED START/STOP received.
;
;
;    https://www.avrfreaks.net/forum/twi-module-seems-buggy-multi-master-communications
;*/
;
;
;#include <myheader.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <mandala2.h>
;
;void glcddisplay(void)
; 0008 0005 {

	.CSEG
_glcddisplay:
; .FSTART _glcddisplay
; 0008 0006  GLCDINIT_t glcd_init_data;
; 0008 0007 
; 0008 0008 
; 0008 0009 glcd_init_data.font=font5x7;
	SBIW R28,6
;	glcd_init_data -> Y+0
	LDI  R30,LOW(_font5x7*2)
	LDI  R31,HIGH(_font5x7*2)
	ST   Y,R30
	STD  Y+1,R31
; 0008 000A glcd_init_data.readxmem=NULL;
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0008 000B glcd_init_data.writexmem=NULL;
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0008 000C glcd_init(&glcd_init_data);
	MOVW R26,R28
	CALL _glcd_init
; 0008 000D 
; 0008 000E 
; 0008 000F glcd_putimagef(0,0,mandalapic,GLCD_PUTCOPY);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(_mandalapic*2)
	LDI  R31,HIGH(_mandalapic*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _glcd_putimagef
; 0008 0010 
; 0008 0011 
; 0008 0012 }
	JMP  _0x214000A
; .FEND
;void glcd_init_func(void)
; 0008 0014 {
; 0008 0015  GLCDINIT_t glcd_init_data;
; 0008 0016 
; 0008 0017 
; 0008 0018 glcd_init_data.font=font5x7;
;	glcd_init_data -> Y+0
; 0008 0019 glcd_init_data.readxmem=NULL;
; 0008 001A glcd_init_data.writexmem=NULL;
; 0008 001B glcd_init(&glcd_init_data);
; 0008 001C 
; 0008 001D //glcd_putimagef(0,0,mandalapic,GLCD_PUTCOPY);
; 0008 001E 
; 0008 001F }
;
;void glcddisplay2(void)
; 0008 0022 {
; 0008 0023  GLCDINIT_t glcd_init_data;
; 0008 0024 
; 0008 0025 
; 0008 0026 glcd_init_data.font=font5x7;
;	glcd_init_data -> Y+0
; 0008 0027 glcd_init_data.readxmem=NULL;
; 0008 0028 glcd_init_data.writexmem=NULL;
; 0008 0029 glcd_init(&glcd_init_data);
; 0008 002A 
; 0008 002B glcd_putimagee(0,0,data_rec,GLCD_PUTCOPY);
; 0008 002C 
; 0008 002D }
;
;//void clock_display(void)
;//{
;//glcd_init_func();
;//glcd_putimagef(0,0,clock,GLCD_PUTCOPY);
;//}
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_puts:
; .FSTART _puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000003:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000005
	MOV  R26,R17
	CALL _putchar
	RJMP _0x2000003
_0x2000005:
	LDI  R26,LOW(10)
	CALL _putchar
_0x214000F:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_put_buff_G100:
; .FSTART _put_buff_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2000013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2000014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0x7
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0x7
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0x8
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x9
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x8
	CALL SUBOPT_0xA
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x8
	CALL SUBOPT_0xA
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0x8
	CALL SUBOPT_0xB
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0x8
	CALL SUBOPT_0xB
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0x7
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x9
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0x7
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x9
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
_0x214000E:
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0xC
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x214000D
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0xC
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x214000D:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
_twi_int_handler:
; .FSTART _twi_int_handler
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	CALL __SAVELOCR6
	LDS  R17,_twi_rx_index
	LDS  R16,_twi_tx_index
	LDS  R19,_bytes_to_tx_G101
	LDS  R18,_twi_result
	MOV  R30,R17
	LDS  R26,_twi_rx_buffer_G101
	LDS  R27,_twi_rx_buffer_G101+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R20,R30
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	CPI  R30,LOW(0x8)
	BRNE _0x2020017
	LDI  R18,LOW(0)
	RJMP _0x2020018
_0x2020017:
	CPI  R30,LOW(0x10)
	BRNE _0x2020019
_0x2020018:
	LDS  R30,_slave_address_G101
	RJMP _0x2020067
_0x2020019:
	CPI  R30,LOW(0x18)
	BREQ _0x202001D
	CPI  R30,LOW(0x28)
	BRNE _0x202001E
_0x202001D:
	CP   R16,R19
	BRSH _0x202001F
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G101
	LDS  R27,_twi_tx_buffer_G101+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x2020067:
	OUT  0x3,R30
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	OUT  0x36,R30
	RJMP _0x2020020
_0x202001F:
	LDS  R30,_bytes_to_rx_G101
	CP   R17,R30
	BRSH _0x2020021
	LDS  R30,_slave_address_G101
	ORI  R30,1
	STS  _slave_address_G101,R30
	CLT
	BLD  R2,3
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xA0)
	OUT  0x36,R30
	RJMP _0x2020016
_0x2020021:
	RJMP _0x2020022
_0x2020020:
	RJMP _0x2020016
_0x202001E:
	CPI  R30,LOW(0x50)
	BRNE _0x2020023
	IN   R30,0x3
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2020024
_0x2020023:
	CPI  R30,LOW(0x40)
	BRNE _0x2020025
_0x2020024:
	LDS  R30,_bytes_to_rx_G101
	SUBI R30,LOW(1)
	CP   R17,R30
	BRLO _0x2020026
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2020068
_0x2020026:
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x2020068:
	OUT  0x36,R30
	RJMP _0x2020016
_0x2020025:
	CPI  R30,LOW(0x58)
	BRNE _0x2020028
	IN   R30,0x3
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2020029
_0x2020028:
	CPI  R30,LOW(0x20)
	BRNE _0x202002A
_0x2020029:
	RJMP _0x202002B
_0x202002A:
	CPI  R30,LOW(0x30)
	BRNE _0x202002C
_0x202002B:
	RJMP _0x202002D
_0x202002C:
	CPI  R30,LOW(0x48)
	BRNE _0x202002E
_0x202002D:
	CPI  R18,0
	BRNE _0x202002F
	SBRS R2,3
	RJMP _0x2020030
	CP   R16,R19
	BRLO _0x2020032
	RJMP _0x2020033
_0x2020030:
	LDS  R30,_bytes_to_rx_G101
	CP   R17,R30
	BRSH _0x2020034
_0x2020032:
	LDI  R18,LOW(4)
_0x2020034:
_0x2020033:
_0x202002F:
_0x2020022:
	RJMP _0x2020069
_0x202002E:
	CPI  R30,LOW(0x38)
	BRNE _0x2020037
	LDI  R18,LOW(2)
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x202006A
_0x2020037:
	CPI  R30,LOW(0x68)
	BREQ _0x202003A
	CPI  R30,LOW(0x78)
	BRNE _0x202003B
_0x202003A:
	LDI  R18,LOW(2)
	RJMP _0x202003C
_0x202003B:
	CPI  R30,LOW(0x60)
	BREQ _0x202003F
	CPI  R30,LOW(0x70)
	BRNE _0x2020040
_0x202003F:
	LDI  R18,LOW(0)
_0x202003C:
	LDI  R17,LOW(0)
	CLT
	BLD  R2,3
	LDS  R30,_twi_rx_buffer_size_G101
	CPI  R30,0
	BRNE _0x2020041
	LDI  R18,LOW(1)
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x202006B
_0x2020041:
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x202006B:
	OUT  0x36,R30
	RJMP _0x2020016
_0x2020040:
	CPI  R30,LOW(0x80)
	BREQ _0x2020044
	CPI  R30,LOW(0x90)
	BRNE _0x2020045
_0x2020044:
	SBRS R2,3
	RJMP _0x2020046
	LDI  R18,LOW(1)
	RJMP _0x2020047
_0x2020046:
	IN   R30,0x3
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	LDS  R30,_twi_rx_buffer_size_G101
	CP   R17,R30
	BRSH _0x2020048
	LDS  R30,_twi_slave_rx_handler_G101
	LDS  R31,_twi_slave_rx_handler_G101+1
	SBIW R30,0
	BRNE _0x2020049
	LDI  R18,LOW(6)
	RJMP _0x2020047
_0x2020049:
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_rx_handler_G101,0
	CPI  R30,0
	BREQ _0x202004A
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	OUT  0x36,R30
	RJMP _0x2020016
_0x202004A:
	RJMP _0x202004B
_0x2020048:
	SET
	BLD  R2,3
_0x202004B:
	RJMP _0x202004C
_0x2020045:
	CPI  R30,LOW(0x88)
	BRNE _0x202004D
_0x202004C:
	RJMP _0x202004E
_0x202004D:
	CPI  R30,LOW(0x98)
	BRNE _0x202004F
_0x202004E:
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	OUT  0x36,R30
	RJMP _0x2020016
_0x202004F:
	CPI  R30,LOW(0xA0)
	BRNE _0x2020050
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	OUT  0x36,R30
	SET
	BLD  R2,4
	LDS  R30,_twi_slave_rx_handler_G101
	LDS  R31,_twi_slave_rx_handler_G101+1
	SBIW R30,0
	BREQ _0x2020051
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_rx_handler_G101,0
	RJMP _0x2020052
_0x2020051:
	LDI  R18,LOW(6)
_0x2020052:
	RJMP _0x2020016
_0x2020050:
	CPI  R30,LOW(0xB0)
	BRNE _0x2020053
	LDI  R18,LOW(2)
	RJMP _0x2020054
_0x2020053:
	CPI  R30,LOW(0xA8)
	BRNE _0x2020055
_0x2020054:
	LDS  R30,_twi_slave_tx_handler_G101
	LDS  R31,_twi_slave_tx_handler_G101+1
	SBIW R30,0
	BREQ _0x2020056
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_tx_handler_G101,0
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x2020058
	LDI  R18,LOW(0)
	RJMP _0x2020059
_0x2020056:
_0x2020058:
	LDI  R18,LOW(6)
	RJMP _0x2020047
_0x2020059:
	LDI  R16,LOW(0)
	CLT
	BLD  R2,3
	RJMP _0x202005A
_0x2020055:
	CPI  R30,LOW(0xB8)
	BRNE _0x202005B
_0x202005A:
	SBRS R2,3
	RJMP _0x202005C
	LDI  R18,LOW(1)
	RJMP _0x2020047
_0x202005C:
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G101
	LDS  R27,_twi_tx_buffer_G101+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	OUT  0x3,R30
	CP   R16,R19
	BRSH _0x202005D
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	RJMP _0x202006C
_0x202005D:
	SET
	BLD  R2,3
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
_0x202006C:
	OUT  0x36,R30
	RJMP _0x2020016
_0x202005B:
	CPI  R30,LOW(0xC0)
	BREQ _0x2020060
	CPI  R30,LOW(0xC8)
	BRNE _0x2020061
_0x2020060:
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	OUT  0x36,R30
	LDS  R30,_twi_slave_tx_handler_G101
	LDS  R31,_twi_slave_tx_handler_G101+1
	SBIW R30,0
	BREQ _0x2020062
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_tx_handler_G101,0
_0x2020062:
	RJMP _0x2020035
_0x2020061:
	CPI  R30,0
	BRNE _0x2020016
	LDI  R18,LOW(3)
_0x2020047:
_0x2020069:
	IN   R30,0x36
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xD0)
_0x202006A:
	OUT  0x36,R30
_0x2020035:
	SET
	BLD  R2,4
_0x2020016:
	STS  _twi_rx_index,R17
	STS  _twi_tx_index,R16
	STS  _twi_result,R18
	STS  _bytes_to_tx_G101,R19
	CALL __LOADLOCR6
	ADIW R28,6
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_ks0108_enable_G102:
; .FSTART _ks0108_enable_G102
	nop
	SBI  0x1B,2
	nop
	RET
; .FEND
_ks0108_disable_G102:
; .FSTART _ks0108_disable_G102
	CBI  0x1B,2
	SBI  0x1B,7
	SBI  0x1B,6
	RET
; .FEND
_ks0108_rdbus_G102:
; .FSTART _ks0108_rdbus_G102
	ST   -Y,R17
	RCALL _ks0108_enable_G102
	LDI  R17,LOW(0)
	SBIC 0x16,0
	LDI  R17,LOW(1)
	SBIC 0x16,1
	ORI  R17,LOW(2)
	SBIC 0x10,2
	ORI  R17,LOW(4)
	SBIC 0x10,3
	ORI  R17,LOW(8)
	SBIC 0x10,4
	ORI  R17,LOW(16)
	SBIC 0x10,5
	ORI  R17,LOW(32)
	SBIC 0x10,6
	ORI  R17,LOW(64)
	SBIC 0x10,7
	ORI  R17,LOW(128)
	CBI  0x1B,2
	MOV  R30,R17
	LD   R17,Y+
	RET
; .FEND
_ks0108_busy_G102:
; .FSTART _ks0108_busy_G102
	ST   -Y,R26
	ST   -Y,R17
	CALL SUBOPT_0xD
	CBI  0x1B,4
	LDD  R26,Y+1
	LDI  R30,LOW(2)
	SUB  R30,R26
	MOV  R17,R30
	SBRS R17,0
	RJMP _0x204000B
	SBI  0x1B,7
	RJMP _0x204000C
_0x204000B:
	CBI  0x1B,7
_0x204000C:
	SBRS R17,1
	RJMP _0x204000D
	SBI  0x1B,6
	RJMP _0x204000E
_0x204000D:
	CBI  0x1B,6
_0x204000E:
_0x204000F:
	RCALL _ks0108_rdbus_G102
	ANDI R30,LOW(0x80)
	BRNE _0x204000F
_0x214000C:
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
_ks0108_wrcmd_G102:
; .FSTART _ks0108_wrcmd_G102
	ST   -Y,R26
	LDD  R26,Y+1
	RCALL _ks0108_busy_G102
	CALL SUBOPT_0xE
	BREQ _0x2040012
	SBI  0x18,0
	RJMP _0x2040013
_0x2040012:
	CBI  0x18,0
_0x2040013:
	LD   R30,Y
	ANDI R30,LOW(0x2)
	BREQ _0x2040014
	SBI  0x18,1
	RJMP _0x2040015
_0x2040014:
	CBI  0x18,1
_0x2040015:
	LD   R30,Y
	ANDI R30,LOW(0x4)
	BREQ _0x2040016
	SBI  0x12,2
	RJMP _0x2040017
_0x2040016:
	CBI  0x12,2
_0x2040017:
	LD   R30,Y
	ANDI R30,LOW(0x8)
	BREQ _0x2040018
	SBI  0x12,3
	RJMP _0x2040019
_0x2040018:
	CBI  0x12,3
_0x2040019:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x204001A
	SBI  0x12,4
	RJMP _0x204001B
_0x204001A:
	CBI  0x12,4
_0x204001B:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x204001C
	SBI  0x12,5
	RJMP _0x204001D
_0x204001C:
	CBI  0x12,5
_0x204001D:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x204001E
	SBI  0x12,6
	RJMP _0x204001F
_0x204001E:
	CBI  0x12,6
_0x204001F:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x2040020
	SBI  0x12,7
	RJMP _0x2040021
_0x2040020:
	CBI  0x12,7
_0x2040021:
	RCALL _ks0108_enable_G102
	RCALL _ks0108_disable_G102
	JMP  _0x2140003
; .FEND
_ks0108_setloc_G102:
; .FSTART _ks0108_setloc_G102
	__GETB1MN _ks0108_coord_G102,1
	ST   -Y,R30
	LDS  R30,_ks0108_coord_G102
	ANDI R30,LOW(0x3F)
	ORI  R30,0x40
	MOV  R26,R30
	RCALL _ks0108_wrcmd_G102
	__GETB1MN _ks0108_coord_G102,1
	ST   -Y,R30
	__GETB1MN _ks0108_coord_G102,2
	ORI  R30,LOW(0xB8)
	MOV  R26,R30
	RCALL _ks0108_wrcmd_G102
	RET
; .FEND
_ks0108_gotoxp_G102:
; .FSTART _ks0108_gotoxp_G102
	ST   -Y,R26
	LDD  R30,Y+1
	STS  _ks0108_coord_G102,R30
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	__PUTB1MN _ks0108_coord_G102,1
	LD   R30,Y
	__PUTB1MN _ks0108_coord_G102,2
	RCALL _ks0108_setloc_G102
	JMP  _0x2140003
; .FEND
_ks0108_nextx_G102:
; .FSTART _ks0108_nextx_G102
	LDS  R26,_ks0108_coord_G102
	SUBI R26,-LOW(1)
	STS  _ks0108_coord_G102,R26
	CPI  R26,LOW(0x80)
	BRLO _0x2040022
	LDI  R30,LOW(0)
	STS  _ks0108_coord_G102,R30
_0x2040022:
	LDS  R30,_ks0108_coord_G102
	ANDI R30,LOW(0x3F)
	BRNE _0x2040023
	LDS  R30,_ks0108_coord_G102
	ST   -Y,R30
	__GETB2MN _ks0108_coord_G102,2
	RCALL _ks0108_gotoxp_G102
_0x2040023:
	RET
; .FEND
_ks0108_wrdata_G102:
; .FSTART _ks0108_wrdata_G102
	ST   -Y,R26
	__GETB2MN _ks0108_coord_G102,1
	RCALL _ks0108_busy_G102
	SBI  0x1B,4
	CALL SUBOPT_0xE
	BREQ _0x2040024
	SBI  0x18,0
	RJMP _0x2040025
_0x2040024:
	CBI  0x18,0
_0x2040025:
	LD   R30,Y
	ANDI R30,LOW(0x2)
	BREQ _0x2040026
	SBI  0x18,1
	RJMP _0x2040027
_0x2040026:
	CBI  0x18,1
_0x2040027:
	LD   R30,Y
	ANDI R30,LOW(0x4)
	BREQ _0x2040028
	SBI  0x12,2
	RJMP _0x2040029
_0x2040028:
	CBI  0x12,2
_0x2040029:
	LD   R30,Y
	ANDI R30,LOW(0x8)
	BREQ _0x204002A
	SBI  0x12,3
	RJMP _0x204002B
_0x204002A:
	CBI  0x12,3
_0x204002B:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x204002C
	SBI  0x12,4
	RJMP _0x204002D
_0x204002C:
	CBI  0x12,4
_0x204002D:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x204002E
	SBI  0x12,5
	RJMP _0x204002F
_0x204002E:
	CBI  0x12,5
_0x204002F:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2040030
	SBI  0x12,6
	RJMP _0x2040031
_0x2040030:
	CBI  0x12,6
_0x2040031:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x2040032
	SBI  0x12,7
	RJMP _0x2040033
_0x2040032:
	CBI  0x12,7
_0x2040033:
	RCALL _ks0108_enable_G102
	RCALL _ks0108_disable_G102
_0x214000B:
	ADIW R28,1
	RET
; .FEND
_ks0108_rddata_G102:
; .FSTART _ks0108_rddata_G102
	__GETB2MN _ks0108_coord_G102,1
	RCALL _ks0108_busy_G102
	CALL SUBOPT_0xD
	SBI  0x1B,4
	RCALL _ks0108_rdbus_G102
	RET
; .FEND
_ks0108_rdbyte_G102:
; .FSTART _ks0108_rdbyte_G102
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	CALL SUBOPT_0xF
	RCALL _ks0108_rddata_G102
	RCALL _ks0108_setloc_G102
	RCALL _ks0108_rddata_G102
	JMP  _0x2140003
; .FEND
_glcd_init:
; .FSTART _glcd_init
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	SBI  0x1A,2
	SBI  0x1A,3
	SBI  0x1A,4
	SBI  0x1A,5
	SBI  0x1B,5
	SBI  0x1A,7
	SBI  0x1A,6
	RCALL _ks0108_disable_G102
	CBI  0x1B,5
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x1B,5
	LDI  R17,LOW(0)
_0x2040034:
	CPI  R17,2
	BRSH _0x2040036
	ST   -Y,R17
	LDI  R26,LOW(63)
	RCALL _ks0108_wrcmd_G102
	ST   -Y,R17
	INC  R17
	LDI  R26,LOW(192)
	RCALL _ks0108_wrcmd_G102
	RJMP _0x2040034
_0x2040036:
	LDI  R30,LOW(1)
	STS  _glcd_state,R30
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SBIW R30,0
	BREQ _0x2040037
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __GETW1P
	__PUTW1MN _glcd_state,4
	ADIW R26,2
	CALL __GETW1P
	__PUTW1MN _glcd_state,25
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,4
	CALL __GETW1P
	RJMP _0x20400D4
_0x2040037:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _glcd_state,4
	__PUTW1MN _glcd_state,25
_0x20400D4:
	__PUTW1MN _glcd_state,27
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,6
	__PUTB1MN _glcd_state,7
	__PUTB1MN _glcd_state,8
	LDI  R30,LOW(255)
	__PUTB1MN _glcd_state,9
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,16
	__POINTW1MN _glcd_state,17
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDI  R26,LOW(8)
	LDI  R27,0
	CALL _memset
	RCALL _glcd_clear
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	JMP  _0x2140002
; .FEND
_glcd_clear:
; .FSTART _glcd_clear
	CALL __SAVELOCR4
	LDI  R16,0
	LDI  R19,0
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x204003D
	LDI  R16,LOW(255)
_0x204003D:
_0x204003E:
	CPI  R19,8
	BRSH _0x2040040
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R19
	SUBI R19,-1
	RCALL _ks0108_gotoxp_G102
	LDI  R17,LOW(0)
_0x2040041:
	MOV  R26,R17
	SUBI R17,-1
	CPI  R26,LOW(0x80)
	BRSH _0x2040043
	MOV  R26,R16
	CALL SUBOPT_0x10
	RJMP _0x2040041
_0x2040043:
	RJMP _0x204003E
_0x2040040:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _ks0108_gotoxp_G102
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _glcd_moveto
	CALL __LOADLOCR4
	JMP  _0x2140001
; .FEND
_ks0108_wrmasked_G102:
; .FSTART _ks0108_wrmasked_G102
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+5
	ST   -Y,R30
	LDD  R26,Y+5
	RCALL _ks0108_rdbyte_G102
	MOV  R17,R30
	RCALL _ks0108_setloc_G102
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x2040053
	CPI  R30,LOW(0x8)
	BRNE _0x2040054
_0x2040053:
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+2
	CALL _glcd_mappixcolor1bit
	STD  Y+3,R30
	RJMP _0x2040055
_0x2040054:
	CPI  R30,LOW(0x3)
	BRNE _0x2040057
	LDD  R30,Y+3
	COM  R30
	STD  Y+3,R30
	RJMP _0x2040058
_0x2040057:
	CPI  R30,0
	BRNE _0x2040059
_0x2040058:
_0x2040055:
	LDD  R30,Y+2
	COM  R30
	AND  R17,R30
	RJMP _0x204005A
_0x2040059:
	CPI  R30,LOW(0x2)
	BRNE _0x204005B
_0x204005A:
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	OR   R17,R30
	RJMP _0x2040051
_0x204005B:
	CPI  R30,LOW(0x1)
	BRNE _0x204005C
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	EOR  R17,R30
	RJMP _0x2040051
_0x204005C:
	CPI  R30,LOW(0x4)
	BRNE _0x2040051
	LDD  R30,Y+2
	COM  R30
	LDD  R26,Y+3
	OR   R30,R26
	AND  R17,R30
_0x2040051:
	MOV  R26,R17
	CALL SUBOPT_0x10
	LDD  R17,Y+0
_0x214000A:
	ADIW R28,6
	RET
; .FEND
_glcd_block:
; .FSTART _glcd_block
	ST   -Y,R26
	SBIW R28,3
	CALL __SAVELOCR6
	LDD  R26,Y+16
	CPI  R26,LOW(0x80)
	BRSH _0x204005F
	LDD  R26,Y+15
	CPI  R26,LOW(0x40)
	BRSH _0x204005F
	LDD  R26,Y+14
	CPI  R26,LOW(0x0)
	BREQ _0x204005F
	LDD  R26,Y+13
	CPI  R26,LOW(0x0)
	BRNE _0x204005E
_0x204005F:
	RJMP _0x2140009
_0x204005E:
	LDD  R30,Y+14
	STD  Y+8,R30
	LDD  R26,Y+16
	CLR  R27
	LDD  R30,Y+14
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x81)
	LDI  R30,HIGH(0x81)
	CPC  R27,R30
	BRLO _0x2040061
	LDD  R26,Y+16
	LDI  R30,LOW(128)
	SUB  R30,R26
	STD  Y+14,R30
_0x2040061:
	LDD  R18,Y+13
	LDD  R26,Y+15
	CLR  R27
	LDD  R30,Y+13
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	CPI  R26,LOW(0x41)
	LDI  R30,HIGH(0x41)
	CPC  R27,R30
	BRLO _0x2040062
	LDD  R26,Y+15
	LDI  R30,LOW(64)
	SUB  R30,R26
	STD  Y+13,R30
_0x2040062:
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BREQ PC+2
	RJMP _0x2040063
	LDD  R30,Y+12
	CPI  R30,LOW(0x1)
	BRNE _0x2040067
	RJMP _0x2140009
_0x2040067:
	CPI  R30,LOW(0x3)
	BRNE _0x204006A
	__GETW1MN _glcd_state,27
	SBIW R30,0
	BRNE _0x2040069
	RJMP _0x2140009
_0x2040069:
_0x204006A:
	LDD  R16,Y+8
	LDD  R30,Y+13
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R19,R30
	MOV  R30,R18
	ANDI R30,LOW(0x7)
	BRNE _0x204006C
	LDD  R26,Y+13
	CP   R18,R26
	BREQ _0x204006B
_0x204006C:
	MOV  R26,R16
	CLR  R27
	MOV  R30,R19
	LDI  R31,0
	CALL __MULW12U
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CALL SUBOPT_0x11
	LSR  R18
	LSR  R18
	LSR  R18
	MOV  R21,R19
_0x204006E:
	PUSH R21
	SUBI R21,-1
	MOV  R30,R18
	POP  R26
	CP   R30,R26
	BRLO _0x2040070
	MOV  R17,R16
_0x2040071:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2040073
	CALL SUBOPT_0x12
	RJMP _0x2040071
_0x2040073:
	RJMP _0x204006E
_0x2040070:
_0x204006B:
	LDD  R26,Y+14
	CP   R16,R26
	BREQ _0x2040074
	LDD  R30,Y+14
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	CALL SUBOPT_0x11
	LDD  R30,Y+13
	ANDI R30,LOW(0x7)
	BREQ _0x2040075
	SUBI R19,-LOW(1)
_0x2040075:
	LDI  R18,LOW(0)
_0x2040076:
	PUSH R18
	SUBI R18,-1
	MOV  R30,R19
	POP  R26
	CP   R26,R30
	BRSH _0x2040078
	LDD  R17,Y+14
_0x2040079:
	PUSH R17
	SUBI R17,-1
	MOV  R30,R16
	POP  R26
	CP   R26,R30
	BRSH _0x204007B
	CALL SUBOPT_0x12
	RJMP _0x2040079
_0x204007B:
	LDD  R30,Y+14
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL SUBOPT_0x11
	RJMP _0x2040076
_0x2040078:
_0x2040074:
_0x2040063:
	LDD  R30,Y+15
	ANDI R30,LOW(0x7)
	MOV  R19,R30
_0x204007C:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE PC+2
	RJMP _0x204007E
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(0)
	LDD  R16,Y+16
	CPI  R19,0
	BREQ PC+2
	RJMP _0x204007F
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH PC+2
	RJMP _0x2040080
	LDD  R30,Y+9
	CPI  R30,0
	BREQ _0x2040085
	CPI  R30,LOW(0x3)
	BRNE _0x2040086
_0x2040085:
	RJMP _0x2040087
_0x2040086:
	CPI  R30,LOW(0x7)
	BRNE _0x2040088
_0x2040087:
	RJMP _0x2040089
_0x2040088:
	CPI  R30,LOW(0x8)
	BRNE _0x204008A
_0x2040089:
	RJMP _0x204008B
_0x204008A:
	CPI  R30,LOW(0x6)
	BRNE _0x204008C
_0x204008B:
	RJMP _0x204008D
_0x204008C:
	CPI  R30,LOW(0x9)
	BRNE _0x204008E
_0x204008D:
	RJMP _0x204008F
_0x204008E:
	CPI  R30,LOW(0xA)
	BRNE _0x2040083
_0x204008F:
	ST   -Y,R16
	LDD  R30,Y+16
	CALL SUBOPT_0xF
_0x2040083:
_0x2040091:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x2040093
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BRNE _0x2040094
	RCALL _ks0108_rddata_G102
	RCALL _ks0108_setloc_G102
	CALL SUBOPT_0x13
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ks0108_rddata_G102
	MOV  R26,R30
	CALL _glcd_writemem
	RCALL _ks0108_nextx_G102
	RJMP _0x2040095
_0x2040094:
	LDD  R30,Y+9
	CPI  R30,LOW(0x9)
	BRNE _0x2040099
	LDI  R21,LOW(0)
	RJMP _0x204009A
_0x2040099:
	CPI  R30,LOW(0xA)
	BRNE _0x2040098
	LDI  R21,LOW(255)
	RJMP _0x204009A
_0x2040098:
	CALL SUBOPT_0x13
	CALL SUBOPT_0x14
	MOV  R21,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x7)
	BREQ _0x20400A1
	CPI  R30,LOW(0x8)
	BRNE _0x20400A2
_0x20400A1:
_0x204009A:
	CALL SUBOPT_0x15
	MOV  R21,R30
	RJMP _0x20400A3
_0x20400A2:
	CPI  R30,LOW(0x3)
	BRNE _0x20400A5
	COM  R21
	RJMP _0x20400A6
_0x20400A5:
	CPI  R30,0
	BRNE _0x20400A8
_0x20400A6:
_0x20400A3:
	MOV  R26,R21
	CALL SUBOPT_0x10
	RJMP _0x204009F
_0x20400A8:
	CALL SUBOPT_0x16
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
_0x204009F:
_0x2040095:
	RJMP _0x2040091
_0x2040093:
	LDD  R30,Y+15
	SUBI R30,-LOW(8)
	STD  Y+15,R30
	LDD  R30,Y+13
	SUBI R30,LOW(8)
	STD  Y+13,R30
	RJMP _0x20400A9
_0x2040080:
	LDD  R21,Y+13
	LDI  R18,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x20400AA
_0x204007F:
	MOV  R30,R19
	LDD  R26,Y+13
	ADD  R26,R30
	CPI  R26,LOW(0x9)
	BRSH _0x20400AB
	LDD  R18,Y+13
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x20400AC
_0x20400AB:
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
_0x20400AC:
	ST   -Y,R19
	MOV  R26,R18
	CALL _glcd_getmask
	MOV  R20,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x20400B0
_0x20400B1:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400B3
	CALL SUBOPT_0x17
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSRB12
	CALL SUBOPT_0x18
	MOV  R30,R19
	MOV  R26,R20
	CALL __LSRB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x13
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x20400B1
_0x20400B3:
	RJMP _0x20400AF
_0x20400B0:
	CPI  R30,LOW(0x9)
	BRNE _0x20400B4
	LDI  R21,LOW(0)
	RJMP _0x20400B5
_0x20400B4:
	CPI  R30,LOW(0xA)
	BRNE _0x20400BB
	LDI  R21,LOW(255)
_0x20400B5:
	CALL SUBOPT_0x15
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	MOV  R21,R30
_0x20400B8:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400BA
	CALL SUBOPT_0x16
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400B8
_0x20400BA:
	RJMP _0x20400AF
_0x20400BB:
_0x20400BC:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400BE
	CALL SUBOPT_0x19
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400BC
_0x20400BE:
_0x20400AF:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE _0x20400BF
	RJMP _0x204007E
_0x20400BF:
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH _0x20400C0
	LDD  R30,Y+13
	SUB  R30,R18
	MOV  R21,R30
	LDI  R30,LOW(0)
	RJMP _0x20400D5
_0x20400C0:
	MOV  R21,R19
	LDD  R30,Y+13
	SUBI R30,LOW(8)
_0x20400D5:
	STD  Y+13,R30
	LDI  R17,LOW(0)
	LDD  R30,Y+15
	SUBI R30,-LOW(8)
	STD  Y+15,R30
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
	LDD  R16,Y+16
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x20400AA:
	MOV  R30,R21
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R20,Z
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x20400C5
_0x20400C6:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400C8
	CALL SUBOPT_0x17
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSLB12
	CALL SUBOPT_0x18
	MOV  R30,R18
	MOV  R26,R20
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x13
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x20400C6
_0x20400C8:
	RJMP _0x20400C4
_0x20400C5:
	CPI  R30,LOW(0x9)
	BRNE _0x20400C9
	LDI  R21,LOW(0)
	RJMP _0x20400CA
_0x20400C9:
	CPI  R30,LOW(0xA)
	BRNE _0x20400D0
	LDI  R21,LOW(255)
_0x20400CA:
	CALL SUBOPT_0x15
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	MOV  R21,R30
_0x20400CD:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400CF
	CALL SUBOPT_0x16
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400CD
_0x20400CF:
	RJMP _0x20400C4
_0x20400D0:
_0x20400D1:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400D3
	CALL SUBOPT_0x19
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400D1
_0x20400D3:
_0x20400C4:
_0x20400A9:
	LDD  R30,Y+8
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x204007C
_0x204007E:
_0x2140009:
	CALL __LOADLOCR6
	ADIW R28,17
	RET
; .FEND

	.CSEG
_glcd_clipx:
; .FSTART _glcd_clipx
	CALL SUBOPT_0x1A
	BRLT _0x2060003
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x2140003
_0x2060003:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x80)
	LDI  R30,HIGH(0x80)
	CPC  R27,R30
	BRLT _0x2060004
	LDI  R30,LOW(127)
	LDI  R31,HIGH(127)
	JMP  _0x2140003
_0x2060004:
	LD   R30,Y
	LDD  R31,Y+1
	JMP  _0x2140003
; .FEND
_glcd_clipy:
; .FSTART _glcd_clipy
	CALL SUBOPT_0x1A
	BRLT _0x2060005
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x2140003
_0x2060005:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRLT _0x2060006
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	JMP  _0x2140003
_0x2060006:
	LD   R30,Y
	LDD  R31,Y+1
	JMP  _0x2140003
; .FEND
_glcd_imagesize:
; .FSTART _glcd_imagesize
	ST   -Y,R26
	ST   -Y,R17
	LDD  R26,Y+2
	CPI  R26,LOW(0x80)
	BRSH _0x2060008
	LDD  R26,Y+1
	CPI  R26,LOW(0x40)
	BRLO _0x2060007
_0x2060008:
	CALL SUBOPT_0x1B
	LDD  R17,Y+0
	JMP  _0x2140002
_0x2060007:
	LDD  R30,Y+1
	ANDI R30,LOW(0x7)
	MOV  R17,R30
	LDD  R30,Y+1
	LSR  R30
	LSR  R30
	LSR  R30
	STD  Y+1,R30
	CPI  R17,0
	BREQ _0x206000A
	SUBI R30,-LOW(1)
	STD  Y+1,R30
_0x206000A:
	LDD  R26,Y+2
	CLR  R27
	CLR  R24
	CLR  R25
	LDD  R30,Y+1
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __MULD12U
	__ADDD1N 4
	LDD  R17,Y+0
	JMP  _0x2140002
; .FEND
_glcd_putimagef:
; .FSTART _glcd_putimagef
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	CPI  R26,LOW(0x5)
	BRSH _0x2060038
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LPM  R16,Z+
	CALL SUBOPT_0x1C
	LPM  R17,Z+
	CALL SUBOPT_0x1C
	LPM  R18,Z+
	CALL SUBOPT_0x1C
	LPM  R19,Z+
	STD  Y+5,R30
	STD  Y+5+1,R31
	CALL SUBOPT_0x1D
	LDI  R30,LOW(1)
	CALL SUBOPT_0x1E
	RJMP _0x2140007
_0x2060038:
	RJMP _0x2140008
; .FEND
_glcd_putimagee:
; .FSTART _glcd_putimagee
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R26,Y+4
	CPI  R26,LOW(0x5)
	BRSH _0x2060039
	CALL SUBOPT_0x1F
	MOV  R16,R30
	CALL SUBOPT_0x1F
	MOV  R17,R30
	CALL SUBOPT_0x1F
	MOV  R18,R30
	CALL SUBOPT_0x1F
	MOV  R19,R30
	CALL SUBOPT_0x1D
	LDI  R30,LOW(2)
	CALL SUBOPT_0x1E
	RJMP _0x2140007
_0x2060039:
_0x2140008:
	__GETD1N 0x0
_0x2140007:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_glcd_moveto:
; .FSTART _glcd_moveto
	ST   -Y,R26
	LDD  R26,Y+1
	CLR  R27
	RCALL _glcd_clipx
	__PUTB1MN _glcd_state,2
	LD   R26,Y
	CLR  R27
	RCALL _glcd_clipy
	__PUTB1MN _glcd_state,3
	JMP  _0x2140003
; .FEND

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL SUBOPT_0x20
	JMP  _0x2140001
__floor1:
    brtc __floor0
	CALL SUBOPT_0x20
	CALL SUBOPT_0x21
	JMP  _0x2140001
; .FEND
_log:
; .FSTART _log
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x22
	CALL __CPD02
	BRLT _0x20A000C
	__GETD1N 0xFF7FFFFF
	RJMP _0x2140006
_0x20A000C:
	CALL SUBOPT_0x23
	CALL __PUTPARD1
	IN   R26,SPL
	IN   R27,SPH
	SBIW R26,1
	PUSH R17
	PUSH R16
	CALL _frexp
	POP  R16
	POP  R17
	CALL SUBOPT_0x24
	CALL SUBOPT_0x22
	__GETD1N 0x3F3504F3
	CALL __CMPF12
	BRSH _0x20A000D
	CALL SUBOPT_0x25
	CALL __ADDF12
	CALL SUBOPT_0x24
	__SUBWRN 16,17,1
_0x20A000D:
	CALL SUBOPT_0x23
	CALL SUBOPT_0x21
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x23
	__GETD2N 0x3F800000
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	CALL SUBOPT_0x26
	__GETD2N 0x3F654226
	CALL SUBOPT_0x27
	__GETD1N 0x4054114E
	CALL SUBOPT_0x28
	CALL SUBOPT_0x22
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x29
	__GETD2N 0x3FD4114D
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R16
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x3F317218
	CALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
_0x2140006:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_exp:
; .FSTART _exp
	CALL __PUTPARD2
	SBIW R28,8
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x2A
	__GETD1N 0xC2AEAC50
	CALL __CMPF12
	BRSH _0x20A000F
	CALL SUBOPT_0x1B
	RJMP _0x2140005
_0x20A000F:
	__GETD1S 10
	CALL __CPD10
	BRNE _0x20A0010
	__GETD1N 0x3F800000
	RJMP _0x2140005
_0x20A0010:
	CALL SUBOPT_0x2A
	__GETD1N 0x42B17218
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x20A0011
	__GETD1N 0x7F7FFFFF
	RJMP _0x2140005
_0x20A0011:
	CALL SUBOPT_0x2A
	__GETD1N 0x3FB8AA3B
	CALL __MULF12
	__PUTD1S 10
	CALL SUBOPT_0x2A
	RCALL _floor
	CALL __CFD1
	MOVW R16,R30
	CALL SUBOPT_0x2A
	CALL __CWD1
	CALL __CDF1
	CALL SUBOPT_0x28
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F000000
	CALL SUBOPT_0x28
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	CALL SUBOPT_0x26
	__GETD2N 0x3D6C4C6D
	CALL __MULF12
	__GETD2N 0x40E6E3A6
	CALL __ADDF12
	CALL SUBOPT_0x22
	CALL __MULF12
	CALL SUBOPT_0x24
	CALL SUBOPT_0x29
	__GETD2N 0x41A68D28
	CALL __ADDF12
	CALL SUBOPT_0x4
	CALL SUBOPT_0x23
	__GETD2S 2
	CALL __ADDF12
	__GETD2N 0x3FB504F3
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x22
	CALL SUBOPT_0x29
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL __PUTPARD1
	MOVW R26,R16
	CALL _ldexp
_0x2140005:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,14
	RET
; .FEND
_pow:
; .FSTART _pow
	CALL __PUTPARD2
	SBIW R28,4
	CALL SUBOPT_0x2B
	CALL __CPD10
	BRNE _0x20A0012
	CALL SUBOPT_0x1B
	RJMP _0x2140004
_0x20A0012:
	__GETD2S 8
	CALL __CPD02
	BRGE _0x20A0013
	CALL SUBOPT_0x2C
	CALL __CPD10
	BRNE _0x20A0014
	__GETD1N 0x3F800000
	RJMP _0x2140004
_0x20A0014:
	__GETD2S 8
	CALL SUBOPT_0x2D
	RCALL _exp
	RJMP _0x2140004
_0x20A0013:
	CALL SUBOPT_0x2C
	MOVW R26,R28
	CALL __CFD1
	CALL __PUTDP1
	CALL SUBOPT_0x20
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x2C
	CALL __CPD12
	BREQ _0x20A0015
	CALL SUBOPT_0x1B
	RJMP _0x2140004
_0x20A0015:
	CALL SUBOPT_0x2B
	CALL __ANEGF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x2D
	RCALL _exp
	__PUTD1S 8
	LD   R30,Y
	ANDI R30,LOW(0x1)
	BRNE _0x20A0016
	CALL SUBOPT_0x2B
	RJMP _0x2140004
_0x20A0016:
	CALL SUBOPT_0x2B
	CALL __ANEGF1
_0x2140004:
	ADIW R28,12
	RET
; .FEND

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	ADIW R28,5
	RET
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_glcd_getmask:
; .FSTART _glcd_getmask
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R26,Z
	LDD  R30,Y+1
	CALL __LSLB12
_0x2140003:
	ADIW R28,2
	RET
; .FEND
_glcd_mappixcolor1bit:
; .FSTART _glcd_mappixcolor1bit
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	CPI  R30,LOW(0x7)
	BREQ _0x2120007
	CPI  R30,LOW(0xA)
	BRNE _0x2120008
_0x2120007:
	LDS  R17,_glcd_state
	RJMP _0x2120009
_0x2120008:
	CPI  R30,LOW(0x9)
	BRNE _0x212000B
	__GETBRMN 17,_glcd_state,1
	RJMP _0x2120009
_0x212000B:
	CPI  R30,LOW(0x8)
	BRNE _0x2120005
	__GETBRMN 17,_glcd_state,16
_0x2120009:
	__GETB1MN _glcd_state,1
	CPI  R30,0
	BREQ _0x212000E
	CPI  R17,0
	BREQ _0x212000F
	LDI  R30,LOW(255)
	LDD  R17,Y+0
	RJMP _0x2140002
_0x212000F:
	LDD  R30,Y+2
	COM  R30
	LDD  R17,Y+0
	RJMP _0x2140002
_0x212000E:
	CPI  R17,0
	BRNE _0x2120011
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x2140002
_0x2120011:
_0x2120005:
	LDD  R30,Y+2
	LDD  R17,Y+0
	RJMP _0x2140002
; .FEND
_glcd_readmem:
; .FSTART _glcd_readmem
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	CPI  R30,LOW(0x1)
	BRNE _0x2120015
	LD   R30,Y
	LDD  R31,Y+1
	LPM  R30,Z
	RJMP _0x2140002
_0x2120015:
	CPI  R30,LOW(0x2)
	BRNE _0x2120016
	LD   R26,Y
	LDD  R27,Y+1
	CALL __EEPROMRDB
	RJMP _0x2140002
_0x2120016:
	CPI  R30,LOW(0x3)
	BRNE _0x2120018
	LD   R26,Y
	LDD  R27,Y+1
	__CALL1MN _glcd_state,25
	RJMP _0x2140002
_0x2120018:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
_0x2140002:
	ADIW R28,3
	RET
; .FEND
_glcd_writemem:
; .FSTART _glcd_writemem
	ST   -Y,R26
	LDD  R30,Y+3
	CPI  R30,0
	BRNE _0x212001C
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ST   X,R30
	RJMP _0x212001B
_0x212001C:
	CPI  R30,LOW(0x2)
	BRNE _0x212001D
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL __EEPROMWRB
	RJMP _0x212001B
_0x212001D:
	CPI  R30,LOW(0x3)
	BRNE _0x212001B
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+2
	__CALL1MN _glcd_state,27
_0x212001B:
_0x2140001:
	ADIW R28,4
	RET
; .FEND

	.DSEG
_adc_data:
	.BYTE 0x2
_data_spi:
	.BYTE 0x4
_num_data_spi:
	.BYTE 0x1
_twi_tx_index:
	.BYTE 0x1
_twi_rx_index:
	.BYTE 0x1
_twi_result:
	.BYTE 0x1
_glcd_state:
	.BYTE 0x1D

	.ESEG
_data_rec:
	.BYTE 0x200

	.DSEG
_input_index_S0010000000:
	.BYTE 0x1
_rx_buffer:
	.BYTE 0x100
_tx_buffer:
	.BYTE 0x100
_slave_address_G101:
	.BYTE 0x1
_twi_tx_buffer_G101:
	.BYTE 0x2
_bytes_to_tx_G101:
	.BYTE 0x1
_twi_rx_buffer_G101:
	.BYTE 0x2
_bytes_to_rx_G101:
	.BYTE 0x1
_twi_rx_buffer_size_G101:
	.BYTE 0x1
_twi_slave_rx_handler_G101:
	.BYTE 0x2
_twi_slave_tx_handler_G101:
	.BYTE 0x2
_ks0108_coord_G102:
	.BYTE 0x3
__seed_G106:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _delay_ms
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1:
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,141
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2:
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	MOVW R26,R28
	JMP  _puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	LDD  R30,Y+1
	OUT  0x3,R30
	LDI  R30,LOW(132)
	OUT  0x36,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	CALL _eeprom_read_frame
	LDI  R30,LOW(4)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	ST   -Y,R30
	LDI  R30,LOW(_data_rec)
	LDI  R31,HIGH(_data_rec)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _glcd_putimagee

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x7:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x8:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	CBI  0x17,0
	CBI  0x17,1
	CBI  0x11,2
	CBI  0x11,3
	CBI  0x11,4
	CBI  0x11,5
	CBI  0x11,6
	CBI  0x11,7
	SBI  0x1B,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xE:
	CBI  0x1B,3
	SBI  0x17,0
	SBI  0x17,1
	SBI  0x11,2
	SBI  0x11,3
	SBI  0x11,4
	SBI  0x11,5
	SBI  0x11,6
	SBI  0x11,7
	LD   R30,Y
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R26,R30
	JMP  _ks0108_gotoxp_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	CALL _ks0108_wrdata_G102
	JMP  _ks0108_nextx_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x12:
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _glcd_writemem

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x13:
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x14:
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	JMP  _glcd_readmem

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	ST   -Y,R21
	LDD  R26,Y+10
	JMP  _glcd_mappixcolor1bit

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x16:
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+16
	ST   -Y,R30
	ST   -Y,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	ST   -Y,R16
	INC  R16
	LDD  R26,Y+16
	CALL _ks0108_rdbyte_G102
	AND  R30,R20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x18:
	MOV  R21,R30
	LDD  R30,Y+12
	ST   -Y,R30
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CLR  R24
	CLR  R25
	CALL _glcd_readmem
	MOV  R1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x19:
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+16
	ST   -Y,R30
	LDD  R30,Y+14
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ADIW R30,1
	STD  Y+9,R30
	STD  Y+9+1,R31
	SBIW R30,1
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	STD  Y+5,R30
	STD  Y+5+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	LDD  R30,Y+8
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	ST   -Y,R16
	ST   -Y,R18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1E:
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+11
	CALL _glcd_block
	ST   -Y,R16
	MOV  R26,R18
	JMP  _glcd_imagesize

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	ADIW R26,1
	STD  Y+5,R26
	STD  Y+5+1,R27
	SBIW R26,1
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	__GETD2N 0x3F800000
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x22:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x23:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x24:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	RCALL SUBOPT_0x23
	RJMP SUBOPT_0x22

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x26:
	CALL __MULF12
	RCALL SUBOPT_0x4
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x27:
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2A:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2B:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2D:
	CALL _log
	__GETD2S 4
	RJMP SUBOPT_0x27


	.CSEG
	.equ __sda_bit=1
	.equ __scl_bit=0
	.equ __i2c_port=0x15 ;PORTC
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2

_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,13
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,27
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	mov  r23,r26
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ldi  r23,8
__i2c_write0:
	lsl  r26
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	rjmp __i2c_delay1

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

_frexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	CLR  R24
	SUBI R23,0x7E
	SBC  R24,R24
	ST   X+,R23
	ST   X,R24
	LDI  R23,0x7E
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

_ldexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	ADD  R23,R26
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
