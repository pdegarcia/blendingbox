close all;

x = 0; y = 0;
x_values = [];
y_values = [];
valuesTable = 'Color Blends_two.csv';   % MODIFY TABLE NAME.
pathLab = '/Users/PauloGarcia/Documents/MATLAB/lab_diagrams';

tableC = readtable(valuesTable, 'Delimiter', ';');
variables = tableC.Properties.VariableNames;

% Tables with every value from each Color Model
hsvTable = tableC(:, {'Color','H','S','V'});

for i = 1 : height(hsvTable)
    valuesHSV = hsvTable{i,{'H','S','V'}};
    hsv = hsv2rgb(valuesHSV);                    %convert hsv -> rgb -> xyz
    hsv = rgb2xyz(hsv);
    hsvTable(i, 2:4) = num2cell(hsv);
end

figure('Name','Pre-Calculated Mixtures', 'NumberTitle','off');
cieplot();
xlabel('X Value');
ylabel('Y Value');
hold on;

for i = 1 : height(hsvTable)
    color = hsvTable{i, {'H','S','V'}};
    x = color(1)/(color(1) + color(2) + color(3));
    y = color(2)/(color(1) + color(2) + color(3));
    x_values = [x_values x];
    y_values = [y_values y];
end

for i = 1 : 6
    scatter(x_values(i), y_values(i), 50, 'white', 'filled');
    text(x_values(i) - 0.025, y_values(i), strcat(hsvTable{i, {'Color'}}), 'FontSize', 13,'Color','white');
end

for i = 7 : height(hsvTable)
    scatter(x_values(i), y_values(i), 50, 'black');
    if(ismember(x_values(i), x_values(7:(i-1))) || ismember(y_values(i), y_values(7:(i-1))))
        text(x_values(i) + 0.02, y_values(i) - 0.03, strcat(hsvTable{i, {'Color'}}), 'FontSize', 12);
    else
        text(x_values(i) + 0.02, y_values(i), strcat('\leftarrow ',hsvTable{i, {'Color'}}), 'FontSize', 12);
    end
end

hold off;
saveas(gcf, fullfile(pathLab, 'PreCalc_Mixtures'),'png');