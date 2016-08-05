%% Process XKCD's Color Bins
% Explanation: 
% This file processes the Color Bins studied XKCD web-page. The study consisted of
% 40,000 Women and 100,000 Men and its main goal was to create bins of
% colors recognized by people. We will use them to categorize the responses
% given by our users.
%
% The file is available on (at 20th July 2016): http://xkcd.com/color/rgb/
%
% This File separates the colors of the given CSV, drawing them in a CIE
% Chromaticity Diagram. The data was already processed from a txt onto a
% csv by me.
%
% NOTE: Black Bin is not drawed since it is not capable of being mapped in
% CIE Chromaticity Diagram.

close all;

colors_file     = 'data_xkcd_colorBins.csv';
tableBins       = readtable(colors_file, 'Delimiter', ',');

% Color transformation to convert from sRGB to CIE XYZ
cformRGB_XYZ    = makecform('srgb2xyz');

% x and y values for every color bin
x_blue = [];        y_blue = [];
x_brown = [];       y_brown = [];
x_cyan = [];        y_cyan = [];
x_darkblue = [];    y_darkblue = [];
x_darkbrown = [];   y_darkbrown = [];
x_darkgreen = [];   y_darkgreen = [];
x_darkpurple = [];  y_darkpurple = [];
x_darkred = [];     y_darkred = [];
x_darkteal = [];    y_darkteal = [];
x_gold = [];        y_gold = [];
x_green = [];       y_green = [];
x_lightblue = [];   y_lightblue = [];
x_lightgreen = [];  y_lightgreen = [];
x_limegreen = [];   y_limegreen = [];
x_magenta = [];     y_magenta = [];
x_maroon = [];      y_maroon = [];
x_mustard = [];     y_mustard = [];
x_navyblue = [];    y_navyblue = [];
x_olive = [];       y_olive = [];
x_orange = [];      y_orange = [];
x_pink = [];        y_pink = [];
x_purple = [];      y_purple = [];
x_red = [];         y_red = [];
x_skyblue = [];     y_skyblue = [];
x_teal = [];        y_teal = [];
x_yellow = [];      y_yellow = [];

%% Existing Color Bins

table_black = tableBins(strcmp(tableBins.name, 'black'),:);     % NOT to be drawn (not represented)
table_blue = tableBins(strcmp(tableBins.name, 'blue'),:);
table_brown = tableBins(strcmp(tableBins.name, 'brown'),:);
table_cyan = tableBins(strcmp(tableBins.name, 'cyan'),:);
table_darkblue = tableBins(strcmp(tableBins.name, 'darkblue'),:);
table_darkbrown = tableBins(strcmp(tableBins.name, 'darkbrown'),:);
table_darkgreen = tableBins(strcmp(tableBins.name, 'darkgreen'),:);
table_darkpurple = tableBins(strcmp(tableBins.name, 'darkpurple'),:);
table_darkred = tableBins(strcmp(tableBins.name, 'darkred'),:);     % NOT to be drawn (not enough points)
table_darkteal = tableBins(strcmp(tableBins.name, 'darkteal'),:);
table_gold = tableBins(strcmp(tableBins.name, 'gold'),:);
table_green = tableBins(strcmp(tableBins.name, 'green'),:);
table_lightblue = tableBins(strcmp(tableBins.name, 'lightblue'),:);
table_lightgreen = tableBins(strcmp(tableBins.name, 'lightgreen'),:);
table_limegreen = tableBins(strcmp(tableBins.name, 'limegreen'),:);
table_magenta = tableBins(strcmp(tableBins.name, 'magenta'),:);
table_maroon = tableBins(strcmp(tableBins.name, 'maroon'),:);
table_mustard = tableBins(strcmp(tableBins.name, 'mustard'),:);
table_navyblue = tableBins(strcmp(tableBins.name, 'navyblue'),:);
table_olive = tableBins(strcmp(tableBins.name, 'olive'),:);
table_orange = tableBins(strcmp(tableBins.name, 'orange'),:);
table_pink = tableBins(strcmp(tableBins.name, 'pink'),:);
table_purple = tableBins(strcmp(tableBins.name, 'purple'),:);
table_red = tableBins(strcmp(tableBins.name, 'red'),:);
table_skyblue = tableBins(strcmp(tableBins.name, 'skyblue'),:);
table_teal = tableBins(strcmp(tableBins.name, 'teal'),:);
table_yellow = tableBins(strcmp(tableBins.name, 'yellow'),:);

%% Blue Color Bin
% for i = 1 : height(table_blue)
%     color = table_blue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
%     color = applycform(color, cformRGB_XYZ);
%     x_blue = [x_blue color(1)/(color(1) + color(2) + color(3))];
%     y_blue = [y_blue color(2)/(color(1) + color(2) + color(3))];
% end
% area_blue = convhull(x_blue, y_blue);

