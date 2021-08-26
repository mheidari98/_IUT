all: Start
	
Start: installStatic src_main.o
	gcc   ./src_main.o  -L./static -lStatic_Mr7 -o ./statically-linked
src_main.o: src_main.c
	gcc -c ./src_main.c -o ./src_main.o

DynamicLibrary:
	
	gcc -c -fPIC ./src1.c    -o ./shared_src1.o
	gcc -c -fPIC ./src2.c    -o ./shared_src2.o
	gcc -shared ./shared_src1.o ./shared_src2.o -o ./libShared_Mr7.so
#	gcc  ./src_main.o -L./shared -lMr7 -o ./use-shared-library
StaticLibrary:Ss1 Ss2

	ar rcs ./libStatic_Mr7.a ./static_src1.o ./static_src2.o
#	gcc   ./src_main.o  -L./static -lMr7 -o ./statically-linked
Ss1:src1.c
	gcc -c ./src1.c -o ./static_src1.o
Ss2:src2.c
	gcc -c ./src2.c -o ./static_src2.o
installDynamic: DynamicLibrary
	cp ./libShared_Mr7.so /usr/lib/
installStatic: StaticLibrary
	cp ./libStatic_Mr7.a /usr/lib/
#	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH)”;path_to_shared_object
#	export LD_LIBRARY_PATH
