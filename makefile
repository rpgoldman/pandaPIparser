CC=g++
COMPILEFLAGS=-O2 -Wall
LINKERFLAG=-lm

.PHONY = parser clean

parser: src/hddl-token.o src/hddl.o src/main.o
	${CC} ${LINKERFLAG} $^ -o parser

%.o: %.cpp
	${CC} ${COMPILEFLAGS} -o $@ -c $<

src/hddl-token.cpp: src/hddl.cpp src/hddl-token.l
	flex --yylineno -o src/hddl-token.cpp src/hddl-token.l

src/hddl.cpp: src/hddl.y
	bison -d -o src/hddl.cpp src/hddl.y

clear:
	rm src/hddl-token.cpp
	rm src/hddl.cpp
	rm src/hddl.hpp
	rm src/*o
