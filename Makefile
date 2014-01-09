CXX=g++
UFLAGS=-O2 -fomit-frame-pointer
CXXFLAGS=$(UFLAGS) -march=native -fvisibility-inlines-hidden -fvisibility=hidden -Wall -std=c++0x -iquote -lmysqlcppconn  -DMYSQLPP_MYSQL_HEADERS_BURIED 

LIBS=-lmysqlpp  -lev -lpthread -lboost_system
OCELOT=ocelot
OBJS=$(patsubst %.cpp,%.o,$(wildcard *.cpp))
all: $(OCELOT)
$(OCELOT): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)
%.o: %.cpp %.h
	$(CXX) -c $(CXXFLAGS) -o $@ $<
clean:
	rm -f $(OCELOT) $(OBJS)

debug:
	make CXX=clang++ UFLAGS='-g -pg -D_DIE_ON_SIG' -j3
