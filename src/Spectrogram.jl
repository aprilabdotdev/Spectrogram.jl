module Spectrogram

export read_meta!, read_cdata!, GF3

# data reader
include("gf3.jl")
include("generic_slc.jl")
# calculate spectrogram and others
include("base.jl")

end  # module