
close all;
ref = 'Color Blends_two.csv';
cformLab = makecform('lab2xyz');
cformsRGB = makecform('srgb2xyz');
cformLch = makecform('lch2lab');
cformCMYK = makecform('cmyk2srgb');
cformXYZ = makecform('xyz2srgb');

tableC = readtable(ref, 'Delimiter', ';');
variables = tableC.Properties.VariableNames;

% Tables with every value from each Color Model
hsvTable = tableC(:, {'Color','H','S','V'});

lchTable = tableC(:, {'Color','L','C','h'});
missing = ismissing(lchTable);
lchTable = lchTable(~any(missing, 2), :);

cmykTable = tableC(:, {'Color','C_1','M','Y', 'K'});
    cmykTable.Properties.VariableNames = {'Color' 'C' 'M' 'Y' 'K'};
missing = ismissing(cmykTable);
cmykTable = cmykTable(~any(missing, 2), :);

rgbTable = tableC(:, {'Color','R','G','B'});
missing = ismissing(rgbTable);
rgbTable = rgbTable(~any(missing, 2), :);

labTable = tableC(:, {'Color','L_1','a','b'});
    labTable.Properties.VariableNames = {'Color' 'L' 'a' 'b'};
missing = ismissing(labTable);
labTable = labTable(~any(missing, 2), :);
       
for i = 1 : height(rgbTable),
    valuesRGB = rgbTable{i,{'R','G','B'}};
    valuesLAB = labTable{i, {'L','a','b'}};
    valuesLCh = lchTable{i, {'L','C','h'}};
    valuesCMYK = cmykTable{i, {'C','M','Y','K'}};
    
    rgb = applycform(valuesRGB, cformsRGB);     %convert rgb -> xyz
    lab = applycform(valuesLAB, cformLab);      %convert Lab -> xyz
    lch = applycform(valuesLCh, cformLch);      %convert lch -> lab -> xyz
    lch = applycform(lch, cformLab);
    cmyk = applycform(valuesCMYK, cformCMYK);   %convert cmyk -> sRGB -> xyz
    cmyk = applycform(cmyk, cformsRGB);
    
    rgbTable(i, 2:4) = num2cell(rgb);
    labTable(i, 2:4) = num2cell(lab);
    lchTable(i, 2:4) = num2cell(lch);
    cmykTable(i, 2:4) = num2cell(cmyk);
    
end

for i = 1 : height(hsvTable)
   valuesHSV = hsvTable{i,{'H','S','V'}};
   hsv = hsv2rgb(valuesHSV);                    %convert hsv -> rgb -> xyz
   hsv = rgb2xyz(hsv);
   
   hsvTable(i, 2:4) = num2cell(hsv);
end
