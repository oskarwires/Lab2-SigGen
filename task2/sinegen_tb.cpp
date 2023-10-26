#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"

#include "vbuddy.cpp"     // include vbuddy code
#define MAX_CLK 1000000

int main(int argc, char **argv, char **env) {
  int clk;     // sim clk
  int tick;    // clk * 2 (rising and falling edge)

  Verilated::commandArgs(argc, argv);
  Vsinegen* top = new Vsinegen;
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("sinegen.vcd");
 
  if (vbdOpen()!=1) return(-1);
  vbdHeader("L2T2: SigGen");

  // initialize simulation inputs
  top->clk = 1;
  top->rst = 0;
  top->en = 1;
  top->phase_shift = 1;
  top->incr = 5;

  for (clk=0; clk<MAX_CLK; clk++) {
    // dump variables into VCD file and flip clock 
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*clk+tick);
      top->clk = !top->clk;
      top->eval ();
    }
    
    top->phase_shift = vbdValue();

    // plot sinusoid and clock cycle
    vbdPlot(int (top->dout1), 0, 255);
    vbdPlot(int (top->dout2), 0, 255);
    vbdCycle(clk);

    if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
      exit(0); // quit if finished or if 'q' pressed       
  }

  vbdClose();

  tfp->close(); 

  exit(0);
}
