module LFSR(
  input wire [3:0] seed,
  input wire clock,
  input wire reset,
  output reg OUT,
  output reg valid
  );
  
  reg [3:0] counter;
  reg stop_flag;
  reg [3:0] lfsr;
  
  // LFSR Sequential Logic
  always@(posedge clock or negedge reset)
    begin
      if(!reset)
        begin
          lfsr <= seed;
          OUT <= 1'b0;
        end
      else
        begin
          lfsr[0] <= lfsr[1];
          lfsr[1] <= lfsr[2];
          lfsr[2] <= lfsr[3];
          if(stop_flag)
            begin
              //Shift Mode
              OUT <= lfsr[0];
            end
          else
            begin
              //LFSR Mode
              lfsr[3] <= lfsr[3] ^ lfsr[1] ^ lfsr[0];
            end
        end
    end
    
  // Valid 
  always@(posedge clock)
    begin
      valid = (stop_flag) ? 1'b1 : 1'b0;
    end
  
  // Counter
  always@(posedge clock or negedge reset)
    begin
      if(!reset)
        begin
          counter <= 'd0;
        end
      else
        begin
          if(stop_flag)
            begin
              counter <= 'd0;
            end
          else
            begin
              counter <= counter + 'd1;
            end
        end
    end
    
    // Stop flag from counter
    always @(*)
      begin
        stop_flag = (counter == 'd8) ? 1'b1 : 1'b0;
      end
  
endmodule

