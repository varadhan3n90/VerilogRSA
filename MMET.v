`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:58:07 10/18/2013
// Design Name:   MME
// Module Name:   C:/Xilinx92i/MM/MMET.v
// Project Name:  MM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MME
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MMET_v;

	// Inputs
	parameter bits=31;
	reg [bits:0] M;
	reg [bits:0] E;
	reg [bits:0] N;
	reg [bits:0] C;
	reg clk;
	reg start1;

	// Outputs
	wire [bits:0] R;

	// Instantiate the Unit Under Test (UUT)
	MME uut (
		.R(R), 
		.M(M), 
		.E(E), 
		.N(N), 
		.C(C), 
		.clk(clk), 
		.start1(start1)
	);

	initial begin
		// Initialize Inputs
		M = 0;
		E = 0;
		N = 0;
		C = 0;
		clk = 0;
		start1 = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		  
		M=23;
		N=29;
		E=31;
		C=28;
		start1=1;
		
		forever
		#5 clk = ~clk;
		// Add stimulus here

	end
      
endmodule

