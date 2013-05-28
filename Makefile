# Generated by vmake version 2.2

# Define path to each library
LIB_WORK = work

# Define path to each design unit
XILINX_LIBS = 
VCOM = vcom
VLOG = vlog
VOPT = vopt
SCCOM = sccom
VSIM = vsim -c 
VSIM_SIM = vsim
LOCAL_SIM = +define+LOCAL_SIM
SRC = *.v
INCLUDE = defines 
#TEST = checksum_test
TEST = fir_top_test
VSIM_PARA = -do "add wave -r /*; run -all; delete wave * ;do wave.do"
VPITOP = pli_full_example_modelsim
GCC = gcc 
LD = ld
RUNALL = -do "run -all"
compile : test
	test -d work || vlib work 
	$(VLOG) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(SRC)
test : 
	test -f restart.do || echo -e "$(VLOG) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(SRC)  \n \
	$(VSIM) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(TEST) $(RUNALL) " > restart.do
whole_library : compile
	$(VLOG) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(SRC) 
run : compile 
	$(VSIM) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(TEST) $(RUNALL)
sim : compile
	$(VSIM_SIM) +incdir+$(INCLUDE) $(XILINX_LIBS) $(LOCAL_SIM) $(TEST) $(VSIM_PARA) 
runvpi :	compile
	$(GCC) -c -g -I$(MTI_HOME)/include $(VPITOP).c 
	$(LD) -shared -E -o $(VPITOP).sl $(VPITOP).o
	$(VSIM) $(TEST)  -pli $(VPITOP).sl $(RUNALL)
clean :	
	rm -rf *.o *.sl 
	rm -rf transcript work vsim.wlf
