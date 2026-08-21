CXX := g++
CXXFLAGS := -std=c++23 -Wall -O2 $(shell root-config --cflags)
LDFLAGS := $(shell root-config --libs)

TARGET := puzzle-picture-ROOT
SRC := puzzle-picture-ROOT.cpp
OBJ := $(SRC:.cpp=.o)

.PHONY: all package puzzle-picture clean

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(OBJ) -o $(TARGET) $(LDFLAGS)

%.o: %.cxx
	$(CXX) $(CXXFLAGS) -c $< -o $@

package:
	@pacman -S root  # Install C++ data-analysis ROOT-framework from CERN, through Extra-repository on Arch Linux (needs root privilege).

puzzle-picture:
	@./puzzle-picture-ROOT  # Create puzzle picture 'puzzle-picture-ROOT.png'.

clean:
	@rm -f $(OBJ) $(TARGET) puzzle-picture-ROOT.png
