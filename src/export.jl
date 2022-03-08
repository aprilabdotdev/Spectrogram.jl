using Images
using Plots
# using FFTW

# function serialize(cdata::Matrix{T}, filename::String="exported.png")  where T<:Any
function serialize(cdata::Matrix{T}, filename::String)  where T<:Any
    abs_cdata = clamp01nan.(abs.(cdata))
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