%% Brown Color Bin
for i = 1 : height(table_brown)
    color = table_brown{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_brown = [x_brown color(1)/(color(1) + color(2) + color(3))];
    y_brown = [y_brown color(2)/(color(1) + color(2) + color(3))];
end
area_brown = convhull(x_brown, y_brown);

%% Cyan Color Bin
for i = 1 : height(table_cyan)
    color = table_cyan{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_cyan = [x_cyan color(1)/(color(1) + color(2) + color(3))];
    y_cyan = [y_cyan color(2)/(color(1) + color(2) + color(3))];
end
area_cyan = convhull(x_cyan, y_cyan);

%% Dark Blue Color Bin
for i = 1 : height(table_darkblue)
    color = table_darkblue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkblue = [x_darkblue color(1)/(color(1) + color(2) + color(3))];
    y_darkblue = [y_darkblue color(2)/(color(1) + color(2) + color(3))];
end
area_darkblue = convhull(x_darkblue, y_darkblue);

%% Dark Brown Color Bin
for i = 1 : height(table_darkbrown)
    color = table_darkbrown{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkbrown = [x_darkbrown color(1)/(color(1) + color(2) + color(3))];
    y_darkbrown = [y_darkbrown color(2)/(color(1) + color(2) + color(3))];
end
area_darkbrown = convhull(x_darkbrown, y_darkbrown);

%% Dark Green Color Bin
for i = 1 : height(table_darkgreen)
    color = table_darkgreen{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkgreen = [x_darkgreen color(1)/(color(1) + color(2) + color(3))];
    y_darkgreen = [y_darkgreen color(2)/(color(1) + color(2) + color(3))];
end
area_darkgreen = convhull(x_darkgreen, y_darkgreen);

%% Dark Purple Color Bin
for i = 1 : height(table_darkpurple)
    color = table_darkpurple{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkpurple = [x_darkpurple color(1)/(color(1) + color(2) + color(3))];
    y_darkpurple = [y_darkpurple color(2)/(color(1) + color(2) + color(3))];
end
area_darkpurple = convhull(x_darkpurple, y_darkpurple);

%% Dark Red Color Bin
% for i = 1 : height(table_darkred)
%     color = table_darkred{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
%     color = applycform(color, cformRGB_XYZ);
%     x_darkred = [x_darkred color(1)/(color(1) + color(2) + color(3))];
%     y_darkred = [y_darkred color(2)/(color(1) + color(2) + color(3))];
% end
% area_darkred = convhull(x_darkred, y_darkred);

%% Dark Teal Color Bin
for i = 1 : height(table_darkteal)
    color = table_darkteal{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkteal = [x_darkteal color(1)/(color(1) + color(2) + color(3))];
    y_darkteal = [y_darkteal color(2)/(color(1) + color(2) + color(3))];
end
area_darkteal = convhull(x_darkteal, y_darkteal);

%% Gold Color Bin
for i = 1 : height(table_gold)
    color = table_gold{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_gold = [x_gold color(1)/(color(1) + color(2) + color(3))];
    y_gold = [y_gold color(2)/(color(1) + color(2) + color(3))];
end
area_gold = convhull(x_gold, y_gold);

%% Green Color Bin

%% Light Blue Color Bin

%% Light Green Color Bin

%% Lime Green Color Bin

%% Magenta Color Bin

%% Maroon Color Bin

%% Mustard Color Bin

%% Navyblue Color Bin

%% Olive Color Bin

%% Orange Color Bin

%% Pink Color Bin

%% Purple Color Bin

%% Red Color Bin

%% Skyblue Color Bin

%% Teal Color Bin

%% Yellow Color Bin

%% Drawing the Color Bins

figure('NumberTitle','off');
cieplot();
title('XKCD Color Bins', 'FontSize', 13);             
xlabel('X Value');
ylabel('Y Value');
hold on;

%plot(x_brown(area_blue), y_brown(area_blue), 'Color', [0 0 1]);
fill(x_brown(area_brown), y_brown(area_brown), [0.65 0.16 0.16], 'FaceAlpha', 0.4);
fill(x_cyan(area_cyan), y_cyan(area_cyan), 'cyan', 'FaceAlpha', 0.4);
fill(x_darkblue(area_darkblue), y_darkblue(area_darkblue), [0 0 0.55], 'FaceAlpha', 0.4);
fill(x_darkgreen(area_darkgreen), y_darkgreen(area_darkgreen), [0 0.39 0], 'FaceAlpha', 0.4);
fill(x_darkpurple(area_darkpurple), y_darkpurple(area_darkpurple), [0.29 0 0.51], 'FaceAlpha', 0.4);
%fill(x_darkred(area_darkred), y_darkred(area_darkred), [0.55 0 0], 'FaceAlpha', 0.4);
fill(x_darkteal(area_darkteal), y_darkteal(area_darkteal), [0 0.25 0.25], 'FaceAlpha', 0.4);
fill(x_gold(area_gold), y_gold(area_gold), [1 0.84 0], 'FaceAlpha', 0.4);

% Separar color bins em diagramas diferentes.
% guardar resultado de plot (x_, y_ ...)
% respostas devem ser comparadas com resultados, usando inpolygon