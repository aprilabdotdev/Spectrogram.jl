include("../src/Spectrogram.jl") 

using BenchmarkTools
using Profile
using Plots
using FFTW
using .Spectrogram

# # Read and plot
test = SarImage(range=6185, azimuth=10912, data="data/slave_rsmp.raw")
cdata_tmp = Spectrogram.read_cdata(test)
# cdata_crop = cdata_tmp[3001:7000, 1001:5000]
gf3_tiff_path = "data/gf3_sl_sample.tiff"
cdata = read_gf3_cdata(gf3_tiff_path)
cdata[1001:10000,1001:10000] .|> abs .|> log |> x -> heatmap(x, color=:jet) 
cdata_crop = cdata[1001:10000,1001:10000]


@btime Spectrogram.range_spectrogram_easy_but_inefficient(cdata_crop)
@btime range_spectrogram(cdata_crop)
@btime azimuth_spectrogram(cdata_crop)

r1 = range_spectrogram(cdata_crop)
a1 = azimuth_spectrogram(cdata)

FFTW.set_num_threads(1)
A = cdata_crop |> transpose |> copy |> x -> fft(x, 1) .|> abs .|> log
B = abs.(fft(copy(transpose(cdata_crop)), 1))

azimuth_spectrogram(cdata_crop) |> plot
range_spectrogram(cdata_crop) |> plot

