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

function shape = MCreateMosaicShape(data, data_type, options)
// Create the shape of the given mosaic image (or signal of another type).
//
// Calling Sequence
//  shape = MCreateMosaicShape(data, data_type)
//
// Parameters
//  data: Image (or signal of another type) which shape needs to be created.
//  data_type: Text string specifying input data type. Only "grayscale" is now implemented.
//  shape: Structure representing the created shape.
//
// Description
//  <link linkend="MCreateMosaicShape">MCreateMosaicShape()</link> creates a structure
//  representing the shape of the given image (or signal of another type).
//  That structure is supposed to be supplied as an argument to
//  <link linkend="MCreateProjector">MCreateProjector()</link> and some other MorIARTy functions.
//
// Examples
//  // Read an image
//  imgfile = fullpath(MorIARTyPath() + "/images/cube/cube-1.png");
//  cube = im2double(rgb2gray(imread(imgfile)));
//
//  // Create the image shape
//  shape = MCreateMosaicShape(cube, "grayscale");
//
// See also
//  MCreateProjector
//
// Authors
//  Andrey Zubyuk

    // Validate the arguments
    assert_checktrue(argn(2) >= 2);
    _MValidateData(data);
    if type(data_type) ~= 10 then
        error("The 2-nd argument must be a text string.");
    end

    // Dispatch
    if data_type == "grayscale" then
        shape = _MGrMosCreateShape(data);
    elseif data_type == "color"
        error("Not implemented for color images.");
    else
        error("The 2-nd argument is incorrect.");
    end
endfunction
