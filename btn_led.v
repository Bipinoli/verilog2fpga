//------------------------------------------------------------------
//-- Pressing a button toggle the state of the led on the side to it 
//-- This example has been tested on the following boards:
//     * iCE40HX1K-BLINK-EVN
//-- By: Bipin Oli (https://github.com/Bipinoli)
//------------------------------------------------------------------

module btn_led (LED1, LED2, LED3, LED4, BTN1, BTN2, BTN3, BTN4);
  input BTN1, BTN2, BTN3, BTN4;
  output reg LED1, LED2, LED3, LED4;

  always @(posedge BTN1)
    LED1 =~ LED1;

endmodule

