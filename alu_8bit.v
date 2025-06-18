`timescale 1ns / 1ps

module alu_8bit(CLK,RST,A,B,ALU_SEL,ALU_OUT,CAR_OUT);
input [7:0]A,B;         //Inputs
input CLK,RST;
input [3:0]ALU_SEL;
output reg [15:0]ALU_OUT;       //Outputs
output reg CAR_OUT; 
reg [7:0]lout;
initial begin
$display("ALU_SEL:1.Addition\n2.Subtraction\n3.Multiplication\n4.Division\n5.Bitwise AND\n6.Bitwise OR\n7.Bitwise XOR\n8.Bitwise NOT of A\n9.Left shift of A\n10.Right shift of A\n11.Relation of A and B(>,<,==)\n12.2'sComplement of A\n13.Concatenate(B,A)\n14.Concatenate{A,B}\n15.Addition of A with A");
end
always@(posedge CLK)     //Intialization of clock
begin
		if(RST==1'b1)     	// Reset of ALU
		begin
		ALU_OUT=16'b0;
		CAR_OUT=1'b0;
		end	
else
begin
case(ALU_SEL)
4'd0:begin 
		 ALU_OUT=A+B; 
			CAR_OUT=ALU_OUT[8];
			$display("A=%b/%d  B=%b/%d  SUM=%b/%d CARRY=%b/%d",A,A,B,B,ALU_OUT,ALU_OUT,CAR_OUT,CAR_OUT);
			if(CAR_OUT)
			$display("Carry bit is set||Output exceed 8 bit range");
			end
4'd1:begin
	if(B>A)
	begin
	ALU_OUT[7:0]=A-B;
	ALU_OUT[7:0] = (~ALU_OUT[7:0])+8'b1;
	ALU_OUT[15:8] = 8'b0;
	
	$display("B is greater than A so 2'complement output is %b  / -%d",ALU_OUT,ALU_OUT);
end 		else  begin
				ALU_OUT=A-B;
			CAR_OUT=1'b0;
			$display("A=%b/%d   B=%b/%d  DIFFERENCE=%b/%d  ",A,A,B,B,ALU_OUT,ALU_OUT);
			end 
	end 
4'd2:begin ALU_OUT=A*B;
			CAR_OUT=1'b0;
			$display("A=%b/%d   B=%b/%d   PRODUCT=%b/%d   ",A,A,B,B,ALU_OUT,ALU_OUT);
			end
4'd3:begin
			if(B==8'b0)
			begin
			ALU_OUT=16'hDEAD;
			CAR_OUT=1'b0;
			$display("A=%b/%d  B=%b/%d \nInvalid Input B",A,A,B,B);
			end
			else begin 
			ALU_OUT=A/B;
			CAR_OUT=1'b0;
			$display("A=%b/%d    B=%b/%d   DIVISION=%b/%d   ",A,A,B,B,ALU_OUT,ALU_OUT);
			end
			end
4'd4:begin
			if(B==8'b0)
			begin
			ALU_OUT=16'hDEAD;
			CAR_OUT=1'b0;
			$display("A=%b/%d    B=%b/%d \nInvalid Input B",A,A,B,B);
			end
			else begin 
			ALU_OUT=A%B;
			CAR_OUT=1'b0;
			$display("A=%b/%d    B=%b/%d   MODULO DIVISION=%b/%d   ",A,A,B,B,ALU_OUT,ALU_OUT);
			end
			end
4'd5:begin
			ALU_OUT=A&B;
			CAR_OUT=1'b0;
			$display("A=%b    B=%b  BITWISE AND=%b  ",A,B,ALU_OUT);
	end
	
4'd6:begin
	ALU_OUT=A|B;
	CAR_OUT=1'b0;
	$display("A=%b   B=%b  BITWISE OR=%b  ",A,B,ALU_OUT);
	end
	
4'd7: begin
	ALU_OUT=A^B;
	CAR_OUT=1'b0;
	$display("A=%b   B=%b  BITWISE XOR=%b  ",A,B,ALU_OUT);
	end
	
4'd8:begin
		lout=(~A);
		ALU_OUT={8'b0,lout};
		CAR_OUT=1'b0;
		$display("A=%b     BITWISE NOT OF A=%b  ",A,ALU_OUT);
	end
	
4'd9:begin
		lout= A << 1;     //Left shift
		ALU_OUT={8'b0,lout};
		CAR_OUT=1'b0;
		$display("A=%b     LEFT SHIFT OF A BY 1=%b  ",A,ALU_OUT);
	end

4'd10:begin
		lout= A >> 1;				//right shift
		ALU_OUT={8'b0,lout};
		CAR_OUT=1'b0;
		$display("A=%b     RIGHT SHIFT OF A BY 1=%b  ",A,ALU_OUT);
	end
	
4'd11:begin
		if(A>B)
		begin
		ALU_OUT[0]=1'b1;
		ALU_OUT[15:1]=15'b0;
		$display("A is greater than B");
		end
		else if(A<B)
		begin
		ALU_OUT[0]=1'b0;
		ALU_OUT[1]=1'b1;
		ALU_OUT[15:2]=14'b0;
		$display("B is greater than A");
		end
		else
		begin
		ALU_OUT[1:0]=2'b0;
		ALU_OUT[2]=1'b1;
		ALU_OUT[15:3]=13'b0;
		$display("A is equal to B");
		end
	end
	
4'd12:begin
lout=(~A);
ALU_OUT=lout+1;
$display("A=%b     2'COMPLEMENT OF A=%b  ",A,ALU_OUT);
end

4'd13:begin
ALU_OUT={B,A};
	$display("A=%b   B=%b  CONCATENATE OF B,A=%b  ",A,B,ALU_OUT);
end

4'd14:begin
ALU_OUT={A,B};
	$display("A=%b   B=%b  CONCATENATE OF A,B=%b  ",A,B,ALU_OUT);
end

4'd15:begin 
		  ALU_OUT=A+A; 
			CAR_OUT=ALU_OUT[8];
			$display("A=%b   SUM=%b  CARRY=%b",A,ALU_OUT,CAR_OUT);
			end	
	//default
default:begin
ALU_OUT=16'hDEAD;
CAR_OUT=1'b0;
$display("Invalid ALU_SEL=%b",ALU_SEL);
end
endcase
end
end
endmodule





















