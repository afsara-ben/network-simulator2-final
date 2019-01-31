# network-simulator2-final

This is my offline for level 3 term 2 CSE 322 course.

Offline specification can be found in ns2-project.
Installation process of ns2 can be found in resources/installation.txt or follow https://youtu.be/FXm8i1K-6jI

--> For running the modified version follow this : https://www.youtube.com/watch?v=ItA0C7AlqWk&t=602s
After editing any *.cc file make sure to do: $make clean;make;sudo make install;

--> resouces/ns contains the iso virtual image provided by sir. The codes given there was given by sir and the modifications can be found in resources/ns/ns/ns2 programs/itcp

--> To run the modified code always do: <version of ns2 which you installed and is present in /usr/local/bin> <fileName> <args if any>, otherwise it will always run the default ns2 installed. 

--> Wimax Patch and commands:

	$ cd ns-allinone-2.35/
	$ zcat wimax-awg26_ns235.patch.gz | patch -p0
	$ ./install
	$ cd ns-2.35/
	$ ./ns test-be-mod.tcl 1 2 http://code.google.com/p/ns2-wimax-awg/ 500
	.... looks like an OK simulation. The file out_mod_2.res, 2.2MB is created.
	(I.e. test-be-mod.tcl : "Syntax: ns test-be.tcl seed diuc dl/ul distance".)
	More examples : ns-2.35/tcl/wimax/*

--> important websites

	http://nile.wpi.edu/NS/
	https://www.isi.edu/nsnam/ns/doc/node1.html
	https://www.isi.edu/nsnam/ns/tutorial/
