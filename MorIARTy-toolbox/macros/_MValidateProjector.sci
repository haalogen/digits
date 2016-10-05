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

function _MValidateProjector(projector)
// Helper function. Validates the projector.
//
// Parameters
//  projector: Projector to be validated.
//
// Description
//  _MValidateProjector() verifies if the given argument is a structure with the
//  fields specific for a projector. If not, it calls error().

    notaprojectormessage = "Incorrect projector.";
    if ~isstruct(projector) then
        error(notaprojectormessage);
    end
    fields = fieldnames(projector);
    if sum(fields == "obj_name") == 0 then
        error(notaprojectormessage);
    end
    if projector.obj_name ~= "projector" then
        error(notaprojectormessage);
    end
    if sum(fields == "projector_type") == 0 then
        error(notaprojectormessage);
    end
    if sum(fields == "data_type") == 0 then
        error(notaprojectormessage);
    end
    if projector.data_type ~= "grayscale" & projector.data_type ~= "color" then
        error(notaprojectormessage);
    end
endfunction
