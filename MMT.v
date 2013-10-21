`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:34:00 10/18/2013
// Design Name:   MM
// Module Name:   C:/Xilinx92i/MM/mmt.v
// Project Name:  MM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mmt_v;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg [31:0] N;
	reg start;
	reg clk;

	// Outputs
	wire [31:0] y;
	wire [2:0] stateO;

	// Instantiate the Unit Under Test (UUT)
	MM uut (
		.y(y), 
		.a(a), 
		.b(b), 
		.N(N), 
		.stateO(stateO), 
		.start(start), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		N = 0;
		start = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
		a=23;
		b=31;
		N=29;
		start=1;
		forever
		#5 clk=~clk;
        
		// Add stimulus here

	end
      
endmodule

