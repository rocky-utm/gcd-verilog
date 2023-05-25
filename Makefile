.MAIN: test
all: test

cmake:
	@mkdir -p cmake-build && cd cmake-build && cmake .. -G"Unix Makefiles" --fresh

test:
	@make clean
	@echo "Verilating..."
	@verilator --timing --trace --cc testbench.v
	@echo "Compiling..."
	@verilator --timing --trace --exe --build --cc testbench.v testbench.cpp
	@echo "Building..."
	@./obj_dir/Vtestbench

show:
	@echo "Showing..."
	@gtkwave obj_dir/Vtestbench.vcd

clean:
	@echo "Cleaning..."
	@rm -rf obj_dir
	@verilator --timing --trace --cc testbench.v
