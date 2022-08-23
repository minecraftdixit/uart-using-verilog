// Code your design here
`define idle 3'b000
`define start 3'b001
`define trans 3'b010
`define stop 3'b011

module uart_tx
  (
  input  clk, rst, 
  input tx_start,
  input [7:0] data_in, 
  output reg txd, tx_done

  );

  
  wire tick ;
 wire [11:0] q_next ;
reg [11:0] q ;
reg txd_done, tx_next , tx_reg ;
  reg [2:0] ps , ns;
  reg [7:0] sbuf_reg, sbuf_next;
  reg [0:2] count_reg, count_next, count;
  
  
//memory block for Fsm 

always @(posedge clk)
begin
    if(rst)
   begin 
      ps = `idle ;
      sbuf_reg= 0;
      count_reg =0;
       tx_reg =0;
    end 
else
    begin
          ps = ns ;
          sbuf_reg = sbuf_next;
          count_reg =count_next;
          tx_reg = tx_next;
      end
  end
//next state block and output block
always @(*)
        begin 
          ns = ps;
          sbuf_next = sbuf_reg;
          count_next  = count_reg;
          tx_next = tx_reg;
          
          case(ps)
            `idle : begin 
              
              $display("\n------------------idle  state", $time );
                    tx_next =1 ;
                     tx_done= 0;
              if(tx_start == 1)
                begin 
                  ns = `start;
                  sbuf_reg = data_in ;
                  
                  $display("\n------------------idle to start", $time );
                end
            end
            `start :  begin 
              tx_next =0 ; //start bit
              $display("\n------------------ start  state ", $time );
              if(tick)
                begin
              sbuf_next = data_in;
                  count_next = 0;
                  ns= `trans;
                  $display("\n------------------start  to trans ", $time );
            
                end
            end
              `trans : begin 
                
                tx_next = sbuf_reg[0];
                $display("\n------------------trans state", $time );
                if(tick)begin
                  sbuf_next= sbuf_reg >> 1;
                  if(count==7)
                    begin 
                      ns = `stop;
                      
                      $display("\n------------------trans to  stop", $time );
                    end
                  else
                    count_next = count_reg + 1;
                end
                end
                  `stop: begin
                    tx_next  = 1 ;
                    
                    $display("\n------------------stop state", $time );
                    if(tick)
                      begin 
                   tx_done = 1;
                    ns = `idle;
                  end
                  end
              default: ns=`idle;
              endcase
                   end
            
            assign txd = tx_reg;
//baud rate generator ----------------------
            always @(posedge clk)
              begin 
                if(rst)
                  
                q <= 0;
                else
                  q <= q_next;
                
                end
            
  assign q_next  = (q==500)?0:q+1;
  assign tick = (q==500)? 1:0;
            //----------------------------------
            endmodule
