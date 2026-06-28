//testbench for 16x8 synchronous dual-port RAM
module mem_tb ;
		reg clk,rst,we,re;
		reg [3:0]w_add,r_add;
		reg [7:0]w_data;
		wire [7:0]r_data;
		integer l;
		
		mem dut(we,re,clk,rst,w_data,r_data,w_add,r_add);


		always
				  #10 clk = ~clk;

		task initialize;
				  begin
							 {clk,rst,we,re,w_add,r_add,w_data} = 0;
					end
		endtask

		task stimulus(input integer i);
				  begin
							 @(negedge clk)
							 w_add = i;
							 r_add = i;
							 w_data = i;
				  end
		endtask

		task write;
				  begin
							 we = 1'b1;
							 re = 1'b0;
					end
		endtask

		task read;
				  begin
							 we = 1'b0;
							 re = 1'b1;
					end
		endtask
		
		initial
			begin
					  initialize;
					  write;
					  for(l=0;l<16;l=l+1)
								 stimulus(l);
					  read;
					  for(l=0;l<16;l=l+1)
								 stimulus(l);
					  $finish;
			 end
endmodule


