#include <cstdlib>
#include <iostream>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "obj_dir/Vtestbench.h"

vluint16_t sim_time = 100;

int main(int argc, char** argv, char** env) {
    auto context = new VerilatedContext;
    auto *dut = new Vtestbench(context);
    Verilated::traceEverOn(true);
    auto *tfp = new VerilatedVcdC;
    dut->trace(tfp, 99);

    tfp->open("obj_dir/testbench.vcd");

    while (context->time() < sim_time && !context->gotFinish()) {
        context->timeInc(1);
        dut->eval();
        tfp->dump(context->time());
    }

    tfp->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
