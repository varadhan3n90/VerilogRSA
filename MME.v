`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:17:35 10/17/2013 
// Design Name: 
// Module Name:    MME 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MME(R,M,E,N,C,clk,start1);

	parameter bits=31,k=5,n=5;
	parameter calc_mv=1,preasign=2,calc_r=3,evaluation=5,postasign=6,comp_MM=4,repeatState=7,dummy=0;
		
   input [bits:0]M;
	input [bits:0]E;
	input [bits:0]N;
	input [bits:0]C;
	input clk;
	reg [bits:0]MV;
	input start1;
	output reg [bits:0]R;
	reg [2:0] state;
   reg [bits:0] a;
	reg [bits:0] b;
	wire [2:0] stateO;
	
   reg start;    
	wire [bits:0] y;
	reg [1:0]current;
	integer counter;
	reg reset;
	
	MM mm1 (
		.y(y), 
		.a(a), 
		.b(b), 
		.N(N), 
		.stateO(stateO),.start(start),.clk(clk),.reset(reset)
	);
	
	
	always @ (start1)
	begin 
	   if(start1)
		begin
		    state=calc_mv;
			 counter = 1;
			 $display("started");			 
		end
	end
	  
	  
	  
   always@(state or clk)
	begin
		case(state)
        calc_mv : begin

						 // #15 $display("calc_mv %d",stateO);						
                   a=M;
                   b=C;                   
						 start=0;
						 start=1;
						 current = 0;
						 if(stateO==4)
						 begin
							state = comp_MM;
							reset = 0;
							reset = 1;
							#5 $display ("completed calc_mv with output: %d %d",y,stateO);
						 end
						
						end 
						
						
			comp_MM: begin			
							
							if(current==0)
								begin
									MV = y;
									state = preasign;
									$display ("in comp_mm going to preassign");
								end
							else if (current==1)
								begin
										$display("current==1 and E[k-i-2] %d",E[k-counter-2]);
										R = y;
										if(E[k-counter-2]==1)
										begin									
											a=R;
											b=MV;								
											start=0;
											start=1;
											if(stateO==4)
											begin
												current = 2;
												reset = 0;
												reset = 1;
												$display ("completed MM: %d",y);
											end
										end
									else
									begin
										$display("Going to repeat state");
										state = repeatState;										
									end
								end								
								
							else if (current==2)
								begin
										state = repeatState;
								end
							else if (current==3)	
							begin
								 R=y;
								 $display("Completedf");
							end
						end
			preasign: 
						begin
							#15
							$display ("preassign state");
							R = MV;
							state = calc_r;
						end
			calc_r:
						begin
								#15 $display ("calc_r state");
								a=R;
								b=R;								
								start=0;
								start=1;
								current = 1;
								if(stateO==4)
								begin
									reset = 0;
									reset = 1;
									state = comp_MM;									
								end
						end
			repeatState:
						begin
						#15
							$display("repeatSTate %d",counter);
							counter = counter + 1;
							if (counter==k-1)
							begin
								state = postasign;
							end
							else
								state = calc_r;
							begin
							end
						end
			postasign :
			           begin
						  $display("postassign");
						  #15
						  a=R;
						  b=1;
						  current=3;
						  start = 0;
						  start = 1;
						  if(stateO==4)
						  begin
							$display("Completed");
							reset = 0;							
							reset = 1;
							state = dummy;
						  end
						  end
	endcase
	end

endmodule