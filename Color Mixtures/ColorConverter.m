
close all;

%% MODIFIABLE VALUES%%

valuesTable = 'Color Blends_two.csv';   % MODIFY TABLE NAME.
profileSrc = 'profileA';                % MODIFY PROFILE NAME.

profile = iccread(profileSrc);
iccTransform = makecform('mattrc', profile, 'Direction', 'inverse');
tableC = readtable(valuesTable, 'Delimiter', ';');
variables = tableC.Properties.VariableNames;

cformLab = makecform('lab2xyz');
cformsRGB = makecform('srgb2xyz');
cformLch = makecform('lch2lab');
cformCMYK = makecform('cmyk2srgb');

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

%% CONVERSION BETWEEN COLOR MODELS -> XYZ %%
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

%% CONVERSION BETWEEN XYZ -> RGB, with .icc profile %%

cmykTable.K = [];   % Get rid of K value.
for i = 1 : height(rgbTable)
    valuesRGB = rgbTable{i,{'R','G','B'}};
    valuesLAB = labTable{i, {'L','a','b'}};
    valuesLCh = lchTable{i, {'L','C','h'}};
    valuesCMYK = cmykTable{i, {'C','M','Y'}};
    
    rgb = (applycform(valuesRGB, iccTransform)*255);
    lab = (applycform(valuesLAB, iccTransform)*255);
    lch = (applycform(valuesLCh, iccTransform)*255);
    cmyk = (applycform(valuesCMYK, iccTransform)*255);
    
    rgbTable(i, 2:4) = num2cell(rgb);
    labTable(i, 2:4) = num2cell(lab);
    lchTable(i, 2:4) = num2cell(lch);
    cmykTable(i, 2:4) = num2cell(cmyk);
end

for i = 1 : height(hsvTable)
    valuesHSV = hsvTable{i,{'H','S','V'}};
    hsv = (applycform(valuesHSV, iccTransform)*255);
    hsvTable(i, 2:4) = num2cell(hsv);
end

%% CONVERSION BETWEEN RGB -> HEX COLOR CODES %%

frgb = fopen('rgb_colors_hex.txt','w');
flab = fopen('lab_colors_hex.txt','w');
flch = fopen('lch_colors_hex.txt','w');
fcmy = fopen('cmyk_colors_hex.txt','w');
fhsv = fopen('hsv_colors_hex.txt','w');
fslider = fopen('sliders_colors_hex.txt','w');
fcircles = fopen('circles_colors_hex.txt','w');

for i = 1 : height(rgbTable)
    valuesRGB = rgbTable{i,{'R','G','B'}};
    valuesLAB = labTable{i, {'L','a','b'}};
    valuesLCh = lchTable{i, {'L','C','h'}};
    valuesCMYK = cmykTable{i, {'C','M','Y'}};
    
    r = strcat(dec2hex(floor((valuesRGB(1)/16))), dec2hex(floor(rem(valuesRGB(1), 16))));
    g = strcat(dec2hex(floor((valuesRGB(2)/16))), dec2hex(floor(rem(valuesRGB(2), 16))));
    b = strcat(dec2hex(floor((valuesRGB(3)/16))), dec2hex(floor(rem(valuesRGB(3), 16))));
    rgb = strcat('#',r,g,b);
    
    l = strcat(dec2hex(floor((valuesLAB(1)/16))), dec2hex(floor(rem(valuesLAB(1), 16))));
    a = strcat(dec2hex(floor((valuesLAB(2)/16))), dec2hex(floor(rem(valuesLAB(2), 16))));
    b = strcat(dec2hex(floor((valuesLAB(3)/16))), dec2hex(floor(rem(valuesLAB(3), 16))));
    lab = strcat('#',l,a,b);
    
    l = strcat(dec2hex(floor((valuesLCh(1)/16))), dec2hex(floor(rem(valuesLCh(1), 16))));
    c = strcat(dec2hex(floor((valuesLCh(2)/16))), dec2hex(floor(rem(valuesLCh(2), 16))));
    h = strcat(dec2hex(floor((valuesLCh(3)/16))), dec2hex(floor(rem(valuesLCh(3), 16))));
    lch = strcat('#',l,c,h);
    
    c = strcat(dec2hex(floor((valuesCMYK(1)/16))), dec2hex(floor(rem(valuesCMYK(1), 16))));
    m = strcat(dec2hex(floor((valuesCMYK(2)/16))), dec2hex(floor(rem(valuesCMYK(2), 16))));
    y = strcat(dec2hex(floor((valuesCMYK(3)/16))), dec2hex(floor(rem(valuesCMYK(3), 16))));
    cmy = strcat('#',c,m,y);
    
    % PRINT ON MULTIPLE FILES %
    fprintf(frgb, '%s \n',rgb);
    fprintf(flab, '%s \n',lab);
    fprintf(flch, '%s \n',lch);
    fprintf(fcmy, '%s \n',cmy);
    
    % PRINT ON SAME FILE FOR SLIDER %
    fprintf(fslider, '%s \n',rgb);
    fprintf(fslider, '%s \n',lab);
    fprintf(fslider, '%s \n',lch);
    fprintf(fslider, '%s \n',cmy);
    
end

for i = 1 : height(hsvTable)
    valuesHSV = hsvTable{i,{'H','S','V'}};
    
    h = strcat(dec2hex(floor((valuesHSV(1)/16))), dec2hex(floor(rem(valuesHSV(1), 16))));
    s = strcat(dec2hex(floor((valuesHSV(2)/16))), dec2hex(floor(rem(valuesHSV(2), 16))));
    v = strcat(dec2hex(floor((valuesHSV(3)/16))), dec2hex(floor(rem(valuesHSV(3), 16))));
    hsv = strcat('#',h,s,v);
    
    fprintf(fhsv, '%s \n',hsv);       %HSV FILE
    fprintf(fcircles, '%s \n',hsv);  %COLORS TO PRESENT IN CIRCLES
end

fclose('all');