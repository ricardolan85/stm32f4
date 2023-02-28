#include <stm32f4xx.h>

/* delay */
static inline void spin(volatile uint32_t count) {
  while (count--) asm("nop");
}

void setup(){

  //clock GPIOC
  RCC->AHB1ENR |= 0x000000004;

  //PC13 - output push pull
  GPIOC->MODER &= ~(3U << 26); //clear mode
  GPIOC->MODER |= (1U << 26); //set output mode
  
}

void blink(volatile uint32_t delay){
  
  //on
  GPIOC->BSRR |= (1U << 29); //set PC13
  spin(delay);

  //off
  GPIOC->BSRR = (1U << 13); //reset PC13  
  spin(500000);

}

void loop(){

  blink(2000000);

}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
