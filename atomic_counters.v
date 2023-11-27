module atomic_counters (
  input  wire            clk,
  input  wire            reset,
  input  wire            trig_i,
  input  wire            req_i,
  input  wire            atomic_i,
  output wire            ack_o,
  output wire[31:0]      count_o
);

  wire [63:0] count;
//my_reg
  reg atomic_r, req_r;
  reg [31:0] count_msb;
  
  
  // --------------------------------------------------------
  // DO NOT CHANGE ANYTHING HERE
  // --------------------------------------------------------
  reg  [63:0] count_q;

  always @(posedge clk or posedge reset)
    if (reset)
      count_q[63:0] <= 64'h0;
    else
      count_q[63:0] <= count;
  // --------------------------------------------------------

  // Write your logic here
  always @(posedge clk or posedge reset)
    if (reset) begin
      atomic_r <= 1'h0;
      req_r  <= 1'h0;
    end
    else begin
      atomic_r <= atomic_i;
      req_r  <= req_i;
    end

  always @(posedge clk or posedge reset)
    if (reset) begin
      count_msb <= 32'h0000_0000;
    end
  else if(atomic_r) begin
    count_msb <= count_q[63:32];
    
    end
  
  else 
    count_msb <= count_msb;
  
  
      //output logic
  assign count = count_q + {{63{1'h0}}, trig_i} ; 
  assign count_o = req_r ? (atomic_r ? count_q[31:0] : count_msb) : 32'h 0000_0000;
  assign ack_o = req_r;
  
  
endmodule