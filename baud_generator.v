
 //baud rate is 1920 and clock freq = 5Mhz
//therefore rate is 5Mhz/1920 = 2604 approx
//12 bits required for output
module baudrate(
  input clk , rst ,
  output reg [11:0] q, 
  output wire tick );
  
 wire [11:0] q_next;
   
  
  always @(posedge clk , posedge rst)
    begin 
      if(rst)
        begin 
          q<=0;
        end
      else
        q<= q_next;
      
      
    end
  
  assign q_next = ( q==2604) ? 0: q+1;
  assign tick = (q==2604) ? 1:0 ;
endmodule
