//------------------------------------------------------------------
//-- Pressing a button toggle the state of the led on the side to it 
//-- This example has been tested on the following boards:
//     * iCE40HX1K-BLINK-EVN
//-- By: Bipin Oli (https://github.com/Bipinoli)
//------------------------------------------------------------------

module btn_led (LED1, LED2, LED3, LED4, BTN1, BTN2, BTN3, BTN4);
  input BTN1, BTN2, BTN3, BTN4;
  output reg LED1, LED2, LED3, LED4;

  reg btn1_state;  // Register to store the previous button state

  // Initialize LED and button state
  initial begin
    LED1 = 0;         // Start with LED off
    btn1_state = 0;   // Initial button state
  end

  always @(posedge BTN1) begin
    if (BTN1 != btn1_state) begin
        LED1 = ~LED1;  // Toggle LED1 when button is pressed
        btn1_state = BTN1;  // Update button state
    end
  end

endmodule

