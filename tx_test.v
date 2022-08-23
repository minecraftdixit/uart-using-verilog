[2~// Code your testbench here
// or browse Examples
module txd ;
  reg clk , rst  ;
  reg tx_start;
  reg [7:0]  data_in ;
  wire txd;
  wire tx_done ;
  
  uart_tx UUT( .clk(clk), .rst(rst), .tx_start(tx_start), 
              .txd(txd), .data_in(data_in) , .tx_done( tx_done));
  
  initial 
    begin
      clk = 0  ;
       rst = 1;
      #20  rst = 0;
      
      #40 tx_start = 1;
      data_in = 8'haa ;
       #500 tx_start = 0;
      
      #500000 $stop;
    end
  initial 
    begin 
       $dumpfile("dut.vcd");
     $dumpvars;
   
   end
  
  always #10 clk =~clk ;
  
      
endmodule
