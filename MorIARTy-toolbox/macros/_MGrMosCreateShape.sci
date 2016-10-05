//////////////////////////////////////////////////
// MorIARTy - Morphological Image Analysis and Recognition Toolbox
// Copyright (C) 2016  MorIARTy Team
//
// Authors:
//  Andrey Zubyuk (zubjuk@physics.msu.ru)
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//////////////////////////////////////////////////

function shape = _MGrMosCreateShape(data, options)
// Helper function for MCreateMosaicShape().
//
// Parameters
//  data: Image (or signal of another type) which shape needs to be created.
//  options: Ignored (reserved for future).
//  shape: Structure representing the created shape.
//
// Description
//  _MGrMosCreateShape() creates the mosaic shape of the given grayscale image
//  (or monochannel signal of another type).

    // Validate the arguments
    assert_checktrue(argn(2) >= 1);
    _MValidateData(data);

    // Initialize the common fields of the shape
    shape = struct();
    shape.obj_name = "shape";
    shape.data_type = "grayscale";
    shape.shape_type = "mosaic";

    // Exact shape
    v = unique(data);
    shape.number_of_regions = length(v);
    shape.regions = zeros(data);
    shape.region_areas = zeros(1, shape.number_of_regions);
    shape.regions = _MGrMosGetRegionsUb(data, v);
    shape.region_areas = _MGrMosMeasureRgnAreas(shape.regions);
endfunction
