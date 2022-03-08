using Test, Spectrogram

@testset "check-export-existence" begin

    # generate a random image
    input = rand(ComplexF32, (1000, 1000))

    tmpdir = mktempdir()

    # test png output
    temp_png = joinpath(tmpdir, "temporary.png")
    Spectrogram.serialize(input, temp_png)
    @test isfile(temp_png) === true

    # # test heatmap plot
    # Spectrogram.serialize(input, heatmap)
    # temp_heatmap = joinpath(tmpdir, "temporary.png")
    # @test isfile(temp_heatmap) === true

end