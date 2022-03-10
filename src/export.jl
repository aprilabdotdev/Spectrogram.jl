using Images
using Plots
using Statistics
# using FFTW

# function serialize(cdata::Matrix{T}, filename::String="exported.png")  where T<:Any
function serialize(cdata::Matrix{T}, filename::String, downsample::Int=10)  where T<:Any
    if downsample>1  # a quick and dirty downsample to reduce file size
        cdata = cdata[1:downsample:end, 1:downsample:end]
    end
    abs_cdata = cdata .|> abs |> x -> x./mean(x) .|> clamp01nan
    save(filename, colorview(Gray, abs_cdata))
    return true
end

# function serialize(cdata::Matrix{T}, plot_func::Function=heatmap) where T<:Any
function serialize(cdata::Matrix{T}, plot_func::Function) where T<:Any  # TODO: add a note here
    cdata .|> abs .|> log |> x -> plot_func(x, color=:jet)
    return true
end

# -------------------------- Unfinished parts --------------------------
# gr()
# plotlyjs() Will this flip xy axis?
# FFTW.set_num_threads(1)
# A = cdata_crop |> transpose |> copy |> x -> fft(x, 1) .|> abs .|> log
# B = abs.(fft(copy(transpose(cdata_crop)), 1))
# azimuth_spectrogram(cdata_crop) |> plot
# range_spectrogram(cdata_crop) |> plot
# ----------------------------------------------------------------------
