//Testbench for SISO 4bit right Shift Register
module SISO4bit_tb;

  reg clk, rst, i;
  wire f;

  siso DUT (
      clk,
      rst,
      i,
      f
  );

  task initialize;
    begin
      {clk, i} = 0;
      rst = 1;
    end
  endtask

  always begin
    #5 clk = ~clk;
  end

  task in;
    input integer j;
    begin
      @(negedge clk) i = j;
    end
  endtask

  initial begin
    initialize;
    @(negedge clk) rst = 0;
    in(0);
    in(1);
    in(1);
    in(0);
    #50 $finish;
  end

endmodule
