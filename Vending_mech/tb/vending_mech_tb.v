//Testbench for Vending Machine
module VendingMachine_tb;

  reg clk, rst, i, j;
  wire X, Y;

  VendingMachine DUT (
      clk,
      rst,
      i,
      j,
      X,
      Y
  );

  task initialize;
    begin
      {clk, i, j} = 0;
      rst = 1;
    end
  endtask

  task stimulus;
    input integer I, J;
    begin
      @(negedge clk) i = I;
      j = J;
    end
  endtask

  task monitor;
    begin
      $dumpfile("VendingMachine_tb.vcd");
      $dumpvars(0, VendingMachine_tb);
    end
  endtask

  always #5 clk = ~clk;

  initial begin
    initialize;
    monitor;
    @(negedge clk) rst = 0;
    stimulus(0, 0);
    stimulus(0, 1);
    stimulus(1, 1);
    stimulus(1, 0);
    stimulus(1, 1);
    #20 $finish;
  end

endmodule


