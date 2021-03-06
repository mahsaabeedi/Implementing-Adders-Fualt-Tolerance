module Mux2_1(input [4:0]a, input [4:0]b, input s, output reg [4:0]out);
  always@(*) begin
    case (s)
      1'b0  : out <= a;
      1'b1  : out <= b;
      default : out <= 0; 
    endcase
  end
endmodule

module Adder(input unsigned [3:0]a, input unsigned[3:0]b, input c_in, output unsigned[4:0]out);
  assign out = a + b + c_in;
endmodule

module CSA(input unsigned[15:0]x, input unsigned[15:0]y, input c_in, output unsigned[15:0]s, output c_out);
  wire [4:0]out1, s0, c1;
  
  wire [4:0]out2;
  wire [4:0]out20;
  wire [4:0]out21;
  
  wire [4:0]out3;
  wire [4:0]out30;
  wire [4:0]out31;
  
  wire [4:0]out4;
  wire [4:0]out40;
  wire [4:0]out41;


  Adder adder1(x[3:0], y[3:0], c_in, out1);
  Adder adder20(x[7:4], y[7:4], 1'b0, out20);
  Adder adder21(x[7:4], y[7:4], 1'b1, out21);  
  Adder adder30(x[11:8], y[11:8], 1'b0, out30);
  Adder adder31(x[11:8], y[11:8], 1'b1, out31);
  Adder adder40(x[15:12], y[15:12], 1'b0, out40);
  Adder adder41(x[15:12], y[15:12], 1'b1, out41);
  

  Mux2_1 m1(out20, out21, out1[4], out2);
  Mux2_1 m2(out30, out31, out2[4], out3);
  Mux2_1 m3(out40, out41, out3[4], out4);
  
  assign s[3:0] = out1[3:0];
  assign s[7:4] = out2[3:0];
  assign s[11:8] = out3[3:0];
  assign s[15:12] = out4[3:0];
  assign c_out = out4[4];
  

endmodule

module TB___CSA();
  reg [15:0]a;
  reg [15:0]b;
  reg c_in;
  wire [15:0]s;
  wire c_out;
  reg [16:0]out;
  CSA csa(a, b, c_in, s, c_out);
  integer i;
  initial begin

    
  for (i = 0; i < 500; i = i + 1) begin
    {a, b} = $random();
    #100
    c_in=0;
    assign out = {c_out, s};
    if (out == a + b)
    $display("Correct ,a=%d, b=%d, out=%d", a, b, out);
    else
    $display("incorrect____ a=%d, b=%d, out=%d", a, b, out);
  end
  
  end
  
endmodule

