%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ABOUT
% This test harness excercises the crank angle domain visualization
% function features. It relies on interpretation of graphical images by the
% developer to determine success. 
%
% DEVELOPMENT NOTES
% This file has been structured to run in MATLAB's unit test environment:
%   runtests PlotCrankAngle_TestHarness
%
% Last run: 17 May 2025
% Totals:
%    16 Passed, 0 Failed, 0 Incomplete.
%    24.9189 seconds testing time.
% 
% The MATLAB test environment requires each section of code inside the main
% comment header to run independently. For this reason, some code pieces
% repeat.

%%
% Save off the script name and reset the workspace
str_script = mfilename;

clearvars
close all
clc

%%
% Test 1 - create a basic plot
idx_test = 1;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)
[h_plot, d_theta] = PlotCrankAngle(ns_rev, d_press_ce );

% Check results
assert( length(d_theta) == ns_rev,...
    [str_test_title ' failed to return correct number of elements in d_theta'])
assert( abs( d_theta(1) ) < 1e-15,...
    [str_test_title ' failed to calculate first element in d_theta'])
assert( abs( d_theta(end) - 359.5 ) < 1e-15,...
    [str_test_title ' failed to calculate last element in d_theta'])

% Output the plot
set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])

%%
% Test 2 - create a basic plot with the inertia loads
close all
idx_test = 2;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize an inertia load curve, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);

% Force replacement of engineering unit description
str_eu_load = 'smurfs';
str_font = 'algerian';
str_title_press = 'No_interp_on_this_title';
str_press_ax_label = 'What label?';

% Create the plot
str_press_ce = 'CE-101';
str_press_he = 'HE-202';
h_plot = PlotCrankAngle(ns_rev, d_press_ce,...
    'str_press_ce', str_press_ce,...
    'd_press_he',d_press_he,...
    'str_press_he', str_press_he,...
    'str_eu_press', str_eu_press,...
    'd_press_ce2', ( d_press_ce * 0.9),...
    'd_press_he2', ( d_press_he * 0.9),...
    'str_title_press', str_title_press,...
    'str_press_ax_label', str_press_ax_label,...
    'd_inertia_load', d_inertia_load, 'str_eu_load', str_eu_load, ...
    'str_font', str_font);


set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])


%%
% Test 3 - create a basic plot with all the loads
close all
idx_test = 3;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])

%%
% Test 4 - create a basic plot with all the acceleration signals
close all
idx_test = 4;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the acceleration curves
d_accel1 = sin( 100 * pi .* t/t(end));
d_accel2 = sin( 120 * pi .* t/t(end));

% Create the plot
str_title_press = {'My great', 'title'};
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'str_title_press', str_title_press, ...
    'd_accel1', d_accel1, 'd_accel2', d_accel2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])


%%
% Test 5 - create a basic plot with all the rod loads and acceleration
close all
idx_test = 5;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the acceleration curves
d_accel1 = sin( 100 * pi .* t/t(end));
d_accel2 = sin( 120 * pi .* t/t(end));

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
     'd_accel1', d_accel1, 'd_accel2', d_accel2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

close all
disp ([str_test_title ' complete.'])

%%
% Test 6 - create a basic plot with all the loads
idx_test = 6;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the vertical force
d_vert_load = abs(1000 *sin(pi .* t/t(end)));

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_vert_load', d_vert_load);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

close all
disp ([str_test_title ' complete.'])


%%
% Test 7 - Passing both pressure waveforms in as zero vectors caused the
% funtion to crash. This section validates the fix.
idx_test = 7;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

d_press_he = zeros(size(d_press_he));
d_press_ce = zeros(size(d_press_ce));

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the vertical force
d_vert_load = abs(1000 *sin(pi .* t/t(end)));

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_vert_load', d_vert_load);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

close all
disp ([str_test_title ' complete.'])

%%
% Test 8 - create a basic plot with all the loads and displacement with
% default labels.
idx_test = 8;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the vertical force
d_vert_load = abs(1000 *sin(pi .* t/t(end)));

% Synthesize the  displacement
d_disp1 = chirp(pi .* t/t(end));
d_disp2 = -chirp(pi .* t/t(end));

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_vert_load', d_vert_load, 'd_disp1', d_disp1,...
    'd_disp2', d_disp2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

%close all
disp ([str_test_title ' complete.'])

%%
% Test 9 - create a basic plot with all the loads and displacement with
% custom labels.
idx_test = 9;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the vertical force
d_vert_load = abs(1000 *sin(pi .* t/t(end)));

% Synthesize the  displacement
str_title_disp1 = 'My Great Title 1';
d_disp1 = chirp(pi .* t/t(end));
str_disp1_lgnd = 'Great Legend 1';
y_lim_disp1 = [-2 4];
str_title_disp2 = 'My Great Title 2';
d_disp2 = -chirp(pi .* t/t(end));
str_disp2_lgnd = 'Great Legend 2';
y_lim_disp2 = [-1 2];

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_vert_load', d_vert_load,...
    'd_disp1', d_disp1, 'str_disp1_lgnd', str_disp1_lgnd, ...
    'str_title_disp1', str_title_disp1, 'y_lim_disp1', y_lim_disp1, ...
    'd_disp2', d_disp2, 'str_disp2_lgnd', str_disp2_lgnd, ...
    'str_title_disp2', str_title_disp2, 'y_lim_disp2', y_lim_disp2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

close all
disp ([str_test_title ' complete.'])

%%
% Test 10 - create a basic plot with all the loads and one displacement
% curve. 
idx_test = 10;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the vertical force
d_vert_load = abs(1000 *sin(pi .* t/t(end)));

