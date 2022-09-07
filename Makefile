include build/Rules.mk

APP := build/mapdas_device_reader

SRCS := $(wildcard source/*.cpp)
OBJS := $(SRCS:.cpp=.o)


CSRCS := $(wildcard source/*.c)
COBJS := $(CSRCS:.c=.o)


LIB_SRCS := $(wildcard lib/**/*.cpp)
LIB_OBJS :=  $(LIB_SRCS:.cpp=.o)


LIB_CSRCS := $(wildcard lib/**/*.c)
LIB_COBJS := $(LIB_CSRCS:.c=.o)


CPPFLAGS +=-I./
LDFLAGS +=

%.o: %.cpp
	@echo "Compiling: $<"
	$(CPP) $(CPPFLAGS) -c $< -o $@
		
%.o: %.c
	@echo "Compiling: $<"
	$(CPP) $(CPPFLAGS) -c $< -o $@

$(APP): $(LIB_OBJS) $(LIB_COBJS) $(OBJS) $(COBJS)
	@echo ""
	@echo "Linking: $@"
	$(CPP) -o $@ $(OBJS) $(COBJS) $(LIB_OBJS) $(LIB_COBJS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(AT)rm -rf $(LIB_OBJS) $(LIB_COBJS) $(OBJS) $(COBJS) $(APP)