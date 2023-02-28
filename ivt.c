#define CORTEXM3_IVT_SIZE 16
#define STM32F4X_IVT_SIZE 91

extern void _reset(void);
extern void _estack(void);

__attribute__((section(".vectors"))) void (*tab[CORTEXM3_IVT_SIZE + STM32F4X_IVT_SIZE])(void) = {_estack, _reset};
