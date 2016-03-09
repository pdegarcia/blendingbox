
close all;
ref = 'Color Blends.csv';

table = readtable(ref, 'Format', '%s%u%u%u%f%f%f%u%u%u%u%f%f%f%f%f%f');
variables = table.Properties.VariableNames;

% Tables with every value from each Color Model
hsvTable = table(:, {'Color','H','S','V'});
lchTable = table(:, {'Color','L','C','h'});

cmykTable = table(:, {'Color','C_1','M','Y', 'K'});
    cmykTable.Properties.VariableNames = {'Color' 'C' 'M' 'Y' 'K'};

rgbTable = table(:, {'Color','R','G','B'});

labTable = table(:, {'Color','L_1','a','b'});
    labTable.Properties.VariableNames = {'Color' 'L' 'a' 'b'};
    
frgb = fopen('rgb_colors_xyz.txt','w');
flab = fopen('lab_colors_xyz.txt','w');
    
for i = 1 : height(table),
    valuesRGB = rgbTable{i,{'R','G','B'}};
    valuesLAB = labTable{i, {'L','a','b'}};
    rgb = rgb2xyz(valuesRGB, 'ColorSpace', 'srgb'); %convert rgb -> xyz
    lab = lab2xyz(valuesLAB);
    fprintf(frgb, '%u: %s %s %s \n',i, rgb);
    fprintf(flab, '%u: %s %s %s \n',i, lab);
end

fclose(flab);
fclose(frgb);