
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
;Global 'const' stored in FLASH: No
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
	.DEF _rx_wr_index=R5
	.DEF _rx_rd_index=R4
	.DEF _rx_counter=R6
	.DEF _rx_counter_msb=R7
	.DEF _tx_wr_index=R9
	.DEF _tx_rd_index=R8
	.DEF _tx_counter=R10
	.DEF _tx_counter_msb=R11
	.DEF _adc_old_data=R12
	.DEF _adc_old_data_msb=R13

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
	JMP  _timer1_ovf_isr
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
_clock:
	.DB  0x40,0x0,0x40,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x80,0x80,0xC0,0xE0,0xE0,0xF0,0xF0,0x78
	.DB  0x78,0x3C,0x3C,0x1C,0x1E,0x1E,0x1E,0xE
	.DB  0xE,0xE,0xE,0xCE,0xCE,0xCE,0xE,0xE
	.DB  0xE,0xE,0x1E,0x1E,0x1E,0x1C,0x3C,0x3C
	.DB  0x78,0x78,0xF0,0xF0,0xE0,0xE0,0xC0,0x80
	.DB  0x80,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x80,0xC0,0xF0,0xF8,0xFC,0x7E,0x1F
	.DB  0xF,0x7,0x7,0x3,0x1,0x0,0xE,0x3E
	.DB  0x7E,0x7C,0x78,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0xF,0xF,0xF,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x70,0x7C
	.DB  0x7E,0x3E,0xE,0x0,0x1,0x3,0x3,0x7
	.DB  0xF,0x1F,0x3E,0xFC,0xF8,0xF0,0xE0,0x80
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0xE0,0xF8
	.DB  0xFE,0x7F,0x1F,0x7,0x1,0x3C,0x3C,0x7C
	.DB  0x78,0x70,0x70,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x20,0x70,0x70
	.DB  0x78,0x78,0x3C,0x3C,0x1,0x7,0x1F,0x7F
	.DB  0xFE,0xF8,0xE0,0x0,0xC0,0xFF,0xFF,0xFF
	.DB  0x7,0x0,0x80,0x80,0x80,0x80,0x80,0x80
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x80,0x80,0x80,0x80,0x80,0x80,0x0
	.DB  0x7,0xFF,0xFF,0xFF,0x7,0xFF,0xFF,0xFF
	.DB  0xC0,0x1,0x3,0x3,0x3,0x3,0x3,0x3
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x3,0x3,0x3,0x3,0x3,0x3,0x3
	.DB  0x80,0xFF,0xFF,0xFF,0x0,0x1,0xF,0x7F
	.DB  0xFF,0xFC,0xF0,0xC0,0x0,0x70,0x78,0x78
	.DB  0x3C,0x3C,0x1C,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x1C,0x3C
	.DB  0x3C,0x78,0x78,0x70,0x0,0xC0,0xF0,0xFC
	.DB  0xFF,0x7F,0xF,0x1,0x0,0x0,0x0,0x0
	.DB  0x0,0x3,0xF,0x1F,0x3F,0x7E,0xF8,0xF0
	.DB  0xE0,0xC0,0x80,0x80,0x0,0x0,0xC0,0xF0
	.DB  0xFC,0xFC,0x3C,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0xE0,0xE0,0xE0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x3C,0x7C
	.DB  0xFC,0xF8,0xE0,0x0,0x0,0x0,0x80,0xC0
	.DB  0xE0,0xF0,0xF8,0x7C,0x3F,0x1F,0xF,0x3
	.DB  0x1,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1
	.DB  0x3,0x7,0x7,0xF,0x1F,0x1E,0x3E,0x3C
	.DB  0x3C,0x78,0x78,0x70,0xF0,0xF0,0xE0,0xE0
	.DB  0xE0,0xE0,0xE0,0xEF,0xEF,0xEF,0xE0,0xE0
	.DB  0xE0,0xE0,0xE0,0xF0,0xF0,0xF0,0x78,0x78
	.DB  0x78,0x3C,0x3E,0x1E,0x1F,0xF,0x7,0x7
	.DB  0x3,0x1,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
_cos6data:
	.DB  0x0,0x0,0xB,0x0,0x15,0x0,0x1F,0x0
	.DB  0x29,0x0,0x32,0x0,0x3B,0x0,0x43,0x0
	.DB  0x4A,0x0,0x51,0x0,0x57,0x0,0x5B,0x0
	.DB  0x5F,0x0,0x62,0x0,0x63,0x0,0x64,0x0
	.DB  0x63,0x0,0x62,0x0,0x5F,0x0,0x5B,0x0
	.DB  0x57,0x0,0x51,0x0,0x4A,0x0,0x43,0x0
	.DB  0x3B,0x0,0x32,0x0,0x29,0x0,0x1F,0x0
	.DB  0x15,0x0,0xB,0x0,0x0,0x0,0xF6,0xFF
	.DB  0xEB,0xFF,0xE1,0xFF,0xD7,0xFF,0xCE,0xFF
	.DB  0xC5,0xFF,0xBD,0xFF,0xB6,0xFF,0xAF,0xFF
	.DB  0xA9,0xFF,0xA5,0xFF,0xA1,0xFF,0x9E,0xFF
	.DB  0x9D,0xFF,0x9C,0xFF,0x9D,0xFF,0x9E,0xFF
	.DB  0xA1,0xFF,0xA5,0xFF,0xA9,0xFF,0xAF,0xFF
	.DB  0xB6,0xFF,0xBD,0xFF,0xC5,0xFF,0xCE,0xFF
	.DB  0xD7,0xFF,0xE1,0xFF,0xEB,0xFF,0xF5,0xFF
	.DB  0x0,0x0
_sin6data:
	.DB  0x64,0x0,0x63,0x0,0x62,0x0,0x5F,0x0
	.DB  0x5B,0x0,0x57,0x0,0x51,0x0,0x4A,0x0
	.DB  0x43,0x0,0x3B,0x0,0x32,0x0,0x29,0x0
	.DB  0x1F,0x0,0x15,0x0,0xA,0x0,0x0,0x0
	.DB  0xF6,0xFF,0xEB,0xFF,0xE1,0xFF,0xD7,0xFF
	.DB  0xCE,0xFF,0xC5,0xFF,0xBD,0xFF,0xB6,0xFF
	.DB  0xAF,0xFF,0xA9,0xFF,0xA5,0xFF,0xA1,0xFF
	.DB  0x9E,0xFF,0x9D,0xFF,0x9C,0xFF,0x9D,0xFF
	.DB  0x9E,0xFF,0xA1,0xFF,0xA5,0xFF,0xA9,0xFF
	.DB  0xAF,0xFF,0xB6,0xFF,0xBD,0xFF,0xC5,0xFF
	.DB  0xCE,0xFF,0xD7,0xFF,0xE1,0xFF,0xEB,0xFF
	.DB  0xF5,0xFF,0x0,0x0,0xA,0x0,0x15,0x0
	.DB  0x1F,0x0,0x29,0x0,0x32,0x0,0x3B,0x0
	.DB  0x43,0x0,0x4A,0x0,0x51,0x0,0x56,0x0
	.DB  0x5B,0x0,0x5F,0x0,0x62,0x0,0x63,0x0
	.DB  0x64,0x0
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
	.DB  0x45,0x4E,0x44,0x20,0x6F,0x66,0x20,0x4F
	.DB  0x4E,0x4C,0x49,0x4E,0x45,0x20,0x43,0x4C
	.DB  0x41,0x53,0x53,0x20,0xD,0xA,0x20,0x20
	.DB  0x20,0x2A,0x2A,0x2A,0x20,0x20,0x20,0x20
	.DB  0x20,0x4D,0x41,0x53,0x54,0x45,0x52,0x20
	.DB  0x4D,0x49,0x43,0x52,0x4F,0x20,0x32,0x20
	.DB  0x20,0x20,0x20,0x2A,0x2A,0x2A,0xD,0xD
	.DB  0xD,0xA,0x0,0x54,0x49,0x4D,0x45,0x3A
	.DB  0x20,0x0,0xD,0xA,0x20,0x52,0x65,0x63
	.DB  0x65,0x69,0x76,0x69,0x6E,0x67,0x20,0x3A
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x25,0x64,0x20,0x20,0x20,0x20,0x0,0xD
	.DB  0xA,0x20,0x53,0x65,0x6E,0x64,0x69,0x6E
	.DB  0x67,0x20,0x3A,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x0
_0x60003:
	.DB  0x63,0x0,0x63
_0x60000:
	.DB  0xD,0xA,0x20,0x41,0x44,0x43,0x30,0x3D
	.DB  0x25,0x64,0x20,0x61,0x70,0x64,0x61,0x74
	.DB  0x65,0x64,0x21,0x21,0x20,0xD,0xA,0x0
_0xC0000:
	.DB  0xD,0xA,0x20,0x41,0x44,0x43,0x30,0x3D
	.DB  0x25,0x64,0xD,0xA,0x0
_0x100003:
	.DB  0x0,0x6,0xA,0xC,0xA,0x6,0x0,0xFA
	.DB  0xF6,0xF4,0xF6,0xFA
_0x100004:
	.DB  0xF4,0xF6,0xFA,0x0,0x6,0xA,0xC,0xA
	.DB  0x6,0x0,0xFA,0xF6,0xF4
_0x100005:
	.DB  0x1E
_0x100006:
	.DB  0x1E
_0x100000:
	.DB  0x25,0x64,0x3A,0x25,0x64,0x3A,0x25,0x64
	.DB  0x20,0x0,0x48,0x65,0x6C,0x6C,0x6F,0x0
	.DB  0x54,0x69,0x6D,0x65,0x0,0x25,0x32,0x64
	.DB  0x3A,0x25,0x32,0x64,0x3A,0x25,0x32,0x64
	.DB  0x0
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

	.DW  0x43
	.DW  _0x3
	.DW  _0x0*2

	.DW  0x16
	.DW  _0x3+67
	.DW  _0x0*2+74

	.DW  0x14
	.DW  _0x3+89
	.DW  _0x0*2+103

	.DW  0x03
	.DW  _data_spi
	.DW  _0x60003*2

	.DW  0x0C
	.DW  _hx
	.DW  _0x100003*2

	.DW  0x0D
	.DW  _hy
	.DW  _0x100004*2

	.DW  0x01
	.DW  _xold
	.DW  _0x100005*2

	.DW  0x01
	.DW  _yold
	.DW  _0x100006*2

	.DW  0x06
	.DW  _0x10000C
	.DW  _0x100000*2+10

	.DW  0x05
	.DW  _0x10000C+6
	.DW  _0x100000*2+16

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
;#include <glcd_s.h>
;#include <clock.h>
;#include <timer.h>
;
;void main(void)
; 0000 0007 {

	.CSEG
_main:
; .FSTART _main
; 0000 0008 
; 0000 0009 char scr[];
; 0000 000A 
; 0000 000B char count1 = 0,count3;
; 0000 000C 
; 0000 000D master_micro=0;
;	scr -> Y+0
;	count1 -> R17
;	count3 -> R16
	LDI  R17,0
	CLT
	BLD  R2,1
; 0000 000E 
; 0000 000F port_init();
	CALL _port_init
; 0000 0010 spi_init_slave();
	CALL _spi_init_slave
; 0000 0011 uart_init();
	CALL _uart_init
; 0000 0012 clock_display();
	CALL _clock_display
; 0000 0013 timer1_init();
	CALL _timer1_init
; 0000 0014 
; 0000 0015 #asm("sei")
	sei
; 0000 0016 
; 0000 0017 puts("Hello,  END of ONLINE CLASS \r\n   ***     MASTER MICRO 2    ***\r\r\r\n");
	__POINTW2MN _0x3,0
	CALL _puts
; 0000 0018 
; 0000 0019 sprintf(scr,"TIME: ");
	CALL SUBOPT_0x0
	__POINTW1FN _0x0,67
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
; 0000 001A glcd_moveto(80,  32);
	LDI  R30,LOW(80)
	ST   -Y,R30
	LDI  R26,LOW(32)
	CALL _glcd_moveto
; 0000 001B glcd_outtext(scr);
	MOVW R26,R28
	CALL _glcd_outtext
; 0000 001C 
; 0000 001D 
; 0000 001E I2C_Slave_Init(Slave_Address);
	LDI  R26,LOW(32)
	CALL _I2C_Slave_Init
; 0000 001F 
; 0000 0020 
; 0000 0021 
; 0000 0022     while (1)
_0x4:
; 0000 0023      {
; 0000 0024 
; 0000 0025 
; 0000 0026     switch(I2C_Slave_Listen())    /* Check for SLA+W or SLA+R */
	CALL _I2C_Slave_Listen
; 0000 0027      {
; 0000 0028         case 0:
	CPI  R30,0
	BRNE _0xA
; 0000 0029         {
; 0000 002A           puts("\r\n Receiving :       ");
	__POINTW2MN _0x3,67
	CALL _puts
; 0000 002B 
; 0000 002C           do
_0xC:
; 0000 002D           {
; 0000 002E             count1 = I2C_Slave_Receive();/* Receive data byte*/
	CALL _I2C_Slave_Receive
	MOV  R17,R30
; 0000 002F 
; 0000 0030             sprintf(scr, "%d    ", count1);
	CALL SUBOPT_0x0
	__POINTW1FN _0x0,96
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R17
	CALL SUBOPT_0x1
; 0000 0031             puts(scr);
	MOVW R26,R28
	CALL _puts
; 0000 0032 
; 0000 0033 
; 0000 0034           }while (count1 != 255); /* Receive until STOP/REPEATED START */
	CPI  R17,255
	BRNE _0xC
; 0000 0035 		  count1 = 0;
	LDI  R17,LOW(0)
; 0000 0036 		  break;
	RJMP _0x9
; 0000 0037 		}
; 0000 0038 	    case 1:
_0xA:
	CPI  R30,LOW(0x1)
	BRNE _0x12
; 0000 0039 		{
; 0000 003A 		  char Ack_status;
; 0000 003B           count3=10;
	SBIW R28,1
;	scr -> Y+1
;	Ack_status -> Y+0
	LDI  R16,LOW(10)
; 0000 003C 		  puts("\r\n Sending :       ");
	__POINTW2MN _0x3,89
	CALL _puts
; 0000 003D 		  do
_0x10:
; 0000 003E 		  {
; 0000 003F 		    Ack_status = I2C_Slave_Transmit(count3);/* Send data byte */
	MOV  R26,R16
	CALL _I2C_Slave_Transmit
	ST   Y,R30
; 0000 0040 
; 0000 0041 		    sprintf(scr, "%d    ",count3);
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,96
	ST   -Y,R31
	ST   -Y,R30
	MOV  R30,R16
	CALL SUBOPT_0x1
; 0000 0042 		    puts(scr);
	MOVW R26,R28
	ADIW R26,1
	CALL _puts
; 0000 0043 		    count3++;
	SUBI R16,-1
; 0000 0044 		  } while (Ack_status == 0);/* Send until Ack is receive */
	LD   R30,Y
	CPI  R30,0
	BREQ _0x10
; 0000 0045 		  break;
	ADIW R28,1
; 0000 0046 		}
; 0000 0047 	    default:
_0x12:
; 0000 0048 		break;
; 0000 0049 	 }
_0x9:
; 0000 004A      }
	RJMP _0x4
; 0000 004B  }
_0x13:
	RJMP _0x13
