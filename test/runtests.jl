using Spectrogram
using Test

tests = [  # modules to be testsed
    "generic_slc",
    "gf3",
    "export",
]

if length(ARGS) > 0  # options to run specific unittests in cli
    tests = ARGS
end

for t in tests
    test_file = "test_$t.jl"
    printstyled("* $test_file\n", color = :green)
    include(test_file)
end