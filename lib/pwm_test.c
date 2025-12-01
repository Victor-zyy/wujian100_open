/*
Copyright (c) 2019 Alibaba Group Holding Limited

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/
#include "stdio.h"
#include "vtimer.h"
#include "datatype.h"

static void sleep(unsigned int time);
#define PWM_BADDR   0x5001C000

#define PWMCFG             0x00
#define PWMINVERTTRIG      0x04
#define PWM01TRIG          0x08
#define PWM23TRIG          0x0c
#define PWM45TRIG          0x10

#define PWMINTEN1          0x14
#define PWMINTEN2          0x18

#define PWMRIS1            0x1c
#define PWMRIS2            0x20
#define PWMIC1             0x24
#define PWMIC2             0x28
#define PWMIS1             0x2c
#define PWMIS2             0x30
#define PWMCTL             0x34
#define PWM01LOAD          0x38
#define PWM23LOAD          0x3c
#define PWM45LOAD          0x40

#define PWM01COUNT         0x44
#define PWM23COUNT         0x48
#define PWM45COUNT         0x4c

#define PWM0CMP            0x50
#define PWM1CMP            0x54
#define PWM2CMP            0x58
#define PWM3CMP            0x5c
#define PWM4CMP            0x60
#define PWM5CMP            0x64

#define PWM01DB            0x68
#define PWM23DB            0x6c
#define PWM45DB            0x70

#define CAPCTL             0x74
#define CAPINTEN           0x78
#define CAPRIS             0x7c
#define CAPIC              0x80
#define CAPIS              0x84

#define CAP01T             0x88
#define CAP23T             0x8c
#define CAP45T             0x90

#define Cap01match         0x94
#define Cap23match         0x98
#define Cap45match         0x9c

#define Tim_int_en         0xa0
#define timris             0xa4
#define Tim_int_clr        0xa8
#define timis              0xac

#define Tim01load          0xb0
#define Tim23load          0xb4
#define Tim45load          0xb8

#define Tim01count         0xbc
#define Tim23count         0xc0
#define Tim45count         0xc4

#define Cnv01val           0xc8
#define Cnv23val           0xcc
#define Cnv45val           0xd0

#define REG32(addr) *((volatile unsigned int *)(addr))

int main (void)
{
#if 0
    int pwm_cap_intr_flag = 0x0;
    //PWM ch0 count load 2 , cmp value 2
    *(volatile uint32_t *) 0x5001c038  = 0x2;
    *(volatile uint32_t *) 0x5001c050  = 0x2;
    //PWM ch2 capture enable, int enble
    *(volatile uint32_t *) 0x5001c074  = 0x302;
    *(volatile uint32_t *) 0x5001c078  = 0x2;
    //PWM ch2 cnt match 0x20 
    *(volatile uint32_t *) 0x5001c094  = 0x200000;
    //PWM ch0 output enable, ch2 capture enable ,clk div enable , div 4
    *(volatile uint32_t *) 0x5001c000  = 0x9002001;

    pwm_cap_intr_flag = *(volatile uint32_t *) 0x5001c07c;
    while (  pwm_cap_intr_flag != 0x2){
	pwm_cap_intr_flag = *(volatile uint32_t *) 0x5001c07c;
    }
#endif
    /**
     * APB0 20Mhz Clock default div 2 = 10Mhz
     * Generate 4 PWMs Output
     * */
    // 1. PWM Count Mode -- Count Up Mode
    REG32(PWM_BADDR + PWMCTL) = 0x0;
    // 2. Set PWM Period 12.5Khz period = 80us, PWM Load Value
    // 10Mhz 100ns->80us PWMLoadValue = 0x320(800) 80us and 0x2ee(750) for 75us
    REG32(PWM_BADDR + PWM01LOAD ) = (0x2ee << 16) | 0x320;
    // 3. Set PWM Duty Cycle namely Channel Compare Value
    REG32(PWM_BADDR + PWM0CMP) = ( 0x140 << 16 ) | 0x64;
    REG32(PWM_BADDR + PWM1CMP) = ( 0x12c << 16 ) | 0x64;
    // 4. Bypass Dead-Band insert 
    REG32(PWM_BADDR + PWM01DB) = 0x0;
    //
    // 5. enable PWM output
    REG32(PWM_BADDR + PWMCFG) = 0x800000F;  // PWMCFG: tim0en and tim1en
    // PWM Interrupt Enable for Counter equals = load value then we change the 
    // PWM time period test for channel 0 and channel 1
    REG32(PWM_BADDR + PWMINTEN1) = 0x00000200;
    while(1);
    sleep(400000);
    sim_end();
}

static void sleep(unsigned int time){
    while(--time);
}
