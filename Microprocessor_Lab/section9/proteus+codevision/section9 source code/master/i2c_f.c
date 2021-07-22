/*
 * I2C_Master_C_file.c
 *
 */ 

#include <myheader.h>



                            /* Include I2C header file */

void I2C_Init2()                                                /* I2C initialize function */
{
    TWBR = BITRATE(TWSR = 0x00);                            /* Get bit rate register value by formula */
}    


char I2C_Start2(char write_address)                        /* I2C start function */
{
    char status;                                            /* Declare variable */
    TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition) */
    status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits */
    if (status != 0x08)                                        /* Check weather start condition transmitted successfully or not? */
    return 0;                                                /* If not then return 0 to indicate start condition fail */
    TWDR = write_address;                                    /* If yes then write SLA+W in TWI data register */
    TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation) */
    status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits */    
    if (status == 0x18)                                        /* Check weather SLA+W transmitted & ack received or not? */
    return 1;                                                /* If yes then return 1 to indicate ack received i.e. ready to accept data byte */
    if (status == 0x20)                                        /* Check weather SLA+W transmitted & nack received or not? */
    return 2;                                                /* If yes then return 2 to indicate nack received i.e. device is busy */
    else
    return 3;                                                /* Else return 3 to indicate SLA+W failed */
}

char I2C_Repeated_Start(char read_address)                /* I2C repeated start function */
{
    char status;                                            /* Declare variable */
    TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                    /* Enable TWI, generate start condition and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (start condition) */
    status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits */
    if (status != 0x10)                                        /* Check weather repeated start condition transmitted successfully or not? */
    return 0;                                                /* If no then return 0 to indicate repeated start condition fail */
    TWDR = read_address;                                    /* If yes then write SLA+R in TWI data register */
    TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation) */
    status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits */
    if (status == 0x40)                                        /* Check weather SLA+R transmitted & ack received or not? */
    return 1;                                                /* If yes then return 1 to indicate ack received */ 
    if (status == 0x20)                                        /* Check weather SLA+R transmitted & nack received or not? */
    return 2;                                                /* If yes then return 2 to indicate nack received i.e. device is busy */
    else
    return 3;                                                /* Else return 3 to indicate SLA+W failed */
}

void I2C_Stop2()                                                /* I2C stop function */
{
    TWCR=(1<<TWSTO)|(1<<TWINT)|(1<<TWEN);                    /* Enable TWI, generate stop condition and clear interrupt flag */
    while(TWCR & (1<<TWSTO));                                /* Wait until stop condition execution */ 
}

void I2C_Start_Wait(char write_address)                        /* I2C start wait function */
{
    char status;                                            /* Declare variable */
    while (1)
    {
        TWCR = (1<<TWSTA)|(1<<TWEN)|(1<<TWINT);                /* Enable TWI, generate start condition and clear interrupt flag */
        while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (start condition) */
        status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits */
        if (status != 0x08)                                    /* Check weather start condition transmitted successfully or not? */
        continue;                                            /* If no then continue with start loop again */
        TWDR = write_address;                                /* If yes then write SLA+W in TWI data register */
        TWCR = (1<<TWEN)|(1<<TWINT);                        /* Enable TWI and clear interrupt flag */
        while (!(TWCR & (1<<TWINT)));                        /* Wait until TWI finish its current job (Write operation) */
        status = TWSR & 0xF8;                                /* Read TWI status register with masking lower three bits */
        if (status != 0x18 )                                /* Check weather SLA+W transmitted & ack received or not? */
        {
            I2C_Stop2();                                        /* If not then generate stop condition */
            //i2c_stop();
            continue;                                        /* continue with start loop again */
        }
        break;                                                /* If yes then break loop */
    }
}

