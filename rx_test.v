[2~ 
module rx ;
  reg clk , rst, rxd ;
  wire [7:0] data_out ;
  wire rx_done ;
  wire tick ;
  
  
  uart_tx DUT( .clk(clk) , .rst(rst), .rxd(rxd), .data_out( data_out),
              .rx_done(rx_done), .tick(tick));
  initial begin
    clk = 0 ;
    rst =1;
    #11 rst = 0;
    #20 rxd = 0;
    $display($time , "------------------------start bit ");
    
    rdata(1);
    
    $display($time , "------------------------if1");
    rdata(0);
    
    $display($time , "------------------------if2 ");
    rdata(1);
    
    
    $display($time , "------------------------if 3 ");
    
    
    rdata(0);
    
    $display($time , "------------------------if 4");
    
    rdata(1);
    
    $display($time , "------------------------if 5 ");
    rdata(1);
    
    $display($time , "------------------------if 6 ");
    rdata(0);
    
    $display($time , "------------------------if 7");
    
    rdata(1);
    
    $display($time , "------------------------stop bit 8");
   
    
  end
  
  task rdata  ;
    input inp;
    begin 
      @(posedge tick)
      begin 
        rxd = inp ;
        
        $display($time , " ------------------------------supply data  ");
        
      end

      
          end
  endtask
  always #10 clk = ~clk; 
  
  initial 
  begin   
    $dumpfile("dump.vcd");
    $dumpvars ;
     #10000 $finish ;
    end      
    
    

      endmodule

