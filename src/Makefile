#TOOL INPUT
SRC =$(wildcard *.v)
TESTBENCH = TestBenches/Intersection_tb.v
TBOUTPUT = Intersection_tb.vcd

#TOOLS
COMPILER = iverilog
SIMULATOR = vvp
VIEWER = Scansion

#TOOL OPTIONS
COFLAGS = -v -o
SFLAGS = -v

#TOOL OUTPUT
COUTPUT = compiler.out          

###############################################################################
check : $(TESTBENCH) $(SRC)
	$(COMPILER) -v $(SRC)

simulate: $(COUTPUT)
	$(SIMULATOR) $(SFLAGS) $(COUTPUT) 

display: $(TBOUTPUT)
	open -a $(VIEWER) $(TBOUTPUT) 

$(COUTPUT): $(TESTBENCH) $(SRC)
	$(COMPILER) $(COFLAGS) $(COUTPUT) $(TESTBENCH) $(SRC)