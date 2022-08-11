`timescale 1 ns / 1 ps

module LFSR_tb();
  
  reg [3:0] seed_tb;
  reg clock_tb;
  reg reset_tb;
  wire OUT_tb;
  wire valid_tb;
  
  localparam T_PERIOD = 100;
  
  initial
    begin
      $dumpfile("LFSR.vcd");
      $dumpvars;
      clock_tb = 'b0;
      seed_tb = 4'b1001;
      reset_tb = 1'b0;
      
      #T_PERIOD
      reset_tb = 1'b1;
      
      #(T_PERIOD * 10)
      $finish;
      
    end
  
  always
  #(T_PERIOD/2) clock_tb = ~clock_tb;
  
  LFSR DUT (
  .seed(seed_tb),
  .clock(clock_tb),
  .reset(reset_tb),
  .OUT(OUT_tb),
  .valid(valid_tb)
  );
  
endmodule

