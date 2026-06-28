//RTL for 16x8 Synchronous dual-port Ram
module mem(we,re,clk,rst,w_data,r_data,w_add,r_add);
		input clk,rst,we,re;
		input [7:0]w_data;
		input [3:0]w_add,r_add;
		output reg [7:0]r_data;
		integer i;

		reg [7:0]mem[0:15];

		always@(posedge clk)
			begin
					  if(rst)
					  begin
								 for(i=0;i<16;i=i+1) begin
											mem[i] = 8'b00;
								 end
								 r_data = 0;
					 end
					 else if (we && !re)
								mem[w_add] = w_data;
					 else if (re && !we)
								r_data = mem[r_add];

			end
			endmodule	
						


