using Test, Spectrogram
import ArchGDAL as AG

@testset "gf3-read-data-meta" begin

    tmpdir = mktempdir()
    temppath = joinpath(tmpdir, "temporary.tiff")
    # create dummy data
    input = rand(Int16, (1000, 2000, 2))
    # write dummy data to tempdir
    AG.create(
        temppath,
        driver = AG.getdriver("GTiff"),
        width=1000,
        height=2000,
        nbands=2,
        dtype=Int16
    ) do dataset
        AG.write!(dataset, input, [1,2])
    end

    # intialize GF3
    testdata = GF3(
        cdata_path=temppath,
        meta_path=joinpath(@__DIR__, "test_data/gf3_test.meta.xml")
    )

    expected_cdata = read_cdata(testdata)
    @test expected_cdata == convert(Matrix{ComplexF32}, input[:,:,1] + im * input[:,:,2])

    expected_meta = read_meta(testdata)
    @test expected_meta["Number_of_lines_original"] == "28312"
    @test expected_meta["Number_of_pixels_original"] == "17080"
    @test expected_meta["Product type specifier"] == "GF3"
    # @test expected_meta["
end