filter:  
	rm -rf _build
	mkdir _build
	cp src/utils.ml src/types.ml src/fir.ml src/streams.ml examples/coefficients.ml examples/filter.ml _build
	cd _build && ocamlopt -S -unsafe -inline 1000 -o filter utils.ml types.ml fir.ml streams.ml coefficients.ml filter.ml
	cp _build/filter .

upsample:
	rm -rf _build
	mkdir _build
	cp src/utils.ml src/types.ml src/fir.ml src/streams.ml examples/coefficients.ml examples/upsample.ml _build
	cd _build && ocamlopt -S -unsafe -inline 1000 -o upsample utils.ml types.ml fir.ml streams.ml coefficients.ml upsample.ml
	cp _build/upsample .

stereo:
	rm -rf _build
	mkdir _build
	cp src/utils.ml src/types.ml src/streams.ml examples/stereo.ml _build
	cd _build && ocamlopt -S -unsafe -inline 1000 -o stereo utils.ml types.ml streams.ml stereo.ml
	cp _build/stereo .

lib: 
	rm -rf _build
	mkdir _build
	cp src/utils.ml src/types.ml src/fir.ml src/streams.ml _build
	cd _build && ocamlopt -S -unsafe -inline 1000 -linkall -a -o sig_proc.cmxa utils.ml types.ml fir.ml streams.ml
	cp _build/sig_proc.cmxa .
	cp _build/sig_proc.a .

test:
	rm -rf _build
	mkdir _build
	cp src/utils.ml src/types.ml src/fir.ml tests/tests.ml _build
	cd _build && ocamlopt -S -unsafe -inline 1000 -o test utils.ml types.ml fir.ml tests.ml
	cp _build/test .
	./test

clean: 
	rm -rf *.cmo *.cmi *.o *.cmx *.s sig_proc.* filter test upsample stereo out.raw
	rm -rf _build
