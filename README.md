# Spectrogram.jl

`Spectrogra.jl` is a Julia package for computing spectrograms for SAR imageries along the given dimension. It is based on Julia package `[SignalAnalysis.jl](https://github.com/org-arl/SignalAnalysis.jl)` but has been modified to work with SAR imageries.

`Spectrogra.jl` is capable of multithreading and will use all your CPU cores by default. 

## Installation

```
(v1.6) pkg> add https://github.com/fredrikekre/ImportMacros.jl
```

After the package is added to the project, it can be loaded in Julia:

```
julia> using Spectrogram
```

## Example

An example of how to use `Spectrogra.jl`  is shown in `examples/example.jl`.
