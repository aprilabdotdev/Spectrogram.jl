using Base.Threads
using FFTW
using Mmap
using Setfield
using SignalAnalysis, SignalAnalysis.Units

import Base: +


Base.@kwdef mutable struct GenericSlc  # keyword argument
    cdata = nothing
    meta = nothing
    cdata_path
end

function read_cdata!(sar_image::GenericSlc, lines::Int, pixels::Int)::GenericSlc
    stream = open(sar_image.cdata_path, "r+")   # default is read-only
    return Mmap.mmap(stream, Matrix{ComplexF32}, (lines,pixels))
end
