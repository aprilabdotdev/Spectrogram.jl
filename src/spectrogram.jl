using Mmap
using SignalAnalysis, SignalAnalysis.Units

import Base.@kwdef

@kwdef struct SarImage
    range
    azimuth
    path
end

function read(sar_imge::SarImage)
    stream = open(sar_imge.path, "r+")   # default is read-only
    return Mmap.mmap(stream, Matrix{ComplexF32}, (sar_image.azimuth,sar_image.range))
end

function spectrogram(x)
    return tfd(x, Spectrogram(nfft=512, noverlap=256, window=hamming));
end

# Read and plot
sar_image = SarImage(range=6185, azimuth=10912, path="data/slave_rsmp.raw")
cdata = read(sar_image)
cdata_crop = cdata[3001:7000, 2001:4000]
plotly()
heatmap(abs.(cdata_crop), clim=(0, 256)) 
y = spectrogram(cdata_crop[:,1])
power = y.power
for i = 2:2000
    y = spectrogram(cdata_crop[:,i])
    power += y.power
end