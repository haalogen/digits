function builder_gw_cpp()
    curr_path = get_absolute_file_path("builder_gateway_cpp.sce");

    tbx_build_gateway( ...
        "MorIARTy_cpp", ..  // library to be built
        [ ...               // functions: scilab name - cpp name
            "_MGrMosGetRegionsUb",      "grmos_get_regions_ub"; ...
            "_MGrMosSetRegionValues",   "grmos_set_region_values"; ...
            "_MGrMosMeasureRgnAreas",   "grmos_measure_region_areas"; ...
            "_MGrMosSumOverRegions",    "grmos_sum_over_regions" ...
        ], ...
        [ ...               // library sources
            "common.h", "common.cpp", ...
            "gray_mosaic.cpp" ...
        ], ...
        curr_path ...
    );

endfunction

builder_gw_cpp();
clear builder_gw_cpp; // remove builder_gw_cpp on stack
