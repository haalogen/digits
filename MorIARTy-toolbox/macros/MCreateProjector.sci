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

function projector = MCreateProjector(shape)
// Create the projector onto the given shape.
//
// Calling Sequence
//  projector = MCreateProjector(shape)
//
// Parameters
//  shape: Structure representing the shape (typically created using the function like <link linkend="MCreateMosaicShape">MCreateMosaicShape()</link>).
//  projector: Structure representing the created projector.
//
// Description
//  <link linkend="MCreateProjector">MCreateProjector()</link> creates a structure
//  representing the projector onto the given shape.
//  That structure is supposed to be supplied as an argument to
//  <link linkend="MProjection">MProjection()</link> and some other MorIARTy functions.
//
// Examples
//  // Read an image
//  imgfile = fullpath(MorIARTyPath() + "/images/cube/cube-1.png");
//  cube = im2double(rgb2gray(imread(imgfile)));
//
//  // Create the image shape
//  shape = MCreateMosaicShape(cube, "grayscale");
//
//  // Create the projector onto the shape
//  projector = MCreateProjector(shape);
//
// See also
//  MCreateMosaicShape
//  MProjection
//
// Authors
//  Andrey Zubyuk

    // Validate the arguments
    assert_checktrue(argn(2) >= 1);
    _MValidateShape(shape);

    // Dispatch
    projector = struct();
    projector.obj_name = "projector";
    if shape.data_type == "grayscale" then
        if shape.shape_type == "mosaic" then
            projector.projector_type = "orthogonal";
            projector.data_type = shape.data_type;
            projector.shape = shape;
        else
            error("Projectors onto non-mosaic shapes are not implemented.");
        end
    elseif shape.data_type == "color"
        error("Not implemented for color images.");
    else
        error("The argument is incorrect.");
    end
endfunction
