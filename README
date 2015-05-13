                        FIR and Upsampling Filters in OCaml
                        -----------------------------------



Dependencies:           make, ocamlopt


About:                  The essential notion of this library is to provide
                        the means of performing convolution for the purpose 
                        of applying filters and performing upsampling to 
                        audio data in terms of list operations.  Data is collected 
                        from stdin as a list, operations are applied to the list, 
                        and the resulting list is sent to stdout.  This can be 
                        performed as either floating point or integer arithmetic.  
                        Extensible functors are provided to build the proper 
                        modules.  The core computational code for the convolution 
                        can be either based on lists or on arrays as desired.  

                        Two types of FIR filters are implemented: a functional 
                        implementation based on lists and (fairly) traditional 
                        implementation based on arrays.  The functional
                        version is almost purely functional, though exhibits
                        mutable filter state so that it can more easily be used
                        in repeated invocation.  Both have an identical
                        interface and can be used interchangably, and both
                        isolate mutable values within their respective class.  
                        Functionally there is very little different between
                        the two; both are O(n) in the size of the coefficients,
                        though the array implementation is faster and may
                        make better use of caching. 
                        
                        Support modules are included for working with mono and
                        stereo raw audio data streams with bit depths of 16
                        and 24 bits, signed little endian.  Since the interface
                        is via stdin and stdout, the below examples can easily
                        be reconsidered in various more inspired ways.   

                        To be more portable, many common list functions are 
                        implemented specificly for this project, though are named
                        in a manner consistent with standard implementations;
                        while taylored to the needs of this library, they can
                        replaced if desired.  Consistency and tail recursion 
                        are the principal reasons.  There are a number of custom 
                        supportive list functions included as well.  Many of 
                        the list functions have a reversed version; you may
                        find these of merit for concise execution of you are
                        performing back-to-back operations that preserve order
                        by reversing an intermediate list.  

                        Tests are provided, as are some examples of use designed 
                        for 44.1kHz mono 16 bit raw data.  The first example is 
                        simply a low pass filter with a cutoff of around 1kHz.  
                        The filter is linear phase with reasonably smooth passband.  
                        The second example is a conventional FIR upsampler.  It 
                        produces a 176.4kHz sample rate result from the 44.1kHz 
                        sample audio file (4x upsampling).  The specific filter 
                        is a fast rolloff linear phase filter with a cutoff of 
                        approximately 20kHz.  There is a quick demo of reading one
                        format and writing another.  Note that while processing in
                        the examples are conducted in floating point, they are not
                        normalized and require scaling when converting to differing
                        bit depths.  Same goes for upsampling.  The included test 
                        file, moo.raw, is 44.1kHz, 16 bit, signed little endian.  
                        You can play these with aplay or similar.

                        
Caveats:                One might think that this implementation would have a
                        natural extension to Lagrange polynomial interpolators,
                        spline interpolators, and the like.  This is not planned
                        for this library for two main reasons.  First, while one
                        of the principal benefits of this approach is infinite
                        streams of data, this is not conducive in the general case
                        when boundary conditions require special knowledge of 
                        conditions that are unknown to an infinite stream.  
                        Second, there is a propensity with higher order polynomial
                        interpolators to behave poorly with rapidly changing data;
                        in the case of audio near the Nyquist frequency, which 
                        naturally is a common region for upsampling applications, 
                        this is a poor assumption. 


How to run:             Tests:              make test
                                            ./test      (runs on build)

                        Filter demo:        make filter
                                            cat data/moo.raw | ./filter > out.raw

                        Upsample demo:      make upsample
                                            cat data/moo.raw | ./upsample > out.raw

                        Stereo from mono:   make stereo
                                            cat data/moo.raw | ./stereo > out.raw

                        Library:            make lib    
                                            (produces sig_proc.cmxa amd sig_proc.a)