char I2C_Write2(char data)                                /* I2C write function */
{
    char status;                                            /* Declare variable */
    TWDR = data;                                            /* Copy data in TWI data register */
    TWCR = (1<<TWEN)|(1<<TWINT);                            /* Enable TWI and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (Write operation) */
    status = TWSR & 0xF8;                                    /* Read TWI status register with masking lower three bits */
    if (status == 0x28)                                        /* Check weather data transmitted & ack received or not? */
    return 0;                                                /* If yes then return 0 to indicate ack received */
    if (status == 0x30)                                        /* Check weather data transmitted & nack received or not? */
    return 1;                                                /* If yes then return 1 to indicate nack received */
    else
    return 2;                                                /* Else return 2 to indicate data transmission failed */
}

char I2C_Read_Ack()                                            /* I2C read ack function */
{
    TWCR=(1<<TWEN)|(1<<TWINT)|(1<<TWEA);                    /* Enable TWI, generation of ack and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) */
    return TWDR;                                            /* Return received data */
}    

char I2C_Read_Nack()                                        /* I2C read nack function */
{
    TWCR=(1<<TWEN)|(1<<TWINT);                                /* Enable TWI and clear interrupt flag */
    while (!(TWCR & (1<<TWINT)));                            /* Wait until TWI finish its current job (read operation) */
    return TWDR;                                            /* Return received data */
}    



void I2C_Slave_Init(char slave_address)
{
	TWAR = slave_address;						/* Assign address in TWI address register */
	TWCR = (1<<TWEN) | (1<<TWEA) | (1<<TWINT);	/* Enable TWI, Enable ack generation, clear TWI interrupt */
}

char I2C_Slave_Listen()
{
	while(1)
	{
		char status;							/* Declare variable */
		while (!(TWCR & (1<<TWINT)));			/* Wait to be addressed */
		status = TWSR & 0xF8;					/* Read TWI status register with masking lower three bits */
		if (status == 0x60 || status == 0x68)	/* Check weather own SLA+W received & ack returned (TWEA = 1) */
		return 0;								/* If yes then return 0 to indicate ack returned */
		if (status == 0xA8 || status == 0xB0)	/* Check weather own SLA+R received & ack returned (TWEA = 1) */
		return 1;								/* If yes then return 1 to indicate ack returned */
		if (status == 0x70 || status == 0x78)	/* Check weather general call received & ack returned (TWEA = 1) */
		return 2;								/* If yes then return 2 to indicate ack returned */
		else
		continue;								/* Else continue */
	}
}

char I2C_Slave_Transmit(char data)
{
	char status;
	TWDR = data;								/* Write data to TWDR to be transmitted */
	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWEA);		/* Enable TWI and clear interrupt flag */
	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (Write operation) */
	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -1 */
		return -1;
	}
	if (status == 0xB8)							/* Check weather data transmitted & ack received */
		return 0;									/* If yes then return 0 */
	if (status == 0xC0)							/* Check weather data transmitted & nack received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return -2 */
		return -2;
	}
	if (status == 0xC8)							/* If last data byte transmitted with ack received TWEA = 0 */
	return -3;									/* If yes then return -3 */
	else										/* else return -4 */
	return -4;
}

char I2C_Slave_Receive()
{
	char status;								/* Declare variable */
	TWCR=(1<<TWEN)|(1<<TWEA)|(1<<TWINT);		/* Enable TWI, generation of ack and clear interrupt flag */
	while (!(TWCR & (1<<TWINT)));				/* Wait until TWI finish its current job (read operation) */
	status = TWSR & 0xF8;						/* Read TWI status register with masking lower three bits */
	if (status == 0x80 || status == 0x90)		/* Check weather data received & ack returned (TWEA = 1) */
	return TWDR;								/* If yes then return received data */
	if (status == 0x88 || status == 0x98)		/* Check weather data received, nack returned and switched to not addressed slave mode */
	return TWDR;								/* If yes then return received data */
	if (status == 0xA0)							/* Check weather STOP/REPEATED START received */
	{
		TWCR |= (1<<TWINT);						/* If yes then clear interrupt flag & return 0 */
		return -1;
	}
	else
	return -2;									/* Else return 1 */
}
