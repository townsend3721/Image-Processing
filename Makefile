ifndef VERBOSE
VERBOSE = false
endif
ifeq ($(VERBOSE), false)
.SILENT:
endif

Complier = gcc
Flags = -g -std=c99 -fopenmp -o
Libraries = -lm -lpng

build:
	make build-student; make build-naive;

build-student: student/ced.c student/student.c student/ced.h student/student.h
	$(Complier) $(Flags) student/ced student/ced.c student/student.c $(Libraries)

build-naive: naive/ced.c naive/student.c naive/ced.h naive/student.h
	$(Complier) $(Flags) naive/ced naive/ced.c naive/student.c $(Libraries)

build-correctness: check-correctness.c
	$(Complier) $(Flags) check-correctness check-correctness.c $(Libraries)

clean:
	make clean-student; make clean-naive

clean-student:
	rm -r student/out; mkdir student/out; rm student/ced;

clean-naive:
	rm -r naive/out; mkdir naive/out; rm naive/ced;

clean-correctness:
	rm check-correctness;

batch:
	echo "Batch testing your project..."; make clean; make build; make build-correctness; ./run-test.py batch; make clean-correctness;

view:
	echo "Viewing..."; make clean-student; make build-student; ./run-test.py view;

correctness:
	echo "Testing the correctness of your project..."; make clean-student; make build-student; make build-correctness; ./run-test.py correctness; make clean-correctness;

valgrind:
	make clean-student; make build-student; cd student; valgrind --leak-check=yes ./ced  ../input/valve.png ../input/weaver.png ../input/bigbrain.png

.PHONY: build build-student build-naive build-correctness clean clean-student clean-naive clean-correctness batch view correctness valgrind
