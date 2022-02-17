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

function read_cdata(sar_image::GenericSlc, lines::Int, pixels::Int)::Matrix{ComplexF32}
    stream = open(sar_image.cdata_path, "r+")   # default is read-only
    return Mmap.mmap(stream, Matrix{ComplexF32}, (lines,pixels))
end

function read_cdata!(sar_image::GenericSlc, lines::Int, pixels::Int)::GenericSlc
    sar_image.cdata = read_cdata(sar_image, lines, pixels)
    # update the meta as well
    (sar_image.meta == nothing) && (sar_image.meta = Dict())
    sar_image.meta["lines"] = lines
    sar_image.meta["pixels"] = pixels
    return sar_image
end
