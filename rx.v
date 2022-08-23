[2~ 
 
// Code your design here
`define idle 3'b000
`define start 3'b001
`define trans 3'b010
`define stop 3'b011

module uart_tx
  (
  input  clk, rst,rxd ,
    output tick,
    
    output [7:0] data_out,
    output reg rx_done

  );
  reg [2:0] ps, ns ;
  reg [7:0] sbuf_reg ;
  reg [7:0] sbuf_next;
  reg [0:2] count_reg , count_next ;
  wire tick  ;
  wire [7:0] q_next;
  reg [7:0] q;
  always @(posedge clk)
    begin
      if(rst)
        begin
          ps = `idle;
            sbuf_reg = 0;
          count_reg =0 ;
        end
          else 
            begin
            ps =ns ;
           sbuf_reg = sbuf_next;
          count_reg =count_next ;
          

              end 
        end
      always @(*)
        begin
            ns=ps ;
          sbuf_next= sbuf_reg ; 
          count_next  =count_reg;  
          case(ps)
        
            `idle :  begin 
              $display($time, "--------------------idle state");
              if(rxd ==0)
                begin 
                  ns = `start;
 
                  $display($time, "--------------------idle to start state");
                end
              
            end
        `start :  begin 
          
            $display($time, "--------------------start state");
          if(tick)
            begin 
              ns = `trans ;
              $display($time, "--------------------start to trans state");
              count_next = 0;
            end
        end
        
   `trans : begin
     $display($time, "--------------------trans state"); 
   if(tick)
     begin 
       sbuf_next = {rxd,sbuf_reg[7:1]};
       if(count_reg == 7)
         begin 
           ns= `stop;  
           $display($time, "--------------------trans to stop state");end
      
       else 
         count_next =  count_reg +1 ;
        
       
     end
   
 end
            
            `stop :begin 
              
              $display($time, "--------------------stop state"); 
              if(tick)
                begin 
                  ns = `idle ;
                  rx_done =1; 
                end
            end
            default : ns = `idle ;
          endcase
            end
   
  assign data_out  = sbuf_reg ;
      //baud rate generator
      //-------------------------------------------
      always @(posedge clk)
        begin 
          if(rst)
            q = 0;
          
          else q = q_next;
          
 end
  assign q_next = (q==200)?0:q+1;
  assign tick = (q==200)?0:1;
    //------------------------------------------------
            endmodule
