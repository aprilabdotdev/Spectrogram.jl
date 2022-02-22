using Test, Spectrogram
using Mmap

@testset "generic-slc-read-data-meta" begin

    tmpdir = mktempdir()
    temppath = joinpath(tmpdir, "temporary.raw")
    lines = 2000
    pixels = 1000
    input = rand(ComplexF32, (lines, pixels))
    stream = open(temppath, "w+")
    write(stream, input)
    close(stream)

    # intialize GenericSlc
    testdata = GenericSlc(cdata_path=temppath)
    expected_cdata = read_cdata(testdata, lines, pixels)
    @test expected_cdata == input
    read_cdata!(testdata, lines, pixels)
    @test testdata.meta["lines"] == lines
    @test testdata.meta["pixels"] == pixels

end