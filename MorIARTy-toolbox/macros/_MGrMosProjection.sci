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

function projection = _MGrMosProjection(projector, data)
// Helper function for MProjection().
//
// Parameters
//  shape: Structure representing the shape (typically created using the function like <link linkend="MCreateMosaicShape">MCreateMosaicShape()</link>).
//  data: Image (or signal of another type) which projection onto the given shape need to be calculated.
//  projection: Projection of the given data (image or signal of another type) onto the given shape.
//
// Description
//  _MGrMosProjection() calculates projection of the given grayscale image
//  (or monochannel signal of another type) onto the mosaic shape.

    // Validate the arguments
    assert_checktrue(argn(2) >= 2);
    _MValidateProjector(projector);
    _MValidateData(data);
    if projector.data_type ~= "grayscale" then
        error("I can work only with grayscale images (monochannel signals).");
    end
    
    // Dispatch
    if projector.projector_type == "orthogonal" then
        // Continue validating
        _MValidateShape(projector.shape);
        if projector.shape.shape_type ~= "mosaic" then
            error("I can work only with mosaic shapes.");
        end
        if ~isequal(size(projector.shape.regions), size(data)) then
            error("Incorrect data size.");
        end
        
        // Calculate projection
        if projector.shape.number_of_regions == 0 then
            projection = data;
            return;
        end
        v = _MGrMosSumOverRegions(data, projector.shape.regions, projector.shape.number_of_regions);
        v = v ./ projector.shape.region_areas;
        projection = _MGrMosSetRegionValues(projector.shape.regions, v);
    else
        error("Non-orthogonal projectors are not implemented.");
    end
endfunction
