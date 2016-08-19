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
table_lightgreen = tableBins(strcmp(tableBins.name, 'lightgreen'),:);   % NOT to be drawn (not enough points)
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

disp('Colors Separated in tables Successfully!');

%% Blue Color Bin
disp('> Processing Blue Color Bin (37 725 elements) ...');

for i = 1 : height(table_blue)
    color = table_blue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_blue = [x_blue color(1)/(color(1) + color(2) + color(3))];
    y_blue = [y_blue color(2)/(color(1) + color(2) + color(3))];
end
area_blue = convhull(x_blue, y_blue);

disp('... Blue Color Bin Successfully Processed!');
%% Brown Color Bin
disp('> Processing Brown Color Bin (10 299 elements) ...');

for i = 1 : height(table_brown)
    color = table_brown{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_brown = [x_brown color(1)/(color(1) + color(2) + color(3))];
    y_brown = [y_brown color(2)/(color(1) + color(2) + color(3))];
end
area_brown = convhull(x_brown, y_brown);

disp('... Brown Color Bin Successfully Processed!');
%% Cyan Color Bin
disp('> Processing Cyan Color Bin (2 625 elements) ...');

for i = 1 : height(table_cyan)
    color = table_cyan{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_cyan = [x_cyan color(1)/(color(1) + color(2) + color(3))];
    y_cyan = [y_cyan color(2)/(color(1) + color(2) + color(3))];
end
area_cyan = convhull(x_cyan, y_cyan);

disp('... Cyan Color Bin Successfully Processed!');
%% Dark Blue Color Bin
disp('> Processing Dark Blue Color Bin (2 233 elements) ...');

for i = 1 : height(table_darkblue)
    color = table_darkblue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkblue = [x_darkblue color(1)/(color(1) + color(2) + color(3))];
    y_darkblue = [y_darkblue color(2)/(color(1) + color(2) + color(3))];
end
area_darkblue = convhull(x_darkblue, y_darkblue);

disp('... Dark Blue Color Bin Successfully Processed!');
%% Dark Brown Color Bin
disp('> Processing Dark Brown Color Bin (30 elements) ...');

for i = 1 : height(table_darkbrown)
    color = table_darkbrown{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkbrown = [x_darkbrown color(1)/(color(1) + color(2) + color(3))];
    y_darkbrown = [y_darkbrown color(2)/(color(1) + color(2) + color(3))];
end
area_darkbrown = convhull(x_darkbrown, y_darkbrown);

disp('... Dark Brown Color Bin Successfully Processed!');
%% Dark Green Color Bin
disp('> Processing Dark Green Color Bin (2 927 elements) ...');

for i = 1 : height(table_darkgreen)
    color = table_darkgreen{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkgreen = [x_darkgreen color(1)/(color(1) + color(2) + color(3))];
    y_darkgreen = [y_darkgreen color(2)/(color(1) + color(2) + color(3))];
end
area_darkgreen = convhull(x_darkgreen, y_darkgreen);

disp('... Dark Green Color Bin Successfully Processed!');
%% Dark Purple Color Bin
disp('> Processing Dark Purple Color Bin (669 elements) ...');

for i = 1 : height(table_darkpurple)
    color = table_darkpurple{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkpurple = [x_darkpurple color(1)/(color(1) + color(2) + color(3))];
    y_darkpurple = [y_darkpurple color(2)/(color(1) + color(2) + color(3))];
end
area_darkpurple = convhull(x_darkpurple, y_darkpurple);

disp('... Dark Purple Color Bin Successfully Processed!');
%% Dark Red Color Bin
% for i = 1 : height(table_darkred)
%     color = table_darkred{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
%     color = applycform(color, cformRGB_XYZ);
%     x_darkred = [x_darkred color(1)/(color(1) + color(2) + color(3))];
%     y_darkred = [y_darkred color(2)/(color(1) + color(2) + color(3))];
% end
% area_darkred = convhull(x_darkred, y_darkred);

%% Dark Teal Color Bin
disp('> Processing Dark Teal Color Bin (163 elements) ...');

for i = 1 : height(table_darkteal)
    color = table_darkteal{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_darkteal = [x_darkteal color(1)/(color(1) + color(2) + color(3))];
    y_darkteal = [y_darkteal color(2)/(color(1) + color(2) + color(3))];
end
area_darkteal = convhull(x_darkteal, y_darkteal);

disp('... Dark Teal Color Bin Successfully Processed!');
%% Gold Color Bin
disp('> Processing Gold Color Bin (49 elements) ...');

for i = 1 : height(table_gold)
    color = table_gold{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_gold = [x_gold color(1)/(color(1) + color(2) + color(3))];
    y_gold = [y_gold color(2)/(color(1) + color(2) + color(3))];
end
area_gold = convhull(x_gold, y_gold);

disp('... Gold Color Bin Successfully Processed!');
%% Green Color Bin
disp('> Processing Green Color Bin (47 858 elements) ...');

for i = 1 : height(table_green)
    color = table_green{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_green = [x_green color(1)/(color(1) + color(2) + color(3))];
    y_green = [y_green color(2)/(color(1) + color(2) + color(3))];
end
area_green = convhull(x_green, y_green);

disp('... Green Color Bin Successfully Processed!');
%% Light Blue Color Bin
disp('> Processing Light Blue Color Bin (2 078 elements) ...');

for i = 1 : height(table_lightblue)
    color = table_lightblue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_lightblue = [x_lightblue color(1)/(color(1) + color(2) + color(3))];
    y_lightblue = [y_lightblue color(2)/(color(1) + color(2) + color(3))];
end
area_lightblue = convhull(x_lightblue, y_lightblue);

disp('... Light Blue Color Bin Successfully Processed!');
%% Light Green Color Bin
% for i = 1 : height(table_lightgreen)
%     color = table_lightgreen{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
%     color = applycform(color, cformRGB_XYZ);
%     x_lightgreen = [x_lightgreen color(1)/(color(1) + color(2) + color(3))];
%     y_lightgreen = [y_lightgreen color(2)/(color(1) + color(2) + color(3))];
% end
% area_lightgreen = convhull(x_lightgreen, y_lightgreen);

%% Lime Green Color Bin
disp('> Processing Lime Green Color Bin (878 elements) ...');

for i = 1 : height(table_limegreen)
    color = table_limegreen{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_limegreen = [x_limegreen color(1)/(color(1) + color(2) + color(3))];
    y_limegreen = [y_limegreen color(2)/(color(1) + color(2) + color(3))];
end
area_limegreen = convhull(x_limegreen, y_limegreen);

disp('... Lime Green Color Bin Successfully Processed!');
%% Magenta Color Bin
disp('> Processing Magenta Color Bin (990 elements) ...');

for i = 1 : height(table_magenta)
    color = table_magenta{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_magenta = [x_magenta color(1)/(color(1) + color(2) + color(3))];
    y_magenta = [y_magenta color(2)/(color(1) + color(2) + color(3))];
end
area_magenta = convhull(x_magenta, y_magenta);

disp('... Magenta Color Bin Successfully Processed!');
%% Maroon Color Bin
disp('> Processing Maroon Color Bin (3 283 elements) ...');

for i = 1 : height(table_maroon)
    color = table_maroon{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_maroon = [x_maroon color(1)/(color(1) + color(2) + color(3))];
    y_maroon = [y_maroon color(2)/(color(1) + color(2) + color(3))];
end
area_maroon = convhull(x_maroon, y_maroon);

disp('... Maroon Color Bin Successfully Processed!');
%% Mustard Color Bin
disp('> Processing Mustard Color Bin (771 elements) ...');

for i = 1 : height(table_mustard)
    color = table_mustard{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_mustard = [x_mustard color(1)/(color(1) + color(2) + color(3))];
    y_mustard = [y_mustard color(2)/(color(1) + color(2) + color(3))];
end
area_mustard = convhull(x_mustard, y_mustard);

disp('... Mustard Color Bin Successfully Processed!');
%% Navyblue Color Bin
disp('> Processing Navy Blue Color Bin (922 elements) ...');

for i = 1 : height(table_navyblue)
    color = table_navyblue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_navyblue = [x_navyblue color(1)/(color(1) + color(2) + color(3))];
    y_navyblue = [y_navyblue color(2)/(color(1) + color(2) + color(3))];
end
area_navyblue = convhull(x_navyblue, y_navyblue);

disp('... Navy Blue Color Bin Successfully Processed!');
%% Olive Color Bin
disp('> Processing Olive Color Bin (1 336 elements) ...');

for i = 1 : height(table_olive)
    color = table_olive{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_olive = [x_olive color(1)/(color(1) + color(2) + color(3))];
    y_olive = [y_olive color(2)/(color(1) + color(2) + color(3))];
end
area_olive = convhull(x_olive, y_olive);

disp('... Olive Color Bin Successfully Processed!');
%% Orange Color Bin
disp('> Processing Orange Color Bin (9 152 elements) ...');

for i = 1 : height(table_orange)
    color = table_orange{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_orange = [x_orange color(1)/(color(1) + color(2) + color(3))];
    y_orange = [y_orange color(2)/(color(1) + color(2) + color(3))];
end
area_orange = convhull(x_orange, y_orange);

disp('... Orange Color Bin Successfully Processed!');
%% Pink Color Bin
disp('> Processing Pink Color Bin (12 627 elements) ...');

for i = 1 : height(table_pink)
    color = table_pink{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_pink = [x_pink color(1)/(color(1) + color(2) + color(3))];
    y_pink = [y_pink color(2)/(color(1) + color(2) + color(3))];
end
area_pink = convhull(x_pink, y_pink);

disp('... Pink Color Bin Successfully Processed!');
%% Purple Color Bin
disp('> Processing Purple Color Bin (25 747 elements) ...');

for i = 1 : height(table_purple)
    color = table_purple{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_purple = [x_purple color(1)/(color(1) + color(2) + color(3))];
    y_purple = [y_purple color(2)/(color(1) + color(2) + color(3))];
end
area_purple = convhull(x_purple, y_purple);

disp('... Purple Color Bin Successfully Processed!');
%% Red Color Bin
disp('> Processing Red Color Bin (15 474 elements) ...');

for i = 1 : height(table_red)
    color = table_red{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_red = [x_red color(1)/(color(1) + color(2) + color(3))];
    y_red = [y_red color(2)/(color(1) + color(2) + color(3))];
end
area_red = convhull(x_red, y_red);

disp('... Red Color Bin Successfully Processed!');
%% Skyblue Color Bin
disp('> Processing Skyblue Color Bin (32 elements) ...');

for i = 1 : height(table_skyblue)
    color = table_skyblue{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_skyblue = [x_skyblue color(1)/(color(1) + color(2) + color(3))];
    y_skyblue = [y_skyblue color(2)/(color(1) + color(2) + color(3))];
end
area_skyblue = convhull(x_skyblue, y_skyblue);

disp('... Skyblue Color Bin Successfully Processed!');
%% Teal Color Bin
disp('> Processing Teal Color Bin (9 007 elements) ...');

for i = 1 : height(table_teal)
    color = table_teal{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_teal = [x_teal color(1)/(color(1) + color(2) + color(3))];
    y_teal = [y_teal color(2)/(color(1) + color(2) + color(3))];
end
area_teal = convhull(x_teal, y_teal);

disp('... Teal Color Bin Successfully Processed!');
%% Yellow Color Bin
disp('> Processing Yellow Color Bin (7 808 elements) ...');

for i = 1 : height(table_yellow)
    color = table_yellow{i, {'R','G','B'}} / 255;    % convert to [0, 1] values
    color = applycform(color, cformRGB_XYZ);
    x_yellow = [x_yellow color(1)/(color(1) + color(2) + color(3))];
    y_yellow = [y_yellow color(2)/(color(1) + color(2) + color(3))];
end
area_yellow = convhull(x_yellow, y_yellow);

disp('... Yellow Color Bin Successfully Processed!');
%% Drawing the Color Bins (Convex Hull)
disp('Starting to draw in 3, 2, 1...');

figure('NumberTitle','off');
cieplot();
title('XKCD Color Bins - Convex Hull', 'FontSize', 13);             
xlabel('X Value');
ylabel('Y Value');
hold on;

area_red = fill(x_red(area_red),               y_red(area_red),                [1 0 0],            'FaceAlpha', 0.4);       area_red.Tag = 'Red      '; 
area_blue = fill(x_blue(area_blue),             y_blue(area_blue),              [0 0 1],            'FaceAlpha', 0.4);      area_blue.Tag = 'Blue     '; 
area_green = fill(x_green(area_green),           y_green(area_green),            [0 0.5 0],          'FaceAlpha', 0.4);     area_green.Tag = 'Green    '; 
area_cyan = fill(x_cyan(area_cyan),             y_cyan(area_cyan),              'cyan',             'FaceAlpha', 0.4);      area_cyan.Tag = 'Cyan     '; 
area_magenta = fill(x_magenta(area_magenta),       y_magenta(area_magenta),        [1 0 1],            'FaceAlpha', 0.4);   area_magenta.Tag = 'Magenta  '; 
area_yellow = fill(x_yellow(area_yellow),         y_yellow(area_yellow),          [1 1 0],            'FaceAlpha', 0.4);    area_yellow.Tag = 'Yellow   '; 
area_orange = fill(x_orange(area_orange),         y_orange(area_orange),          [1 0.65 0],         'FaceAlpha', 0.4);    area_orange.Tag = 'Orange   '; 
area_pink = fill(x_pink(area_pink),             y_pink(area_pink),              [1 0.75 0.8],       'FaceAlpha', 0.4);      area_pink.Tag = 'Pink     '; 
area_purple = fill(x_purple(area_purple),         y_purple(area_purple),          [0.5 0 0.5],        'FaceAlpha', 0.4);    area_purple.Tag = 'Purple   '; 
area_gold = fill(x_gold(area_gold),             y_gold(area_gold),              [1 0.84 0],         'FaceAlpha', 0.4);      area_gold.Tag = 'Gold     '; 
area_brown = fill(x_brown(area_brown),           y_brown(area_brown),            [0.65 0.16 0.16],   'FaceAlpha', 0.4);     area_brown.Tag = 'Brown    '; 
area_skyblue = fill(x_skyblue(area_skyblue),       y_skyblue(area_skyblue),        [0.53 0.81 0.92],   'FaceAlpha', 0.4);   area_skyblue.Tag = 'Sky-Blue '; 
area_teal = fill(x_teal(area_teal),             y_teal(area_teal),              [0 0.5 0.5],        'FaceAlpha', 0.4);      area_teal.Tag = 'Teal     '; 
area_maroon = fill(x_maroon(area_maroon),         y_maroon(area_maroon),          [0.5 0 0],          'FaceAlpha', 0.4);    area_maroon.Tag = 'Maroon   '; 
area_mustard = fill(x_mustard(area_mustard),       y_mustard(area_mustard),        [0.96 0.82 0.3],    'FaceAlpha', 0.4);   area_mustard.Tag = 'Mustard  '; 
area_navyblue = fill(x_navyblue(area_navyblue),     y_navyblue(area_navyblue),      [0 0 0.5],          'FaceAlpha', 0.4);  area_navyblue.Tag = 'Navy-Blue'; 
area_olive = fill(x_olive(area_olive),           y_olive(area_olive),            [0.5 0.5 0],        'FaceAlpha', 0.4);     area_olive.Tag = 'Olive    '; 

area_darkblue = fill(x_darkblue(area_darkblue),     y_darkblue(area_darkblue),      [0 0 0.55],         'FaceAlpha', 0.4);  area_darkblue.Tag = 'DK-Blue  '; 
area_darkgreen = fill(x_darkgreen(area_darkgreen),   y_darkgreen(area_darkgreen),    [0 0.39 0],         'FaceAlpha', 0.4); area_darkgreen.Tag = 'DK-Green '; 
area_darkpurple = fill(x_darkpurple(area_darkpurple), y_darkpurple(area_darkpurple),  [0.29 0 0.51],      'FaceAlpha', 0.4);area_darkpurple.Tag = 'DK-Purple'; 
area_darkbrown = fill(x_brown(area_darkbrown),       y_brown(area_darkbrown),        [0.32 0.08 0.08],   'FaceAlpha', 0.4); area_darkbrown.Tag = 'DK-Brown '; 
area_darkteal = fill(x_darkteal(area_darkteal),     y_darkteal(area_darkteal),      [0 0.25 0.25],      'FaceAlpha', 0.4);  area_darkteal.Tag = 'DK-Teal  '; 

area_lightblue = fill(x_lightblue(area_lightblue),   y_lightblue(area_lightblue),    [0.68 0.85 0.9],    'FaceAlpha', 0.4); area_lightblue.Tag = 'LI-Blue  ';  
area_limegreen = fill(x_limegreen(area_limegreen),   y_limegreen(area_limegreen),    [0.2 0.80 0.2],     'FaceAlpha', 0.4); area_limegreen.Tag = 'LI-Green '; 

%% Drawing the Color Bins (Points)

figure('NumberTitle','off');
cieplot();
title('XKCD Color Bins - Points', 'FontSize', 13);             
xlabel('X Value');
ylabel('Y Value');
hold on;

% FALTA LIME GREEN AQUI
% area_blue = plot(x_blue, y_blue, 'Color', [0 0 1]);                         area_blue.Tag = 'Blue'; 
% area_brown = plot(x_brown, y_brown, 'Color', [0.65 0.16 0.16]);             area_brown.Tag = 'Brown'; 
% area_darkbrown = plot(x_darkbrown, y_darkbrown, 'Color', [0.32 0.08 0.08]); area_darkbrown.Tag = 'Dark-Brown'; 
% area_cyan = plot(x_cyan, y_cyan, 'cyan');                                   area_cyan.Tag = 'Cyan'; 
% area_darkblue = plot(x_darkblue, y_darkblue, 'Color', [0 0 0.55]);          area_darkblue.Tag = 'Dark-Blue'; 
% area_darkgreen = plot(x_darkgreen, y_darkgreen, 'Color', [0 0.39 0]);       area_darkgreen.Tag = 'Dark-Green'; 
% area_darkpurple = plot(x_darkpurple, y_darkpurple, 'Color', [0.29 0 0.51]); area_darkpurple.Tag = 'Dark-Purple'; 
% area_darkteal = plot(x_darkteal, y_darkteal, 'Color', [0 0.25 0.25]);       area_darkteal.Tag = 'Dark-Teal'; 
% area_gold = plot(x_gold, y_gold, 'Color', [1 0.84 0]);                      area_gold.Tag = 'Gold'; 
% area_green = plot(x_green, y_green, 'Color', [0 0.5 0]);                    area_green.Tag = 'Green'; 
% area_lightblue = plot(x_lightblue, y_lightblue, 'Color', [0.2 0.80 0.2]);   area_lightblue.Tag = 'Light-Blue';  
% area_magenta = plot(x_magenta, y_magenta, 'Color', [1 0 1]);                area_magenta.Tag = 'Magenta'; 
% area_maroon = plot(x_maroon, y_maroon, 'Color', [0.5 0 0]);                 area_maroon.Tag = 'Maroon'; 
% area_mustard = plot(x_mustard, y_mustard, 'Color', [0.96 0.82 0.3]);        area_mustard.Tag = 'Mustard'; 
% area_navyblue = plot(x_navyblue, y_navyblue, 'Color', [0 0 0.5]);           area_navyblue.Tag = 'Navy-Blue'; 
% area_olive = plot(x_olive, y_olive, 'Color', [0.5 0.5 0]);                  area_olive.Tag = 'Olive'; 
% area_orange = plot(x_orange, y_orange, 'Color', [1 0.65 0]);                area_orange.Tag = 'Orange'; 
% area_pink = plot(x_pink, y_pink, 'Color', [1 0.75 0.8]);                    area_pink.Tag = 'Pink'; 
% area_purple = plot(x_purple, y_purple, 'Color', [0.5 0 0.5]);               area_purple.Tag = 'Purple'; 
% area_red = plot(x_red, y_red, 'Color', [1 0 0]);                            area_red.Tag = 'Red'; 
% area_skyblue = plot(x_skyblue, y_skyblue, 'Color', [0.53 0.81 0.92]);       area_skyblue.Tag = 'Sky-Blue'; 
% area_teal = plot(x_teal, y_teal, 'Color', [0 0.5 0.5]);                     area_teal.Tag = 'Teal'; 
% area_yellow = plot(x_yellow, y_yellow, 'Color', [1 1 0]);                   area_yellow.Tag = 'Yellow'; 

plot(x_blue, y_blue, 'Color', [0 0 1]);
plot(x_brown, y_brown, 'Color', [0.65 0.16 0.16]);
plot(x_darkbrown, y_darkbrown, 'Color', [0.32 0.08 0.08]);
plot(x_cyan, y_cyan, 'cyan');                             
plot(x_darkblue, y_darkblue, 'Color', [0 0 0.55]);        
plot(x_darkgreen, y_darkgreen, 'Color', [0 0.39 0]);      
plot(x_darkpurple, y_darkpurple, 'Color', [0.29 0 0.51]); 
plot(x_darkteal, y_darkteal, 'Color', [0 0.25 0.25]);     
plot(x_gold, y_gold, 'Color', [1 0.84 0]);                
plot(x_green, y_green, 'Color', [0 0.5 0]);               
plot(x_lightblue, y_lightblue, 'Color', [0.2 0.80 0.2]);  
plot(x_magenta, y_magenta, 'Color', [1 0 1]);             
plot(x_maroon, y_maroon, 'Color', [0.5 0 0]);             
plot(x_mustard, y_mustard, 'Color', [0.96 0.82 0.3]);     
plot(x_navyblue, y_navyblue, 'Color', [0 0 0.5]);         
plot(x_olive, y_olive, 'Color', [0.5 0.5 0]);             
plot(x_orange, y_orange, 'Color', [1 0.65 0]);            
plot(x_pink, y_pink, 'Color', [1 0.75 0.8]);              
plot(x_purple, y_purple, 'Color', [0.5 0 0.5]);           
plot(x_red, y_red, 'Color', [1 0 0]);                     
plot(x_skyblue, y_skyblue, 'Color', [0.53 0.81 0.92]);    
plot(x_teal, y_teal, 'Color', [0 0.5 0.5]);               
plot(x_yellow, y_yellow, 'Color', [1 1 0]);               

colorBins = [area_blue area_brown area_darkbrown area_cyan area_darkblue area_darkgreen area_darkpurple area_darkteal area_gold area_green area_limegreen area_lightblue area_magenta area_maroon area_mustard area_navyblue area_olive area_orange area_pink area_purple area_red area_skyblue area_teal area_yellow];

disp('Finished Script without errors.');