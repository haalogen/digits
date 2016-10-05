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

function projection = MProjection(projector, data)
// Calculate projection of the given image (or signal of another type) using the given projector.
//
// Calling Sequence
//  projection = MProjection(projector, data)
//
// Parameters
//  projector: Structure representing the projector (typically created using <link linkend="MCreateProjector">MCreateProjector()</link>).
//  data: Image (or signal of another type) which projection needs to be calculated.
//  projection: Projection of the given data (image or signal of another type).
//
// Description
//  <link linkend="MProjection">MProjection()</link> calculates projection
//  of the given image (or signal of another type) using the given projector.
//  Projection is of the same type and size as the input data.
//
// Examples
//  // Read two images of a cube and an image of a circle
//  imgfile = fullpath(MorIARTyPath() + "/images/cube/cube-1.png");
//  cube1 = im2double(rgb2gray(imread(imgfile)));
//  imgfile = fullpath(MorIARTyPath() + "/images/cube/cube-2.png");
//  cube2 = im2double(rgb2gray(imread(imgfile)));
//  imgfile = fullpath(MorIARTyPath() + "/images/cube/circle.png");
//  circle = im2double(rgb2gray(imread(imgfile)));
//
//  // Create the shape of the 1-st cube image and projector onto it
//  shape_cube = MCreateMosaicShape(cube1, "grayscale");
//  projector_cube = MCreateProjector(shape_cube);
//
//  // Calculate projection of the 2-nd cube image
//  p_cube2 = MProjection(projector_cube, cube2);
//  norm(cube2(:) - p_cube2(:)) // 0 expected
//
//  // Calculate projection of the circle image
//  p_circle = MProjection(projector_cube, circle);
//  norm(circle(:) - p_circle(:)) // non-zero value expected
//
// See also
//  MCreateProjector
//
// Authors
//  Andrey Zubyuk

    // Validate the arguments
    assert_checktrue(argn(2) >= 2);
    _MValidateProjector(projector);
    _MValidateData(data);

    // Dispatch
    if projector.data_type == "grayscale" then
        if projector.projector_type == "orthogonal" then
            if projector.shape.shape_type == "mosaic" then
                projection = _MGrMosProjection(projector, data);
            else
                error("Projectors onto non-mosaic shapes are not implemented.");
            end
        else
            error("Non-orthogonal projectors are not implemented.");
        end
    elseif shape.data_type == "color"
        error("Not implemented for color images.");
    else
        error("The 1-st argument is incorrect.");
    end
endfunction
