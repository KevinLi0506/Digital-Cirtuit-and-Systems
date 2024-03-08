module CT(
    // Input signals
    opcode,
	in_n0,
	in_n1,
	in_n2,
	in_n3,
	in_n4,
	in_n5,
    // Output signals
    out_n
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input [3:0] in_n0, in_n1, in_n2, in_n3, in_n4, in_n5;
input [4:0] opcode;
output logic [8:0] out_n;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [4:0] value_0, value_1, value_2, value_3, value_4, value_5;
logic [4:0] value_s0, value_s1, value_s2, value_s3, value_s4, value_s5;
logic [4:0] sorted_arr [5:0];

//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------

register_file reg0(.address(in_n0), .value(value_0));
register_file reg1(.address(in_n1), .value(value_1));
register_file reg2(.address(in_n2), .value(value_2));
register_file reg3(.address(in_n3), .value(value_3));
register_file reg4(.address(in_n4), .value(value_4));
register_file reg5(.address(in_n5), .value(value_5));

merge m1(
	.in_num0(value_0), .in_num1(value_1), .in_num2(value_2), .in_num3(value_3), .in_num4(value_4), .in_num5(value_5),
	.out_num0(value_s0), .out_num1(value_s1), .out_num2(value_s2), .out_num3(value_s3), .out_num4(value_s4), .out_num5(value_s5)
);

always_comb begin
	sorted_arr = {value_s0, value_s1, value_s2, value_s3, value_s4, value_s5};
	case(opcode[4:3])
		2'b00: sorted_arr = {value_0, value_1, value_2, value_3, value_4, value_5};
		2'b01: sorted_arr = {value_5, value_4, value_3, value_2, value_1, value_0};
		2'b10: sorted_arr = {value_s5, value_s4, value_s3, value_s2, value_s1, value_s0};
		2'b11: sorted_arr = {value_s0, value_s1, value_s2, value_s3, value_s4, value_s5};
	endcase
end

calculation cal1(.opcode(opcode), .sorted_arr(sorted_arr), .out_n(out_n));

endmodule


//---------------------------------------------------------------------
// Part1. Data Sorting: merge data from min to Max
//---------------------------------------------------------------------

module merge(
	in_num0, in_num1, in_num2, in_num3, in_num4, in_num5,
	out_num0, out_num1, out_num2, out_num3, out_num4, out_num5
);

input [4:0] in_num0, in_num1, in_num2, in_num3, in_num4, in_num5;
output logic [4:0] out_num0, out_num1, out_num2, out_num3, out_num4, out_num5;

wire [4:0] in_num01, in_num11, in_num21, in_num31, in_num41, in_num51;
wire [4:0] in_num02, in_num12, in_num22, in_num32, in_num42, in_num52;
wire [4:0] in_num03, in_num13, in_num23, in_num33, in_num43, in_num53;
wire [4:0] in_num04, in_num14, in_num24, in_num34, in_num44, in_num54;
wire [4:0] in_num05, in_num15, in_num25, in_num35, in_num45, in_num55;
wire [4:0] in_num06, in_num16, in_num26, in_num36, in_num46, in_num56;
wire [4:0] in_num07, in_num17, in_num27, in_num37, in_num47, in_num57;
wire [4:0] in_num08, in_num18, in_num28, in_num38, in_num48, in_num58;
wire [4:0] in_num09, in_num19, in_num29, in_num39, in_num49, in_num59;
	
assign in_num01 = (in_num0 > in_num1) ? in_num1 : in_num0;
assign in_num11 = (in_num0 > in_num1) ? in_num0 : in_num1;
assign in_num21 = in_num2;
assign in_num31 = (in_num3 > in_num4) ? in_num4 : in_num3;
assign in_num41 = (in_num3 > in_num4) ? in_num3 : in_num4;
assign in_num51 = in_num5;

assign in_num02 = in_num01;
assign in_num12 = (in_num11 > in_num21) ? in_num21 : in_num11;
assign in_num22 = (in_num11 > in_num21) ? in_num11 : in_num21;
assign in_num32 = in_num31;
assign in_num42 = (in_num41 > in_num51) ? in_num51 : in_num41;
assign in_num52 = (in_num41 > in_num51) ? in_num41 : in_num51;

assign in_num03 = (in_num02 > in_num12) ? in_num12 : in_num02;
assign in_num13 = (in_num02 > in_num12) ? in_num02 : in_num12;
assign in_num23 = in_num22;
assign in_num33 = (in_num32 > in_num42) ? in_num42 : in_num32;
assign in_num43 = (in_num32 > in_num42) ? in_num32 : in_num42;
assign in_num53 = in_num52;

// Two merged-sort merging one-by-one
// Adding num_3 to sort with num_0 ~ num_2
assign in_num24 = (in_num23 > in_num33) ? in_num33 : in_num23;
assign in_num34 = (in_num23 > in_num33) ? in_num23 : in_num33;
assign in_num14 = (in_num13 > in_num24) ? in_num24 : in_num13;
assign in_num25 = (in_num13 > in_num24) ? in_num13 : in_num24;
assign in_num04 = (in_num03 > in_num14) ? in_num14 : in_num03;
assign in_num15 = (in_num03 > in_num14) ? in_num03 : in_num14;

assign in_num54 = in_num53;
assign in_num55 = in_num54;

assign in_num44 = in_num43;
assign in_num45 = in_num44;

assign in_num35 = in_num34;
assign in_num05 = in_num04;

// Adding num_4 to sort with num_0 ~ num_3
assign in_num36 = (in_num35 > in_num45) ? in_num45 : in_num35;
assign in_num46 = (in_num35 > in_num45) ? in_num35 : in_num45;
assign in_num26 = (in_num25 > in_num36) ? in_num36 : in_num25;
assign in_num37 = (in_num25 > in_num36) ? in_num25 : in_num36;
assign in_num16 = (in_num15 > in_num26) ? in_num26 : in_num15;
assign in_num27 = (in_num15 > in_num26) ? in_num15 : in_num26;
assign in_num06 = (in_num05 > in_num16) ? in_num16 : in_num05;
assign in_num17 = (in_num05 > in_num16) ? in_num05 : in_num16;

assign in_num56 = in_num55;
assign in_num57 = in_num56;

assign in_num47 = in_num46;
assign in_num07 = in_num06;

// Adding num_5 to sort with num_0 ~ num_4
assign in_num48 = (in_num47 > in_num57) ? in_num57 : in_num47;
assign in_num58 = (in_num47 > in_num57) ? in_num47 : in_num57;
assign in_num38 = (in_num37 > in_num48) ? in_num48 : in_num37;
assign in_num49 = (in_num37 > in_num48) ? in_num37 : in_num48;
assign in_num28 = (in_num27 > in_num38) ? in_num38 : in_num27;
assign in_num39 = (in_num27 > in_num38) ? in_num27 : in_num38;
assign in_num18 = (in_num17 > in_num28) ? in_num28 : in_num17;
assign in_num29 = (in_num17 > in_num28) ? in_num17 : in_num28;
assign in_num08 = (in_num07 > in_num18) ? in_num18 : in_num07;
assign in_num19 = (in_num07 > in_num18) ? in_num07 : in_num18;

assign out_num0 = in_num08;
assign out_num1 = in_num19;
assign out_num2 = in_num29;
assign out_num3 = in_num39;
assign out_num4 = in_num49;
assign out_num5 = in_num58;

endmodule

//---------------------------------------------------------------------
// Part2. Data Calculation Block
//---------------------------------------------------------------------

module calculation(
	opcode, 
	sorted_arr,
	out_n
);
input [4:0] opcode;
input [4:0] sorted_arr [5:0];
output logic [8:0] out_n;

logic [9:0] mean;
logic [2:0] pass_0, pass_1, pass_2, pass_3, pass_4, pass_out;

assign mean = (sorted_arr[0] + sorted_arr[1] + sorted_arr[2] + sorted_arr[3] + sorted_arr[4] + sorted_arr[5] )/6;

assign pass_0 = (sorted_arr[0] >= mean) ? 1 : 0;
assign pass_1 = (sorted_arr[1] >= mean) ? pass_0 + 1 : pass_0;
assign pass_2 = (sorted_arr[2] >= mean) ? pass_1 + 1 : pass_1;
assign pass_3 = (sorted_arr[3] >= mean) ? pass_2 + 1 : pass_2;
assign pass_4 = (sorted_arr[4] >= mean) ? pass_3 + 1 : pass_3;
assign pass_out = (sorted_arr[5] >= mean) ? pass_4 + 1 : pass_4;

//Note that num_0 in sheet is actually "array with index = 5'
always_comb begin
	out_n = 0;
	case(opcode[2:0])
		3'b000: out_n = pass_out;
		3'b001: out_n = sorted_arr[5] + sorted_arr[0];
		3'b010: out_n = sorted_arr[2]*sorted_arr[1]/2;
		3'b011: out_n = sorted_arr[5] + 2*sorted_arr[3];
		3'b100: out_n = sorted_arr[4] & sorted_arr[3];
		3'b101: out_n = ~sorted_arr[5];
		3'b110: out_n = sorted_arr[2] ^ sorted_arr[1];
		3'b111: out_n = sorted_arr[4] << 1;
	endcase
end

endmodule


//---------------------------------------------------------------------
//   Register design from TA (Do not modify, or demo fails)
//---------------------------------------------------------------------
module register_file(
    address,
    value
);
input [3:0] address;
output logic [4:0] value;

always_comb begin
    case(address)
    4'b0000:value = 5'd9;
    4'b0001:value = 5'd27;
    4'b0010:value = 5'd30;
    4'b0011:value = 5'd3;
    4'b0100:value = 5'd11;
    4'b0101:value = 5'd8;
    4'b0110:value = 5'd26;
    4'b0111:value = 5'd17;
    4'b1000:value = 5'd3;
    4'b1001:value = 5'd12;
    4'b1010:value = 5'd1;
    4'b1011:value = 5'd10;
    4'b1100:value = 5'd15;
    4'b1101:value = 5'd5;
    4'b1110:value = 5'd23;
    4'b1111:value = 5'd20;
    default: value = 0;
    endcase
end

endmodule