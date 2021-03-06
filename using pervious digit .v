module TW (input [1:0]X  , input [1:0] Y, input P , output reg [1:0]T , output reg [1:0]W);

wire [1:0]outX;
wire [1:0]outY;
assign outX = X[1:0];
assign outY = Y[1:0];

wire [3:0] concatanate;
assign concatanate ={outX , outY};

always@(*) begin
//0
if (concatanate == 4'b0000 ) 
	begin  
				T	<= 2'b00;
				W	<= 2'b00;
				end 
				
if (concatanate == 4'b1101)

	begin  
				T	<= 2'b00;
				W	<= 2'b00;
				end
				
if (concatanate == 4'b0111)

	begin  
				T	<= 2'b00;
				W	<= 2'b00;
				end
				
//2			
if (concatanate==4'b0101 )
	begin
				T	<= 2'b01;
				W	<= 2'b00;
				end

//-2		
if (concatanate==4'b1111 )
	begin
				T	<= 2'b11;
				W	<= 2'b00;
				end 
//1		p=0	
 if (concatanate==4'b0100 && P==1'b0 )
	begin
				T	<= 2'b01;
				W	<= 2'b11;
				end				
 if (concatanate==4'b0001 && P==1'b0 )
	begin
				T	<= 2'b01;
				W	<= 2'b11;
				end	
// 1 p=1
			
if (concatanate==4'b0100 && P==1'b1 )
	begin
				T	<= 2'b00;
				W	<= 2'b01;
				end	
			
if (concatanate==4'b0001 && P==1'b1 )
	begin
				T	<= 2'b00;
				W	<= 2'b01;
				end
//	-1	

if (concatanate==4'b1100 && P==1'b0 )
	begin
				T	<= 2'b00;
				W	<= 2'b11;
				end 				
if (concatanate==4'b0011 && P==1'b0 )
	begin
				T	<= 2'b00;
				W	<= 2'b11;
				end 
if (concatanate==4'b1100 && P==1'b1 )
	begin
				T	<= 2'b11;
				W	<= 2'b01;
				end 
 
if(concatanate==4'b0011 && P==1'b1 )
	begin
				T	<= 2'b11;
				W	<= 2'b01;
			end 

end			
endmodule



module PP(input [1:0]N1 , input [1:0]N2 ,output reg P);

always@(*) 
begin
	if (N1[1]==0 && N2[1]==0)
		  P = 1'b0;
	else
		  P = 1'b1;	
end
endmodule


module pervious_info(input [7:0]A , input [7:0]B, input cin , output [7:0] result , output carryout);

wire [1:0]T0;
wire [1:0]T1;
wire [1:0]T2;
wire [1:0]T3;
wire [1:0]T4;

wire [1:0]W0;
wire [1:0]W1;
wire [1:0]W2;
wire [1:0]W3;

wire [1:0]S0;
wire [1:0]S1;
wire [1:0]S2;
wire [1:0]S3;

wire P0;
wire P1;
wire P2;
wire P3;
wire P4;

PP P01(A[1:0] , B[1:0] , P1 );
PP P11(A[3:2] , B[3:2] , P2 );
PP P21(A[5:4] , B[5:4] , P3 );
PP P31(A[7:6] , B[7:6] , P4 );

TW TW0(A[1:0] , B[1:0] , 1'b0 , T1 , W0);
TW TW1(A[3:2] , B[3:2] , P1   , T2 , W1);
TW TW2(A[5:4] , B[5:4] , P2   , T3 , W2);
TW TW3(A[7:6] , B[7:6] , P3   , T4 , W3);



assign T0 = cin;
assign carryout = T4;	
assign	S0= W0;
assign  S1=	T1 + W1;
assign	S2= T2 + W2;
assign  S3= T3 + W3;
	
assign result ={S3 , S2 , S1 , S0};
	
endmodule 


module pv_tb();
   reg [7:0] A;
   reg [7:0] B;
   reg Ci;
   wire [7:0] result;
   wire carryout;
  
	pervious_info pv(A , B, ci , result , carryout);
	initial
  begin
    $display("A              |B        || cout  | sum             ");
  end
  
  initial
  begin
    $monitor("%b | %b  |||| %b   |%b", A[7:0], B[7:0] , carryout, result);
  end
	
   initial begin
   A = 8'b0000_0101;
   B = 8'b0001_0001;
   Ci = 0;

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































