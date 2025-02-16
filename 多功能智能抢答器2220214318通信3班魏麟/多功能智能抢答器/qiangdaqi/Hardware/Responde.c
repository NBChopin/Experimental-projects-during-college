#include "stm32f10x.h"                  // Device header
#include "Delay.h"
#include "OLED.h"
#include "Key.h"
#include "LED.h"

void Responde_Init(void)
	{

	LED1_OFF();
	LED2_OFF();
	BEEP_OFF();
	OLED_Clear();
	OLED_ShowChinese(32, 18, "准备答题");
		OLED_Update();
}