; .FEND

	.DSEG
_0x3:
	.BYTE 0x6D
;
;
;
;
;
;
;
;
;#include <mega16.h>
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
;#include <delay.h>
;
;// Declare your global variables here
;
;// Voltage Reference: AVCC pin
;#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))
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
; 0002 0005 {

	.CSEG
_port_init:
; .FSTART _port_init
; 0002 0006 // Declare your local variables here
; 0002 0007 
; 0002 0008 // Input/Output Ports initialization
; 0002 0009 // Port A initialization
; 0002 000A // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 000B DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0002 000C // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 000D PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0002 000E 
; 0002 000F // Port B initialization
; 0002 0010 // Function: Bit7=Out Bit6=In Bit5=Out Bit4=Out Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 0011 DDRB=(1<<DDB7) | (0<<DDB6) | (1<<DDB5) | (1<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(176)
	OUT  0x17,R30
; 0002 0012 // State: Bit7=0 Bit6=T Bit5=0 Bit4=0 Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 0013 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0002 0014 
; 0002 0015 // Port C initialization
; 0002 0016 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 0017 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0002 0018 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 0019 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0002 001A 
; 0002 001B // Port D initialization
; 0002 001C // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0002 001D DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0002 001E // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0002 001F PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0002 0020  }
	RET
; .FEND
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
; int data_spi[2]={99,99};

	.DSEG
; char num_data_spi=0;
; bit new_data_spi=0;
; bit master_micro=1;
;
; void spi_init(void)
; 0003 000A {

	.CSEG
; 0003 000B // SPI initialization
; 0003 000C // SPI Type: Master
; 0003 000D // SPI Clock Rate: 2000.000 kHz
; 0003 000E // SPI Clock Phase: Cycle Start
; 0003 000F // SPI Clock Polarity: Low
; 0003 0010 // SPI Data Order: MSB First
; 0003 0011 SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (1<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
; 0003 0012 SPSR=(0<<SPI2X);
; 0003 0013 
; 0003 0014 // Clear the SPI interrupt flag
; 0003 0015 #asm
; 0003 0016     in   r30,spsr
; 0003 0017     in   r30,spdr
; 0003 0018 #endasm
; 0003 0019 
; 0003 001A 
; 0003 001B }
; void spi_init_slave(void)
; 0003 001D {
_spi_init_slave:
; .FSTART _spi_init_slave
; 0003 001E 
; 0003 001F 
; 0003 0020 
; 0003 0021 // SPI initialization
; 0003 0022 // SPI Type: Slave
; 0003 0023 // SPI Clock Rate: 2000.000 kHz
; 0003 0024 // SPI Clock Phase: Cycle Start
; 0003 0025 // SPI Clock Polarity: Low
; 0003 0026 // SPI Data Order: MSB First
; 0003 0027 SPCR=(1<<SPIE) | (1<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(192)
	OUT  0xD,R30
; 0003 0028 SPSR=(0<<SPI2X);
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0003 0029 
; 0003 002A #asm
; 0003 002B     in   r30,spsr
    in   r30,spsr
; 0003 002C     in   r30,spdr
    in   r30,spdr
; 0003 002D #endasm
; 0003 002E 
; 0003 002F 
; 0003 0030 
; 0003 0031 }
	RET
; .FEND
;
;interrupt [SPI_STC] void spi_isr(void)
; 0003 0034 {
_spi_isr:
; .FSTART _spi_isr
	CALL SUBOPT_0x2
; 0003 0035 //unsigned char data;
; 0003 0036 //data_spi[0]=SPDR;
; 0003 0037 char scr[20];
; 0003 0038 
; 0003 0039 
; 0003 003A data_spi[num_data_spi]=SPDR;
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
; 0003 003B num_data_spi++;
	LDS  R30,_num_data_spi
	SUBI R30,-LOW(1)
	STS  _num_data_spi,R30
; 0003 003C if (num_data_spi==2)
	LDS  R26,_num_data_spi
	CPI  R26,LOW(0x2)
	BRNE _0x60004
; 0003 003D {
; 0003 003E new_data_spi=1;
	SET
	BLD  R2,0
; 0003 003F num_data_spi=0;
	LDI  R30,LOW(0)
	STS  _num_data_spi,R30
; 0003 0040 }
; 0003 0041 if (master_micro==0)
_0x60004:
	SBRC R2,1
	RJMP _0x60005
; 0003 0042 {
; 0003 0043             if (new_data_spi==1)
	SBRS R2,0
	RJMP _0x60006
; 0003 0044        {
; 0003 0045        sprintf(scr,"\r\n ADC0=%d apdated!! \r\n",((data_spi[0]&0x00ff)|(data_spi[1]<<8)));
	CALL SUBOPT_0x0
	__POINTW1FN _0x60000,0
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
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0003 0046         puts(scr);
	MOVW R26,R28
	CALL _puts
; 0003 0047        new_data_spi=0;
	CLT
	BLD  R2,0
; 0003 0048        }
; 0003 0049  }
_0x60006:
; 0003 004A }
_0x60005:
	ADIW R28,20
	CALL SUBOPT_0x3
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
; 0004 0022 {

	.CSEG
_usart_rx_isr:
; .FSTART _usart_rx_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0004 0023 char status,data;
; 0004 0024 status=UCSRA;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0004 0025 data=UDR;
	IN   R16,12
; 0004 0026 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x80003
; 0004 0027    {
; 0004 0028    rx_buffer[rx_wr_index++]=data;
	MOV  R30,R5
	INC  R5
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0004 0029 #if RX_BUFFER_SIZE == 256
; 0004 002A    // special case for receiver buffer size=256
; 0004 002B    if (++rx_counter == 0) rx_buffer_overflow=1;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	BRNE _0x80004
	SET
	BLD  R2,2
; 0004 002C #else
; 0004 002D    if (rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
; 0004 002E    if (++rx_counter == RX_BUFFER_SIZE)
; 0004 002F       {
; 0004 0030       rx_counter=0;
; 0004 0031       rx_buffer_overflow=1;
; 0004 0032       }
; 0004 0033 #endif
; 0004 0034    }
_0x80004:
; 0004 0035 }
_0x80003:
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
; 0004 003C {
; 0004 003D char data;
; 0004 003E while (rx_counter==0);
;	data -> R17
; 0004 003F data=rx_buffer[rx_rd_index++];
; 0004 0040 #if RX_BUFFER_SIZE != 256
; 0004 0041 if (rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0004 0042 #endif
; 0004 0043 #asm("cli")
; 0004 0044 --rx_counter;
; 0004 0045 #asm("sei")
; 0004 0046 return data;
; 0004 0047 }
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
; 0004 005D {
_usart_tx_isr:
; .FSTART _usart_tx_isr
	ST   -Y,R0
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0004 005E if (tx_counter)
	MOV  R0,R10
	OR   R0,R11
	BREQ _0x80008
; 0004 005F    {
; 0004 0060    --tx_counter;
	MOVW R30,R10
	SBIW R30,1
	MOVW R10,R30
; 0004 0061    UDR=tx_buffer[tx_rd_index++];
	MOV  R30,R8
	INC  R8
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	OUT  0xC,R30
; 0004 0062 #if TX_BUFFER_SIZE != 256
; 0004 0063    if (tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
; 0004 0064 #endif
; 0004 0065    }
; 0004 0066 }
_0x80008:
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
; 0004 006D {
_putchar:
; .FSTART _putchar
; 0004 006E while (tx_counter == TX_BUFFER_SIZE);
	ST   -Y,R26
;	c -> Y+0
_0x80009:
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CP   R30,R10
	CPC  R31,R11
	BREQ _0x80009
; 0004 006F #asm("cli")
	cli
; 0004 0070 if (tx_counter || ((UCSRA & DATA_REGISTER_EMPTY)==0))
	MOV  R0,R10
	OR   R0,R11
	BRNE _0x8000D
	SBIC 0xB,5
	RJMP _0x8000C
_0x8000D:
; 0004 0071    {
; 0004 0072    tx_buffer[tx_wr_index++]=c;
	MOV  R30,R9
	INC  R9
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
; 0004 0073 #if TX_BUFFER_SIZE != 256
; 0004 0074    if (tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
; 0004 0075 #endif
; 0004 0076    ++tx_counter;
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
; 0004 0077    }
; 0004 0078 else
	RJMP _0x8000F
_0x8000C:
; 0004 0079    UDR=c;
	LD   R30,Y
	OUT  0xC,R30
; 0004 007A #asm("sei")
_0x8000F:
	sei
; 0004 007B }
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
; 0004 0084 {
_uart_init:
; .FSTART _uart_init
; 0004 0085 UCSRA=(0<<RXC) | (0<<TXC) | (0<<UDRE) | (0<<FE) | (0<<DOR) | (0<<UPE) | (0<<U2X) | (0<<MPCM);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0004 0086 UCSRB=(1<<RXCIE) | (1<<TXCIE) | (0<<UDRIE) | (1<<RXEN) | (1<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0004 0087 UCSRC=(1<<URSEL) | (0<<UMSEL) | (0<<UPM1) | (0<<UPM0) | (0<<USBS) | (1<<UCSZ1) | (1<<UCSZ0) | (0<<UCPOL);
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0004 0088 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0004 0089 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0004 008A  }
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
; 0005 000D {

	.CSEG
; 0005 000E     TWBR = BITRATE(TWSR = 0x00);                            /* Get bit rate register value by formula */
; 0005 000F }
;
;
;char I2C_Start2(char write_address)                        /* I2C start function */
; 0005 0013 {
; 0005 0014     char status;                                            /* Declare variable */
; 0005 0015     TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interru ...
;	write_address -> Y+1
;	status -> R17
; 0005 0016     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition)  ...
; 0005 0017     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0005 0018     if (status != 0x08)                                        /* Check weather start condition transmitted successfully ...
; 0005 0019     return 0;                                                /* If not then return 0 to indicate start condition fail */
; 0005 001A     TWDR = write_address;                                    /* If yes then write SLA+W in TWI data register */
; 0005 001B     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0005 001C     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
; 0005 001D     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0005 001E     if (status == 0x18)                                        /* Check weather SLA+W transmitted & ack received or not? ...
; 0005 001F     return 1;                                                /* If yes then return 1 to indicate ack received i.e. ready ...
; 0005 0020     if (status == 0x20)                                        /* Check weather SLA+W transmitted & nack received or not ...
; 0005 0021     return 2;                                                /* If yes then return 2 to indicate nack received i.e. devi ...
; 0005 0022     else
; 0005 0023     return 3;                                                /* Else return 3 to indicate SLA+W failed */
; 0005 0024 }
;
;char I2C_Repeated_Start(char read_address)                /* I2C repeated start function */
; 0005 0027 {
; 0005 0028     char status;                                            /* Declare variable */
; 0005 0029     TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interru ...
;	read_address -> Y+1
;	status -> R17
; 0005 002A     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition)  ...
; 0005 002B     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0005 002C     if (status != 0x10)                                        /* Check weather repeated start condition transmitted suc ...
; 0005 002D     return 0;                                                /* If no then return 0 to indicate repeated start condition ...
; 0005 002E     TWDR = read_address;                                    /* If yes then write SLA+R in TWI data register */
; 0005 002F     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0005 0030     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
; 0005 0031     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0005 0032     if (status == 0x40)                                        /* Check weather SLA+R transmitted & ack received or not? ...
; 0005 0033     return 1;                                                /* If yes then return 1 to indicate ack received */
; 0005 0034     if (status == 0x20)                                        /* Check weather SLA+R transmitted & nack received or not ...
; 0005 0035     return 2;                                                /* If yes then return 2 to indicate nack received i.e. devi ...
; 0005 0036     else
; 0005 0037     return 3;                                                /* Else return 3 to indicate SLA+W failed */
; 0005 0038 }
;
;void I2C_Stop2()                                                /* I2C stop function */
; 0005 003B {
; 0005 003C     TWCR=(1<<TWSTO)|(1<<TWINT)|(1<<TWEN);                    /* Enable TWI, generate stop condition and clear interrupt  ...
; 0005 003D     while(TWCR & (1<<TWSTO));                                /* Wait until stop condition execution */
; 0005 003E }
;
;void I2C_Start_Wait(char write_address)                        /* I2C start wait function */
; 0005 0041 {
; 0005 0042     char status;                                            /* Declare variable */
; 0005 0043     while (1)
;	write_address -> Y+1
;	status -> R17
; 0005 0044     {
; 0005 0045         TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                /* Enable TWI, generate start condition and clear interru ...
; 0005 0046         while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (start condition)  ...
; 0005 0047         status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits * ...
; 0005 0048         if (status != 0x08)                                    /* Check weather start condition transmitted successfully ...
; 0005 0049         continue;                                            /* If no then continue with start loop again */
; 0005 004A         TWDR = write_address;                                /* If yes then write SLA+W in TWI data register */
; 0005 004B         TWCR = (1<<TWEN)|(1<<TWINT);                        /* Enable TWI and clear interrupt flag */
; 0005 004C         while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (Write operation)  ...
; 0005 004D         status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits * ...
; 0005 004E         if (status != 0x18 )                                /* Check weather SLA+W transmitted & ack received or not? */
; 0005 004F         {
; 0005 0050             I2C_Stop2();                                        /* If not then generate stop condition */
; 0005 0051             //i2c_stop();
; 0005 0052             continue;                                        /* continue with start loop again */
; 0005 0053         }
; 0005 0054         break;                                                /* If yes then break loop */
; 0005 0055     }
; 0005 0056 }
;
;char I2C_Write2(char data)                                /* I2C write function */
; 0005 0059 {
; 0005 005A     char status;                                            /* Declare variable */
; 0005 005B     TWDR = data;                                            /* Copy data in TWI data register */
;	data -> Y+1
;	status -> R17
; 0005 005C     TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
; 0005 005D     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation)  ...
; 0005 005E     status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits * ...
; 0005 005F     if (status == 0x28)                                        /* Check weather data transmitted & ack received or not?  ...
; 0005 0060     return 0;                                                /* If yes then return 0 to indicate ack received */
; 0005 0061     if (status == 0x30)                                        /* Check weather data transmitted & nack received or not? ...
; 0005 0062     return 1;                                                /* If yes then return 1 to indicate nack received */
; 0005 0063     else
; 0005 0064     return 2;                                                /* Else return 2 to indicate data transmission failed */
; 0005 0065 }
;
;char I2C_Read_Ack()                                            /* I2C read ack function */
; 0005 0068 {
; 0005 0069     TWCR=(1<<TWEN)|(1<<TWINT)|(1<<TWEA);                    /* Enable TWI, generation of ack and clear interrupt flag */
; 0005 006A     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) * ...
; 0005 006B     return TWDR;                                            /* Return received data */
; 0005 006C }
;
;char I2C_Read_Nack()                                        /* I2C read nack function */
; 0005 006F {
; 0005 0070     TWCR=(1<<TWEN)|(1<<TWINT);                                /* Enable TWI and clear interrupt flag */
; 0005 0071     while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) * ...
; 0005 0072     return TWDR;                                            /* Return received data */
; 0005 0073 }
;
;
;
;void I2C_Slave_Init(char slave_address)
; 0005 0078 {
_I2C_Slave_Init:
; .FSTART _I2C_Slave_Init
; 0005 0079 	TWAR = slave_address;						/* Assign address in TWI address register */
	ST   -Y,R26
;	slave_address -> Y+0
	LD   R30,Y
	OUT  0x2,R30
; 0005 007A 	TWCR = (1<<TWEN) | (1<<TWEA) | (1<<TWINT);	/* Enable TWI, Enable ack generation, clear TWI interrupt */
	LDI  R30,LOW(196)
	OUT  0x36,R30
; 0005 007B }
	JMP  _0x214000B
; .FEND
;
;char I2C_Slave_Listen()
; 0005 007E {
_I2C_Slave_Listen:
; .FSTART _I2C_Slave_Listen
; 0005 007F 	while(1)
_0xA0031:
; 0005 0080 	{
; 0005 0081 		char status;							/* Declare variable */
; 0005 0082 		while (!(TWCR & (1<<TWINT)));			/* Wait to be addressed */
	SBIW R28,1
;	status -> Y+0
_0xA0034:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xA0034
; 0005 0083 		status = TWSR & 0xF8;					/* Read TWI status register with masking lower three bits */
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	ST   Y,R30
; 0005 0084 		if (status == 0x60 || status == 0x68)	/* Check weather own SLA+W received & ack returned (TWEA = 1) */
	LD   R26,Y
	CPI  R26,LOW(0x60)
	BREQ _0xA0038
	CPI  R26,LOW(0x68)
	BRNE _0xA0037
_0xA0038:
; 0005 0085 		return 0;								/* If yes then return 0 to indicate ack returned */
	LDI  R30,LOW(0)
	JMP  _0x214000B
; 0005 0086 		if (status == 0xA8 || status == 0xB0)	/* Check weather own SLA+R received & ack returned (TWEA = 1) */
_0xA0037:
	LD   R26,Y
	CPI  R26,LOW(0xA8)
	BREQ _0xA003B
	CPI  R26,LOW(0xB0)
	BRNE _0xA003A
_0xA003B:
; 0005 0087 		return 1;								/* If yes then return 1 to indicate ack returned */
	LDI  R30,LOW(1)
	JMP  _0x214000B
; 0005 0088 		if (status == 0x70 || status == 0x78)	/* Check weather general call received & ack returned (TWEA = 1) */
_0xA003A:
	LD   R26,Y
	CPI  R26,LOW(0x70)
	BREQ _0xA003E
	CPI  R26,LOW(0x78)
	BRNE _0xA003D
_0xA003E:
; 0005 0089 		return 2;								/* If yes then return 2 to indicate ack returned */
	LDI  R30,LOW(2)
	JMP  _0x214000B
; 0005 008A 		else
_0xA003D:
; 0005 008B 		continue;								/* Else continue */
	ADIW R28,1
	RJMP _0xA0031
; 0005 008C 	}
; 0005 008D }
; .FEND
;
;char I2C_Slave_Transmit(char data)
; 0005 0090 {
_I2C_Slave_Transmit:
; .FSTART _I2C_Slave_Transmit
; 0005 0091 	char status;
; 0005 0092 	TWDR = data;								/* Write data to TWDR to be transmitted */
	ST   -Y,R26
	ST   -Y,R17
;	data -> Y+1
;	status -> R17
	LDD  R30,Y+1
	OUT  0x3,R30
; 0005 0093 	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWEA);		/* Enable TWI and clear interrupt flag */
	LDI  R30,LOW(196)
	OUT  0x36,R30
; 0005 0094 	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (Write operation) */
_0xA0041:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xA0041
; 0005 0095 	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0005 0096 	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
	CPI  R17,160
	BRNE _0xA0044
; 0005 0097 	{
; 0005 0098 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -1 */
	IN   R30,0x36
	ORI  R30,0x80
	OUT  0x36,R30
; 0005 0099 		return -1;
	LDI  R30,LOW(255)
	RJMP _0x214000E
; 0005 009A 	}
; 0005 009B 	if (status == 0xB8)							/* Check weather data transmitted & ack received */
_0xA0044:
	CPI  R17,184
	BRNE _0xA0045
; 0005 009C 		return 0;									/* If yes then return 0 */
	LDI  R30,LOW(0)
	RJMP _0x214000E
; 0005 009D 	if (status == 0xC0)							/* Check weather data transmitted & nack received */
_0xA0045:
	CPI  R17,192
	BRNE _0xA0046
; 0005 009E 	{
; 0005 009F 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -2 */
	IN   R30,0x36
	ORI  R30,0x80
	OUT  0x36,R30
; 0005 00A0 		return -2;
	LDI  R30,LOW(254)
	RJMP _0x214000E
; 0005 00A1 	}
; 0005 00A2 	if (status == 0xC8)							/* If last data byte transmitted with ack received TWEA = 0 */
_0xA0046:
	CPI  R17,200
	BRNE _0xA0047
; 0005 00A3 	return -3;									/* If yes then return -3 */
	LDI  R30,LOW(253)
	RJMP _0x214000E
; 0005 00A4 	else										/* else return -4 */
_0xA0047:
; 0005 00A5 	return -4;
	LDI  R30,LOW(252)
; 0005 00A6 }
_0x214000E:
	LDD  R17,Y+0
	ADIW R28,2
	RET
; .FEND
;
;char I2C_Slave_Receive()
; 0005 00A9 {
_I2C_Slave_Receive:
; .FSTART _I2C_Slave_Receive
; 0005 00AA 	char status;								/* Declare variable */
; 0005 00AB 	TWCR=(1<<TWEN)|(1<<TWEA)|(1<<TWINT);		/* Enable TWI, generation of ack and clear interrupt flag */
	ST   -Y,R17
;	status -> R17
	LDI  R30,LOW(196)
	OUT  0x36,R30
; 0005 00AC 	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (read operation) */
_0xA0049:
	IN   R30,0x36
	ANDI R30,LOW(0x80)
	BREQ _0xA0049
; 0005 00AD 	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	IN   R30,0x1
	ANDI R30,LOW(0xF8)
	MOV  R17,R30
; 0005 00AE 	if (status == 0x80 || status == 0x90)		/* Check weather data received & ack returned (TWEA = 1) */
	CPI  R17,128
	BREQ _0xA004D
	CPI  R17,144
	BRNE _0xA004C
_0xA004D:
; 0005 00AF 	return TWDR;								/* If yes then return received data */
	IN   R30,0x3
	JMP  _0x214000C
; 0005 00B0 	if (status == 0x88 || status == 0x98)		/* Check weather data received, nack returned and switched to not addressed slav ...
_0xA004C:
	CPI  R17,136
	BREQ _0xA0050
	CPI  R17,152
	BRNE _0xA004F
_0xA0050:
; 0005 00B1 	return TWDR;								/* If yes then return received data */
	IN   R30,0x3
	JMP  _0x214000C
; 0005 00B2 	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
_0xA004F:
	CPI  R17,160
	BRNE _0xA0052
; 0005 00B3 	{
; 0005 00B4 		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return 0 */
	IN   R30,0x36
	ORI  R30,0x80
	OUT  0x36,R30
; 0005 00B5 		return -1;
	LDI  R30,LOW(255)
	JMP  _0x214000C
; 0005 00B6 	}
; 0005 00B7 	else
_0xA0052:
; 0005 00B8 	return -2;									/* Else return 1 */
	LDI  R30,LOW(254)
	JMP  _0x214000C
; 0005 00B9 }
; .FEND
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
; 0006 000F {

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
; 0006 0010 static unsigned char input_index=0;
; 0006 0011 // Read the AD conversion result
; 0006 0012 adc_data[input_index]=ADCW;
	LDS  R30,_input_index_S0060000000
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
; 0006 0013 // Select next ADC input
; 0006 0014 if (++input_index > (LAST_ADC_INPUT-FIRST_ADC_INPUT))
	LDS  R26,_input_index_S0060000000
	SUBI R26,-LOW(1)
	STS  _input_index_S0060000000,R26
	CPI  R26,LOW(0x1)
	BRLO _0xC0003
; 0006 0015    input_index=0;
	LDI  R30,LOW(0)
	STS  _input_index_S0060000000,R30
; 0006 0016 ADMUX=(FIRST_ADC_INPUT | ADC_VREF_TYPE)+input_index;
_0xC0003:
	LDS  R30,_input_index_S0060000000
	SUBI R30,-LOW(64)
	OUT  0x7,R30
; 0006 0017 // Delay needed for the stabilization of the ADC input voltage
; 0006 0018 delay_us(10);
	__DELAY_USB 27
; 0006 0019 // Start the AD conversion
; 0006 001A ADCSRA|=(1<<ADSC);
	SBI  0x6,6
; 0006 001B 
; 0006 001C }
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
; 0006 001F 
; 0006 0020  { char scr[20];
; 0006 0021  adc_data[0]= read_adc(0);
;	scr -> Y+0
; 0006 0022  if (adc_data[0]!=  adc_old_data)
; 0006 0023 {
; 0006 0024     SPDR=adc_data[0]&0x00ff;
; 0006 0025     delay_ms(10);
; 0006 0026     SPDR=adc_data[0]>>8;
; 0006 0027     adc_old_data=adc_data[0];
; 0006 0028     sprintf(scr,"\r\n ADC0=%d\r\n",adc_old_data);
; 0006 0029     puts(scr);
; 0006 002A }
; 0006 002B }
;
;
;
;
;void adc_init_no_intterupt(void)
; 0006 0031 {
; 0006 0032 ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
; 0006 0033 ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (0<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
; 0006 0034 SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
; 0006 0035 
; 0006 0036 }
;
;
;void adc_init_interrupt(void)
; 0006 003A {
; 0006 003B ADMUX=FIRST_ADC_INPUT | ADC_VREF_TYPE;
; 0006 003C ADCSRA=(1<<ADEN) | (1<<ADSC) | (1<<ADATE) | (0<<ADIF) | (1<<ADIE) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
; 0006 003D SFIOR=(0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
; 0006 003E 
; 0006 003F }
;
;
;
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0006 0046 {
; 0006 0047 ADMUX=adc_input | ADC_VREF_TYPE;
;	adc_input -> Y+0
; 0006 0048 // Delay needed for the stabilization of the ADC input voltage
; 0006 0049 delay_us(10);
; 0006 004A // Start the AD conversion
; 0006 004B ADCSRA|=(1<<ADSC);
; 0006 004C // Wait for the AD conversion to complete
; 0006 004D while ((ADCSRA & (1<<ADIF))==0);
; 0006 004E ADCSRA|=(1<<ADIF);
; 0006 004F return ADCW;
; 0006 0050 }
;/****************************************************************************
;Image data created by the LCD Vision V1.05 font & image editor/converter
;(C) Copyright 2011-2013 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Graphic LCD controller: KS0108 128x64 /CS1,/CS2
;Image width: 64 pixels
;Image height: 64 pixels
;Color depth: 1 bits/pixel
;Imported image file name: Tempo-schwarz-1.bmp
;
;Exported monochrome image data size:
;516 bytes for displays organized as horizontal rows of bytes
;516 bytes for displays organized as rows of vertical bytes.
;****************************************************************************/
;
;flash unsigned char clock[]=
;{
;/* Image width: 64 pixels */
;0x40, 0x00,
;/* Image height: 64 pixels */
;0x40, 0x00,
;
;
;#ifndef _GLCD_DATA_BYTEY_
;/* Image data for monochrome displays organized
;   as horizontal rows of bytes */
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0xFF, 0xFF, 0x01, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0xFF, 0xFF, 0x0F, 0x00, 0x00,
;0x00, 0x00, 0xF8, 0xFF, 0xFF, 0x3F, 0x00, 0x00,
;0x00, 0x00, 0xFE, 0x07, 0xC0, 0xFF, 0x00, 0x00,
;0x00, 0x80, 0x7F, 0x00, 0x00, 0xFC, 0x03, 0x00,
;0x00, 0xC0, 0x1F, 0x80, 0x03, 0xF0, 0x07, 0x00,
;0x00, 0xF0, 0x07, 0x80, 0x03, 0xC0, 0x1F, 0x00,
;0x00, 0xF8, 0x01, 0x80, 0x03, 0x00, 0x3F, 0x00,
;0x00, 0xFC, 0x1C, 0x80, 0x03, 0x70, 0x7E, 0x00,
;0x00, 0x7E, 0x3C, 0x80, 0x03, 0x78, 0xF8, 0x00,
;0x00, 0x1F, 0x7C, 0x80, 0x03, 0x78, 0xF0, 0x01,
;0x80, 0x0F, 0x78, 0x00, 0x00, 0x3C, 0xE0, 0x03,
;0x80, 0x07, 0x78, 0x00, 0x00, 0x3C, 0xC0, 0x07,
;0xC0, 0x07, 0x70, 0x00, 0x00, 0x1C, 0x80, 0x07,
;0xE0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0F,
;0xE0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F,
;0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E,
;0xF0, 0x0E, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x1E,
;0x78, 0x1E, 0x00, 0x00, 0x00, 0x00, 0xF0, 0x3C,
;0x78, 0x7E, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x3C,
;0x3C, 0x7E, 0x00, 0x00, 0x00, 0x00, 0xFE, 0x78,
;0x3C, 0x78, 0x00, 0x00, 0x00, 0x00, 0x3C, 0x78,
;0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0xCF, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xE7,
;0xEF, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xEF,
;0xCF, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xE0, 0xEF,
;0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0,
;0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0,
;0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x70,
;0x3C, 0x70, 0x00, 0x00, 0x00, 0x00, 0x1C, 0x78,
;0x3C, 0x7C, 0x00, 0x00, 0x00, 0x00, 0x7C, 0x78,
;0x78, 0x7E, 0x00, 0x00, 0x00, 0x00, 0xFC, 0x3C,
;0x78, 0x3E, 0x00, 0x00, 0x00, 0x00, 0xF8, 0x3C,
;0xF8, 0x0E, 0x00, 0x00, 0x00, 0x00, 0xE0, 0x3E,
;0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E,
;0xE0, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F,
;0xE0, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F,
;0xC0, 0x03, 0x70, 0x00, 0x00, 0x1C, 0x80, 0x07,
;0xC0, 0x07, 0x70, 0x00, 0x00, 0x3C, 0xC0, 0x07,
;0x80, 0x0F, 0x78, 0x00, 0x00, 0x3C, 0xE0, 0x03,
;0x00, 0x1F, 0x78, 0x80, 0x03, 0x7C, 0xF0, 0x01,
;0x00, 0x3E, 0x3C, 0x80, 0x03, 0x78, 0xF8, 0x00,
;0x00, 0xFC, 0x3C, 0x80, 0x03, 0x70, 0x7C, 0x00,
;0x00, 0xF8, 0x01, 0x80, 0x03, 0x00, 0x3F, 0x00,
;0x00, 0xF0, 0x07, 0x80, 0x03, 0xC0, 0x1F, 0x00,
;0x00, 0xE0, 0x1F, 0x80, 0x03, 0xE0, 0x0F, 0x00,
;0x00, 0x80, 0x7F, 0x80, 0x03, 0xFC, 0x03, 0x00,
;0x00, 0x00, 0xFF, 0x03, 0x80, 0xFF, 0x01, 0x00,
;0x00, 0x00, 0xFC, 0xFF, 0xFF, 0x7F, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0xFF, 0xFF, 0x1F, 0x00, 0x00,
;0x00, 0x00, 0x00, 0xFF, 0xFF, 0x03, 0x00, 0x00,
;#else
;/* Image data for monochrome displays organized
;   as rows of vertical bytes */
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0xC0, 0xE0,
;0xE0, 0xF0, 0xF0, 0x78, 0x78, 0x3C, 0x3C, 0x1C,
;0x1E, 0x1E, 0x1E, 0x0E, 0x0E, 0x0E, 0x0E, 0xCE,
;0xCE, 0xCE, 0x0E, 0x0E, 0x0E, 0x0E, 0x1E, 0x1E,
;0x1E, 0x1C, 0x3C, 0x3C, 0x78, 0x78, 0xF0, 0xF0,
;0xE0, 0xE0, 0xC0, 0x80, 0x80, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xC0, 0xF0,
;0xF8, 0xFC, 0x7E, 0x1F, 0x0F, 0x07, 0x07, 0x03,
;0x01, 0x00, 0x0E, 0x3E, 0x7E, 0x7C, 0x78, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F,
;0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x70, 0x7C, 0x7E, 0x3E, 0x0E, 0x00,
;0x01, 0x03, 0x03, 0x07, 0x0F, 0x1F, 0x3E, 0xFC,
;0xF8, 0xF0, 0xE0, 0x80, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0xE0, 0xF8, 0xFE, 0x7F, 0x1F, 0x07,
;0x01, 0x3C, 0x3C, 0x7C, 0x78, 0x70, 0x70, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x20, 0x70, 0x70, 0x78, 0x78, 0x3C, 0x3C,
;0x01, 0x07, 0x1F, 0x7F, 0xFE, 0xF8, 0xE0, 0x00,
;0xC0, 0xFF, 0xFF, 0xFF, 0x07, 0x00, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80,
;0x80, 0x80, 0x80, 0x00, 0x07, 0xFF, 0xFF, 0xFF,
;0x07, 0xFF, 0xFF, 0xFF, 0xC0, 0x01, 0x03, 0x03,
;0x03, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x03,
;0x03, 0x03, 0x03, 0x03, 0x80, 0xFF, 0xFF, 0xFF,
;0x00, 0x01, 0x0F, 0x7F, 0xFF, 0xFC, 0xF0, 0xC0,
;0x00, 0x70, 0x78, 0x78, 0x3C, 0x3C, 0x1C, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x1C, 0x3C, 0x3C, 0x78, 0x78, 0x70,
;0x00, 0xC0, 0xF0, 0xFC, 0xFF, 0x7F, 0x0F, 0x01,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x0F, 0x1F,
;0x3F, 0x7E, 0xF8, 0xF0, 0xE0, 0xC0, 0x80, 0x80,
;0x00, 0x00, 0xC0, 0xF0, 0xFC, 0xFC, 0x3C, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xE0,
;0xE0, 0xE0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x3C, 0x7C, 0xFC, 0xF8, 0xE0, 0x00,
;0x00, 0x00, 0x80, 0xC0, 0xE0, 0xF0, 0xF8, 0x7C,
;0x3F, 0x1F, 0x0F, 0x03, 0x01, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x07, 0x0F,
;0x1F, 0x1E, 0x3E, 0x3C, 0x3C, 0x78, 0x78, 0x70,
;0xF0, 0xF0, 0xE0, 0xE0, 0xE0, 0xE0, 0xE0, 0xEF,
;0xEF, 0xEF, 0xE0, 0xE0, 0xE0, 0xE0, 0xE0, 0xF0,
;0xF0, 0xF0, 0x78, 0x78, 0x78, 0x3C, 0x3E, 0x1E,
;0x1F, 0x0F, 0x07, 0x07, 0x03, 0x01, 0x00, 0x00,
;0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
;#endif
;};
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
;
;
;flash int cos6data[]={0    ,  11    ,21    ,  31    ,  41    ,50    ,  59    ,  67    ,  74    ,81    ,87    ,
;91    ,95    ,  98    ,  99    ,  100    ,99    ,98    ,  95    ,  91    ,87    ,81    ,74    ,67    ,59    ,50    ,41   ...
;31    ,21    ,  11    ,0    ,  -10    ,-21    ,  -31    ,  -41    ,-50    ,-59    ,-67    ,-74    ,
;-81    ,-87    ,-91    ,-95    ,-98    ,-99    ,-100    ,  -99    ,-98    ,-95    ,
;-91    ,-87    ,-81    ,-74    ,-67    ,-59    ,-50    ,-41    ,-31    ,-21    ,-11    ,
;0
;};
;
;flash int sin6data[]={
;100    ,99    ,98    ,95    ,91    ,87    ,81    ,74    ,
;67    ,59    ,  50    ,41    ,31    ,21    ,  10    ,0    ,
;-10    ,-21    ,-31    ,-41    ,-50    ,-59    ,-67    ,-74    ,
;-81    ,-87    ,-91    ,-95    ,-98    ,-99    ,-100    ,-99    ,
;-98    ,-95    ,-91    ,  -87    ,-81    ,-74    ,-67    ,  -59    ,
;-50    ,  -41    ,-31    ,  -21    ,-11    ,  0    ,10    ,  21    ,
;31    ,  41    ,50    ,  59    ,      67    ,  74    ,  81    ,    86    ,
;91    ,  95    ,98    ,  99    ,100
;};
;
;char hx[]={0,6,10,12,10,6,0,-6,-10,-12,-10,-6,0};

	.DSEG
;char hy[]={-12,-10,-6,0,6,10,12,10,6,0,-6,-10,-12};
;
;char xold=30,yold=30,xmold,ymold;
;char hourd=0,mind=0,secd=0,count_clock=0;
;bit hsecd=0,hmind=0,hhourd=0;
;
;
;void hms_display(void)
; 0008 0021 {

	.CSEG
_hms_display:
; .FSTART _hms_display
; 0008 0022  char x,y;
; 0008 0023  char scr[20];
; 0008 0024 
; 0008 0025 
; 0008 0026  sprintf(scr,"%d:%d:%d ",hourd,mind,secd);
	SBIW R28,20
	ST   -Y,R17
	ST   -Y,R16
;	x -> R17
;	y -> R16
;	scr -> Y+2
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x100000,0
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_hourd
	CALL SUBOPT_0x4
	LDS  R30,_mind
	CALL SUBOPT_0x4
	LDS  R30,_secd
	CALL SUBOPT_0x4
	LDI  R24,12
	CALL _sprintf
	ADIW R28,16
; 0008 0027  glcd_moveto(80,  40);
	LDI  R30,LOW(80)
	ST   -Y,R30
	LDI  R26,LOW(40)
	CALL _glcd_moveto
; 0008 0028  glcd_outtext(scr);
	MOVW R26,R28
	ADIW R26,2
	CALL _glcd_outtext
; 0008 0029 
; 0008 002A  glcd_setlinestyle(1,GLCD_LINE_SOLID);
	CALL SUBOPT_0x5
; 0008 002B  deleteclock(sec_radius, xold,yold);
	LDI  R30,LOW(19)
	ST   -Y,R30
	LDS  R30,_xold
	ST   -Y,R30
	LDS  R26,_yold
	RCALL _deleteclock
; 0008 002C 
; 0008 002D  glcd_line(x_center_clock ,y_center_clock,(x_center_clock +sec_radius*cos6data[secd]/100),(y_center_clock-sec_radius*sin ...
	CALL SUBOPT_0x6
	LDS  R30,_secd
	CALL SUBOPT_0x7
	CALL SUBOPT_0x8
	SUBI R30,-LOW(32)
	ST   -Y,R30
	LDS  R30,_secd
	CALL SUBOPT_0x9
	CALL SUBOPT_0x8
	LDI  R26,LOW(32)
	SUB  R26,R30
	CALL _glcd_line
; 0008 002E 
; 0008 002F 
; 0008 0030  if (hmind==1)
	SBRS R2,4
	RJMP _0x100007
; 0008 0031  {
; 0008 0032   deleteclock(min_radius,xmold,ymold);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDS  R30,_xmold
	ST   -Y,R30
	LDS  R26,_ymold
	RCALL _deleteclock
; 0008 0033   }
; 0008 0034 
; 0008 0035  glcd_line(x_center_clock ,y_center_clock,(x_center_clock +min_radius*cos6data[mind]/100),(y_center_clock-min_radius*sin ...
_0x100007:
	CALL SUBOPT_0x6
	LDS  R30,_mind
	CALL SUBOPT_0x7
	CALL SUBOPT_0xA
	SUBI R30,-LOW(32)
	ST   -Y,R30
	LDS  R30,_mind
	CALL SUBOPT_0x9
	CALL SUBOPT_0xA
	LDI  R26,LOW(32)
	SUB  R26,R30
	CALL _glcd_line
; 0008 0036  x=hx[hourd]+(mind*(hx[hourd+1]-hx[hourd]))/60;
	LDS  R30,_hourd
	LDI  R31,0
	MOVW R0,R30
	MOVW R26,R30
	SUBI R30,LOW(-_hx)
	SBCI R31,HIGH(-_hx)
	LD   R24,Z
	LDS  R22,_mind
	CLR  R23
	MOVW R30,R26
	__ADDW1MN _hx,1
	LD   R26,Z
	LDI  R27,0
	MOVW R30,R0
	SUBI R30,LOW(-_hx)
	SBCI R31,HIGH(-_hx)
	CALL SUBOPT_0xB
	MOV  R17,R30
; 0008 0037  y=hy[hourd]+(mind*(hy[hourd+1]-hy[hourd]))/60;
	LDS  R30,_hourd
	LDI  R31,0
	MOVW R0,R30
	MOVW R26,R30
	SUBI R30,LOW(-_hy)
	SBCI R31,HIGH(-_hy)
	LD   R24,Z
	LDS  R22,_mind
	CLR  R23
	MOVW R30,R26
	__ADDW1MN _hy,1
	LD   R26,Z
	LDI  R27,0
	MOVW R30,R0
	SUBI R30,LOW(-_hy)
	SBCI R31,HIGH(-_hy)
	CALL SUBOPT_0xB
	MOV  R16,R30
; 0008 0038 
; 0008 0039 glcd_line(x_center_clock ,y_center_clock,(x_center_clock+x),(y_center_clock+y)); //min
	CALL SUBOPT_0x6
	MOV  R30,R17
	SUBI R30,-LOW(32)
	ST   -Y,R30
	MOV  R26,R16
	SUBI R26,-LOW(32)
	CALL _glcd_line
; 0008 003A  yold=secd;
	LDS  R30,_secd
	STS  _yold,R30
; 0008 003B  xold=secd;
	LDS  R30,_secd
	STS  _xold,R30
; 0008 003C  xmold=mind;
	LDS  R30,_mind
	STS  _xmold,R30
; 0008 003D  ymold=mind;
	LDS  R30,_mind
	STS  _ymold,R30
; 0008 003E  }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,22
	RET
; .FEND
;
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0008 0043 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
	CALL SUBOPT_0x2
; 0008 0044 // Reinitialize Timer1 value
; 0008 0045 TCNT1H=0xD8F0 >> 8;
	LDI  R30,LOW(216)
	OUT  0x2D,R30
; 0008 0046 TCNT1L=0xD8F0 & 0xff;
	LDI  R30,LOW(240)
	OUT  0x2C,R30
; 0008 0047 // Place your code here
; 0008 0048  count_clock++;
	LDS  R30,_count_clock
	SUBI R30,-LOW(1)
	STS  _count_clock,R30
; 0008 0049  //if (count==50)clockdisplay();
; 0008 004A  if (count_clock==20)
	LDS  R26,_count_clock
	CPI  R26,LOW(0x14)
	BRNE _0x100008
; 0008 004B  {
; 0008 004C      count_clock=0;
	LDI  R30,LOW(0)
	STS  _count_clock,R30
; 0008 004D      secd++;
	LDS  R30,_secd
	SUBI R30,-LOW(1)
	STS  _secd,R30
; 0008 004E      hsecd==1;
	LDI  R26,0
	SBRC R2,3
	LDI  R26,1
	LDI  R30,LOW(1)
	CALL __EQB12
; 0008 004F      if (secd==60)
	LDS  R26,_secd
	CPI  R26,LOW(0x3C)
	BRNE _0x100009
; 0008 0050      {
; 0008 0051         secd=0;
	LDI  R30,LOW(0)
	STS  _secd,R30
; 0008 0052         mind++;
	LDS  R30,_mind
	SUBI R30,-LOW(1)
	STS  _mind,R30
; 0008 0053         hmind=1;
	SET
	BLD  R2,4
; 0008 0054         if (mind==60){
	LDS  R26,_mind
	CPI  R26,LOW(0x3C)
	BRNE _0x10000A
; 0008 0055         hourd++;
	LDS  R30,_hourd
	SUBI R30,-LOW(1)
	STS  _hourd,R30
; 0008 0056         hhourd=1;
	BLD  R2,5
; 0008 0057         mind=0;
	LDI  R30,LOW(0)
	STS  _mind,R30
; 0008 0058         if (hourd==12)hourd=0;
	LDS  R26,_hourd
	CPI  R26,LOW(0xC)
	BRNE _0x10000B
	STS  _hourd,R30
; 0008 0059         }
_0x10000B:
; 0008 005A         }
_0x10000A:
; 0008 005B 
; 0008 005C      hms_display();
_0x100009:
	RCALL _hms_display
; 0008 005D  }
; 0008 005E 
; 0008 005F }
_0x100008:
	CALL SUBOPT_0x3
	RETI
; .FEND
;
;
;
;void timer1_init(void)
; 0008 0064 {
_timer1_init:
; .FSTART _timer1_init
; 0008 0065 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0008 0066 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (1<<CS11) | (0<<CS10);
	LDI  R30,LOW(2)
	OUT  0x2E,R30
; 0008 0067 TCNT1H=0xD8;
	LDI  R30,LOW(216)
	OUT  0x2D,R30
; 0008 0068 TCNT1L=0xF0;
	LDI  R30,LOW(240)
	OUT  0x2C,R30
; 0008 0069 ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0008 006A ICR1L=0x00;
	OUT  0x26,R30
; 0008 006B OCR1AH=0x00;
	OUT  0x2B,R30
; 0008 006C OCR1AL=0x00;
	OUT  0x2A,R30
; 0008 006D OCR1BH=0x00;
	OUT  0x29,R30
; 0008 006E OCR1BL=0x00;
	OUT  0x28,R30
; 0008 006F 
; 0008 0070 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0008 0071 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (1<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0008 0072 
; 0008 0073 // Global enable interrupts
; 0008 0074 }
	RET
; .FEND
;
;
;
;
;
;
;
;/****************************/
;void clockdisplay(void)
; 0008 007E {
; 0008 007F  char scr[10];
; 0008 0080 char i,j,alfa,beta;
; 0008 0081 
; 0008 0082 glcd_outtext("Hello");
;	scr -> Y+4
;	i -> R17
;	j -> R16
;	alfa -> R19
;	beta -> R18
; 0008 0083 
; 0008 0084 glcd_outtextxy(0,40,"Time");
; 0008 0085 sprintf(scr,"%2d:%2d:%2d",10,30,9);
; 0008 0086 //glcd_outtextxy(30,20,"in the name of god");
; 0008 0087 glcd_outtextxy(0,50,scr);
; 0008 0088 
; 0008 0089 glcd_setlinestyle(3,4);
; 0008 008A 
; 0008 008B glcd_circle(80,30,30); //clock circle
; 0008 008C glcd_circle(80,30,2); //clock circle
; 0008 008D 
; 0008 008E glcd_setlinestyle(1,GLCD_LINE_SOLID);
; 0008 008F 
; 0008 0090 
; 0008 0091  for (i=0;i<60;i++)
; 0008 0092  {
; 0008 0093   glcd_setlinestyle(1,GLCD_LINE_SOLID);
; 0008 0094 
; 0008 0095   glcd_setpixel( 80+25*cos6data[i]/100, (30+25*sin6data[i]/100));
; 0008 0096 
; 0008 0097   if((i==0)||(i==15)||(i==30)||(i==45))
; 0008 0098   {
; 0008 0099 
; 0008 009A   glcd_setpixel( 80+25*cos6data[i]/100, (30+25*sin6data[i]/100));
; 0008 009B   glcd_setpixel( 80+24*cos6data[i]/100, (30+24*sin6data[i]/100));
; 0008 009C   glcd_setpixel( 80+23*cos6data[i]/100, (30+23*sin6data[i]/100));
; 0008 009D   glcd_setpixel( 80+22*cos6data[i]/100, (30+22*sin6data[i]/100));
; 0008 009E 
; 0008 009F   glcd_line((80+22*sin6data[i]/100),(30+20*cos6data[i]/100),(80+25*sin6data[i]/100),(30+25*cos6data[i]/100));
; 0008 00A0  }
; 0008 00A1 
; 0008 00A2  if((i==5)||(i==10))
; 0008 00A3 
; 0008 00A4  {
; 0008 00A5  alfa=25*cos6data[i]/100;
; 0008 00A6  beta=25*sin6data[i]/100;
; 0008 00A7  glcd_setpixel( 80+alfa, 30+beta);
; 0008 00A8  for (j=0;j<2;j++)glcd_setpixel( 80+alfa-j, 30+beta-j);
; 0008 00A9 }
; 0008 00AA  if((i==40)||(i==35))
; 0008 00AB 
; 0008 00AC  {
; 0008 00AD  alfa=25*cos6data[i]/100;
; 0008 00AE  beta=25*sin6data[i]/100;
; 0008 00AF  glcd_setpixel( 80+alfa, 30+beta);
; 0008 00B0  for (j=0;j<2;j++)glcd_setpixel( 80+alfa+j, 30+beta+j);
; 0008 00B1 }
; 0008 00B2  if((i==20)||(i==25))
; 0008 00B3 
; 0008 00B4  {
; 0008 00B5  alfa=25*cos6data[i]/100;
; 0008 00B6  beta=25*sin6data[i]/100;
; 0008 00B7  glcd_setpixel( 80+alfa, 30+beta);
; 0008 00B8  for (j=0;j<2;j++)glcd_setpixel( 80+alfa-j, 30+beta+j);
; 0008 00B9 }
; 0008 00BA  if((i==50)||(i==55))
; 0008 00BB 
; 0008 00BC  {
; 0008 00BD  alfa=25*cos6data[i]/100;
; 0008 00BE  beta=25*sin6data[i]/100;
; 0008 00BF  glcd_setpixel( 80+alfa, 30+beta);
; 0008 00C0  for (j=0;j<2;j++)glcd_setpixel( 80+alfa+j, 30+beta-j);
; 0008 00C1 }
; 0008 00C2  }
; 0008 00C3 
; 0008 00C4   }

	.DSEG
_0x10000C:
	.BYTE 0xB
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
;#include <clock.h>
;#include <timer.h>
;
;
;
;void glcd_init_func(void)
; 0009 0008 {

	.CSEG
_glcd_init_func:
; .FSTART _glcd_init_func
; 0009 0009  GLCDINIT_t glcd_init_data;
; 0009 000A 
; 0009 000B 
; 0009 000C glcd_init_data.font=font5x7;
	SBIW R28,6
;	glcd_init_data -> Y+0
	LDI  R30,LOW(_font5x7*2)
	LDI  R31,HIGH(_font5x7*2)
	ST   Y,R30
	STD  Y+1,R31
; 0009 000D glcd_init_data.readxmem=NULL;
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0009 000E glcd_init_data.writexmem=NULL;
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0009 000F glcd_init(&glcd_init_data);
	MOVW R26,R28
	CALL _glcd_init
; 0009 0010 
; 0009 0011 
; 0009 0012 
; 0009 0013 }
	JMP  _0x214000A
; .FEND
;
;/**************************************************/
;
;void clock_display(void)
; 0009 0018 {
_clock_display:
; .FSTART _clock_display
; 0009 0019 glcd_init_func();
	RCALL _glcd_init_func
; 0009 001A glcd_putimagef(0,0,clock,GLCD_PUTCOPY);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	LDI  R30,LOW(_clock*2)
	LDI  R31,HIGH(_clock*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _glcd_putimagef
; 0009 001B }
	RET
; .FEND
;/***********************************************/
;void deleteclock(char data,char xxold,char yyold)
; 0009 001E  {
_deleteclock:
; .FSTART _deleteclock
; 0009 001F  char i,x,y;
; 0009 0020  //????????????????????????????
; 0009 0021  for (i=1;i<(data+1);i++)
	ST   -Y,R26
	CALL __SAVELOCR4
;	data -> Y+6
;	xxold -> Y+5
;	yyold -> Y+4
;	i -> R17
;	x -> R16
;	y -> R19
	LDI  R17,LOW(1)
_0x120004:
	LDD  R30,Y+6
	LDI  R31,0
	ADIW R30,1
	MOV  R26,R17
	LDI  R27,0
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x120005
; 0009 0022  {
; 0009 0023  x=x_center_clock +i*cos6data[xxold]/100;
	MOV  R22,R17
	CLR  R23
	LDD  R30,Y+5
	CALL SUBOPT_0x7
	CALL SUBOPT_0xC
	SUBI R30,-LOW(32)
	MOV  R16,R30
; 0009 0024  y=y_center_clock-i*sin6data[yyold]/100;
	MOV  R22,R17
	CLR  R23
	LDD  R30,Y+4
	CALL SUBOPT_0x9
	CALL SUBOPT_0xC
	LDI  R26,LOW(32)
	SUB  R26,R30
	MOV  R19,R26
; 0009 0025 
; 0009 0026  glcd_clrpixel(x,y);
	ST   -Y,R16
	CALL _glcd_clrpixel
; 0009 0027  glcd_clrpixel(x,y+1);
	ST   -Y,R16
	MOV  R26,R19
	SUBI R26,-LOW(1)
	CALL _glcd_clrpixel
; 0009 0028  glcd_clrpixel(x,y-1);
	ST   -Y,R16
	MOV  R26,R19
	SUBI R26,LOW(1)
	CALL _glcd_clrpixel
; 0009 0029 
; 0009 002A  glcd_clrpixel(x-1,y);
	MOV  R30,R16
	SUBI R30,LOW(1)
	CALL SUBOPT_0xD
; 0009 002B  glcd_clrpixel(x+1,y);
	CALL SUBOPT_0xD
; 0009 002C  glcd_clrpixel(x+1,y+1);
	ST   -Y,R30
	MOV  R26,R19
	SUBI R26,-LOW(1)
	CALL _glcd_clrpixel
; 0009 002D  glcd_clrpixel(x+1,y-1);
	MOV  R30,R16
	SUBI R30,-LOW(1)
	ST   -Y,R30
	MOV  R26,R19
	SUBI R26,LOW(1)
	CALL _glcd_clrpixel
; 0009 002E   }
	SUBI R17,-1
	RJMP _0x120004
_0x120005:
; 0009 002F   }
	CALL __LOADLOCR4
	ADIW R28,7
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

	.CSEG
_puts:
; .FSTART _puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000003:
	CALL SUBOPT_0xE
	BREQ _0x2000005
	MOV  R26,R17
	CALL _putchar
	RJMP _0x2000003
_0x2000005:
	LDI  R26,LOW(10)
	CALL _putchar
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
	CALL SUBOPT_0xF
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0xF
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
	CALL SUBOPT_0x10
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x11
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x10
	CALL SUBOPT_0x12
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x10
	CALL SUBOPT_0x12
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
	CALL SUBOPT_0x10
	CALL SUBOPT_0x13
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
	CALL SUBOPT_0x10
	CALL SUBOPT_0x13
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
	CALL SUBOPT_0xF
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
	CALL SUBOPT_0xF
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
	CALL SUBOPT_0x11
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0xF
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
	CALL SUBOPT_0x11
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
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x14
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
	CALL SUBOPT_0x14
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
	BLD  R2,6
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
	SBRS R2,6
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
	BLD  R2,6
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
	SBRS R2,6
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
	BLD  R2,6
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
	BLD  R2,7
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
	BLD  R2,6
	RJMP _0x202005A
_0x2020055:
	CPI  R30,LOW(0xB8)
	BRNE _0x202005B
_0x202005A:
	SBRS R2,6
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
	BLD  R2,6
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
	BLD  R2,7
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
	SBI  0x15,2
	nop
	RET
; .FEND
_ks0108_disable_G102:
; .FSTART _ks0108_disable_G102
	CBI  0x15,2
	SBI  0x15,7
	SBI  0x15,6
	RET
; .FEND
_ks0108_rdbus_G102:
; .FSTART _ks0108_rdbus_G102
	ST   -Y,R17
	RCALL _ks0108_enable_G102
	IN   R17,25
	CBI  0x15,2
	MOV  R30,R17
_0x214000C:
	LD   R17,Y+
	RET
; .FEND
_ks0108_busy_G102:
; .FSTART _ks0108_busy_G102
	ST   -Y,R26
	ST   -Y,R17
	LDI  R30,LOW(0)
	OUT  0x1A,R30
	SBI  0x15,3
	CBI  0x15,4
	LDD  R26,Y+1
	LDI  R30,LOW(2)
	SUB  R30,R26
	MOV  R17,R30
	SBRS R17,0
	RJMP _0x2040003
	SBI  0x15,7
	RJMP _0x2040004
_0x2040003:
	CBI  0x15,7
_0x2040004:
	SBRS R17,1
	RJMP _0x2040005
	SBI  0x15,6
	RJMP _0x2040006
_0x2040005:
	CBI  0x15,6
_0x2040006:
_0x2040007:
	RCALL _ks0108_rdbus_G102
	ANDI R30,LOW(0x80)
	BRNE _0x2040007
	LDD  R17,Y+0
	JMP  _0x2140003
; .FEND
_ks0108_wrcmd_G102:
; .FSTART _ks0108_wrcmd_G102
	ST   -Y,R26
	LDD  R26,Y+1
	RCALL _ks0108_busy_G102
	CALL SUBOPT_0x15
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
	BRLO _0x204000A
	LDI  R30,LOW(0)
	STS  _ks0108_coord_G102,R30
_0x204000A:
	LDS  R30,_ks0108_coord_G102
	ANDI R30,LOW(0x3F)
	BRNE _0x204000B
	LDS  R30,_ks0108_coord_G102
	ST   -Y,R30
	__GETB2MN _ks0108_coord_G102,2
	RCALL _ks0108_gotoxp_G102
_0x204000B:
	RET
; .FEND
_ks0108_wrdata_G102:
; .FSTART _ks0108_wrdata_G102
	ST   -Y,R26
	__GETB2MN _ks0108_coord_G102,1
	RCALL _ks0108_busy_G102
	SBI  0x15,4
	CALL SUBOPT_0x15
_0x214000B:
	ADIW R28,1
	RET
; .FEND
_ks0108_rddata_G102:
; .FSTART _ks0108_rddata_G102
	__GETB2MN _ks0108_coord_G102,1
	RCALL _ks0108_busy_G102
	LDI  R30,LOW(0)
	OUT  0x1A,R30
	SBI  0x15,3
	SBI  0x15,4
	RCALL _ks0108_rdbus_G102
	RET
; .FEND
_ks0108_rdbyte_G102:
; .FSTART _ks0108_rdbyte_G102
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	CALL SUBOPT_0x16
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
	SBI  0x14,2
	SBI  0x14,3
	SBI  0x14,4
	SBI  0x14,5
	SBI  0x15,5
	SBI  0x14,7
	SBI  0x14,6
	RCALL _ks0108_disable_G102
	CBI  0x15,5
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
	SBI  0x15,5
	LDI  R17,LOW(0)
_0x204000C:
	CPI  R17,2
	BRSH _0x204000E
	ST   -Y,R17
	LDI  R26,LOW(63)
	RCALL _ks0108_wrcmd_G102
	ST   -Y,R17
	INC  R17
	LDI  R26,LOW(192)
	RCALL _ks0108_wrcmd_G102
	RJMP _0x204000C
_0x204000E:
	LDI  R30,LOW(1)
	STS  _glcd_state,R30
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SBIW R30,0
	BREQ _0x204000F
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
	RJMP _0x20400AC
_0x204000F:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _glcd_state,4
	__PUTW1MN _glcd_state,25
_0x20400AC:
	__PUTW1MN _glcd_state,27
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,6
	__PUTB1MN _glcd_state,7
	CALL SUBOPT_0x5
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
	BREQ _0x2040015
	LDI  R16,LOW(255)
_0x2040015:
_0x2040016:
	CPI  R19,8
	BRSH _0x2040018
	LDI  R30,LOW(0)
	ST   -Y,R30
	MOV  R26,R19
	SUBI R19,-1
	RCALL _ks0108_gotoxp_G102
	LDI  R17,LOW(0)
_0x2040019:
	MOV  R26,R17
	SUBI R17,-1
	CPI  R26,LOW(0x80)
	BRSH _0x204001B
	MOV  R26,R16
	CALL SUBOPT_0x17
	RJMP _0x2040019
_0x204001B:
	RJMP _0x2040016
_0x2040018:
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
_glcd_putpixel:
; .FSTART _glcd_putpixel
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x80)
	BRSH _0x204001D
	LDD  R26,Y+3
	CPI  R26,LOW(0x40)
	BRLO _0x204001C
_0x204001D:
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2140004
_0x204001C:
	LDD  R30,Y+4
	ST   -Y,R30
	LDD  R26,Y+4
	RCALL _ks0108_rdbyte_G102
	MOV  R17,R30
	RCALL _ks0108_setloc_G102
	LDD  R30,Y+3
	ANDI R30,LOW(0x7)
	LDI  R26,LOW(1)
	CALL __LSLB12
	MOV  R16,R30
	LDD  R30,Y+2
	CPI  R30,0
	BREQ _0x204001F
	OR   R17,R16
	RJMP _0x2040020
_0x204001F:
	MOV  R30,R16
	COM  R30
	AND  R17,R30
_0x2040020:
	MOV  R26,R17
	RCALL _ks0108_wrdata_G102
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x2140004
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
	BREQ _0x204002B
	CPI  R30,LOW(0x8)
	BRNE _0x204002C
_0x204002B:
	LDD  R30,Y+3
	ST   -Y,R30
	LDD  R26,Y+2
	CALL _glcd_mappixcolor1bit
	STD  Y+3,R30
	RJMP _0x204002D
_0x204002C:
	CPI  R30,LOW(0x3)
	BRNE _0x204002F
	LDD  R30,Y+3
	COM  R30
	STD  Y+3,R30
	RJMP _0x2040030
_0x204002F:
	CPI  R30,0
	BRNE _0x2040031
_0x2040030:
_0x204002D:
	LDD  R30,Y+2
	COM  R30
	AND  R17,R30
	RJMP _0x2040032
_0x2040031:
	CPI  R30,LOW(0x2)
	BRNE _0x2040033
_0x2040032:
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	OR   R17,R30
	RJMP _0x2040029
_0x2040033:
	CPI  R30,LOW(0x1)
	BRNE _0x2040034
	LDD  R30,Y+2
	LDD  R26,Y+3
	AND  R30,R26
	EOR  R17,R30
	RJMP _0x2040029
_0x2040034:
	CPI  R30,LOW(0x4)
	BRNE _0x2040029
	LDD  R30,Y+2
	COM  R30
	LDD  R26,Y+3
	OR   R30,R26
	AND  R17,R30
_0x2040029:
	MOV  R26,R17
	CALL SUBOPT_0x17
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
	BRSH _0x2040037
	LDD  R26,Y+15
	CPI  R26,LOW(0x40)
	BRSH _0x2040037
	LDD  R26,Y+14
	CPI  R26,LOW(0x0)
	BREQ _0x2040037
	LDD  R26,Y+13
	CPI  R26,LOW(0x0)
	BRNE _0x2040036
_0x2040037:
	RJMP _0x2140009
_0x2040036:
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
	BRLO _0x2040039
	LDD  R26,Y+16
	LDI  R30,LOW(128)
	SUB  R30,R26
	STD  Y+14,R30
_0x2040039:
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
	BRLO _0x204003A
	LDD  R26,Y+15
	LDI  R30,LOW(64)
	SUB  R30,R26
	STD  Y+13,R30
_0x204003A:
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BREQ PC+2
	RJMP _0x204003B
	LDD  R30,Y+12
	CPI  R30,LOW(0x1)
	BRNE _0x204003F
	RJMP _0x2140009
_0x204003F:
	CPI  R30,LOW(0x3)
	BRNE _0x2040042
	__GETW1MN _glcd_state,27
	SBIW R30,0
	BRNE _0x2040041
	RJMP _0x2140009
_0x2040041:
_0x2040042:
	LDD  R16,Y+8
	LDD  R30,Y+13
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R19,R30
	MOV  R30,R18
	ANDI R30,LOW(0x7)
	BRNE _0x2040044
	LDD  R26,Y+13
	CP   R18,R26
	BREQ _0x2040043
_0x2040044:
	MOV  R26,R16
	CLR  R27
	MOV  R30,R19
	LDI  R31,0
	CALL __MULW12U
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CALL SUBOPT_0x18
	LSR  R18
	LSR  R18
	LSR  R18
	MOV  R21,R19
_0x2040046:
	PUSH R21
	SUBI R21,-1
	MOV  R30,R18
	POP  R26
	CP   R30,R26
	BRLO _0x2040048
	MOV  R17,R16
_0x2040049:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x204004B
	CALL SUBOPT_0x19
	RJMP _0x2040049
_0x204004B:
	RJMP _0x2040046
_0x2040048:
_0x2040043:
	LDD  R26,Y+14
	CP   R16,R26
	BREQ _0x204004C
	LDD  R30,Y+14
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	CALL SUBOPT_0x18
	LDD  R30,Y+13
	ANDI R30,LOW(0x7)
	BREQ _0x204004D
	SUBI R19,-LOW(1)
_0x204004D:
	LDI  R18,LOW(0)
_0x204004E:
	PUSH R18
	SUBI R18,-1
	MOV  R30,R19
	POP  R26
	CP   R26,R30
	BRSH _0x2040050
	LDD  R17,Y+14
_0x2040051:
	PUSH R17
	SUBI R17,-1
	MOV  R30,R16
	POP  R26
	CP   R26,R30
	BRSH _0x2040053
	CALL SUBOPT_0x19
	RJMP _0x2040051
_0x2040053:
	LDD  R30,Y+14
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	CALL SUBOPT_0x18
	RJMP _0x204004E
_0x2040050:
_0x204004C:
_0x204003B:
	LDD  R30,Y+15
	ANDI R30,LOW(0x7)
	MOV  R19,R30
_0x2040054:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2040056
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(0)
	LDD  R16,Y+16
	CPI  R19,0
	BREQ PC+2
	RJMP _0x2040057
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH PC+2
	RJMP _0x2040058
	LDD  R30,Y+9
	CPI  R30,0
	BREQ _0x204005D
	CPI  R30,LOW(0x3)
	BRNE _0x204005E
_0x204005D:
	RJMP _0x204005F
_0x204005E:
	CPI  R30,LOW(0x7)
	BRNE _0x2040060
_0x204005F:
	RJMP _0x2040061
_0x2040060:
	CPI  R30,LOW(0x8)
	BRNE _0x2040062
_0x2040061:
	RJMP _0x2040063
_0x2040062:
	CPI  R30,LOW(0x6)
	BRNE _0x2040064
_0x2040063:
	RJMP _0x2040065
_0x2040064:
	CPI  R30,LOW(0x9)
	BRNE _0x2040066
_0x2040065:
	RJMP _0x2040067
_0x2040066:
	CPI  R30,LOW(0xA)
	BRNE _0x204005B
_0x2040067:
	ST   -Y,R16
	LDD  R30,Y+16
	CALL SUBOPT_0x16
_0x204005B:
_0x2040069:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x204006B
	LDD  R26,Y+9
	CPI  R26,LOW(0x6)
	BRNE _0x204006C
	RCALL _ks0108_rddata_G102
	RCALL _ks0108_setloc_G102
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ks0108_rddata_G102
	MOV  R26,R30
	CALL _glcd_writemem
	RCALL _ks0108_nextx_G102
	RJMP _0x204006D
_0x204006C:
	LDD  R30,Y+9
	CPI  R30,LOW(0x9)
	BRNE _0x2040071
	LDI  R21,LOW(0)
	RJMP _0x2040072
_0x2040071:
	CPI  R30,LOW(0xA)
	BRNE _0x2040070
	LDI  R21,LOW(255)
	RJMP _0x2040072
_0x2040070:
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1B
	MOV  R21,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x7)
	BREQ _0x2040079
	CPI  R30,LOW(0x8)
	BRNE _0x204007A
_0x2040079:
_0x2040072:
	CALL SUBOPT_0x1C
	MOV  R21,R30
	RJMP _0x204007B
_0x204007A:
	CPI  R30,LOW(0x3)
	BRNE _0x204007D
	COM  R21
	RJMP _0x204007E
_0x204007D:
	CPI  R30,0
	BRNE _0x2040080
_0x204007E:
_0x204007B:
	MOV  R26,R21
	CALL SUBOPT_0x17
	RJMP _0x2040077
_0x2040080:
	CALL SUBOPT_0x1D
	LDI  R30,LOW(255)
	ST   -Y,R30
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
_0x2040077:
_0x204006D:
	RJMP _0x2040069
_0x204006B:
	LDD  R30,Y+15
	SUBI R30,-LOW(8)
	STD  Y+15,R30
	LDD  R30,Y+13
	SUBI R30,LOW(8)
	STD  Y+13,R30
	RJMP _0x2040081
_0x2040058:
	LDD  R21,Y+13
	LDI  R18,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x2040082
_0x2040057:
	MOV  R30,R19
	LDD  R26,Y+13
	ADD  R26,R30
	CPI  R26,LOW(0x9)
	BRSH _0x2040083
	LDD  R18,Y+13
	LDI  R30,LOW(0)
	STD  Y+13,R30
	RJMP _0x2040084
_0x2040083:
	LDI  R30,LOW(8)
	SUB  R30,R19
	MOV  R18,R30
_0x2040084:
	ST   -Y,R19
	MOV  R26,R18
	CALL _glcd_getmask
	MOV  R20,R30
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x2040088
_0x2040089:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x204008B
	CALL SUBOPT_0x1E
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSRB12
	CALL SUBOPT_0x1F
	MOV  R30,R19
	MOV  R26,R20
	CALL __LSRB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x2040089
_0x204008B:
	RJMP _0x2040087
_0x2040088:
	CPI  R30,LOW(0x9)
	BRNE _0x204008C
	LDI  R21,LOW(0)
	RJMP _0x204008D
_0x204008C:
	CPI  R30,LOW(0xA)
	BRNE _0x2040093
	LDI  R21,LOW(255)
_0x204008D:
	CALL SUBOPT_0x1C
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	MOV  R21,R30
_0x2040090:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x2040092
	CALL SUBOPT_0x1D
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G102
	RJMP _0x2040090
_0x2040092:
	RJMP _0x2040087
_0x2040093:
_0x2040094:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x2040096
	CALL SUBOPT_0x20
	MOV  R26,R30
	MOV  R30,R19
	CALL __LSLB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
	RJMP _0x2040094
_0x2040096:
_0x2040087:
	LDD  R30,Y+13
	CPI  R30,0
	BRNE _0x2040097
	RJMP _0x2040056
_0x2040097:
	LDD  R26,Y+13
	CPI  R26,LOW(0x8)
	BRSH _0x2040098
	LDD  R30,Y+13
	SUB  R30,R18
	MOV  R21,R30
	LDI  R30,LOW(0)
	RJMP _0x20400AD
_0x2040098:
	MOV  R21,R19
	LDD  R30,Y+13
	SUBI R30,LOW(8)
_0x20400AD:
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
_0x2040082:
	MOV  R30,R21
	LDI  R31,0
	SUBI R30,LOW(-__glcd_mask*2)
	SBCI R31,HIGH(-__glcd_mask*2)
	LPM  R20,Z
	LDD  R30,Y+9
	CPI  R30,LOW(0x6)
	BRNE _0x204009D
_0x204009E:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400A0
	CALL SUBOPT_0x1E
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSLB12
	CALL SUBOPT_0x1F
	MOV  R30,R18
	MOV  R26,R20
	CALL __LSLB12
	COM  R30
	AND  R30,R1
	OR   R21,R30
	CALL SUBOPT_0x1A
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R21
	CALL _glcd_writemem
	RJMP _0x204009E
_0x20400A0:
	RJMP _0x204009C
_0x204009D:
	CPI  R30,LOW(0x9)
	BRNE _0x20400A1
	LDI  R21,LOW(0)
	RJMP _0x20400A2
_0x20400A1:
	CPI  R30,LOW(0xA)
	BRNE _0x20400A8
	LDI  R21,LOW(255)
_0x20400A2:
	CALL SUBOPT_0x1C
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	MOV  R21,R30
_0x20400A5:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400A7
	CALL SUBOPT_0x1D
	ST   -Y,R20
	LDI  R26,LOW(0)
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400A5
_0x20400A7:
	RJMP _0x204009C
_0x20400A8:
_0x20400A9:
	PUSH R17
	SUBI R17,-1
	LDD  R30,Y+14
	POP  R26
	CP   R26,R30
	BRSH _0x20400AB
	CALL SUBOPT_0x20
	MOV  R26,R30
	MOV  R30,R18
	CALL __LSRB12
	ST   -Y,R30
	ST   -Y,R20
	LDD  R26,Y+13
	RCALL _ks0108_wrmasked_G102
	RJMP _0x20400A9
_0x20400AB:
_0x204009C:
_0x2040081:
	LDD  R30,Y+8
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2040054
_0x2040056:
_0x2140009:
	CALL __LOADLOCR6
	ADIW R28,17
	RET
; .FEND

	.CSEG
_glcd_clipx:
; .FSTART _glcd_clipx
	CALL SUBOPT_0x21
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
	CALL SUBOPT_0x21
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
_glcd_clrpixel:
; .FSTART _glcd_clrpixel
	ST   -Y,R26
	LDD  R30,Y+1
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	__GETB2MN _glcd_state,1
	RCALL _glcd_putpixel
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
	__GETD1N 0x0
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
_glcd_getcharw_G103:
; .FSTART _glcd_getcharw_G103
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,3
	CALL SUBOPT_0x22
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x206000B
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2140008
_0x206000B:
	CALL SUBOPT_0x23
	STD  Y+7,R0
	CALL SUBOPT_0x23
	STD  Y+6,R0
	CALL SUBOPT_0x23
	STD  Y+8,R0
	LDD  R30,Y+11
	LDD  R26,Y+8
	CP   R30,R26
	BRSH _0x206000C
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2140008
_0x206000C:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R21,Z
	LDD  R26,Y+8
	CLR  R27
	CLR  R30
	ADD  R26,R21
	ADC  R27,R30
	LDD  R30,Y+11
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRLO _0x206000D
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x2140008
_0x206000D:
	LDD  R30,Y+6
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R20,R30
	LDD  R30,Y+6
	ANDI R30,LOW(0x7)
	BREQ _0x206000E
	SUBI R20,-LOW(1)
_0x206000E:
	LDD  R30,Y+7
	CPI  R30,0
	BREQ _0x206000F
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	LDD  R26,Y+8
	LDD  R30,Y+11
	SUB  R30,R26
	LDI  R31,0
	MOVW R26,R30
	LDD  R30,Y+7
	LDI  R31,0
	CALL __MULW12U
	MOVW R26,R30
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	ADD  R30,R16
	ADC  R31,R17
	RJMP _0x2140008
_0x206000F:
	MOVW R18,R16
	MOV  R30,R21
	LDI  R31,0
	__ADDWRR 16,17,30,31
_0x2060010:
	LDD  R26,Y+8
	SUBI R26,-LOW(1)
	STD  Y+8,R26
	SUBI R26,LOW(1)
	LDD  R30,Y+11
	CP   R26,R30
	BRSH _0x2060012
	MOVW R30,R18
	__ADDWRN 18,19,1
	LPM  R26,Z
	LDI  R27,0
	MOV  R30,R20
	LDI  R31,0
	CALL __MULW12U
	__ADDWRR 16,17,30,31
	RJMP _0x2060010
_0x2060012:
	MOVW R30,R18
	LPM  R30,Z
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ST   X,R30
	MOVW R30,R16
_0x2140008:
	CALL __LOADLOCR6
	ADIW R28,12
	RET
; .FEND
_glcd_new_line_G103:
; .FSTART _glcd_new_line_G103
	LDI  R30,LOW(0)
	__PUTB1MN _glcd_state,2
	__GETB2MN _glcd_state,3
	CLR  R27
	CALL SUBOPT_0x24
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	__GETB1MN _glcd_state,7
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RCALL _glcd_clipy
	__PUTB1MN _glcd_state,3
	RET
; .FEND
_glcd_putchar:
; .FSTART _glcd_putchar
	ST   -Y,R26
	SBIW R28,1
	CALL SUBOPT_0x22
	SBIW R30,0
	BRNE PC+2
	RJMP _0x206001F
	LDD  R26,Y+7
	CPI  R26,LOW(0xA)
	BRNE _0x2060020
	RJMP _0x2060021
_0x2060020:
	LDD  R30,Y+7
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,7
	RCALL _glcd_getcharw_G103
	MOVW R20,R30
	SBIW R30,0
	BRNE _0x2060022
	RJMP _0x2140007
_0x2060022:
	__GETB1MN _glcd_state,6
	LDD  R26,Y+6
	ADD  R30,R26
	MOV  R19,R30
	__GETB2MN _glcd_state,2
	CLR  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R16,R30
	__CPWRN 16,17,129
	BRLO _0x2060023
	MOV  R16,R19
	CLR  R17
	RCALL _glcd_new_line_G103
_0x2060023:
	__GETB1MN _glcd_state,2
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	CALL SUBOPT_0x24
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	ST   -Y,R21
	ST   -Y,R20
	LDI  R26,LOW(7)
	RCALL _glcd_block
	__GETB1MN _glcd_state,2
	LDD  R26,Y+6
	ADD  R30,R26
	ST   -Y,R30
	__GETB1MN _glcd_state,3
	ST   -Y,R30
	__GETB1MN _glcd_state,6
	ST   -Y,R30
	CALL SUBOPT_0x24
	CALL SUBOPT_0x25
	__GETB1MN _glcd_state,2
	ST   -Y,R30
	__GETB2MN _glcd_state,3
	CALL SUBOPT_0x24
	ADD  R30,R26
	ST   -Y,R30
	ST   -Y,R19
	__GETB1MN _glcd_state,7
	CALL SUBOPT_0x25
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x2060024
_0x2060021:
	RCALL _glcd_new_line_G103
	RJMP _0x2140007
_0x2060024:
_0x206001F:
	__PUTBMRN _glcd_state,2,16
_0x2140007:
	CALL __LOADLOCR6
	ADIW R28,8
	RET
; .FEND
_glcd_outtext:
; .FSTART _glcd_outtext
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x206002E:
	CALL SUBOPT_0xE
	BREQ _0x2060030
	MOV  R26,R17
	RCALL _glcd_putchar
	RJMP _0x206002E
_0x2060030:
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
	CALL SUBOPT_0x26
	LPM  R17,Z+
	CALL SUBOPT_0x26
	LPM  R18,Z+
	CALL SUBOPT_0x26
	LPM  R19,Z+
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDD  R30,Y+8
	ST   -Y,R30
	LDD  R30,Y+8
	ST   -Y,R30
	ST   -Y,R16
	ST   -Y,R18
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+11
	RCALL _glcd_block
	ST   -Y,R16
	MOV  R26,R18
	RCALL _glcd_imagesize
	RJMP _0x2140006
_0x2060038:
	__GETD1N 0x0
_0x2140006:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_glcd_putpixelm_G103:
; .FSTART _glcd_putpixelm_G103
	ST   -Y,R26
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R30,Y+2
	ST   -Y,R30
	__GETB1MN _glcd_state,9
	LDD  R26,Y+2
	AND  R30,R26
	BREQ _0x206003E
	LDS  R30,_glcd_state
	RJMP _0x206003F
_0x206003E:
	__GETB1MN _glcd_state,1
_0x206003F:
	MOV  R26,R30
	RCALL _glcd_putpixel
	LD   R30,Y
	LSL  R30
	ST   Y,R30
	CPI  R30,0
	BRNE _0x2060041
	LDI  R30,LOW(1)
	ST   Y,R30
_0x2060041:
	LD   R30,Y
	JMP  _0x2140002
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
_glcd_line:
; .FSTART _glcd_line
	ST   -Y,R26
	SBIW R28,11
	CALL __SAVELOCR6
	LDD  R26,Y+20
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+20,R30
	LDD  R26,Y+18
	CLR  R27
	RCALL _glcd_clipx
	STD  Y+18,R30
	LDD  R26,Y+19
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+19,R30
	LDD  R26,Y+17
	CLR  R27
	RCALL _glcd_clipy
	STD  Y+17,R30
	LDD  R30,Y+18
	__PUTB1MN _glcd_state,2
	LDD  R30,Y+17
	__PUTB1MN _glcd_state,3
	LDI  R30,LOW(1)
	STD  Y+8,R30
	LDD  R30,Y+17
	LDD  R26,Y+19
	CP   R30,R26
	BRNE _0x2060042
	LDD  R17,Y+20
	LDD  R26,Y+18
	CP   R17,R26
	BRNE _0x2060043
	ST   -Y,R17
	LDD  R30,Y+20
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G103
	RJMP _0x2140005
_0x2060043:
	LDD  R26,Y+18
	CP   R17,R26
	BRSH _0x2060044
	LDD  R30,Y+18
	SUB  R30,R17
	MOV  R16,R30
	__GETWRN 20,21,1
	RJMP _0x2060045
_0x2060044:
	LDD  R26,Y+18
	MOV  R30,R17
	SUB  R30,R26
	MOV  R16,R30
	__GETWRN 20,21,-1
_0x2060045:
_0x2060047:
	LDD  R19,Y+19
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2060049:
	CALL SUBOPT_0x27
	BRSH _0x206004B
	ST   -Y,R17
	ST   -Y,R19
	INC  R19
	LDD  R26,Y+10
	RCALL _glcd_putpixelm_G103
	STD  Y+7,R30
	RJMP _0x2060049
_0x206004B:
	LDD  R30,Y+7
	STD  Y+8,R30
	ADD  R17,R20
	MOV  R30,R16
	SUBI R16,1
	CPI  R30,0
	BRNE _0x2060047
	RJMP _0x206004C
_0x2060042:
	LDD  R30,Y+18
	LDD  R26,Y+20
	CP   R30,R26
	BRNE _0x206004D
	LDD  R19,Y+19
	LDD  R26,Y+17
	CP   R19,R26
	BRSH _0x206004E
	LDD  R30,Y+17
	SUB  R30,R19
	MOV  R18,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x206011B
_0x206004E:
	LDD  R26,Y+17
	MOV  R30,R19
	SUB  R30,R26
	MOV  R18,R30
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
_0x206011B:
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x2060051:
	LDD  R17,Y+20
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2060053:
	CALL SUBOPT_0x27
	BRSH _0x2060055
	ST   -Y,R17
	INC  R17
	CALL SUBOPT_0x28
	STD  Y+7,R30
	RJMP _0x2060053
_0x2060055:
	LDD  R30,Y+7
	STD  Y+8,R30
	LDD  R30,Y+13
	ADD  R19,R30
	MOV  R30,R18
	SUBI R18,1
	CPI  R30,0
	BRNE _0x2060051
	RJMP _0x2060056
_0x206004D:
	LDI  R30,LOW(0)
	STD  Y+6,R30
_0x2060057:
	CALL SUBOPT_0x27
	BRLO PC+2
	RJMP _0x2060059
	LDD  R17,Y+20
	LDD  R19,Y+19
	LDI  R30,LOW(1)
	MOV  R18,R30
	MOV  R16,R30
	LDD  R26,Y+18
	CLR  R27
	LDD  R30,Y+20
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
	TST  R21
	BRPL _0x206005A
	LDI  R16,LOW(255)
	MOVW R30,R20
	CALL __ANEGW1
	MOVW R20,R30
_0x206005A:
	MOVW R30,R20
	LSL  R30
	ROL  R31
	STD  Y+15,R30
	STD  Y+15+1,R31
	LDD  R26,Y+17
	CLR  R27
	LDD  R30,Y+19
	LDI  R31,0
	SUB  R26,R30
	SBC  R27,R31
	STD  Y+13,R26
	STD  Y+13+1,R27
	LDD  R26,Y+14
	TST  R26
	BRPL _0x206005B
	LDI  R18,LOW(255)
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	CALL __ANEGW1
	STD  Y+13,R30
	STD  Y+13+1,R31
_0x206005B:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LSL  R30
	ROL  R31
	STD  Y+11,R30
	STD  Y+11+1,R31
	ST   -Y,R17
	ST   -Y,R19
	LDI  R26,LOW(1)
	RCALL _glcd_putpixelm_G103
	STD  Y+8,R30
	LDI  R30,LOW(0)
	STD  Y+9,R30
	STD  Y+9+1,R30
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	CP   R20,R26
	CPC  R21,R27
	BRLT _0x206005C
_0x206005E:
	ADD  R17,R16
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x29
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R20,R26
	CPC  R21,R27
	BRGE _0x2060060
	ADD  R19,R18
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	CALL SUBOPT_0x2A
_0x2060060:
	ST   -Y,R17
	CALL SUBOPT_0x28
	STD  Y+8,R30
	LDD  R30,Y+18
	CP   R30,R17
	BRNE _0x206005E
	RJMP _0x2060061
_0x206005C:
_0x2060063:
	ADD  R19,R18
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	CALL SUBOPT_0x29
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x2060065
	ADD  R17,R16
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL SUBOPT_0x2A
_0x2060065:
	ST   -Y,R17
	CALL SUBOPT_0x28
	STD  Y+8,R30
	LDD  R30,Y+17
	CP   R30,R19
	BRNE _0x2060063
_0x2060061:
	LDD  R30,Y+19
	SUBI R30,-LOW(1)
	STD  Y+19,R30
	LDD  R30,Y+17
	SUBI R30,-LOW(1)
	STD  Y+17,R30
	RJMP _0x2060057
_0x2060059:
_0x2060056:
_0x206004C:
_0x2140005:
	CALL __LOADLOCR6
	ADIW R28,21
	RET
; .FEND

	.CSEG

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
_0x2140004:
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
_rx_buffer:
	.BYTE 0x100
_tx_buffer:
	.BYTE 0x100
_input_index_S0060000000:
	.BYTE 0x1
_hx:
	.BYTE 0xD
_hy:
	.BYTE 0xD
_xold:
	.BYTE 0x1
_yold:
	.BYTE 0x1
_xmold:
	.BYTE 0x1
_ymold:
	.BYTE 0x1
_hourd:
	.BYTE 0x1
_mind:
	.BYTE 0x1
_secd:
	.BYTE 0x1
_count_clock:
	.BYTE 0x1
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
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2:
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
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x3:
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
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(1)
	__PUTB1MN _glcd_state,8
	LDI  R30,LOW(255)
	__PUTB1MN _glcd_state,9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(32)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(_cos6data*2)
	LDI  R27,HIGH(_cos6data*2)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(19)
	LDI  R27,HIGH(19)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x9:
	LDI  R26,LOW(_sin6data*2)
	LDI  R27,HIGH(_sin6data*2)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(15)
	LDI  R27,HIGH(15)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xB:
	LD   R30,Z
	LDI  R31,0
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	MOVW R26,R22
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL __DIVW21
	ADD  R30,R24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	MOVW R26,R22
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	ST   -Y,R30
	MOV  R26,R19
	CALL _glcd_clrpixel
	MOV  R30,R16
	SUBI R30,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xF:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x10:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x12:
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
SUBOPT_0x13:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x15:
	CBI  0x15,3
	LDI  R30,LOW(255)
	OUT  0x1A,R30
	LD   R30,Y
	OUT  0x1B,R30
	CALL _ks0108_enable_G102
	JMP  _ks0108_disable_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	LSR  R30
	LSR  R30
	LSR  R30
	MOV  R26,R30
	JMP  _ks0108_gotoxp_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x17:
	CALL _ks0108_wrdata_G102
	JMP  _ks0108_nextx_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x19:
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
SUBOPT_0x1A:
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
SUBOPT_0x1B:
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	JMP  _glcd_readmem

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	ST   -Y,R21
	LDD  R26,Y+10
	JMP  _glcd_mappixcolor1bit

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1D:
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+16
	ST   -Y,R30
	ST   -Y,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	ST   -Y,R16
	INC  R16
	LDD  R26,Y+16
	CALL _ks0108_rdbyte_G102
	AND  R30,R20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1F:
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
SUBOPT_0x20:
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
	RJMP SUBOPT_0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	CALL __SAVELOCR6
	__GETW1MN _glcd_state,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	MOVW R30,R16
	__ADDWRN 16,17,1
	LPM  R0,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x24:
	__GETW1MN _glcd_state,4
	ADIW R30,1
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x25:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(9)
	JMP  _glcd_block

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	STD  Y+5,R30
	STD  Y+5+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x27:
	LDD  R26,Y+6
	SUBI R26,-LOW(1)
	STD  Y+6,R26
	SUBI R26,LOW(1)
	__GETB1MN _glcd_state,8
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	ST   -Y,R19
	LDD  R26,Y+10
	JMP  _glcd_putpixelm_G103

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+9,R30
	STD  Y+9+1,R31
	RET


	.CSEG
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

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
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

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

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

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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