% Synthesize the  displacement
str_title_disp1 = 'My Great Title';
d_disp1 = chirp(pi .* t/t(end));
str_disp1_lgnd = 'Great Legend 1';
y_lim_disp1 = [-1 2];
str_title_disp2 = 'My Second Great Title';
d_disp2 = [];
str_disp2_lgnd = 'Great Legend 2';
y_lim_disp2 = [-1 2];
str_vert_load_lgnd = 'Great Vert';

% Create the plot
str_press_ce2 = 'KB-101';
str_press_he2 = 'KB-102';
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_press_ce2', ( d_press_ce * 0.9),...
    'str_press_ce2', str_press_ce2,...
    'str_press_he2', str_press_he2,...
    'd_press_he2', ( d_press_he * 0.9),...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_vert_load', d_vert_load, 'd_disp1', d_disp1,...
    'str_vert_load_lgnd', str_vert_load_lgnd,...
    'd_disp1', d_disp1, 'str_disp1_lgnd', str_disp1_lgnd, ...
    'str_title_disp1', str_title_disp1, 'y_lim_disp1', y_lim_disp1, ...
    'd_disp2', d_disp2, 'str_disp2_lgnd', str_disp2_lgnd, ...
    'str_title_disp2', str_title_disp2, 'y_lim_disp2', y_lim_disp2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

close all
disp ([str_test_title ' complete.'])

%%
% Test 11 - create a segmental plot with all the rod loads and acceleration
idx_test = 11;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the acceleration curves
d_accel1 = sin( 100 * pi .* t/t(end));
d_accel1(25:49) = d_accel1(25:49) +...
    ( hann(25) .* sin( 200 * pi .* t(25:49)/t(end)) );
d_accel1(125:149) = d_accel1(125:149) +...
    ( 1.5 * hann(25) .* sin( 200 * pi .* t(125:149)/t(end)) );
d_accel2 = sin( 120 * pi .* t/t(end));
d_accel2(225:249) = d_accel2(225:249) +...
    ( hann(25) .* sin( 240 * pi .* t(225:249)/t(end)) );

d_seg1 = d_accel1;
d_seg2 = d_accel2;
y_lim_seg = [0 2];

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_seg1', d_seg1, 'd_seg2', d_seg2, 'y_lim_seg', y_lim_seg,...
    'd_accel1', d_accel1, 'd_accel2', d_accel2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

% close all
disp ([str_test_title ' complete.'])

%%
% Test 12 - create a segmental plot with all the rod loads and acceleration
% with zero values. This condition caused the code to crash. This section
% verified it has been fixed.
idx_test = 12;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the acceleration curves
d_accel1 = zeros(size(t));
d_accel2 = zeros(size(t));
d_seg1 = d_accel1;
d_seg2 = d_accel2;

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_seg1', d_seg1, 'd_seg2', d_seg2,...
    'd_accel1', d_accel1, 'd_accel2', d_accel2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])

%%
% Test 13 - create a segmental plot with all the rod loads and acceleration
% with negative values. This condition caused the code to crash. This section
% verified it has been fixed.
close all
idx_test = 13;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );

% Synthesize the acceleration curves
d_accel1 = -1 * ones(size(t));
d_accel2 = -1 * ones(size(t));
d_seg1 = d_accel1;
d_seg2 = d_accel2;

% Create the plot
h_plot = PlotCrankAngle(ns_rev, d_press_ce, 'd_press_he',d_press_he,...
    'str_eu_press', str_eu_press,...
    'd_inertia_load', d_inertia_load, ...
    'd_gas_load', d_gas_load, 'd_combined_load', d_combined_load,...
    'd_seg1', d_seg1, 'd_seg2', d_seg2,...
    'd_accel1', d_accel1, 'd_accel2', d_accel2);

set(h_plot, 'Units', 'inches')
set(h_plot, 'Position', [0 0 9 6])
set(h_plot, 'PaperSize', [11 8.5])
exportgraphics(h_plot, ['Test' num2str(idx_test, '%02.0f') '.pdf'], ...
    'ContentType', 'vector')

disp ([str_test_title ' complete.'])

%%
% Test 14 - create a basic plot with only gas load. This caused the
% function to throw and error and this test verifies it was fixed.
idx_test = 14;
str_test_title = ['Test ' num2str(idx_test, '%02.0f')];

% Define dataset location
str_dataset_dir = 'H:\Datasets\Recip Misc\';

% Read in the data
str_sample = [str_dataset_dir 'sample001.mat'];
load(str_sample)

% Synthesize the load curves, scaled in klbf
d_inertia_load = 1000 *sin(pi .* t/t(end));
d_inertia_load = d_inertia_load - mean(d_inertia_load);
d_gas_load = -2000 *sin(pi .* t/t(end));
d_gas_load = d_gas_load - mean(d_gas_load);
d_combined_load = ( d_inertia_load + d_gas_load );


% Create the plot
str_press_ce = 'CE-101';
str_press_he = 'HE-202';
str_press_ax_label = 'bar(g)';
str_font = 'Arial';
h_plot = PlotCrankAngle(ns_rev, d_press_ce*0.06894757,...
    'str_press_ce', str_press_ce,...
    'd_press_he',d_press_he*0.06894757,...
    'str_press_he', str_press_he,...
    'str_eu_press', str_eu_press,...
    'str_press_ax_label', str_press_ax_label,...
    'str_font', str_font,...
    'd_gas_load', d_gas_load);

disp ([str_test_title ' complete.'])


%%
% Housekeeping and closeout
close all
disp('All tests completed successfully')

