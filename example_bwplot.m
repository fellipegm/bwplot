%% bmplot examples
% careful, it will erase all variables
clear vars
close all
clc

% initialize some data for the example
t = linspace(0, 4*pi, 1000);
y_1 = sin(t);
y_2 = sin(t) + randn(size(t))*0.1;
y_3 = cos(t) + randn(size(t))*0.1;
y_4 = sin(t).^2 + randn(size(t))*0.05;


% one variable (always plot as vector)
bwplot(t', y_1', ...
       15, 7, ...
       'Time (s)', '$y_1(t)$')

% two variables
bwplot([t' t'], [y_1' y_2'], ...
       15, 7, ...
       'Time (s)', '$y_1(t)$', ...
       {'$y_1(t)$', '$y_2(t)$'})

% two variables with big numbers
bwplot([t' t'].*5e3, [y_1' y_2'].*1e5, ...
       15, 7, ...
       'Time (s)', '$y_n(t)$', ...
       {'$y_1(t)$', '$y_2(t)$'})

% tree variables with no legend
bwplot([t' t' t'], [y_1' y_2' y_3'], ...
       15, 7, ...
       'Time (s)', '$y_n(t)$')
   
% four variables with legend control and different size
bwplot([t' t' t' t'], [y_1' y_2' y_3' y_4'], ...
       16, 10, ...
       'Time (s)', '$y_n(t)$', ...
       {'$y_1(t)$', '$y_2(t)$', '$y_3(t)$', '$y_4(t)$'}, 'SouthEast')

% four variables with negative values only
bwplot(abs([t' t' t' t'])*-1, abs([y_1' y_2' y_3' y_4'])*-1, ...
       16, 10, ...
       'Time (s)', '$y_n(t)$', ...
       {'$y_1(t)$', '$y_2(t)$', '$y_3(t)$', '$y_4(t)$'})

% four variables with positive values only and different size
bwplot(abs([t' t' t' t']), abs([y_1' y_2' y_3' y_4']), ...
       15, 12, ...
       'Time (s)', '$y_n(t)$', ...
       {'$y_1(t)$', '$y_2(t)$', '$y_3(t)$', '$y_4(t)$'})
% export_fig teste.eps
