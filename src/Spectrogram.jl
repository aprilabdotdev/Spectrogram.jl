module Spectrogram

export read_meta!, read_meta, read_cdata!, read_cdata, GF3, GenericSlc, spectrogram2d

include("gf3.jl")
include("generic_slc.jl")
include("spectro.jl")
include("export.jl")

end  # module