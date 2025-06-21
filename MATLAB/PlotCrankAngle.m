%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ABOUT 
% This function plots reciprocating machinery data in the crank angle
% domain with the first sample at top dead center (TDC).
%
% REFERENCES:
% - Boutin, Ben and Kathy Boutin. "Basic Reciprocating Engine & Compressor 
%   Analysis Techniques." GRMC 2002 Gas Machinery Conference.
% - Howerton, Bruce et. al. "The Application of an Online Reciprocating
%   Engine and Compressor Pressure Monitoring System of a WAN." GMRC 2003.
% - Howerton, Bruce et. al. "Monitoring System Boosts Efficiency." Pipeline 
%   and Gas Technology. July/August 2004.
% - Boutin, Ben and Bob Webber. "Basic Reciprocating Engine & Compressor 
%   Analysis Techniques." GRMC 2004 Gas Machinery Conference.
%
% EXAMPLE
% To call the function with a complete set of pressure and load curves:
% h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
%     'str_eu_press', str_eu_press,...
%     'd_inertia_load', d_inertia_load, ...
%     'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load);
%
% To create a plot with pressure and accel curves:
% h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
%     'str_eu_press', str_eu_press,...
%     'str_title_press', str_title_press, ...
%     'd_accel1', d_accel1, 'd_accel2', d_accel2);
%    
% DEVELOPMENT NOTES
% This function has a test harness, "PlotCrankAngle_TestHarness," that must
% be revised when enhancing or debugging code. The source and test harness
% reside in the "Analytics-Reference\Plot_CrankAngle" respository
%
% INPUT
% ns_rev (REQUIRED, POSITIVE SCALAR) - Number of samples per revolution, a 
%   positive scalar.
% d_press_ce (REQUIRED, NUMERIC VECTOR) - Numeric vector of crank end (CE) 
%   cylinder pressure data for the compression / expansion cycle. 
% str_press_ce (PARAMETER, NUMERIC VECTOR) - Character description of the 
%   crank end pressure data that appears in the legend. Defaults to CE.
% d_press_he (PARAMETER, NUMERIC VECTOR) - Numeric vector of head end (HE) 
%   cylinder pressure data for the compression/expansion cycle. This must
%   be the same length as d_press_ce.  Defaults to an empty vector, [].
% str_press_he (PARAMETER, NUMERIC VECTOR) - Character description of the 
%   data that appears in the legend for the head end pressure curve. 
%   Defaults to HE.
% d_press_ce2 (PARAMETER, NUMERIC VECTOR) - Numeric vector of outer
%   cylinder crank end (HE) cylinder pressure data for the
%   compression/expansion cycle. This must be the same length as
%   d_press_ce.  Defaults to an empty vector, [].
% str_press_ce2 (PARAMETER, NUMERIC VECTOR) - Character description of the
%   data that appears in the legend for the outer cylinder crank end
%   pressure curve. Defaults to CE2.
% d_press_he2 (PARAMETER, NUMERIC VECTOR) - Numeric vector of the outer
%   cylinder head end (HE) cylinder pressure data for the
%   compression/expansion cycle. This must be the same length as
%   d_press_ce.  Defaults to an empty vector, [].
% str_press_he2 (PARAMETER, NUMERIC VECTOR) - Character description of the
%   data that appears in the legend for the outer cylinder head end
%   pressure curve. Defaults to HE2.
% str_eu_press (PARAMETER, CHARACTER) - String indicating the units for 
%   pressure data. Defaults to 'psig'
% str_press_ax_label (PARAMETER, CHARACTER) - String indicating the label
%   for the pressure vertical axis. Defaults to 'Pressure'
% str_title_press (PARAMETER, VALID TITLE) - Title for the pressure plot.
%   Default is an empty string. 
% str_title_press_interp (PARAMETER, CHAR) - String defining interpreter 
%   for the pressure plot tile. Defaults to 'None' 
% y_lim_press (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the pressure plot. Automatically
%   calculated if not provided.
% str_title_load (PARAMETER, VALID TITLE) - Title for the load plot. 
%   Default is an empty string. 
% d_inertia_load (PARAMETER, NUMERIC VECTOR) - Numeric vector of inertia 
%   load data. 
% str_eu_load (PARAMETER, CHARACTER) - String indicating the units for load 
%   data. Default is 'lbf'. 
% d_gas_load (PARAMETER, NUMERIC VECTOR) - Numeric vector of gas load data.
% d_combined_load (OPTIONAL, PARAMETER) - Numeric vector of combined load
%   data. 
% y_lim_load (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the load plot. Automatically
%   calculated if not provided.
% str_title_seg (PARAMETER, VALID TITLE) - Title for the segmental
%   acceleration plot. Default is an empty string. 
% d_seg1 (PARAMETER, NUMERIC VECTOR) - Numeric vector with crosshead 
%   acceleration data for segmental plot. 
% str_seg1 (PARAMETER, CHARACTER) - String indicating accel1 label.
%   Defaults to 'accel1'
% d_seg2 (PARAMETER, NUMERIC VECTOR) - Numeric vector with crosshead 
%   acceleration data. 
% str_seg2 (PARAMETER, CHARACTER) - String indicating accel1 label.
%   Defaults to 'accel2'
% str_eu_seg (PARAMETER, CHARACTER) - String indicating the units for 
%   segmental acceleration data. Default is 'g's'. 
% y_lim_seg (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the segmental acceleration plot. 
%   Automatically calculated if not provided.
% str_title_acc (PARAMETER, VALID TITLE) - Title for the acceleration plot. 
%   Default is an empty string. 
% d_accel1 (PARAMETER, NUMERIC VECTOR) - Numeric vector with crosshead 
%   acceleration data. 
% str_accel1 (PARAMETER, CHARACTER) - String indicating accel1 label.
%   Defaults to 'accel1'
% d_accel2 (PARAMETER, NUMERIC VECTOR) - Numeric vector with crosshead 
%   acceleration data. 
% str_accel2 (PARAMETER, CHARACTER) - String indicating accel1 label.
%   Defaults to 'accel2'
% str_eu_acc (PARAMETER, CHARACTER) - String indicating the units for 
%   acceleration data. Default is 'g's'. 
% y_lim_acc (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector specifying 
%   the y-axis limits for the acceleration plot. Automatically calculated
%   if not provided.
% str_title_disp1 (PARAMETER, PARAMETER) - Title for the displacement plot. 
%   Defaults to an empty string. 
% d_disp1 (PARAMETER, NUMERIC VECTOR) - Numeric vector of displacement data
%   to plot below the acceleration signal.
% str_disp1_lgnd (PARAMETER, PARAMETER) - Label for the displacement
% array..
%   Defaults to an empty string. 
% str_eu_disp (PARAMETER, CHARACTER) - String indicating the units for 
%   displacement data. Default is 'mils'. 
% y_lim_disp1 (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the displacement plot. Automatically
%   calculated if not provided.
% str_title_vert_load (PARAMETER, PARAMETER) - Title for the vertical load 
%   plot. Default is an empty string. 
% d_vert_load (PARAMETER, NUMERIC VECTOR) - Numeric vector of vertical load 
%   data. 
% str_vert_load_lgnd (PARAMETER, PARAMETER) - Label for the vertical load 
%   array. Defaults to 'Vertical load'. 
% y_lim_vert_load (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the vertical load plot. Automatically
%   calculated if not provided.
% str_title_disp2 (PARAMETER, PARAMETER) - Title for the last displacement
%   plot. Defaults to an empty string.
% d_disp2 (PARAMETER,NUMERIC VECTOR) - Second numeric vector of 
%   displacement data to plot below the vertical force curve.
% str_disp2_lgnd (PARAMETER, PARAMETER) - Label for the displacement array.. 
%   Defaults to an empty string. 
% y_lim_disp2 (PARAMETER, NUMERIC VECTOR) - 2-element numeric vector 
%   specifying the y-axis limits for the displacement plot. Automatically
%   calculated if not provided.
%
% OUTPUT
% h (HANDLE) - Handle to the plot created by the function
% d_theta (NUMERIC VECTOR) - Vector with crank angle values. It has the
%   same number of elements as ns_rev.
%
% B. Howard
% 4 Feb 2024
%
%
% 8 Feb 2024 - Revision
% For some crank-slider configurations no pressure curves exist (pure
% inertial loads). In that case the pressure arrays have all zero values.
% This revision accomodates that use case by detecting the all-zero values
% and removing the pressure plots from the figure.
% B. Howard
%
% 13 Feb 2024 - Revision
% Added the displacement pane to the plot
% B. Howard
%
% 3 Mar 2024 - Revision
% Added segmental acceleration plot
% B. Howard
%
% 6 May 2024 - Revision
% Added pressure legend labels; cleaned up the comments; allowed HE
% pressure to be parameter.
% B. Howard
%
% 8 June 2024 - Revision
% Corrected code to allow gas load to be plotted alone; added outer
% cylinder pressures.
% B. Howard
%
% 4 Aug 2024 - Revision
% Added option to return the crank angles
% B. Howard
%
% 3 Apr 2025 - Revision
% Refactored xlim values
% B. Howard
%
function [h_plot, d_theta] = PlotCrankAngle(ns_rev, d_press_ce, varargin)

% Instantiate the parser
p = inputParser;

% Validation rules
validScalarPosNum = @(x) assert(isnumeric(x) && isscalar(x) && (x > 0),...
    'Must be a positive scalar numeric quantity');
validNumericVector = @(x) assert( isempty(x) || ( isnumeric(x) && length(x) >= 2 ),...
    'Must be a numeric vector quantity');
validTitle = @(x) assert(ischar(x) || iscell(x),...
    'Must be a valid plot title');

% Define the inputs
addRequired(p, 'ns_rev', validScalarPosNum)
addRequired(p, 'd_press_ce', validNumericVector)
addParameter(p, 'd_press_he', [], validNumericVector)
% 6 May 2024 - Revision
addParameter(p, 'str_press_ce', 'CE', @ischar)
% 6 May 2024 - Revision
addParameter(p, 'str_press_he', 'HE', @ischar)

% 8 June 2024 - Revision
addParameter(p, 'd_press_ce2', [], validNumericVector)
addParameter(p, 'str_press_ce2', 'CE2', @ischar)
addParameter(p, 'd_press_he2', [], validNumericVector)
addParameter(p, 'str_press_he2', 'HE2', @ischar)
% end revision

addParameter(p, 'str_eu_press', 'psig', @ischar)
addParameter(p, 'str_press_ax_label', 'Pressure', @ischar)
addParameter(p, 'str_title_press', '', validTitle)
addParameter(p, 'str_title_press_interp', 'none', @ischar)
addParameter(p, 'y_lim_press', [], validNumericVector)
addParameter(p, 'str_title_load', '', validTitle)
addParameter(p, 'd_inertia_load', [], validNumericVector)
addParameter(p, 'str_eu_load', 'lbf', @ischar )
addParameter(p, 'd_gas_load', [], validNumericVector)
addParameter(p, 'd_combined_load', [], validNumericVector)
addParameter(p, 'y_lim_load', [], validNumericVector)
addParameter(p, 'str_font', 'Garamond', @ischar )
addParameter(p, 'str_title_acc', '', validTitle)
addParameter(p, 'd_accel1', [], validNumericVector)
addParameter(p, 'str_accel1', 'accel1', @ischar )
addParameter(p, 'd_accel2', [], validNumericVector)
addParameter(p, 'str_accel2', 'accel2', @ischar )
addParameter(p, 'str_eu_acc', 'g''s', @ischar )
addParameter(p, 'y_lim_acc', [], validNumericVector)

% 3 Mar 2024 - Revision
addParameter(p, 'str_title_seg', '', validTitle)
addParameter(p, 'd_seg1', [], validNumericVector)
addParameter(p, 'str_seg1', 'accel1', @ischar )
addParameter(p, 'd_seg2', [], validNumericVector)
addParameter(p, 'str_seg2', 'accel2', @ischar )
addParameter(p, 'str_eu_seg', 'g''s', @ischar )
addParameter(p, 'y_lim_seg', [], validNumericVector)
% end revision

% 13 Feb 2024 - Revision
addParameter(p, 'str_title_disp1', '', validTitle)
addParameter(p, 'd_disp1', [], validNumericVector)
addParameter(p, 'str_disp1_lgnd', '', validTitle)
addParameter(p, 'y_lim_disp1', [], validNumericVector)
addParameter(p, 'str_eu_disp', 'mils', @ischar )
addParameter(p, 'str_title_disp2', '', validTitle)
addParameter(p, 'd_disp2', [], validNumericVector)
addParameter(p, 'str_disp2_lgnd', '', validTitle)
addParameter(p, 'y_lim_disp2', [], validNumericVector)
% end revision
addParameter(p, 'str_title_vert_load', '', validTitle)
addParameter(p, 'd_vert_load', [], validNumericVector)
addParameter(p, 'str_vert_load_lgnd', 'Vertical load', validTitle)
addParameter(p, 'y_lim_vert_load', [], validNumericVector)

% Parse the inputs
parse(p, ns_rev, d_press_ce, varargin{:});

% Bring the inputs into the function
ns_rev = p.Results.ns_rev;
d_press_ce = p.Results.d_press_ce;
% 6 May 2024 - Revision
str_press_ce = p.Results.str_press_ce;
d_press_he = p.Results.d_press_he;
% 6 May 2024 - Revision
str_press_he = p.Results.str_press_he;

% 8 June 2024 - Revision
d_press_ce2 = p.Results.d_press_ce2;
str_press_ce2 = p.Results.str_press_ce2;
d_press_he2 = p.Results.d_press_he2;
str_press_he2 = p.Results.str_press_he2;
% end revision

str_eu_press = p.Results.str_eu_press;
str_press_ax_label = p.Results.str_press_ax_label;
str_title_press = p.Results.str_title_press;
% 6 May 2024 - Revision
str_title_press_interp = p.Results.str_title_press_interp;
y_lim_press = p.Results.y_lim_press;
str_title_load = p.Results.str_title_load;
d_inertia_load = p.Results.d_inertia_load;
str_eu_load = p.Results.str_eu_load;
d_gas_load = p.Results.d_gas_load;
d_combined_load = p.Results.d_combined_load;
y_lim_load = p.Results.y_lim_load;
str_font = p.Results.str_font;
str_title_acc = p.Results.str_title_acc;
d_accel1 = p.Results.d_accel1;    
str_accel1 = p.Results.str_accel1;
d_accel2 = p.Results.d_accel2;    
str_accel2 = p.Results.str_accel2;
str_eu_acc = p.Results.str_eu_acc;
y_lim_acc = p.Results.y_lim_acc;

% 3 Mar 2024 - Revision
str_title_seg = p.Results.str_title_seg;
d_seg1 = p.Results.d_seg1;    
str_seg1 = p.Results.str_seg1;
d_seg2 = p.Results.d_seg2;    
str_seg2 = p.Results.str_seg2;
str_eu_seg = p.Results.str_eu_seg;
y_lim_seg = p.Results.y_lim_seg;
% end revision

% 13 Feb 2024 - Revision
str_title_disp1 = p.Results.str_title_disp1;
d_disp1 = p.Results.d_disp1;
str_disp1_lgnd = p.Results.str_disp1_lgnd;
y_lim_disp1 = p.Results.y_lim_disp1;
str_eu_disp = p.Results.str_eu_disp;
str_title_disp2 = p.Results.str_title_disp2;
d_disp2 = p.Results.d_disp2;
str_disp2_lgnd = p.Results.str_disp2_lgnd;
y_lim_disp2 = p.Results.y_lim_disp2;
% end revision
str_title_vert_load = p.Results.str_title_vert_load;
d_vert_load = p.Results.d_vert_load;
str_vert_load_lgnd = p.Results.str_vert_load_lgnd;
y_lim_vert_load = p.Results.y_lim_vert_load;

% Process the inputs
d_press_ce = d_press_ce(:);
d_press_he = d_press_he(:);
b_press_he = false;
if ~isempty(d_press_he)
    b_press_he = true;
end
if b_press_he
    assert(length(d_press_he)==length(d_press_ce),...
        'Pressure curves must have the same number of samples')
end

% 3 Apr 2025 - Revision
% Set internal defaults
x_lim_defaults = [-5 365];

% 8 June 2024 - Revision
d_press_ce2 = d_press_ce2(:);
b_press_ce2 = false;
if ~isempty(d_press_ce2)
    b_press_ce2 = true;
end
if b_press_ce2
    assert(length(d_press_ce2)==length(d_press_ce),...
        'CE2 pressure curve must have the same number of samples as CE')
end
d_press_he2 = d_press_he2(:);
b_press_he2 = false;
if ~isempty(d_press_he2)
    b_press_he2 = true;
end
if b_press_he2
    assert(length(d_press_he2)==length(d_press_ce),...
        'HE2 pressure curve must have the same number of samples as CE')
end
% end revision

if isempty(y_lim_press)

    % 8 June 2024 - Revision
    % MATLAB handles empty vectors gracefully so no need to branch.
    d_max_press = max([max(d_press_ce) max(d_press_he)...
        max(d_press_ce2) max(d_press_he2)]);
    d_min_press = min([min(d_press_ce) min(d_press_he)...
        min(d_press_ce2) min(d_press_he2)]);
    % end revision

    y_lim_press = [d_min_press d_max_press];

end
% 8 Feb 2024 - Revision
b_press = true;
if ( ( abs( sum( d_press_ce ) ) < 1e-6 ) )
    b_press = false;
end
d_inertia_load = d_inertia_load(:);
d_gas_load = d_gas_load(:);
d_combined_load = d_combined_load(:);
b_inertia = false;
if length(d_inertia_load) > 2 
    b_inertia = true;
end
b_gas = false;
% 8 June 2024 - Revision
if ( length(d_gas_load) > 2 )
    b_gas = true;
end
% Added validation that inertia load exists
if ( length(d_gas_load) > 2 ) && b_inertia
    assert(length(d_inertia_load)==length(d_gas_load),...
        'Inertia and gas loads must have the same number of samples')
end
b_comb = false;
if length(d_combined_load) > 2 
    assert(length(d_inertia_load)==length(d_combined_load),...
        'Inertia and combined loads must have the same number of samples')
    b_comb = true;
end
if isempty(y_lim_load)
    d_max_load = max([max(d_inertia_load) max(d_gas_load) ...
        max(d_combined_load)]);
    d_min_load = min([min(d_inertia_load) min(d_gas_load) ...
        min(d_combined_load)]);
    y_lim_load = [d_min_load d_max_load];

    % In case no loads were passed in
    if isempty(y_lim_load)
        y_lim_load = [-1 1];
    end
end

% 3 Mar 2024 - Revision
b_seg1 = false;
d_seg1 = d_seg1(:);
if length(d_seg1) > 2 
    b_seg1 = true;
end
b_seg2 = false;
d_seg2 = d_seg2(:);
if length(d_seg2) > 2 
    assert(length(d_seg1)==length(d_seg2),...
        'seg1 and seg2 must have the same number of samples')
    b_seg2 = true;
end
if isempty(y_lim_seg)
    d_max_seg = max([max(d_seg1) max(d_seg2)]);
    d_min_seg = min([min(d_seg1) min(d_seg2)]);
    y_lim_seg = [0 max([ abs(d_min_seg)  abs(d_max_seg) ])];

    % In case no segmental limits were passed in
    if ( isempty(y_lim_seg) ) || ( isscalar(y_lim_seg) )
        y_lim_seg = [-1 1];
    end

    % Added to avoid limits with all zeros (Limits must be a 2-element
    % vector of increasing numeric values.)
    if abs( y_lim_seg(2) - y_lim_seg(1) ) < 1e-9
        y_lim_seg = [0 1];
    end

end
% end revision

b_accel1 = false;
d_accel1 = d_accel1(:);
if length(d_accel1) > 2 
    b_accel1 = true;
end
b_accel2 = false;
d_accel2 = d_accel2(:);
if length(d_accel2) > 2 
    assert(length(d_accel1)==length(d_accel2),...
        'accel1 and accel2 must have the same number of samples')
    b_accel2 = true;
end
if isempty(y_lim_acc)
    d_max_acc = max([max(d_accel1) max(d_accel2)]);
    d_min_acc = min([min(d_accel1) min(d_accel2)]);
    y_lim_acc = [d_min_acc d_max_acc];
    % In case no accel limites were passed in
    if isempty(y_lim_acc)
        y_lim_acc = [-1 1];
    end

    % Added to avoid limits with all zeros (Limits must be a 2-element
    % vector of increasing numeric values.)
    if abs( y_lim_acc(2) - y_lim_acc(1) ) < 1e-9
        y_lim_acc = [0 1];
    end

end

% 13 Feb 2024 - Revision
% Added the displacement curve under the acceleration curve
b_disp1 = false;
d_disp1 = d_disp1(:);
if length(d_disp1) > 2 
    b_disp1 = true;
end
if isempty(y_lim_disp1)
    d_max_disp = max([max(d_disp1) max(d_disp1)]);
    d_min_disp = min([min(d_disp1) min(d_disp1)]);
    y_lim_disp1 = [d_min_disp d_max_disp];

    % In case no displacement curves were passed in
    if isempty(y_lim_disp1)
        y_lim_disp1 = [-1 1];
    end
end

% Added the displacement curve under the vertical load curve
b_disp2 = false;
d_disp2 = d_disp2(:);
if length(d_disp2) > 2 
    b_disp2 = true;
end

if isempty(y_lim_disp2)
    d_max_disp = max([max(d_disp2) max(d_disp2)]);
    d_min_disp = min([min(d_disp2) min(d_disp2)]);
    y_lim_disp2 = [d_min_disp d_max_disp];

    % In case no displacement curves were passed in
    if isempty(y_lim_disp2)
        y_lim_disp2 = [-1 1];
    end
end
% end revision

b_vert_load = false;
d_vert_load = d_vert_load(:);
if length(d_vert_load) > 2 
    b_vert_load = true;
end
if isempty(y_lim_vert_load)
    d_max_vert_load = max([max(d_vert_load) max(d_vert_load)]);
    d_min_vert_load = min([min(d_vert_load) min(d_vert_load)]);
    y_lim_vert_load = [d_min_vert_load d_max_vert_load];

    % In case no vertical loads were passed in
    if isempty(y_lim_vert_load)
        y_lim_vert_load = [-1 1];
    end
end

% Set the plot up to match RobotSquirrel appearance
set(groot,'defaultAxesFontName',str_font)

% Create the default titles
if length(str_title_press) < 2 
    str_title_press = 'Reciprocating machine signals vs. crank angle';
end
if length(str_title_load) < 2
    str_title_load = 'Reciprocating machine loads vs. crank angle';
end
if length(str_title_seg) < 2
    str_title_seg = 'Reciprocating machine acceleration vs. crank angle';
end
if length(str_title_vert_load) < 2
    str_title_vert_load = 'Reciprocating machine vertical loads vs. crank angle';
end
if length(str_title_disp1) < 2
    str_title_disp1 = 'Reciprocating machine displacement vs. crank angle';
end
if length(str_title_vert_load) < 2
    str_title_vert_load = 'Reciprocating machine vertical loads vs. crank angle';
end
if length(str_title_disp2) < 2
    str_title_disp2 = 'Reciprocating machine displacement vs. crank angle';
end

% Configure the plot panes, depending on what arrays have been included
ns_plots = 0;
% 8 Feb 2024 - Revision
% Added the pressure plot boolean
if ( b_press )
    ns_plots = ( ns_plots + 1 );
end
if ( b_inertia || b_gas || b_comb)
    ns_plots = ns_plots + 1;
end
% 3 Mar 2024 - Revision
if ( b_seg1 || b_seg2)
    ns_plots = ns_plots + 1;
end
% end revision
if ( b_accel1 || b_accel2)
    ns_plots = ns_plots + 1;
end
if ( b_disp1 )
    ns_plots = ns_plots + 1;
end
if (b_vert_load)
    ns_plots = ns_plots + 1;
end
if ( b_disp2 )
    ns_plots = ns_plots + 1;
end

% 8 Feb 2024 - Revision
% The possibility exists that nothing has been passed in for plotting so
% catch it here.
assert( ns_plots > 0, 'Nothing to plot (all inputs zero or empty)')

% Create the figure
str_fig_title = str_title_press;
if iscell(str_title_press)
    str_fig_title = str_title_press{1};
end
h_plot = figure('Name',str_fig_title,'position',[1 1 800 600]);
tiledlayout("vertical")

% Create the crank angle values and store them in d_theta
d_theta = (0:(ns_rev-1)).*(360.0/ns_rev);

% Initialize the pane index
idx_pane = 1;

% 6 May 2024 - Revision
% Create the pressure legend cell list (was fixed as 'CE' and 'HE')
i_press_cl = 1;
if b_press_he
    i_press_cl = ( i_press_cl + 1 );
end
cl_press = cell(i_press_cl,1);


% The top plot has the internal cylinder pressure curves
% 8 Feb 2024 - Revision
% Added check for boolean to display the pressure curves
if b_press

    nexttile;
    idx_pane = ( idx_pane + 1 );
    plot(d_theta, d_press_ce, 'Color', "#2c5a9a", 'Linewidth', 1.0);
    % 6 May 2024 - Revision
    idx_press_leg = 1;
    cl_press{idx_press_leg} = str_press_ce;
    idx_press_leg = ( idx_press_leg + 1 );
    hold on
    grid on
    % 6 May 2024 - Revision
    % Only plot the HE pressure curve if it exists
    if b_press_he
        plot(d_theta, d_press_he, 'Color', "#e13c30", 'Linewidth', 1.0);
        cl_press{idx_press_leg} = str_press_he;
        idx_press_leg = ( idx_press_leg + 1 );
    end
    
    % 8 Jun 2024 - Revision
    % Plot the outer cylinder CE pressure curve
    if b_press_ce2
        plot(d_theta, d_press_ce2, 'Color', "#5f9344", 'Linewidth', 1.0);
        cl_press{idx_press_leg} = str_press_ce2;
        idx_press_leg = ( idx_press_leg + 1 );
    end
    if b_press_he2
        plot(d_theta, d_press_he2, 'color', '#FFA500', 'Linewidth', 1.0);
        cl_press{idx_press_leg} = str_press_he2;
        idx_press_leg = ( idx_press_leg + 1 );
    end
    % end revison

    % 6 May 2024 - Revision - added the interperter parameter
    title(str_title_press, ' ', 'Interpreter', str_title_press_interp)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylim(y_lim_press)
    ylabel([str_press_ax_label, ', ', str_eu_press]);
    legend(cl_press, 'location','best')
    
    % Annotate the plot with locations of the piston
    d_label_y = 1.015;
    text(0, d_label_y, 'TDC', 'HorizontalAlignment','center', ...
        'FontName',str_font, 'Units','normalized' )
    text(0.5, d_label_y, 'BDC', 'HorizontalAlignment','center', ...
        'FontName',str_font, 'Units','normalized' )
end

% Did the inputs include load arrays that need to be plotted?
if ( b_inertia || b_gas || b_comb)

    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on
    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if length(d_inertia_load) > 2
        plot(d_theta, d_inertia_load/1000, 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = 'Inertia load';
        cl_idx = cl_idx + 1;
    end
    if length(d_gas_load) > 2
        plot(d_theta, d_gas_load/1000, 'Color', "#2c5a9a", 'Linewidth', 1.0);
        b_legend = true;
        cl_legend{cl_idx} = 'Gas load';
        cl_idx = cl_idx + 1;
    end
    if length(d_combined_load) > 2
        plot(d_theta, d_combined_load/1000, 'Color', "#5f9344", 'Linewidth', 1.0);
        b_legend = true;
        cl_legend{cl_idx} = 'Combined load';
    end
    title(str_title_load)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Force, k' str_eu_load]);
    ylim(y_lim_load./1000)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end    

% 13 Feb 2024 - Revision
% Did the inputs include displacment array that need to be plotted under
% the acceleration curve?
if ( b_disp1)
    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on
    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if length(d_disp1) > 2
        plot(d_theta, d_disp1, 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_disp1_lgnd;
        cl_idx = cl_idx + 1;
    end
    title(str_title_disp1)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Disp., ' str_eu_disp]);
    ylim(y_lim_disp1)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end    

% Did the inputs include vertical load arrays that need to be plotted?
if ( b_vert_load)
    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on
    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if length(d_vert_load) > 2
        plot(d_theta, d_vert_load/1000, 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_vert_load_lgnd;
        cl_idx = cl_idx + 1;
    end
    title(str_title_vert_load)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Force, k' str_eu_load]);
    ylim(y_lim_vert_load./1000)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end   

% 13 Feb 2024 - Revision
% Did the inputs include displacment array that need to be plotted under
% the vertical laod curve?
if ( b_disp2 )
    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on
    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if length(d_disp2) > 2
        plot(d_theta, d_disp2, 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_disp2_lgnd;
        cl_idx = cl_idx + 1;
    end
    title(str_title_disp2)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Disp., ' str_eu_disp]);
    ylim(y_lim_disp2)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end    
% 3 Mar 2024 - Revision
% Plot the acceleration segmental bands out?
if ( b_seg1 || b_seg2 )

    % Divide the rotation into 36 segments, calculate the maximum value in
    % each one.
    n_bands = 36;
    ns_band = ns_rev / n_bands;
    d_band_pk1 = zeros(n_bands, 1);
    d_seg_band1 = ones(size(d_seg1));
    d_band_pk2 = zeros(n_bands, 1);
    d_seg_band2 = ones(size(d_seg2));
    idx_start = 1;
    for idx = 1:n_bands
        
        % Calculate the ending index for the band
        idx_end = round(idx * ns_band);

        % Extract the maximum value
        if b_seg1
            d_band_pk1(idx) = ( ( max( d_seg1(idx_start:idx_end) ) -...
                min( d_seg1(idx_start:idx_end) ) ) / 2.0 );
            d_seg_band1(idx_start:idx_end) =...
                ( d_seg_band1(idx_start:idx_end) * d_band_pk1(idx) );
        end
        if b_seg2
            d_band_pk2(idx) = ( ( max( d_seg2(idx_start:idx_end) ) -...
                min( d_seg2(idx_start:idx_end) ) ) / 2.0 );
            d_seg_band2(idx_start:idx_end) =...
                ( d_seg_band2(idx_start:idx_end) * d_band_pk2(idx) );
        end

        % Move the start index
        idx_start = ( idx_end + 1 );
    end

    % bring up the plotting pant
    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on

    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if b_seg1

        stairs([0 0], [0 0], 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_seg1;
        cl_idx = cl_idx + 1;

        %  Add the band bars
        idx_start = 1;
        for idx = 1:n_bands

            % Calculate the ending index for the band
            idx_end = round(idx * ns_band);
            
            % Draw the rectangle
            d_w = ( d_theta(idx_end) - d_theta(idx_start) );
            rectangle('Position',...
                [d_theta(idx_start) 0 d_w d_band_pk1(idx)],...
                'FaceColor', '#e13c30',...
                'EdgeColor','k',...
                'LineWidth',1)
            
            % Move the start index
            idx_start = ( idx_end + 0 );
        
        end


    end
    if b_seg2
        stairs([0 0], [0 0], 'Color', "#2c5a9a", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_seg2;
        cl_idx = cl_idx + 1;

        %  Add the band bars
        idx_start = 1;
        for idx = 1:n_bands

            % Calculate the ending index for the band
            idx_end = round(idx * ns_band);
            
            % Draw the rectangle
            d_w = ( d_theta(idx_end) - d_theta(idx_start) );
            rectangle('Position',...
                [d_theta(idx_start) 0 d_w d_band_pk2(idx)],...
                'FaceColor', '#2c5a9a',...
                'EdgeColor','k',...
                'LineWidth',1)
            
            % Move the start index
            idx_start = ( idx_end + 0 );
        
        end

    
    end
    title(str_title_seg)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults)
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Acceleration, ' str_eu_seg]);
    ylim(y_lim_seg)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end 
% End revision

% Did the inputs include acceleration arrays that need to be plotted?
if ( b_accel1 || b_accel2)

    nexttile;
    idx_pane = ( idx_pane + 1 );
    hold on
    grid on
    cl_legend = cell(3,1);
    cl_idx = 1;
    b_legend = false;
    if b_accel1
        plot(d_theta, d_accel1, 'Color', "#e13c30", 'Linewidth',1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_accel1;
        cl_idx = cl_idx + 1;
    end
    if b_accel2
        plot(d_theta, d_accel2, 'Color', "#2c5a9a", 'Linewidth', 1.0);
        b_legend = true;
        cl_legend{cl_idx} = str_accel2;
        cl_idx = cl_idx + 1;
    end
    title(str_title_acc)
    % 3 Apr 2025 - Revision
    xlim( x_lim_defaults )
    set(gca,'XTick', 0:30:360);
    % Skip this label if more panes follow
    if ns_plots < idx_pane
        xlabel('Crank Angle, Degrees')
    end
    ylabel(['Acceleration, ' str_eu_acc]);
    ylim(y_lim_acc)
    if b_legend
        %# find empty cells
        emptyCells = cellfun(@isempty,cl_legend);
        %# remove empty cells
        cl_legend(emptyCells) = [];
        legend(cl_legend, 'Location', 'Best')
    end
end    

return