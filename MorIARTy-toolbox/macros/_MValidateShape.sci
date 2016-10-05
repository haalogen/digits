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

function _MValidateShape(shape)
// Helper function. Validates the shape.
//
// Parameters
//  shape: Shape to be validated.
//
// Description
//  _MValidateShape() verifies if the given argument is a structure with the
//  fields specific for a shape. If not, it calls error().

    notashapemessage = "Incorrect shape.";
    if ~isstruct(shape) then
        error(notashapemessage);
    end
    fields = fieldnames(shape);
    if sum(fields == "obj_name") == 0 then
        error(notashapemessage);
    end
    if shape.obj_name ~= "shape" then
        error(notashapemessage);
    end
    if sum(fields == "data_type") == 0 then
        error(notashapemessage);
    end
    if shape.data_type ~= "grayscale" & shape.data_type ~= "color" then
        error(notashapemessage);
    end
    if sum(fields == "shape_type") == 0 then
        error(notashapemessage);
    end
endfunction
