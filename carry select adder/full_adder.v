module full_adder(a,b,cin,sum, cout);
input a,b,cin;
output sum, cout;
 
wire x,y,z;
 
half_adder h1(.a(a), .b(b), .sum(x), .cout(y));
half_adder h2(.a(x), .b(cin), .sum(sum), .cout(z));
or or_1(cout,z,y);
endmodule