module CLA16(input [15:0]a, input [15:0]b,input Ci, output [15:0]S, output Cout, output AG1, output GG1);


	
	wire [3:0] GG;
	wire [3:0] AG;
	wire [3:1] C;
	//wire Ci;
	
	CLALogic CarryLogic_2 ( GG[3:0],AG[3:0], Ci, C[3:1], Cout, AG1, GG1);
	CLA4 u0 (a[3:0], b[3:0], Ci, S[3:0],AG[0], GG[0]);
	CLA4 u1 (a[7:4], b[7:4], C[1],  S[7:4], AG[1], GG[1]);
	CLA4 u2 (a[11:8], b[11:8], C[2], S[11:8], AG[2], GG[2]);
	CLA4 u3 (a[15:12], b[15:12], C[3], S[15:12], AG[3], GG[3]);

endmodule


module CLA4(input [3:0] a,input [3:0] b,input Ci,output [3:0] S, output AG,output GG);
   //wire Ci;
   wire [3:0] G;
   wire [3:0] A;
   wire [3:1] C;

   CLALogic CarryLogic (G, A, Ci, C, Cout, AG, GG);
   GPFullAdder FA0 (a[0], b[0], Ci, G[0], A[0], S[0]);
   GPFullAdder FA1 (a[1], b[1], C[1], G[1], A[1], S[1]);
   GPFullAdder FA2 (a[2], b[2], C[2], G[2], A[2], S[2]);
   GPFullAdder FA3 (a[3], b[3], C[3], G[3], A[3], S[3]);

endmodule


module CLALogic ( input [3:0] G,input [3:0] A, input Ci,output [3:1] C,output Cout,output AG,output GG);
   wire GG_int;
   wire AG_int;

   assign C[1] = G[0] | (A[0] & Ci);
   assign C[2] = G[1] | (A[1] & G[0])| (A[1] & A[0] & Ci);
   assign C[3] = G[2] | (A[2] & G[1]) | (A[2] & A[1] & G[0])| (A[2] & A[1] & A[0] & Ci);

   assign AG_int = A[3] & A[2] & A[1] & A[0];
   assign GG_int = G[3] | (A[3] & G[2]) | (A[3] & A[2] & G[1]) | (A[3] & A[2] & A[1] & G[0]);
   assign Cout = GG_int | (AG_int & Ci);
   assign AG = AG_int;
   assign GG = GG_int;

   endmodule

module GPFullAdder( input X,input Y,input Cin,output G,output A,output Sum);
      wire P_int;
	  wire A_int;
      assign G = X & Y;
      assign P = P_int;
      assign P_int = X ^ Y;
      assign Sum = P_int ^ Cin;
	  assign A = A_int;
	  assign A_int = X | Y;
endmodule
 

 
module tb_CLA16;

   reg [15:0] a;
   reg [15:0] b;
   reg Ci;
   wire [15:0] S;
   wire Cout;
   wire AG;
   wire GG;

   wire [15:0] G;
   wire [15:0] A;
   wire [15:1] C;

  //CLA4 u0(A, B, Ci, S, Co, PG, GG);
  CLA16 u1(a, b, Ci, S, Cout);
	
	initial
  begin
    $display("a               |b                  |cin |||cout  |sum             ");
  end
  
  initial
  begin
    $monitor("%b | %b | %b |||| %b   |%b", a[15:0], b[15:0] ,Ci , Cout, S[15:0]);
  end
	
   initial begin
   a = 16'b0000_1010_1010_1000;
   b = 16'b0000_0100_0000_0000;
   Ci = 1;

   #100

   a = 16'b0000_0000_1010_1000;
   b = 16'b0000_0100_0110_0000;
   Ci = 0;

   #100
   a = 16'd1552;
   b = 16'd0713;
   Ci = 0;
    
   end

   endmodule
   
  
  
