function bwplot(x, y, size_x, size_y, label_x, label_y, legends, location)
% usual sizes: 15x4, 15x5, 15x7.5 e 7x7

% create figure with the desired size
figure('Units'             , 'centimeters', ...
       'PaperUnits'        , 'centimeters', ...
       'Position'          , [2 5 size_x size_y],...
       'PaperPositionMode' , 'auto');
set(gcf, 'Color', 'w')

s_x = size(x);

% plot the variables
for i = 1:s_x(2)
    switch(i)
        case 1
            line_1l = line(x(:,i), y(:,i));
            set(line_1l, 'LineWidth', 1.5, ...
                'Color', [0, 0, 0]);
            hold on
        case 2
            % plot line 2
            line_2 = line(x(:,i), y(:,i));
            set(line_2, 'LineWidth', 1.5, ...
                'Color', [0.5, 0.5, 0.5], ...
                'LineStyle', '--');
            hold on
            % plot markers
            n_mk = 10; % nb of markers
            line_2m = scatter(x(int64(1+end/n_mk):int64(end/n_mk):end, i), ...  
                            y(int64(1+end/n_mk):int64(end/n_mk):end, i), 70);
            set(line_2m, ...
                'MarkerEdgeColor', [0.5, 0.5, 0.5], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 's', ...
                'LineWidth', 1.5);
            % plot for legend
            line_2l = line(x(1, i), y(1, i));
            set(line_2l, 'LineWidth', 1.5, ...
                'Color', [0.5, 0.5, 0.5], ...
                'LineStyle', '--', ...
                'MarkerEdgeColor', [0.5, 0.5, 0.5], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 's', ...
                'MarkerSize', 8,...
                'LineWidth', 1.5);
        case 3
            % plot line 3
            line_3 = line(x(:,i), y(:,i));
            set(line_3, 'LineWidth', 1.5, ...
                'Color', [0.7, 0.7, 0.7], ...
                'LineStyle', ':');
            hold on
            % plot markers
            n_mk = 8; % nb of markers
            line_3m = scatter(x(int64(1+end/n_mk):int64(end/n_mk):end, i), ...  
                            y(int64(1+end/n_mk):int64(end/n_mk):end, i), 70);
            set(line_3m, ...
                'MarkerEdgeColor', [0.7, 0.7, 0.7], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 'o', ...
                'LineWidth', 1.5);
            % plot for legend
            line_3l = line(x(1, i), y(1, i));
            set(line_3l, 'LineWidth', 1.5, ...
                'Color', [0.7, 0.7, 0.7], ...
                'LineStyle', ':', ...
                'MarkerEdgeColor', [0.7, 0.7, 0.7], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 'o', ...
                'MarkerSize', 8,...
                'LineWidth', 1.5);
        case 4
            % plot line 4
            line_4 = line(x(:,i), y(:,i));
            set(line_4, 'LineWidth', 1.5, ...
                'Color', [0.75, 0.75, 0.75], ...
                'LineStyle', '-.');
            hold on
            % plot markers
            n_mk = 12; % nb of markers
            line_4m = scatter(x(int64(1+end/n_mk):int64(end/n_mk):end, i), ...  
                            y(int64(1+end/n_mk):int64(end/n_mk):end, i), 100);
            set(line_4m, ...
                'MarkerEdgeColor', [0.75, 0.75, 0.75], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 'p', ...
                'LineWidth', 1.5);
            % plot for legend
            line_4l = line(x(1, i), y(1, i));
            set(line_4l, 'LineWidth', 1.5, ...
                'Color', [0.75, 0.75, 0.75], ...
                'LineStyle', '-.', ...
                'MarkerEdgeColor', [0.75, 0.75, 0.75], ...
                'MarkerFaceColor', [1, 1, 1], ...
                'Marker', 'p', ...
                'MarkerSize', 10,...
                'LineWidth', 1.5);
    end
end
xmin = min(min(x));
xmax = max(max(x));
ymin = min(min(y));
ymax = max(max(y));


% setup the plot style
y_extra = 0.03;
if ymin <= 0 && ymax <= 0
    ylims = [ymin*(1+y_extra) ymax*(1-y_extra)];
elseif ymin <= 0 && ymax >= 0
    ylims = [ymin*(1+y_extra) ymax*(1+y_extra)];
else
    ylims = [ymin*(1-y_extra) ymax*(1+y_extra)];
end
xlim([xmin xmax])
ylim(ylims)

fontsize = 12;
set(gca,...
    'Box'           , 'off'     , ...
    'TickDir'       , 'out'     , ...
    'TickLength'    , [.02 .02] , ...
    'XMinorTick'    , 'on'      , ... 
    'YMinorTick'    , 'on'      , ...
    'YTick'         , linspace(round(ylims(1)), round(ylims(2)), 5), ...
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

% create legend
try
    line_2l;
catch
    line_2l = '';
end
try
    line_3l;
catch
    line_3l = '';
end
try
    line_4l;
catch
    line_4l = '';
end

% if location not defined, consider it Best
try
    location;
catch
    location = 'Best';
end
try
    vars_leg = [line_1l, line_2l, line_3l, line_4l];
    legend(vars_leg(1:s_x(2)), legends,...
           'FontUnits', 'points',...
           'Interpreter', 'latex',...
           'FontSize', fontsize,...
           'Location', location)
catch 
end