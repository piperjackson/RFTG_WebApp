PROGS=rftg learner dumpnet
CFLAGS=$(shell pkg-config --cflags gtk+-2.0) -march=native -O3
GTKLIBS=$(shell pkg-config --libs gtk+-2.0)
LDLIBS=-lm
#CC=clang
all: $(PROGS)
rftg: ai.o client.o comm.o engine.o gui.o init.o loadsave.o net.o
	$(CC) $(LDFLAGS) $^ $(GTKLIBS) $(LDLIBS) -o $@
learner: learner.o ai.o engine.o init.o net.o
dumpnet: dumpnet.o net.o
clean:
	rm *.o $(PROGS)
