`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:24 10/09/2013 
// Design Name: 
// Module Name:    MM 
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
module MM(y,a,b,N,stateO,start,clk,reset);
	parameter bits=31,n=6;
	output reg [bits:0]y;
	output wire [2:0]stateO;
	input wire reset;
	reg [2:0] stateO1;
	input [bits:0]a;
	input [bits:0]b;
	input [bits:0]N;
	input clk;
	reg [bits:0]c;
	reg [bits:0]c0;
	reg [bits:0]c1;
	reg [bits:0]result;
	reg [bits:0]p;
	reg [bits:0]q;
	input start;
	integer i;
	
	parameter calc_c=1,reduce=2,outputS=3,comp_MM=4;
	
	reg [2:0] state;
	
	always@(start or reset)
	begin
		if(reset)
			stateO1 = 0;
		if(start)
		begin
			state = calc_c;
			stateO1 = 0;
		end
	end
	
	
	always@(state or clk)
	begin
		case(state)
			
			calc_c : 
			begin
						#15 
						c=a*b;
						p=0;
						c1=c>>n;
						c0=c-(c1<<n);
						state=reduce;
						$display("calc_c");
			end
			
			reduce : 
			begin
					   #15 for(i=0;i<n;i=i+1)
						begin
							q=(p+c[i])%2;
							p=(p+q*N+c[i])/2;
						end
						state=outputS;
						$display("reduce");
			end
			
			outputS : 
			begin 
						#15 $display("output");
						result=p+c1;
						y = result;						
						state = comp_MM;						
			end
			
			comp_MM : 
			begin
						stateO1=4;
			end
			endcase
			
		end
		assign stateO = stateO1;
endmodule
