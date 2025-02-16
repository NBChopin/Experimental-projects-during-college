#include "stm32f10x.h"                  // Device header
#include "Delay.h"
#include "OLED.h"
#include "Key.h"
#include "LED.h"
#include "Responde.h"
uint8_t KeyNum;
uint8_t ResetNum;
uint8_t StartNum;
int main(void)
{
	/*OLED初始化*/
	OLED_Init(); 
	LED_Init();
	Key_Init();	
	BEEP_Init();                                                                                                                                                                                                                                                                                                                                    
	Responde_Init();
	
	while(1)
	{
	ResetNum = Reset_GetNum();
	StartNum = Start_GetNum();
	if(ResetNum ==1)
	{
		Responde_Init();
	} else if(StartNum==1)
			{
			int time=11;
			OLED_Clear();
			//OLED_ShowChinese(32, 16, "无人答题");
				OLED_Update();
				
			for(;time>=1;time--)
	    {			
						if(time==1){
						BEEP_ON();
						LED1_ON();
						OLED_Clear();
						OLED_ShowChinese(32, 16, "无人答题");
						//OLED_Update();
						}
						else
						{KeyNum=Key_GetNum();
						switch(KeyNum)
						{
							case 	0:
							OLED_ShowChinese(32, 0, "开始答题");
							OLED_ShowChinese(0, 16, "题目：");
							OLED_ShowNum(34, 32, time-1, 2, OLED_8X16);	
							OLED_Update();
							Delay_ms(1000);
							break;
							case  1:
								OLED_Clear ();
								OLED_ShowChinese(40, 0, "号选手");
								OLED_ShowNum(32,0,1,1,OLED_8X16);
								OLED_Update();
								time=0;
								break;
								case  2:
								OLED_Clear ();
								OLED_ShowChinese(40, 0, "号选手");
								OLED_ShowNum(32,0,2,1,OLED_8X16);
								OLED_Update();
								time=0;
								break;
									case  3:
								OLED_Clear ();
								OLED_ShowChinese(40, 0, "号选手");
								OLED_ShowNum(32,0,3,1,OLED_8X16);
								OLED_Update();
								time=0;
								break;
										case  4:
								OLED_Clear ();
								OLED_ShowChinese(40, 0, "号选手");
								OLED_ShowNum(32,0,4,1,OLED_8X16);
								OLED_Update();
								time=0;
								break;
							

						}
						
	     }
			}
		}
	
		}
	
	
}


