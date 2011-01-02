% Copyright (C) 2010 Fotios Kasolis
%
% This file is part of Octave.
%
% Octave is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or (at
% your option) any later version.
%
% Octave is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Octave; see the file COPYING.  If not, see
% <http://www.gnu.org/licenses/>.

% -*- texinfo -*-
% @deftypefn {Function File} {} heaviside (@var{x})
% Return the Heaviside step function that is one if @var{x}>0, zero if @var{x}<0
% and one half if @var{x}==0.
%
% @seealso{dirac}
% @end deftypefn

% Author: Fotios Kasolis <fotios.kasolis@gmail.com>

function h = heaviside (x)

%    if (nargin ~= 1)
%      print_usage ();
%    endif

  h = zeros (size (x));
  h(x > 0) = 1.0;
  h(x == 0) = 0.5;

end%function