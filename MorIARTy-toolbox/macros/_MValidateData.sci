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

function _MValidateData(data)
// Helper function. Validates the data.
//
// Parameters
//  data: Data to be validated.
//
// Description
//  _MValidateData() verifies if the given data is an image or a signal of another type.
//  If not, it calls error().

    data_type = type(data);
    if data_type ~= 1 & data_type ~= 4 & data_type ~= 8 & data_type ~= 17 then
        error("Incorrect data: not an image or a signal of another type.");
    end
endfunction
