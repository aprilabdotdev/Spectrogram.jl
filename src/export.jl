using Images
using Plots
# using FFTW

function serialize(cdata::Matrix{Any}, filename::String="exported.png")
    save(filename, colorview(Gray, 100*abs.(cdata)/maximum(abs.(cdata))))
    return true
end

function serialize(cdata::Matrix{Any}, plot_func::Function=heatmap)
    cdata .|> abs .|> log |> x -> plot_func(x, color=:jet)
    return true
end

# gr()
# plotlyjs() 会把 xy 轴反转过来？
# FFTW.set_num_threads(1)
# A = cdata_crop |> transpose |> copy |> x -> fft(x, 1) .|> abs .|> log
# B = abs.(fft(copy(transpose(cdata_crop)), 1))
# azimuth_spectrogram(cdata_crop) |> plot
# range_spectrogram(cdata_crop) |> plot

