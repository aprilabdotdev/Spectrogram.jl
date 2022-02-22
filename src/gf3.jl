using ArchGDAL
using EzXML
import Base: +

Base.@kwdef mutable struct GF3  # keyword argument
    cdata = nothing
    meta = nothing
    cdata_path
    meta_path
end

"""
    read_meta(gf3::GF3)

Read metadata from `GF3` and return a dictionary type.

# Example
```julia-repl
julia> gf3 = GF3(meta_path="gf3_meta.xml")
julia> meta = read_meta(gf3)
```
"""
function read_meta(gf3::GF3)::Dict

    query_list = Dict{String, Any}(  # a list of queries from the xml file
        # volume info
        "Volume file" => nothing,
        "Volume_ID" => "productinfo//productType",
        "Volume_identifier" => "productID",
        "Volume_set_identifier" => nothing,
        # mission info
        "(Check)Number of records in ref. file" => "imageinfo//height",
        "SAR_PROCESSOR" => "Station",
        "Product type specifier" => "satellite",
        "Logical volume generating facility" => "Station",
        "Logical volume creation date" => "productinfo//productGentime",
        "Location and date/time of product creation" => "productinfo//productGentime",
        "Orbit" => "orbitID",  # Scene identification
        "Direction" => "Direction",  # Scene identification
        "Mode" => "sensor//imagingMode",  # Scene identification
        "Leader file" => nothing,
        "Sensor platform mission identifer" => "satellite",
        "Scene_centre_latitude" => "imageinfo//center//latitude",  # Scene location
        "Scene_centre_longitude" => "imageinfo//center//longitude",  # Scene location
        # product info
        "Radar_wavelength (m)" => "sensor//lamda",
        "First_pixel_azimuth_time (UTC)" => "imageinfo//imagingTime//start",
        "Pulse_Repetition_Frequency (computed, Hz)" => "imageinfo//eqvPRF",
        "Total_azimuth_band_width (Hz)" => "processinfo//TotalProcessedAzimuthBandWidth",
        "Weighting_azimuth" => nothing,
        "Xtrack_f_DC_constant (Hz, early edge)" => "processinfo//DopplerCentroidCoefficients//d0",
        "Xtrack_f_DC_linear (Hz/s, early edge)" => "processinfo//DopplerCentroidCoefficients//d1",
        "Xtrack_f_DC_quadratic (Hz/s/s, early edge)" => "processinfo//DopplerCentroidCoefficients//d2",
        "Range_time_to_first_pixel (2way) (ms)" => "imageinfo//nearRange",
        "Range_sampling_rate (computed, MHz)" => "imageinfo//eqvFs",
        "Total_range_band_width (MHz)" => "processinfo//RangeLookBandWidth",
        "Weighting_range" => nothing,
        # SLC info
        "Datafile" => nothing,
        "Dataformat" => "productinfo//productFormat",
        "Number_of_lines_original" => "imageinfo//height",
        "Number_of_pixels_original" => "imageinfo//width",
        # Orbit
        "Orbit Time" => "GPS//GPSParam//TimeStamp",
        "Orbit X" => "GPS//GPSParam//xPosition",
        "Orbit Y" => "GPS//GPSParam//yPosition",
        "Orbit Z" => "GPS//GPSParam//zPosition",
    )

    # query value from a list of xml nodes
    primates = readxml(gf3.meta_path)
    container = Dict()
    for (key, value) in query_list
        if value === nothing
            container[key] = "Unknown"
        else
            """ do the actual querying logic here
            """
            possible_nodes = findall("product//" * value, primates)
            container[key] = possible_nodes[1].content  # only return the first instance
        end
    end
    return container
end  # end read_meta()

"""
    read_meta!(gf3::GF3)

Same as `read_meta()`, but updates `GF3` by writing metadata to `GF3.meta`.
"""
function read_meta!(gf3::GF3)::GF3
    gf3.meta = read_meta(gf3)
    return gf3
end

"""
    read_cdata(gf3::GF3)

Read GF3 SLC data and return a complex matrix.

# Example
```julia-repl
julia> gf3 = GF3(cdata_path="gf3.tiff")
julia> cdata = read_cdata(gf3)
N×M Matrix{Complex}
```
"""
function read_cdata(gf3::GF3)::Matrix{Complex}
    dataset = ArchGDAL.readraster(gf3.cdata_path)
    return convert(Matrix{ComplexF32}, dataset[:,:,1] .+ im * dataset[:,:,2])
end

"""
    read_cdata!(gf3::GF3)

Same as `read_cdata()`, but updates `GF3` by writing complext matrix to `GF3.cdata`.
"""
function read_cdata!(gf3::GF3)::GF3
    gf3.cdata = read_cdata(gf3)
    return gf3
end

