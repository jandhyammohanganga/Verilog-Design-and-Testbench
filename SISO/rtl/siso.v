//RTL for 4bit Rignt Shift register SISO
module siso(clk,rst,in,y);
    input clk,rst,in;
    output reg y;

  reg [2:0] w;

  always @(posedge clk) begin
    if (rst) begin
      {w, y} = 0;
    end else begin
      y = w[2];
      w[2] = w[1];
      w[1] = w[0];
      w[0] = in;
    end
  end

endmodule
