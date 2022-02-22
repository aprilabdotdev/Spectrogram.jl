using Mmap

Base.@kwdef mutable struct GenericSlc  # keyword argument
    cdata = nothing
    meta = nothing
    cdata_path
end

function read_cdata(generic_slc::GenericSlc, lines::Int, pixels::Int)::Matrix{ComplexF32}
    stream = open(generic_slc.cdata_path, "r+")   # default is read-only
    return Mmap.mmap(stream, Matrix{ComplexF32}, (lines,pixels))
end

function read_cdata!(generic_slc::GenericSlc, lines::Int, pixels::Int)::GenericSlc
    generic_slc.cdata = read_cdata(generic_slc, lines, pixels)
    # update the meta as well
    (generic_slc.meta === nothing) && (generic_slc.meta = Dict())
    generic_slc.meta["lines"] = lines
    generic_slc.meta["pixels"] = pixels
    return generic_slc
end
