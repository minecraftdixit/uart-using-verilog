module tb ;
  reg clk , rst ;
  wire [11:0] q;
  wire tick ;
  
  baudrate dut( .clk(clk), .rst(rst), .q(q), .tick(tick));
  
  initial 
    begin 
      clk= 0;
      
       rst=1;
      #11 rst = 0;
      #200000 $stop ;
      
    end
  always #10 clk = ~clk;
  initial begin
    $dumpfile("gen.vcd");
    $dumpvars;
    
  end
endmodule
