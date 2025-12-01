/*
 * Copyright (C) 2017-2019 Alibaba Group Holding Limited
 */


/******************************************************************************
 * @file     main.c
 * @brief    hello world
 * @version  V1.0
 * @date     17. Jan 2018
 ******************************************************************************/

#include <drv_pwm.h>
#include <wj_pwm.h>
#include <pin.h>
#include "stdio.h"

typedef struct {
#ifdef CONFIG_LPM
    uint8_t pwm_power_status;
    uint32_t pwm_regs_saved[36];
#endif
    uint32_t base;
    uint32_t irq;
    uint32_t idx;
    pwm_event_cb_t pwm_event_cb[CONFIG_PER_PWM_CHANNEL_NUM];
} wj_pwm_priv_t;


pwm_handle_t pwm_handle;
static int cycle[3] = { 800, 750, 750};
static int duty[3]  = { 500, 450, 500};
static int index = 0;
wj_pwm_priv_t *pwm_priv;
wj_pwm_reg_t *addr;

static void counter_load_irq_cb(int32_t ch, pwm_event_e event, uint32_t val)
{
    addr->PWM01LOAD = cycle[index];
    addr->PWM0CMP = duty[index];
    index += 1;
    if(index == 3){
        index = 0;
    }
}
static void mdelay(uint32_t ms){
    if( 0 == ms )
        return;
    while(--ms);
}

void example_pin_pwm_init(void)
{
    drv_pinmux_config(EXAMPLE_PWM_CH, EXAMPLE_PWM_CH_FUNC);
}

int32_t  pwm_signal_test(uint32_t pwm_idx, uint8_t pwm_ch)
{
    int32_t ret;

    example_pin_pwm_init();

    pwm_handle = csi_pwm_initialize(pwm_idx);

    if (pwm_handle == NULL) {
        return -1;
    }

    pwm_priv = pwm_handle;

    csi_pwm_interrupt_enable(pwm_handle, pwm_ch);
    drv_pwm_config_cb(pwm_handle, pwm_ch, counter_load_irq_cb);

    // period and duty_cycle
    addr = (wj_pwm_reg_t *)(pwm_priv->base);
    addr->PWMCFG |= PWM_CFG_CNTDIV_EN | PWM_CFG_CNTDIV_2;
    addr->PWM01LOAD = 800;
    addr->PWM0CMP = 500;
    csi_pwm_start(pwm_handle, pwm_ch);
    //csi_pwm_config(pwm_handle, pwm_ch, 75, 45); 
    while(1);

    ret = csi_pwm_config(pwm_handle, pwm_ch, 200, 150);

    if (ret < 0) {
        return -1;
    }

    mdelay(200000);
    csi_pwm_stop(pwm_handle, pwm_ch);

    csi_pwm_uninitialize(pwm_handle);

    return 0;

}

int example_pwm(uint32_t pwm_idx, uint8_t pwm_pin)
{
    int32_t ret;
    ret = pwm_signal_test(pwm_idx, pwm_pin);

    if (ret < 0) {
        return -1;
    }

    return 0;
}

int main(void)
{
    return example_pwm(EXAMPLE_PWM_IDX, EXAMPLE_PWM_CH_IDX);
}

