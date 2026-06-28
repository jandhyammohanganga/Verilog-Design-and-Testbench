//RTL code for designing Vending machine
module VendingMachine (
    input clk,
    rst,
    i,
    j,
    output reg X,
    Y
);

  parameter RST = 0, Rs1 = 1, Rs2 = 2, Rs3 = 3, Rs4 = 4;

  reg [2:0] state, next_state;

  always @(posedge clk) begin
    if (rst) state = RST;
    else state = next_state;
  end

  always @(*) begin
    casex (state)
      RST: begin
        if ({i, j} == 2'b0x) next_state = RST;
        else if ({i, j} == 2'b10) next_state = Rs1;
        else if ({i, j} == 2'b11) next_state = Rs2;
      end
      Rs1: begin
        if ({i, j} == 2'b10) next_state = Rs2;
        else if ({i, j} == 2'b11) next_state = Rs3;
      end
      Rs2: begin
        if ({i, j} == 2'b10) next_state = Rs3;
        else if ({i, j} == 2'b11) next_state = Rs4;
      end
      Rs3: next_state = RST;
      Rs4: next_state = RST;
    endcase
  end

  always @(*) begin
    if (state == Rs4) {X, Y} = 2'b11;
    else if (state == Rs3) {X, Y} = 2'b10;
    else {X, Y} = 2'b00;
  end

endmodule


