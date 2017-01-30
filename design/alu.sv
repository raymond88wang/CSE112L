module alu(
    input logic [31:0] A, B,
    input logic [1:0] opcode,
    output logic [3:0] ALUFlags,
    output logic [31:0] result
    );


always_comb 
begin
	//flags
	bit overflow = 1'b0;
	bit c_out = 1'b0;
	bit negative = 1'b0;
	bit zero = 1'b0;
	ALUFlags 4'b0000;
	
	result = 32'd0;
	
	case(opcode)
		// 4'b0000 :  // No OP
		// 2'b00 :
		// begin
			// result = 32'd0;
			// overflow = 1'b0;
			// c_out = 1'b0;
			// equal = 1'b0;
			// negative = 1'b0;
		// end
		// 4'b0001 :   // ADD
		2'b00 :
		begin
			{c_out,result} = A + B;
			if (A[31] & B[31] & ~result[31])
				overflow = 1'b1;
			else if (~A[31] & ~B[31] & result[31])
				overflow = 1'b1;
			else
				overflow = 1'b0;
			c_out = c_out & ~opcode[1];
			negative = result[31];
			zero = ~(&result);
		end
		// 4'b0010 :   // SUB
		2'b01 :
		begin
			{c_out,result} = A - B;
			if (A[31] & ~B[31] & ~result[31])
				overflow = 1'b1;
			else if (~A[31] & B[31] & result[31])
				overflow = 1'b1;
			else
				overflow = 1'b0;
			c_out = c_out & ~opcode[1];
			negative = result[31];
			zero = 	~(&result);
		end
		// 4'b0011 :   // COMP
		// begin
			// result = 32'd0;    
			// c_out = 1'b0;
			// overflow = 1'b0;
			// if (A == B)
				// equal = 1'b1;
			// else
				// equal = 1'b0;
		// end
		// 4'b0101 :   // AND
		2'b10 :
		begin
			result = A & B;
			c_out = 1'b0;
			overflow = 1'b0;
			negative = 1'b0;
			zero = 1'b0;
		end
		// 4'b0110 :   // OR
		2'b11 :
		begin
			result = A | B;
			c_out = 1'b0;
			overflow = 1'b0;
			negative = 1'b0;
			zero = 1'b0;
		end
		// 4'b0111 :   // NOT
		// begin
			// output1 = ~A;
			// c_out = 1'b0;
			// overflow = 1'b0;
			// equal = 1'b0;
		// end
		// 4'b1000 :   // XOR
		// begin
			// output1 = A ^ B;
			// c_out = 1'b0;
			// overflow = 1'b0;
			// equal = 1'b0;
		// end
		// 4'b1001 :   // SLL
		// begin
			// {c_out,output1} = $unsigned(A) << $unsigned(B);
			// overflow = 1'b0;
			// equal = 1'b0;
		// end
		// 4'b1011 :   // MOV
		// begin
			// output1 = A;
			// c_out = 1'b0;
			// overflow = 1'b0;
			// equal = 1'b0;
		// end
		// default :
		// begin
			// output1 = 32'd0;
			// c_out = 1'b0;
			// overflow = 1'b0;
			// equal = 1'b0;
		// end
	endcase
	ALUFlags = {overflow, c_out, negative, zero};
end