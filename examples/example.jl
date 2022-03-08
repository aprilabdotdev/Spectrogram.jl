include("../src/Spectrogram.jl")
using .Spectrogram

# lines=1000
# pixels=1000

# for f ∈ (1, 2, 3)
#     f |> x -> GenericSlc(cdata_path = x) |>
#          x -> read_cdata(x, lines, pixels) |>
#          x -> serialize(x, "f_quicklook.png")

# end

"""
    find(dirname::String, filename::String="slave_rsmp.raw")

Recursively find files in a directory and return the filelist.
"""
function find(dirname::String, filename::String="slave_rsmp.raw")
    fmatched = []
    for (root, _, files) in walkdir(dirname)
        for file in files
            if file === filename
                append!(fmatched, [joinpath(root, file)])
            end
        end
    end
    return fmatched
end

""" read data and export quicklook
"""
function quicklook(fname::String, lines::Int, pixels::Int)

    cdata = read_cdata(GenericSlc(cdata_path=fname), lines, pixels)
    fout = joinpath(splitpath(fname)[1:end-1], "quicklook.png")
    Spectrogram.serialize(cdata, fout)

end

# master img lines and pixels
lines = 1000
pixels = 1000
stack_dir = "some_path"
for f in find(stack_dir, "slave_rsmp.raw")
    quicklook(f, lines, pixels)
end
