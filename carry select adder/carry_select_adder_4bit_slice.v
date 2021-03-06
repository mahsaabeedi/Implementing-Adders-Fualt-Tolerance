module carry_select_adder_4bit_slice(a, b, cin, sum, cout);
input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;
 
wire [3:0] s0,s1;
wire c0,c1;
 
ripple_carry_4_bit rca1(
.a(a[3:0]),
.b(b[3:0]),
.cin(1'b0),
.sum(s0[3:0]),
.cout(c0));
 
ripple_carry_4_bit rca2(
.a(a[3:0]),
.b(b[3:0]),
.cin(1'b1),
.sum(s1[3:0]),
.cout(c1));
 
mux2X1 #(4) ms0(
.in0(s0[3:0]),
.in1(s1[3:0]),
.sel(cin),
.out(sum[3:0]));
 
mux2X1 #(1) mc0(
.in0(c0),
.in1(c1),
.sel(cin),
.out(cout));
endmodule