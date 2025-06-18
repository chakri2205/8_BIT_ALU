`timescale 1ns / 1ps



module alu_8bit_tb;

	// Inputs
	reg CLK;
	reg RST;
	reg [7:0] A;
	reg [7:0] B;
	reg [3:0] ALU_SEL;

	// Outputs
	wire [15:0] ALU_OUT;
	wire CAR_OUT;

	// Instantiate the Unit Under Test (UUT)
	alu_8bit uut (
		.CLK(CLK), 
		.RST(RST), 
		.A(A), 
		.B(B), 
		.ALU_SEL(ALU_SEL), 
		.ALU_OUT(ALU_OUT), 
		.CAR_OUT(CAR_OUT)
	);
	always #5 CLK=~CLK;

	initial begin
		// Initialize Inputs
		CLK = 1;
		RST = 0;
		A = 8'b0;
		B = 8'b0;
		ALU_SEL = 4'bx;

	$display("Reset Test Values");
	RST=1'b1;
	#10;
	if(ALU_OUT != 16'b0 && CAR_OUT != 1'b0)
	$display("Reset is failed||Outputs are not zeroes");
	else $display("------Reset is Worked sucessfully------");
	RST=1'b0;
	#10;

	//Addition Test cases
	$display("------Addition Test cases------");
	ALU_SEL=4'b0000;

	//simple addition
	A=8'd30;B=8'd22;#10;
	if(ALU_OUT == 16'd52 && CAR_OUT == 1'b0)
	$display("Addition is successful");
	else $display("Addition is falied");

	//over flow a=ff  b=ff
	A=8'hFF;B=8'hFF;#10;
	if(ALU_OUT == 16'd510 && CAR_OUT == 1'b1)
	$display("Addition is successful");
	else $display("Addition is falied");

	// addition with 0
	A=8'hCC;B=8'b0;#10;
	if(ALU_OUT == 16'hCC && CAR_OUT == 1'b0)
	$display("Addition is successful");
	else $display("Addition is falied");

	// over flow condition
	A=8'hAA;B=8'hBB;#10;
	if(ALU_OUT == 16'd357 && CAR_OUT == 1'b1)
	$display("Addition is successful");
	else $display("Addition is falied");

	//subtraction test cases	
	ALU_SEL=4'b1;
	$display("------Subtraction test cases------");

	//two positive numbers
	A=8'd210;B=8'd129;#10;
	if(ALU_OUT == 16'd81 && CAR_OUT == 1'b0)
	$display("Subtraction is successful");
	else $display("Subtraction is falied");

	//subtract with 0
	A=8'd196;B=8'd0;#10;
	if(ALU_OUT == 16'd196 && CAR_OUT == 1'b0)
	$display("Subtraction is successful");
	else $display("Subtraction is falied");

	//Subtract A with A
	A=8'd245;B=A;#10;
	if(ALU_OUT == 16'b0 && CAR_OUT == 1'b0)
	$display("Subtraction is successful");
	else $display("Subtraction is falied");
	//two positive numbers
	A=8'd34;B=8'd99;#10;
	if(ALU_OUT == 16'b10111111 && CAR_OUT == 1'b0)
	$display("Subtraction is successful");
	else $display("Subtraction is falied");
	
	
	
	//multiplication test cases
	$display("------Multiplication test cases------");
	ALU_SEL=4'd2;

	//two small numbers
	A=8'hF;B=8'hC;#10;
	if(ALU_OUT ==16'd180 && CAR_OUT==1'b0)
	$display("Multiplication is successful");
	else $display("Multiplication is not successful");

	//Multiply by 1
	A=8'd175;B=8'd1;#10;
	if(ALU_OUT ==16'd175 && CAR_OUT==1'b0)
	$display("Multiplication is successful");
	else $display("Multiplication is not successful");
	
	//Multiply by 0
	A=8'd222;B=8'd0;#10;
	if(ALU_OUT ==16'd0 && CAR_OUT==1'b0)
	$display("Multiplication is successful");
	else $display("Multiplication is not successful");
	
	//two Maximum numbers
	A=8'hFF;B=8'hFF;#10;
	if(ALU_OUT ==16'd65025 && CAR_OUT==1'b0)
	$display("Multiplication is successful");
	else $display("Multiplication is not successful");

//Division cases
$display("------Division test cases------");
ALU_SEL=4'd3;

//Divide A and B (A>B)
	A=8'd254;B=8'd127;#10;
	if(ALU_OUT ==16'd2 && CAR_OUT==1'b0)
	$display("Division is successful");
	else $display("Division is not successful");

//Divide A and 1 (A>B)
	A=8'd230;B=8'd1;#10;
	if(ALU_OUT ==16'd230 && CAR_OUT==1'b0)
	$display("Division is successful");
	else $display("Division is not successful");
	
//Divide A and 0 (A>B)
	A=8'd254;B=8'd0;#10;
	if(ALU_OUT ==16'hDEAD && CAR_OUT==1'b0)
	$display("Division can't be done");
	else $display("Division is not successful");

//Divide A and B (B>A)
	A=8'd127;B=8'd200;#10;
	if(ALU_OUT ==16'd0 && CAR_OUT==1'b0)
	$display("Division is successful");
	else $display("Division is not successful");

//Modulo Division cases
$display("------Modulo Division test cases------");
ALU_SEL=4'd4;

//Modulo Divide A and B 
	A=8'd240;B=8'd15;#10;
	if(ALU_OUT ==16'd0 && CAR_OUT==1'b0)
	$display("Modulo Division is successful");
	else $display("ModuloDivision is not successful");

// Modulo Divide A and B(non zero reminder) 
	A=8'd247;B=8'd200;#10;
	if(ALU_OUT ==16'd47 && CAR_OUT==1'b0)
	$display("Modulo Division is successful");
	else $display("ModuloDivision is not successful");
	
//Modulo Divide A and 0 
	A=8'd78;B=8'd0;#10;
	if(ALU_OUT ==16'hDEAD && CAR_OUT==1'b0)
   $display("Modulo Division is can't be done ");
	else $display("ModuloDivision is not successful");
	
//Bit wise AND
$display("------Bitwise AND------");
ALU_SEL=4'd5;
//random numbers
A=8'd123;B=8'd223;#10;
if(ALU_OUT==16'd91 && CAR_OUT==1'b0)
$display("Bit wise AND is sucessful");
else $display("Bit wise AND is not sucessful");

//AND with all ones
A=8'd129;B=8'hFF;#10;
if(ALU_OUT==16'd129 && CAR_OUT==1'b0)
$display("Bit wise AND is sucessful");
else $display("Bit wise AND is not sucessful");

//AND with all zeros
A=8'd139;B=8'd0;#10;
if(ALU_OUT==16'b0 && CAR_OUT==1'b0)
$display("Bit wise AND is sucessful");
else $display("Bit wise AND is not sucessful");


//Bit wise OR
$display("------Bitwise OR------");
ALU_SEL=4'd6;

//two numbers
A=8'd143;B=8'd200;#10;
if(ALU_OUT==16'd207 && CAR_OUT==1'b0)
$display("Bit wise OR is sucessful");
else $display("Bit wise OR is not sucessful");

//OR with all zeros
A=8'd250;B=8'b0;#10;
if(ALU_OUT==16'd250 && CAR_OUT==1'b0)
$display("Bit wise OR is sucessful");
else $display("Bit wise OR is not sucessful");

//both inputs are zeros
A=8'd0;B=8'd0;#10;
if(ALU_OUT==16'b0 && CAR_OUT==1'b0)
$display("Bit wise OR is sucessful");
else $display("Bit wise OR is not sucessful");


//Bit wise XOR
$display("------Bitwise XOR------");
ALU_SEL=4'd7;

//two numbers
A=8'd169;B=8'd221;#10;
if(ALU_OUT==16'd116 && CAR_OUT==1'b0)
$display("Bit wise XOR is sucessful");
else $display("Bit wise XOR is not sucessful");

//Both inputs are all ones
A=8'hFF;B=8'hFF;#10;
if(ALU_OUT==16'b0 && CAR_OUT==1'b0)
$display("Bit wise XOR is sucessful");
else $display("Bit wise XOR is not sucessful");

//Alternating inputs
A=8'b10101010;B=8'b01010101;#10;
if(ALU_OUT==16'hFF && CAR_OUT==1'b0)
$display("Bit wise XOR is sucessful");
else $display("Bit wise XOR is not sucessful");

//NOT test cases
$display("------NOT TEST CASES------");
ALU_SEL=4'd8;
//random number
A=8'd196;B=8'b0;#10;
if(ALU_OUT==16'd59 && CAR_OUT==1'b0)
$display("Bit wise NOT is sucessful");
else $display("Bit wise NOT is not sucessful");
//all zeros
A=8'b0;B=8'b0;#10;
if(ALU_OUT==16'hFF && CAR_OUT==1'b0)
$display("Bit wise NOT is sucessful");
else $display("Bit wise NOT is not sucessful");
//all ones
A=8'hFF;B=8'b0;#10;
if(ALU_OUT==16'b0 && CAR_OUT==1'b0)
$display("Bit wise NOT is sucessful");
else $display("Bit wise NOT is not sucessful");

//left shift test cases
$display("------LEFT SHIFT------");
ALU_SEL=4'd9;
//random number(big)
A=8'd223;B=8'b0;#10;
if(ALU_OUT==16'd190 && CAR_OUT==1'b0)
$display("LEFT SHIFT OPERATION is sucessful");
else $display("LEFT SHIFT OPERATION is not sucessful"); 
//random number(small)
A=8'd99;B=8'b0;#10;
if(ALU_OUT==16'd198 && CAR_OUT==1'b0)
$display("LEFT SHIFT OPERATION is sucessful");
else $display("LEFT SHIFT OPERATION is not sucessful"); 


//Right shift test cases
$display("------RIGHT SHIFT------");
ALU_SEL=4'd10;
//random number(big)
A=8'd255;B=8'b0;#10;
if(ALU_OUT==16'd127 && CAR_OUT==1'b0)
$display("RIGHT SHIFT OPERATION is sucessful");
else $display("RIGHT SHIFT OPERATION is not sucessful"); 
//random number(small)
A=8'd190;B=8'b0;#10;
if(ALU_OUT==16'd95 && CAR_OUT==1'b0)
$display("RIGHT SHIFT OPERATION is sucessful");
else $display("RIGHT SHIFT OPERATION is not sucessful"); 


//relational operators
$display("------Relational operations------");
//A==B
ALU_SEL=4'd11;
A=8'd126;B=8'd126;#10;
if(ALU_OUT[2]==1'b1 && CAR_OUT==1'b0)
$display("Relational Operator perfect");
else $display("Relational Operator is not perfect");
//A>B
A=8'd200;B=8'd129;#10;
if(ALU_OUT[0]==1'b1 && CAR_OUT==1'b0)
$display("Relational Operator perfect");
else $display("Relational Operator is not perfect");
//A<B
A=8'd144;B=8'd181;#10;
if(ALU_OUT[1]==1'b1 && CAR_OUT==1'b0)
$display("Relational Operator perfect");
else $display("Relational Operator is not perfect");

//2's complement
$display("------2'sComplement Test cases------");
ALU_SEL=4'd12;
//random numbers
A=8'd75;B=8'b0;#10;
if(ALU_OUT==16'b10110101  && CAR_OUT==1'b0)
$display("2's Complement is Sucessful");
else $display("2's Complement not is Sucessful");

//all ones
A=8'b0;B=8'b0;#10;
if(ALU_OUT==16'b100000000  && CAR_OUT==1'b0)
$display("2's Complement is Sucessful");
else $display("2's Complement not is Sucessful");

//concatnate B,A
$display("------Concatenate {B,A}------");
ALU_SEL=4'd13;
//random numbers
A=8'd10;B=8'd45;#10;
if(ALU_OUT==16'b0010110100001010  && CAR_OUT==1'b0)
$display("Conactenate of {B,A} is sucessful");
else $display("Conactenate of {B,A} is not sucessful");
//A=0,B=all ones
A=8'b0;B=8'hFF;#10;
if(ALU_OUT==16'hFF00 && CAR_OUT==1'b0)
$display("Conactenate of {B,A} is sucessful");
else $display("Conactenate of {B,A} is not sucessful");

//A=all ones,B=all zeros
A=8'hFF;B=8'b0;#10;
if(ALU_OUT==16'h00FF && CAR_OUT==1'b0)
$display("Conactenate of {B,A} is sucessful");
else $display("Conactenate of {B,A} is not sucessful");



//concatnate A,B
$display("------Concatenate {A,B}------");
ALU_SEL=4'd14;

//random numbers
A=8'd95;B=8'd25;#10;
if(ALU_OUT==16'b101111100011001  && CAR_OUT==1'b0)
$display("Conactenate of {A,B} is sucessful");
else $display("Conactenate of {A,B} is not sucessful");
//A=0,B=all ones
A=8'hFF;B=8'b0;#10;
if(ALU_OUT==16'hFF00 && CAR_OUT==1'b0)
$display("Conactenate of {A,B} is sucessful");
else $display("Conactenate of {A,B} is not sucessful");

//A=all ones,B=all zeros
A=8'b0;B=8'hFF;#10;
if(ALU_OUT==16'h00FF && CAR_OUT==1'b0)
$display("Conactenate of {A,B} is sucessful");
else $display("Conactenate of {A,B} is not sucessful");

//sum of A with A
$display("------Addition of A with A------");
ALU_SEL=4'd15;
//random number
A=8'd137;B=8'b0;#10;
if(ALU_OUT==16'd274 && CAR_OUT==1'b1)
$display("Addition of A with A is successful");
else $display("Addition of A with A is not successful");
// A=0
A=8'b0;B=8'b0;#10;
if(ALU_OUT==16'b0 && CAR_OUT==1'b0)
$display("Addition of A with A is successful");
else $display("Addition of A with A is not successful");
//A is Max
A=8'hFF;B=8'b0;#10;
if(ALU_OUT==16'd510 && CAR_OUT==1'b1)
$display("Addition of A with A is successful");
else $display("Addition of A with A is not successful");

$display("----------------------All Test Cases Completed-------------------");
$finish;	
	end      
endmodule



