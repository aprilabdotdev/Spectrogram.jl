using Test, Spectrogram

@testset "gf3" begin

    testdata = GF3(
        cdata_path="data/gf3_sl_sample.tiff",
        meta_path="data/gf3_sl_sample.meta.xml"
    )

    read_cdata!(testdata)
    read_meta!(testdata)

    @test isnothing(testdata.cdata) == false
    @test isnothing(testdata.meta) == false

end