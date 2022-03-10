include("../src/Spectrogram.jl")
using .Spectrogram

"""
    find(dirname::String, filename::String="slave_rsmp.raw")
Recursively find files in a directory and return the filelist.
"""
function find(dirname::String, filename::String = "slave_rsmp.raw")
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

    println("1")
    cdata = read_cdata(GenericSlc(cdata_path=fname), lines, pixels)
    # cdata = test(lines, pixels)
    println("2")
    fout = joinpath(vcat(splitpath(fname)[1:end-1], ["quicklook.png"])...)
    println("3")
    Spectrogram.serialize(cdata, fout)

end

# master img lines and pixels
pixels = 21888
lines = 23292
stack_dir = "/Users/yuxiao/Downloads/"
for f in find(stack_dir, "slave_rsmp.raw")
    println("quicklook started for ", f)
    quicklook(f, lines, pixels)
    println("quicklook done for ", f)
end
