module EMPTCircle(output G, A, input Gi, Ai, GiPrev, AiPrev);
  
  wire e;
  and #(1) (e, Ai, GiPrev);
  or #(1) (G, e, Gi);
  and #(1) (A, Ai, AiPrev);
  
endmodule

module FULLCircle(output Ci, input Gi);
  
  buf #(1) (Ci, Gi);
  
endmodule

module APG(output G, P,A ,input Ai, Bi);
  
  and #(1) (G, Ai, Bi);
  xor #(2) (P, Ai, Bi);
  or  #(3)  (A, Ai, Bi);
  
endmodule

module XOR__(output Si, input Pi, CiPrev);
  
  xor #(2) (Si, Pi, CiPrev);
  
endmodule


/* module P (input x , input y , output reg P );

assign p = x^y;

endmodule
 */

module KSA16(output [15:0] sum, output cout, input [15:0] a, b);
  
  wire cin = 1'b0;
  wire [15:0] c;
  wire [15:0] g, p;
  wire [15:0] A;
  APG sq[15:0](g, p, A, a, b);

  // first line
    wire [15:1] g2, p2 ,A2;
  FULLCircle sc0_0(c[0], g[0]);
  EMPTCircle bc0[15:1](g2[15:1], A2[15:1], g[15:1], A[15:1], g[14:0], A[14:0]);
  
  
  // second line
  wire [15:3] g3, p3 , A3;
  FULLCircle sc1[2:1](c[2:1], g2[2:1]);
  EMPTCircle bc1[15:3](g3[15:3], A3[15:3], g2[15:3], A2[15:3], g2[13:1], A2[13:1]);
  
  // third line
  wire [15:7] g4, p4 ,A4;
  FULLCircle sc2[6:3](c[6:3], g3[6:3]);
  EMPTCircle bc2[15:7](g4[15:7], A4[15:7], g3[15:7], A3[15:7], g3[11:3], A3[11:3]);

  // fourth line
  wire [15:15] g5, p5 ,A5 ;
  FULLCircle sc3[14:7](c[14:7], g4[14:7]);
  EMPTCircle bc3_15(g5[15], A5[15], g4[15], A4[15], g4[7], A4[7]);  
  
  // fifth line 
  FULLCircle sc4_15(c[15], g5[15]);
  
  
  // last line XOR
  XOR__ tr0(sum[0], p[0], cin);
  XOR__ tr[15:1](sum[15:1], p[15:1], c[14:0]);

  // generate cout
  buf #(1) (cout, c[15]);

endmodule




module tb_KSA16;
  wire [15:0] sum;
  wire cout;
  reg [15:0] a, b;
  reg cin;
  
  KSA16 ksa16(sum[15:0], cout, a[15:0], b[15:0]);
  
  initial
  begin
    $display("a               |b               ||cout|sum             ");
  end
  
  initial
  begin
    $monitor("%b|%b||%b   |%b", a[15:0], b[15:0], cout, sum[15:0]);
  end
  
  initial
  begin
    a=16'b1010000010100000; 
	b=16'b1010000010100000;
	
    /* #10 
	a=16'b0101100011110100; 
	b=16'b1111010011110100;
    #10
	a=16'b0000111100111101; 
	b=16'b0000111100001111;
    #10 
	a=16'b1100100011001010; 
	b=16'b1100100011001010;
 */
  end
endmodule



