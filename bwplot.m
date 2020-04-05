function bwplot(x, y, size_x, size_y, label_x, label_y, legends, location, opt)
% usual sizes: 15x4, 15x5, 15x7.5 e 7x7 (cm)

std_opt.no_marker = false;
std_opt.no_dash = false;
std_opt.linewidth = 1.5;
std_opt.fontsize = 10;

if nargin < 7
    legends = [];
    location = [];
    opt = std_opt;
elseif nargin < 8
    location = [];
    opt = std_opt;
elseif nargin < 9
    opt = std_opt;
else
    if not(isfield(opt, 'no_marker'))
        opt.no_marker = std_opt.no_marker;
    end
    if not(isfield(opt, 'no_dash'))
        opt.no_dash = std_opt.no_dash;
    end
    if not(isfield(opt, 'linewidth'))
        opt.linewidth = std_opt.linewidth;
    end
    if not(isfield(opt, 'fontsize'))
        opt.fontsize = std_opt.fontsize;
    end
end
if isempty(location)
    location = 'Best';
end

% create figure with the desired size
figure('Units'             , 'centimeters', ...
       'PaperUnits'        , 'centimeters', ...
       'Position'          , [2 5 size_x size_y],...
       'PaperPositionMode' , 'auto');
set(gcf, 'Color', 'w')

s_x = length(x);

% plot configuration
line_color = [0 0 0; 0.5 0.5 0.5; 0.7 0.7 0.7; 0.75 0.75 0.75; ...
    0.5 0.5 0.5; 0.5 0.5 0.5; 0.5 0.5 0.5];


marker_type = {'none', 's', 'o', 'p', 'd', '*', 'h'};
n_mk = [1, 11, 7, 19, 5, 3, 17];
m_size = [1, 70, 70, 100, 70, 70, 70];
m_size_l = [1, 8, 8, 10, 8, 8, 8];
line_style = {'-', '--', '-.', ':', ':', ':', ':'};
line_width = opt.linewidth;

if opt.no_marker
    marker_type = {'none', 'none', 'none', 'none', 'none', 'none', 'none'};
    n_mk = [1, 1, 1, 1, 1, 1, 1];
    m_size = [1, 1, 1, 1, 1, 1, 1];
    m_size_l = [1, 1, 1, 1, 1, 1, 1];
end
if opt.no_dash
    line_style = {'-', '-', '-', '-', '-', '-', '-'};
end

for i = 1:s_x
    cfg = rem(length(line_color)-1+i, length(line_color)) + 1;
    plot_line = line(x{i}, y{i});
    set(plot_line, 'LineWidth', line_width, ...
        'Color', line_color(cfg, :), ...
        'LineStyle', line_style{cfg});
    hold on
    % plot markers
    line_m = scatter(x{i}(int64(1+end/n_mk(cfg)):int64(end/n_mk(cfg)):end), ...  
                    y{i}(int64(1+end/n_mk(cfg)):int64(end/n_mk(cfg)):end), m_size(cfg));
    set(line_m, 'MarkerEdgeColor', line_color(cfg, :), ...
                 'MarkerFaceColor', [1, 1, 1], ...
                 'Marker', marker_type{cfg}, ...
                 'LineWidth', line_width);
    % plot for legend
    line_l(i) = line(x{i}(1), y{i}(1));
    set(line_l(i), 'LineWidth', line_width, ...
                   'Color', line_color(cfg, :), ...
                   'LineStyle', line_style{cfg}, ...
                   'MarkerEdgeColor', line_color(cfg, :), ...
                   'MarkerFaceColor', [1, 1, 1], ...
                   'Marker', marker_type{cfg}, ...
                   'MarkerSize', m_size_l(cfg));
end

xmin = 1e20;
xmax = -1e20;
ymin = 1e20;
ymax = -1e20;
for i = 1:length(x)
    xmin = min(min(xmin, x{i}));
    xmax = max(max(xmax, x{i}));
    ymin = min(min(ymin, y{i}));
    ymax = max(max(ymax, y{i}));
end

% setup the plot style
y_extra = 0.03;
if ymin <= 0 && ymax <= 0
    ylims = [ymin*(1+y_extra) ymax*(1-y_extra)];
elseif ymin <= 0 && ymax >= 0
    ylims = [ymin*(1+y_extra) ymax*(1+y_extra)];
else
    ylims = [ymin*(1-y_extra) ymax*(1+y_extra)];
end

if ylims(1) == 0 && ylims(2) == 0
    ylims(1) = -1;
    ylims(2) = 1;
end

xlim([xmin xmax])
ylim(ylims)

fontsize = opt.fontsize;
set(gca,...
    'Box'           , 'off'     , ...
    'TickDir'       , 'out'     , ...
    'TickLength'    , [.02 .02] , ...
    'XMinorTick'    , 'on'      , ... 
    'YMinorTick'    , 'on'      , ...
    'YGrid'         , 'on'      , ...
    'XGrid'         , 'on'      , ...
    'XColor'        , [.0 .0 .0], ...
    'YColor'        , [.0 .0 .0], ...
    'LineWidth'     , 1, ...
    'Units'         , 'normalized',...
    'FontUnits'     , 'points',...
    'FontWeight'    , 'normal',...
    'FontSize'      , fontsize,...
    'TickLabelInterpreter', 'latex')

ylabel({label_y},...
    'FontUnits', 'points',...
    'interpreter', 'latex',...
    'FontSize', fontsize)
xlabel({label_x},...
    'FontUnits', 'points',...
    'FontWeight', 'normal',...
    'interpreter', 'latex',...
    'FontSize', fontsize)

% if location not defined, consider it Best
if not(isempty(legends))
    legend(line_l, legends,...
       'FontUnits', 'points',...
       'Interpreter', 'latex',...
       'FontSize', fontsize,...
       'Location', location)
end
