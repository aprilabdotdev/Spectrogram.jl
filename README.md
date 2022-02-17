# Spectrogram.jl

`Spectrogram.jl` is a Julia package for computing SAR imageries spectrograms ([what is spectrogram?](https://www.youtube.com/watch?v=EfWnEldTyPA)) along the given dimension. It is based on Julia package [`SignalAnalysis.jl`](https://github.com/org-arl/SignalAnalysis.jl) but has been modified to (1) work with SAR imageries; (2) with a satisfactory computing efficiency.

`Spectrogram.jl` is capable of multithreading and will exhaust all your CPU cores by default.

## Installation

```bash
(v1.6) pkg> add https://github.com/aprilabdotdev/Spectrogram.jl.git
```

After the package is added to the project, it can be loaded in Julia:

```bash
julia> using Spectrogram
```

## Example

An example of how to use `Spectrogram.jl`  is shown in `examples/example.jl`.
