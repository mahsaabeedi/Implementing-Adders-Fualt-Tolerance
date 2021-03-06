module HZ(input [1:0]X  , input [1:0] Y, output reg H , output reg [1:0]Z);	

wire [1:0]outX;
wire [1:0]outY;
assign outX = X[1:0];
assign outY = Y[1:0];

wire [3:0] concatanate;
assign concatanate ={outX , outY};



 always@(*) begin
    case (concatanate)

		4'b1111 :begin 
				H	<= 1'b0;
				Z	<= 2'b10;
				end
//-1

		4'b0011 : begin
				 H	<= 1'b0;
				 Z	<= 2'b11;
				 end
		4'b1100 : begin
				 H	<= 1'b0;
				 Z	<= 2'b11;
				 end
//0

		4'b0000  : begin
				 H <= 1'b0 ;
				 Z <= 2'b00;
				 end
				 
		4'b1101  : begin
				 H <= 1'b0 ;
				 Z <= 2'b00;
				 end
		4'b0111  : begin
				 H <= 1'b0 ;
				 Z <= 2'b00;
				 end
//1

		4'b0001  : begin
				 H <= 1'b1;
				 Z <= 2'b11;
				 end	
		4'b0100  : begin
				 H <= 1'b1;
				 Z <= 2'b11;
				 end	
				 
//2

		4'b0101 :begin
				 H	<= 1'b1;
				 Z	<= 2'b00;
				 end
      default  :  begin
				  H	<= 1'b0;
				  Z <= 2'b00; 
				  end
    endcase
	end
endmodule


module TW (input H, input [1:0]Z  , output reg [1:0]T , output reg [1:0]W);
//wire VH;
//assign VH(0) = H;

//assign SUM	= signed({1'b0, VH}) + signed(Z);

//SUM = Z+H;
wire [2:0] concatanate1;
assign concatanate1={H,Z};
always@(*) begin
    case (concatanate1)
//0	
      3'b000 :begin  
				T	<= 2'b00;
				W	<= 2'b00;
				end
				
	 3'b111 :begin  
				T	<= 2'b00;
				W	<= 2'b00;
				end
//1				
	  3'b100  :begin
				T	<= 2'b00;
				W	<= 2'b01;
				end
//-2				
		3'b010 : begin
				T	<= 2'b11;
				W	<= 2'b00;
				end
//-1				
		3'b011 : begin
				T	<= 2'b11;
				W	<= 2'b01;
				end
				
		3'b110: begin
				T	<= 2'b11;
				W	<= 2'b01;
				end
		
      default : begin 
				T	<= 2'b00;
				W	<= 2'b00;
				end

    endcase
	end
endmodule


module sign_digit(input [7:0]A , input [7:0]B, input cin , output [7:0] result , output carryout);
wire H0;
wire H1;
wire H2;
wire H3;
wire H4;

wire [1:0]Z0;
wire [1:0]Z1;
wire [1:0]Z2;
wire [1:0]Z3;

wire [1:0]T0;
wire [1:0]T1;
wire [1:0]T2;
wire [1:0]T3;

wire [1:0]W0;
wire [1:0]W1;
wire [1:0]W2;
wire [1:0]W3;

wire [1:0]S0;
wire [1:0]S1;
wire [1:0]S2;
wire [1:0]S3;

HZ HZ0 (A[1:0] , B[1:0] , H1 ,Z0);
HZ HZ1 (A[3:2] , B[3:2] , H2 ,Z1);
HZ HZ2 (A[5:4] , B[5:4] , H3 ,Z2);
HZ HZ3 (A[7:6] , B[7:6] , H4 ,Z3);

TW TW0(H0 , Z0 , T1 , W0);
TW TW1(H1 , Z1 , T2 , W1);
TW TW2(H2 , Z2 , T3 , W2);
TW TW3(H3 , Z3 , T4 , W3);

assign H0=cin;
assign carryout = T4;
	
assign	S0= W0;
assign  S1=	T1 + W1;
assign	S2= T2 + W2;
assign  S3= T3 + W3;
	
assign result ={S3 , S2 , S1 , S0};
	
endmodule 


module DB_tb();
   reg [7:0] A;
   reg [7:0] B;
   reg Ci;
   wire [7:0] result;
   wire carryout;
  
	sign_digit db(A , B, ci , result , carryout);
	initial
  begin
    $display("A              |B         ||| cout     | sum             ");
  end
  
  initial
  begin
    $monitor("%b | %b  |||| %b   |%b", A[7:0], B[7:0] , carryout, result);
  end
	
   initial begin
   A = 8'b0000_0101;
   B = 8'b0001_0001;
   Ci = 1;

   #100

   A = 8'b0000_0101;
   B = 8'b1101_0011;
   Ci = 0;

   #100
   A = 8'b1100_0000;
   B = 8'b1100_0000;
   Ci = 0;
    
   end

   endmodule
   


