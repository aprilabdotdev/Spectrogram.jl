using Mmap

Base.@kwdef mutable struct GenericSlc  # keyword argument
    cdata = nothing
    meta = nothing
    cdata_path
end

function read_cdata(generic_slc::GenericSlc, lines::Int, pixels::Int)::Matrix{ComplexF32}
    """TODO: do not hardcode data format
    """
    stream = open(generic_slc.cdata_path, "r+")   # default is read-only
    # doris: pixel-interleaved complex-short 4-byte 2b/2b by default
    cdata_tmp = Mmap.mmap(stream, Matrix{Int16}, (pixels*2, lines))
    cdata_tmp = copy(transpose(cdata_tmp))  # somehow a transpose is needed here for doris file

    slc_tmp = (
        convert(Matrix{Float32}, cdata_tmp[:, 1:2:end]),
        convert(Matrix{Float32}, cdata_tmp[:, 2:2:end])
    )

    # pre-allocation is neccessary for large arrays.
    slc = Matrix{ComplexF32}(undef, lines, pixels)
    for col in 1:lines
        slc[col, :] = slc_tmp[1][col, :] .+ im * slc_tmp[2][col, :]
    end

    close(stream)
    return slc
end

function read_cdata!(generic_slc::GenericSlc, lines::Int, pixels::Int)::GenericSlc
    generic_slc.cdata = read_cdata(generic_slc, lines, pixels)
    # update the meta as well
    (generic_slc.meta === nothing) && (generic_slc.meta = Dict())
    generic_slc.meta["lines"] = lines
    generic_slc.meta["pixels"] = pixels
    return generic_slc
end
