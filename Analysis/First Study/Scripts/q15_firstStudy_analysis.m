%% Question 15 - objTwoColors: Lime-Green = Blue + Yellow
% Explanation: 
% This file is divided onto some main sections: processing the Laboratory
% Results (both Regular and Daltonic Users) and Online Results
%
% This File draws CIE diagrams and digestes the results to new CSV tables.
%
% #1 Step: Comparing the given answers C1 and C2 with the expected ones.
% #2 Step: Comparing C1 and C2 with other pairs which generate the same objective color.
% #3 Step: Blend C1 and C2 in HSV, CIE LCh, CMYK, RGB and CIE Lab Color Models,
% comparing the result against pre-calculated results for each model.

close all;
ColorConverter;
process_colorBins;

centroid_HSV = [];
distance_centroid_HSV = [];
centroid_LCh = [];
distance_centroid_LCh = [];
centroid_CMYK = [];
distance_centroid_CMYK = [];
centroid_RGB = [];
distance_centroid_RGB = [];
centroid_Lab = [];
distance_centroid_Lab = [];

valuesSColor = [];
valuesTColor = [];
x_pre_expectedColors = [];
y_pre_expectedColors = [];
x_pairs = [];
y_pairs = [];
x_aux = 0;
y_aux = 0;
x_values = [];
y_values = [];
x_resulting_answers = [];
y_resulting_answers = [];
x_values_HSV = [];
y_values_HSV = [];
x_values_LCh = [];
y_values_LCh = [];
x_values_CMYK = [];
y_values_CMYK = [];
x_values_RGB = [];
y_values_RGB = [];
x_values_Lab = [];
y_values_Lab = [];

distance_HSV = [];
distance_LCh = [];
distance_Lab = [];
distance_CMYK = [];
distance_RGB = [];
distance_expectedC1C2 = [];

% PAIRS VARIABLES ZONE % -- CHANGE HERE
distance_pair1 = [];    % 'G-Y' generates Green in HSV model
distance_pair2 = [];    % 'G-Y' generates Green in LCh model
distance_pair3 = [];    % 'G-Y' generates Green in CMYK model
distance_pair4 = [];    % 'G-Y' generates Green in RGB model
distance_pair5 = [];    % 'G-Y' generates Green in Lab model
distance_pair6 = [];    % 'G-C' generates Green in HSV Model
distance_pair7 = [];    % 'G-C' generates Green in LCh model
distance_pair8 = [];    % 'G-C' generates Green in CMYK model
distance_pair9 = [];    % 'G-C' generates Green in RGB model
distance_pair10 = [];   % 'G-C' generates Green in Lab model
distance_pair11 = [];   % 'R-C' generates Green in HSV model
distance_pair12 = [];   % 'R-C' generates Green in LCh model

pair1_C1 = []; pair1_C2 = [];
pair2_C1 = []; pair2_C2 = [];
pair3_C1 = []; pair3_C2 = [];
pair4_C1 = []; pair4_C2 = [];
pair5_C1 = []; pair5_C2 = [];
pair6_C1 = []; pair6_C2 = [];
pair7_C1 = []; pair7_C2 = [];
pair8_C1 = []; pair8_C2 = [];
pair9_C1 = []; pair9_C2 = [];
pair10_C1 = []; pair10_C2 = [];
pair11_C1 = []; pair11_C2 = [];
pair12_C1 = []; pair12_C2 = [];
% END

cformRGB_XYZ    = makecform('srgb2xyz');
cformLab_LCh    = makecform('lab2lch');
cformLab_XYZ    = makecform('lab2xyz');
cformXYZ_Lab    = makecform('xyz2lab');
cformXYZ_RGB    = makecform('xyz2srgb');
cformLCh_Lab    = makecform('lch2lab');
cformCMYK_RGB   = makecform('cmyk2srgb');
cformRGB_CMYK   = makecform('srgb2cmyk');

path = '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15';    % -- CHANGE HERE

%% Analyze Users
users_lab = 'data_first_labUsers.csv';                                      % Laboratory Users
users_online = 'data_first_onlineUsers.csv';                                % Online Users

results_lab = 'data_first_laboratory_results.csv';                          % Laboratory Results
results_online = 'data_first_online_results.csv';                           % Online Results

daltonic_results_lab = 'data_first_laboratory_daltonic_results.csv';        % Laboratory Daltonic Users
daltonic_results_online = 'data_first_online_daltonic_results.csv';         % Online Daltonic Users

uncalibrated_results_online = 'data_first_online_uncalibrated_results.csv'; % Uncalibrated Results (Only online)

demographic_ageLess20 = 'data_first_demograph_ageMen20.csv';                    % Demograph. - Age < 20
demographic_age20_29 = 'data_first_demograph_age20-29.csv';                     % Demograph. - Age 20-29
demographic_age30_39 = 'data_first_demograph_age30-39.csv';                     % Demograph. - Age 30-39
demographic_age40_49 = 'data_first_demograph_age40-49.csv';                     % Demograph. - Age 40-49
demographic_age50_59 = 'data_first_demograph_age50-59.csv';                     % Demograph. - Age 50-59
demographic_ageMore60 = 'data_first_demograph_ageMais60.csv';                   % Demograph. - Age > 60
demographic_genderFemale = 'data_first_demograph_genderFemale.csv';             % Demograph. - Gender Female
demographic_genderMale = 'data_first_demograph_genderMale.csv';                 % Demograph. - Gender Male
demographic_genderOther = 'data_first_demograph_genderOther.csv';               % Demograph. - Gender Other

tableU_lab      = readtable(users_lab, 'Delimiter', ',');
tableU_online   = readtable(users_online, 'Delimiter', ',');

tableR_lab      = readtable(results_lab, 'Delimiter', ',');
tableR_online   = readtable(results_online, 'Delimiter', ';');

tableDR_lab     = readtable(daltonic_results_lab, 'Delimiter', ',');
tableDR_online  = readtable(daltonic_results_online, 'Delimiter', ';');

tableUR_online  = readtable(uncalibrated_results_online, 'Delimiter', ';');

tableDEM_age20      = readtable(demographic_ageLess20, 'Delimiter', ',');
tableDEM_age20_29   = readtable(demographic_age20_29, 'Delimiter', ',');
tableDEM_age30_39   = readtable(demographic_age30_39, 'Delimiter', ',');
tableDEM_age40_49   = readtable(demographic_age40_49, 'Delimiter', ',');
tableDEM_age50_59   = readtable(demographic_age50_59, 'Delimiter', ',');
tableDEM_age60      = readtable(demographic_ageMore60, 'Delimiter', ',');
tableDEM_genF       = readtable(demographic_genderFemale, 'Delimiter', ',');
tableDEM_genM       = readtable(demographic_genderMale, 'Delimiter', ',');
tableDEM_genO       = readtable(demographic_genderOther, 'Delimiter', ',');


%% Tables

% Laboratory Tables -- CHANGE HERE
laboratoryResults = tableR_lab(tableR_lab.id_question == 15,:); laboratoryResults = sortrows(laboratoryResults, 'id'); laboratoryResults.id_question = []; laboratoryResults.page_time = []; laboratoryResults.resets = []; 
laboratoryResults_dalt = tableDR_lab(tableDR_lab.id_question == 15,:); laboratoryResults_dalt = sortrows(laboratoryResults_dalt, 'id'); laboratoryResults_dalt.id_question = []; laboratoryResults_dalt.page_time = []; laboratoryResults_dalt.resets = [];

% Online Tables     -- CHANGE HERE
onlineResults = tableR_online(tableR_online.id_question == 15,:); onlineResults = sortrows(onlineResults, 'id'); onlineResults.id_question = []; onlineResults.page_time = []; onlineResults.resets = []; 
onlineResults_dalt = tableDR_online(tableDR_online.id_question == 15,:); onlineResults_dalt = sortrows(onlineResults_dalt, 'id'); onlineResults_dalt.id_question = []; onlineResults_dalt.page_time = []; onlineResults_dalt.resets = [];
onlineResults_uncal = tableUR_online(tableUR_online.id_question == 15,:); onlineResults_uncal = sortrows(onlineResults_uncal, 'id'); onlineResults_uncal.id_question = []; onlineResults_uncal.page_time = []; onlineResults_uncal.resets = [];

% Demographic Tables -- CHANGE HERE
demoResultsAge_20        = tableDEM_age20(tableDEM_age20.id_question == 15,:); demoResultsAge_20 = sortrows(demoResultsAge_20, 'id'); demoResultsAge_20.id_question = []; demoResultsAge_20.page_time = []; demoResultsAge_20.resets = [];
demoResultsAge_20_29     = tableDEM_age20_29(tableDEM_age20_29.id_question == 15,:); demoResultsAge_20_29 = sortrows(demoResultsAge_20_29, 'id'); demoResultsAge_20_29.id_question = []; demoResultsAge_20_29.page_time = []; demoResultsAge_20_29.resets = [];
demoResultsAge_30_39     = tableDEM_age30_39(tableDEM_age30_39.id_question == 15,:); demoResultsAge_30_39 = sortrows(demoResultsAge_30_39, 'id'); demoResultsAge_30_39.id_question = []; demoResultsAge_30_39.page_time = []; demoResultsAge_30_39.resets = [];
demoResultsAge_40_49     = tableDEM_age40_49(tableDEM_age40_49.id_question == 15,:); demoResultsAge_40_49 = sortrows(demoResultsAge_40_49, 'id'); demoResultsAge_40_49.id_question = []; demoResultsAge_40_49.page_time = []; demoResultsAge_40_49.resets = [];
demoResultsAge_50_59     = tableDEM_age20_29(tableDEM_age20_29.id_question == 15,:); demoResultsAge_20_29 = sortrows(demoResultsAge_20_29, 'id'); demoResultsAge_50_59.id_question = []; demoResultsAge_50_59.page_time = []; demoResultsAge_50_59.resets = [];
demoResultsAge_60        = tableDEM_age60(tableDEM_age60.id_question == 15,:); demoResultsAge_60 = sortrows(demoResultsAge_60, 'id'); demoResultsAge_60.id_question = []; demoResultsAge_60.page_time = []; demoResultsAge_60.resets = [];
demoResultsGender_Female = tableDEM_genF(tableDEM_genF.id_question == 15,:); demoResultsGender_Female = sortrows(demoResultsGender_Female, 'id'); demoResultsGender_Female.id_question = []; demoResultsGender_Female.page_time = []; demoResultsGender_Female.resets = [];
demoResultsGender_Male   = tableDEM_genM(tableDEM_genM.id_question == 15,:); demoResultsGender_Male = sortrows(demoResultsGender_Male, 'id'); demoResultsGender_Male.id_question = []; demoResultsGender_Male.page_time = []; demoResultsGender_Male.resets = [];
demoResultsGender_Other  = tableDEM_genO(tableDEM_genO.id_question == 15,:); demoResultsGender_Other = sortrows(demoResultsGender_Other, 'id'); demoResultsGender_Other.id_question = []; demoResultsGender_Other.page_time = []; demoResultsGender_Other.resets = [];

%% Pre-calculated Values

% Expected Colors   -- CHANGE HERE
given_color = hsvTable{22,{'H','S','V'}}; given_color = applycform((given_color/255), cformRGB_XYZ);   % Position - 'B+Y'
expected_C1 = hsvTable{3,{'H','S','V'}}; expected_C1 = applycform((expected_C1/255), cformRGB_XYZ);    % Position - 'B'
expected_C2 = hsvTable{6,{'H','S','V'}}; expected_C2 = applycform((expected_C2/255), cformRGB_XYZ);    % Position - 'Y'

% Other pairs which generate the same given color (if they exist).          -- CHANGE HERE
pair1_C1 = hsvTable{2,{'H','S','V'}} ; pair1_C2 = hsvTable{6,{'H','S','V'}};    pair1_C1 = applycform((pair1_C1/255), cformRGB_XYZ); pair1_C2 = applycform((pair1_C2/255), cformRGB_XYZ);          
pair2_C1 = lchTable{2,{'L','C','h'}} ; pair2_C2 = lchTable{6,{'L','C','h'}};    pair2_C1 = applycform((pair2_C1/255), cformRGB_XYZ); pair2_C2 = applycform((pair2_C2/255), cformRGB_XYZ);        
pair3_C1 = cmykTable{2,{'C','M','Y'}} ; pair3_C2 = cmykTable{6,{'C','M','Y'}};    pair3_C1 = applycform((pair3_C1/255), cformRGB_XYZ); pair3_C2 = applycform((pair3_C2/255), cformRGB_XYZ);         
pair4_C1 = rgbTable{2,{'R','G','B'}} ; pair4_C2 = rgbTable{6,{'R','G','B'}};    pair4_C1 = applycform((pair4_C1/255), cformRGB_XYZ); pair4_C2 = applycform((pair4_C2/255), cformRGB_XYZ);          
pair5_C1 = labTable{2,{'L','a','b'}} ; pair5_C2 = labTable{6,{'L','a','b'}};    pair5_C1 = applycform((pair5_C1/255), cformRGB_XYZ); pair5_C2 = applycform((pair5_C2/255), cformRGB_XYZ);          

pair6_C1 = hsvTable{2,{'H','S','V'}} ; pair6_C2 = hsvTable{4,{'H','S','V'}};    pair6_C1 = applycform((pair6_C1/255), cformRGB_XYZ); pair6_C2 = applycform((pair6_C2/255), cformRGB_XYZ);         
pair7_C1 = lchTable{2,{'L','C','h'}} ; pair7_C2 = lchTable{4,{'L','C','h'}};    pair7_C1 = applycform((pair7_C1/255), cformRGB_XYZ); pair7_C2 = applycform((pair7_C2/255), cformRGB_XYZ);         
pair8_C1 = cmykTable{2,{'C','M','Y'}} ; pair8_C2 = cmykTable{4,{'C','M','Y'}};    pair8_C1 = applycform((pair8_C1/255), cformRGB_XYZ); pair8_C2 = applycform((pair8_C2/255), cformRGB_XYZ);         
pair9_C1 = rgbTable{2,{'R','G','B'}} ; pair9_C2 = rgbTable{4,{'R','G','B'}};    pair9_C1 = applycform((pair9_C1/255), cformRGB_XYZ); pair9_C2 = applycform((pair9_C2/255), cformRGB_XYZ);         
pair10_C1 = labTable{2,{'L','a','b'}} ; pair10_C2 = labTable{4,{'L','a','b'}};    pair10_C1 = applycform((pair10_C1/255), cformRGB_XYZ); pair10_C2 = applycform((pair10_C2/255), cformRGB_XYZ);    

pair11_C1 = hsvTable{1,{'H','S','V'}} ; pair11_C2 = hsvTable{4,{'H','S','V'}};    pair11_C1 = applycform((pair11_C1/255), cformRGB_XYZ); pair11_C2 = applycform((pair11_C2/255), cformRGB_XYZ);    
pair12_C1 = lchTable{1,{'L','C','h'}} ; pair12_C2 = lchTable{4,{'L','C','h'}};    pair12_C1 = applycform((pair12_C1/255), cformRGB_XYZ); pair12_C2 = applycform((pair12_C2/255), cformRGB_XYZ);    

% Results of this combination in each Color Model (Pair: 'B-Y', Position 22/20) -- CHANGE HERE
pre_HSV  =  hsvTable{22,{'H','S','V'}};  pre_HSV  =  applycform((pre_HSV/255), cformRGB_XYZ);                  
pre_LCh  =  lchTable{20,{'L','C','h'}};  pre_LCh  =  applycform((pre_LCh/255), cformRGB_XYZ);                  
pre_CMYK =  cmykTable{20,{'C','M','Y'}}; pre_CMYK =  applycform((pre_CMYK/255), cformRGB_XYZ);
pre_RGB  =  rgbTable{20,{'R','G','B'}};  pre_RGB  =  applycform((pre_RGB/255), cformRGB_XYZ);
pre_Lab  =  labTable{20,{'L','a','b'}};  pre_Lab  =  applycform((pre_Lab/255), cformRGB_XYZ);

% Coordinates XYY for Expected Colors (for CIE Chromaticity Diagram) 
x_pre_expectedColors = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_C1(1)/(expected_C1(1) + expected_C1(2) + expected_C1(3)) expected_C2(1)/(expected_C2(1) + expected_C2(2) + expected_C2(3))];
y_pre_expectedColors = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_C1(2)/(expected_C1(1) + expected_C1(2) + expected_C1(3)) expected_C2(2)/(expected_C2(1) + expected_C2(2) + expected_C2(3))];

% Coordinates XYY for Other pairs which generate the same give color
x_pair1 = [pair1_C1(1)/(pair1_C1(1) + pair1_C1(2) + pair1_C1(3)) pair1_C2(1)/(pair1_C2(1) + pair1_C2(2) + pair1_C2(3))];
y_pair1 = [pair1_C1(2)/(pair1_C1(1) + pair1_C1(2) + pair1_C1(3)) pair1_C2(2)/(pair1_C2(1) + pair1_C2(2) + pair1_C2(3))];

x_pair2 = [pair2_C1(1)/(pair2_C1(1) + pair2_C1(2) + pair2_C1(3)) pair2_C2(1)/(pair2_C2(1) + pair2_C2(2) + pair2_C2(3))];
y_pair2 = [pair2_C1(2)/(pair2_C1(1) + pair2_C1(2) + pair2_C1(3)) pair2_C2(2)/(pair2_C2(1) + pair2_C2(2) + pair2_C2(3))];

x_pair3 = [pair3_C1(1)/(pair3_C1(1) + pair3_C1(2) + pair3_C1(3)) pair3_C2(1)/(pair3_C2(1) + pair3_C2(2) + pair3_C2(3))];
y_pair3 = [pair3_C1(2)/(pair3_C1(1) + pair3_C1(2) + pair3_C1(3)) pair3_C2(2)/(pair3_C2(1) + pair3_C2(2) + pair3_C2(3))];

x_pair4 = [pair4_C1(1)/(pair4_C1(1) + pair4_C1(2) + pair4_C1(3)) pair4_C2(1)/(pair4_C2(1) + pair4_C2(2) + pair4_C2(3))];
y_pair4 = [pair4_C1(2)/(pair4_C1(1) + pair4_C1(2) + pair4_C1(3)) pair4_C2(2)/(pair4_C2(1) + pair4_C2(2) + pair4_C2(3))];

x_pair5 = [pair5_C1(1)/(pair5_C1(1) + pair5_C1(2) + pair5_C1(3)) pair5_C2(1)/(pair5_C2(1) + pair5_C2(2) + pair5_C2(3))];
y_pair5 = [pair5_C1(2)/(pair5_C1(1) + pair5_C1(2) + pair5_C1(3)) pair5_C2(2)/(pair5_C2(1) + pair5_C2(2) + pair5_C2(3))];

x_pair6 = [pair6_C1(1)/(pair6_C1(1) + pair6_C1(2) + pair6_C1(3)) pair6_C2(1)/(pair6_C2(1) + pair6_C2(2) + pair6_C2(3))];
y_pair6 = [pair6_C1(2)/(pair6_C1(1) + pair6_C1(2) + pair6_C1(3)) pair6_C2(2)/(pair6_C2(1) + pair6_C2(2) + pair6_C2(3))];

x_pair7 = [pair7_C1(1)/(pair7_C1(1) + pair7_C1(2) + pair7_C1(3)) pair7_C2(1)/(pair7_C2(1) + pair7_C2(2) + pair7_C2(3))];
y_pair7 = [pair7_C1(2)/(pair7_C1(1) + pair7_C1(2) + pair7_C1(3)) pair7_C2(2)/(pair7_C2(1) + pair7_C2(2) + pair7_C2(3))];

x_pair8 = [pair8_C1(1)/(pair8_C1(1) + pair8_C1(2) + pair8_C1(3)) pair8_C2(1)/(pair8_C2(1) + pair8_C2(2) + pair8_C2(3))];
y_pair8 = [pair8_C1(2)/(pair8_C1(1) + pair8_C1(2) + pair8_C1(3)) pair8_C2(2)/(pair8_C2(1) + pair8_C2(2) + pair8_C2(3))];

x_pair9 = [pair9_C1(1)/(pair9_C1(1) + pair9_C1(2) + pair9_C1(3)) pair9_C2(1)/(pair9_C2(1) + pair9_C2(2) + pair9_C2(3))];
y_pair9 = [pair9_C1(2)/(pair9_C1(1) + pair9_C1(2) + pair9_C1(3)) pair9_C2(2)/(pair9_C2(1) + pair9_C2(2) + pair9_C2(3))];

x_pair10 = [pair10_C1(1)/(pair10_C1(1) + pair10_C1(2) + pair10_C1(3)) pair10_C2(1)/(pair10_C2(1) + pair10_C2(2) + pair10_C2(3))];
y_pair10 = [pair10_C1(2)/(pair10_C1(1) + pair10_C1(2) + pair10_C1(3)) pair10_C2(2)/(pair10_C2(1) + pair10_C2(2) + pair10_C2(3))];

x_pair11 = [pair11_C1(1)/(pair11_C1(1) + pair11_C1(2) + pair11_C1(3)) pair11_C2(1)/(pair11_C2(1) + pair11_C2(2) + pair11_C2(3))];
y_pair11 = [pair11_C1(2)/(pair11_C1(1) + pair11_C1(2) + pair11_C1(3)) pair11_C2(2)/(pair11_C2(1) + pair11_C2(2) + pair11_C2(3))];

x_pair12 = [pair12_C1(1)/(pair12_C1(1) + pair12_C1(2) + pair12_C1(3)) pair12_C2(1)/(pair12_C2(1) + pair12_C2(2) + pair12_C2(3))];
y_pair12 = [pair12_C1(2)/(pair12_C1(1) + pair12_C1(2) + pair12_C1(3)) pair12_C2(2)/(pair12_C2(1) + pair12_C2(2) + pair12_C2(3))];

% Coordinates XYY for Color Models' results
x_pre_models = [pre_HSV(1)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(1)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(1)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(1)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(1)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];
y_pre_models = [pre_HSV(2)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(2)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(2)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(2)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(2)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];

%% Laboratory Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Regular Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');                     % draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black');                               % draw EXPECTED COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                               % draw EXPECTED COLOR

% Draw every pair of responses.
for i = 1 : height(laboratoryResults)                                  
    %% First Color - C1
    sColor = str2num(cell2mat(laboratoryResults.second_color(i)));      % cell2mat serve para converter cell para matriz de uint
    valuesSColor = [valuesSColor sColor];                               % store integers values of answers
    sColor = sColor/360;                                                % scale value to [0,1] instead of [0, 360]
    sColor = [sColor 1 1];                                             % form triplet (sColor, 1, 1)
    hsv_C1 = sColor;
    sColor = hsv2rgb(sColor);                                           % hsv -> rgb, values between [0,1]
    rgb_C1 = round([sColor(1)*255 sColor(2)*255 sColor(3)*255]);
    sColor = rgb2xyz(sColor);                                           % rgb -> xyz
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));              % x = X / (X + Y + Z)
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));              % x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];
    
    %% Second Color - C2
    tColor = str2num(cell2mat(laboratoryResults.third_color(i)));
    valuesTColor = [valuesTColor tColor];                               % store integers values of answers
    tColor = tColor/360;                                                % scale value to [0,1] instead of [0, 360]
    tColor = [tColor 1 1];                                             % form triplet (tColor, 1, 1)
    hsv_C2 = tColor;
    tColor = hsv2rgb(tColor);                                           % hsv -> rgb, values between [0,1]
    rgb_C2 = round([tColor(1)*255 tColor(2)*255 tColor(3)*255]);
    tColor = rgb2xyz(tColor);                                           % rgb -> xyz
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));              % x = X / (X + Y + Z)
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));              % x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];
    
    %% Categorize Colors - Bins
    
    %% Difference between C1/C2 and expected colors C1/C2
    diff_c1_expected = round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(2) y_pre_expectedColors(2)]]), 2);  % [given -C1- C2]
    diff_c2_expected = round(pdist([[x_values(2) y_values(2)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2);  % [given C1 -C2-]
    distance_expectedC1C2 = [distance_expectedC1C2 ; diff_c1_expected + diff_c2_expected];
    
    %% Difference between C1/C2 and other pairs which generate the same color       %% -- CHANGE HERE (ADD MORE PAIRS IF NEEDED)
    diff_c1_pair1c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair1(1) y_pair1(1)]]), 2);   diff_c2_pair1c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair1(2) y_pair1(2)]]), 2);
    distance_pair1 = [distance_pair1 ; diff_c1_pair1c1 + diff_c2_pair1c2];
    
    diff_c1_pair2c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair2(1) y_pair2(1)]]), 2);   diff_c2_pair2c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair2(2) y_pair2(2)]]), 2);
    distance_pair2 = [distance_pair2 ; diff_c1_pair2c1 + diff_c2_pair2c2];
    
    diff_c1_pair3c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair3(1) y_pair3(1)]]), 2);   diff_c2_pair3c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair3(2) y_pair3(2)]]), 2);
    distance_pair3 = [distance_pair3 ; diff_c1_pair3c1 + diff_c2_pair3c2];
    
    diff_c1_pair4c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair4(1) y_pair4(1)]]), 2);   diff_c2_pair4c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair4(2) y_pair4(2)]]), 2);
    distance_pair4 = [distance_pair4 ; diff_c1_pair4c1 + diff_c2_pair4c2];
    
    diff_c1_pair5c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair5(1) y_pair5(1)]]), 2);   diff_c2_pair5c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair5(2) y_pair5(2)]]), 2);
    distance_pair5 = [distance_pair5 ; diff_c1_pair5c1 + diff_c2_pair5c2];
    
    diff_c1_pair6c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair6(1) y_pair6(1)]]), 2);   diff_c2_pair6c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair6(2) y_pair6(2)]]), 2);
    distance_pair6 = [distance_pair6 ; diff_c1_pair6c1 + diff_c2_pair6c2];
    
    diff_c1_pair7c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair7(1) y_pair7(1)]]), 2);   diff_c2_pair7c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair7(2) y_pair7(2)]]), 2);
    distance_pair7 = [distance_pair7 ; diff_c1_pair7c1 + diff_c2_pair7c2];
    
    diff_c1_pair8c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair8(1) y_pair8(1)]]), 2);   diff_c2_pair8c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair8(2) y_pair8(2)]]), 2);
    distance_pair8 = [distance_pair8 ; diff_c1_pair8c1 + diff_c2_pair8c2];
    
    diff_c1_pair9c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair9(1) y_pair9(1)]]), 2);   diff_c2_pair9c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair9(2) y_pair9(2)]]), 2);
    distance_pair9 = [distance_pair9 ; diff_c1_pair9c1 + diff_c2_pair9c2];
    
    diff_c1_pair10c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair10(1) y_pair10(1)]]), 2);   diff_c2_pair10c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair10(2) y_pair10(2)]]), 2);
    distance_pair10 = [distance_pair10 ; diff_c1_pair10c1 + diff_c2_pair10c2];
    
    diff_c1_pair11c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair11(1) y_pair11(1)]]), 2);   diff_c2_pair11c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair11(2) y_pair11(2)]]), 2);
    distance_pair11 = [distance_pair11 ; diff_c1_pair11c1 + diff_c2_pair11c2];
    
    diff_c1_pair12c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair12(1) y_pair12(1)]]), 2);   diff_c2_pair12c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair12(2) y_pair12(2)]]), 2);
    distance_pair12 = [distance_pair12 ; diff_c1_pair12c1 + diff_c2_pair12c2];
    
    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Blend-it in HSV
    sColor_hsv = [(hsv_C1(1)*360) hsv_C1(2) hsv_C1(3)]; tColor_hsv = [(hsv_C2(1)*360) hsv_C2(2) hsv_C2(3)];     
    diff_angles = abs(sColor_hsv(1) - tColor_hsv(1));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        if sum_major > 360
            angle = rem((max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half), 360);
        else
            angle = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        end
    else
        angle = min([sColor_hsv(1) tColor_hsv(1)]) + (diff_angles / 2);
    end
    rColor = rgb2xyz(hsv2rgb(([angle/360 sColor_hsv(2) sColor_hsv(3)])));                                  % hsv -> rgb -> xyz -> compare 
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_HSV = [distance_HSV; round(pdist([[x_aux y_aux]; [x_pre_models(1) y_pre_models(1)]]),2)];
    x_values_HSV = [x_values_HSV x_aux]; y_values_HSV = [y_values_HSV y_aux];
    
    %%%%%% Blend-it in CIE-LCh (XYZ -> Lab -> LCh)
    sColor_lch = sColor; tColor_lch = tColor;
    sColor_lch = applycform(applycform(sColor_lch, cformXYZ_Lab), cformLab_LCh); tColor_lch = applycform(applycform(tColor_lch, cformXYZ_Lab), cformLab_LCh);
    sColor_lch = [sColor_lch(1) sColor_lch(2) (sColor_lch(3)*360)]; tColor_lch = [tColor_lch(1) tColor_lch(2) (tColor_lch(3)*360)];
    l_aux = (abs(sColor_lch(1) - tColor_lch(1)) / 2) + min([sColor_lch(1) tColor_lch(1)]);  % diff between colors, and add half to the smallest
    c_aux = (abs(sColor_lch(2) - tColor_lch(2)) / 2) + min([sColor_lch(2) tColor_lch(2)]);
    diff_angles = abs(sColor_lch(3) - tColor_lch(3));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        if sum_major > 360
            h_aux = rem((max([sColor_lch(3) tColor_lch(3)]) + angle_small_half), 360);
        else
            h_aux = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        end
    else
        h_aux = min([sColor_lch(3) tColor_lch(3)]) + (diff_angles / 2);
    end
    rColor = applycform(applycform([l_aux c_aux (h_aux/360)], cformLCh_Lab), cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_LCh = [distance_LCh; round(pdist([[x_aux y_aux]; [x_pre_models(2) y_pre_models(2)]]), 2)];
    x_values_LCh = [x_values_LCh x_aux]; y_values_LCh = [y_values_LCh y_aux];
    
    %%%%%% Blend-it in CMYK
    sColor_cmyk = sColor; tColor_cmyk = tColor;
    sColor_cmyk = applycform(applycform(sColor_cmyk, cformXYZ_RGB), cformRGB_CMYK); tColor_cmyk = applycform(applycform(tColor_cmyk, cformXYZ_RGB), cformRGB_CMYK);
    sColor_cmyk = [sColor_cmyk(1) sColor_cmyk(2) sColor_cmyk(3)]; tColor_cmyk = [tColor_cmyk(1) tColor_cmyk(2) tColor_cmyk(3)]; %Exclude 'K' component
    c_aux = (abs(sColor_cmyk(1) - tColor_cmyk(1)) / 2) + min([sColor_cmyk(1) tColor_cmyk(1)]);
    m_aux = (abs(sColor_cmyk(2) - tColor_cmyk(2)) / 2) + min([sColor_cmyk(2) tColor_cmyk(2)]);
    y_aux = (abs(sColor_cmyk(3) - tColor_cmyk(3)) / 2) + min([sColor_cmyk(3) tColor_cmyk(3)]);
    rColor = applycform(applycform([c_aux m_aux y_aux 0], cformCMYK_RGB), cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_CMYK = [distance_CMYK; round(pdist([[x_aux y_aux]; [x_pre_models(3) y_pre_models(3)]]), 2)];
    x_values_CMYK = [x_values_CMYK x_aux]; y_values_CMYK = [y_values_CMYK y_aux];
    
    %%%%%% Blend-it in RGB
    sColor_rgb = sColor; tColor_rgb = tColor;
    sColor_rgb = applycform(sColor_rgb, cformXYZ_RGB); tColor_rgb = applycform(tColor_rgb, cformXYZ_RGB);
    r_aux = (abs(sColor_rgb(1) - tColor_rgb(1)) / 2) + min([sColor_rgb(1) tColor_rgb(1)]);
    g_aux = (abs(sColor_rgb(2) - tColor_rgb(2)) / 2) + min([sColor_rgb(2) tColor_rgb(2)]);
    b_aux = (abs(sColor_rgb(3) - tColor_rgb(3)) / 2) + min([sColor_rgb(3) tColor_rgb(3)]);
    rColor = applycform([r_aux g_aux b_aux], cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_RGB = [distance_RGB; round(pdist([[x_aux y_aux]; [x_pre_models(4) y_pre_models(4)]]), 2)];
    x_values_RGB = [x_values_RGB x_aux]; y_values_RGB = [y_values_RGB y_aux];
    
    %%%%%% Blend-it in CIE-Lab
    sColor_lab = sColor; tColor_lab = tColor;
    sColor_lab = applycform(sColor_lab, cformXYZ_Lab); tColor_lab = applycform(tColor_lab, cformXYZ_Lab);
    l_aux = (abs(sColor_lab(1) - tColor_lab(1)) / 2) + min([sColor_lab(1) tColor_lab(1)]);
    a_aux = (abs(sColor_lab(2) - tColor_lab(2)) / 2) + min([sColor_lab(2) tColor_lab(2)]);
    b_aux = (abs(sColor_lab(3) - tColor_lab(3)) / 2) + min([sColor_lab(3) tColor_lab(3)]);
    rColor = applycform([l_aux a_aux b_aux], cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_Lab = [distance_Lab; round(pdist([[x_aux y_aux]; [x_pre_models(5) y_pre_models(5)]]), 2)];
    x_values_Lab = [x_values_Lab x_aux]; y_values_Lab = [y_values_Lab y_aux];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'lab_regularUsers'), 'png');

% Centroids of Color Models
centroid_HSV    = [centroid_HSV  ; [round(mean(x_values_HSV),2) round(mean(y_values_HSV),2)]];
centroid_LCh    = [centroid_LCh  ; [round(mean(x_values_LCh),2) round(mean(y_values_LCh),2)]];
centroid_CMYK   = [centroid_CMYK ; [round(mean(x_values_CMYK),2) round(mean(y_values_CMYK),2)]];
centroid_RGB    = [centroid_RGB  ; [round(mean(x_values_RGB),2) round(mean(y_values_RGB),2)]];
centroid_Lab    = [centroid_Lab  ; [round(mean(x_values_Lab),2) round(mean(y_values_Lab),2)]];

distance_centroid_HSV = [distance_centroid_HSV ; round(pdist([mean(x_values_HSV) mean(y_values_HSV); [x_pre_models(1) y_pre_models(1)]]), 2)];
distance_centroid_LCh = [distance_centroid_LCh ; round(pdist([mean(x_values_LCh) mean(y_values_LCh); [x_pre_models(2) y_pre_models(2)]]), 2)];
distance_centroid_CMYK = [distance_centroid_CMYK ; round(pdist([mean(x_values_CMYK) mean(y_values_CMYK); [x_pre_models(3) y_pre_models(3)]]), 2)];
distance_centroid_RGB = [distance_centroid_RGB ; round(pdist([mean(x_values_RGB) mean(y_values_RGB); [x_pre_models(4) y_pre_models(4)]]), 2)];
distance_centroid_Lab = [distance_centroid_Lab ; round(pdist([mean(x_values_Lab) mean(y_values_Lab); [x_pre_models(5) y_pre_models(5)]]), 2)];

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC1C2, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
diffs_pairs = table(distance_pair1,distance_pair2,distance_pair3,distance_pair4,distance_pair5,distance_pair6,distance_pair7,distance_pair8,distance_pair9,distance_pair10,distance_pair11,distance_pair12);
diffs_table = [diffs_table diffs_pairs];

laboratoryResults = [laboratoryResults diffs_table];

% Plot Results for each Color Model
figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Responses According to HSV Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(1), y_pre_models(1), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_HSV, y_values_HSV, 50, 'white');                          % Draw responses mixed in HSV   
hold off;
saveas(gcf, fullfile(path, 'lab_HSVresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Responses According to CIE-LCh Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(2), y_pre_models(2), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_LCh, y_values_LCh, 50, 'white');                          % Draw responses mixed in LCh   
hold off;
saveas(gcf, fullfile(path, 'lab_LChresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Responses According to CMYK Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(3), y_pre_models(3), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_CMYK, y_values_CMYK, 50, 'white');                          % Draw responses mixed in CMYK   
hold off;
saveas(gcf, fullfile(path, 'lab_CMYKresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Responses According to RGB Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(4), y_pre_models(4), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_RGB, y_values_RGB, 50, 'white');                          % Draw responses mixed in RGB   
hold off;
saveas(gcf, fullfile(path, 'lab_RGBresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Responses According to CIE-Lab Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(5), y_pre_models(5), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_Lab, y_values_Lab, 50, 'white');                          % Draw responses mixed in Lab   
hold off;
saveas(gcf, fullfile(path, 'lab_Labresponses'), 'png');

% Clean all the tables!
x_values_HSV = []; y_values_HSV = []; x_values_LCh = []; y_values_LCh = []; x_values_CMYK = []; y_values_CMYK = []; x_values_RGB = []; y_values_RGB = []; x_values_Lab = []; y_values_Lab = [];  
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC1C2 = [];
distance_pair1 = []; distance_pair2 = []; distance_pair3 = []; distance_pair4 = []; distance_pair5 = []; distance_pair6 = []; distance_pair7 = []; distance_pair8 = []; distance_pair9 = []; distance_pair10 = []; distance_pair11 = []; distance_pair12 = [];

%% Laboratory Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 15: Laboratory Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

for i = 1 : height(laboratoryResults_dalt)
%First Color
    sColor = str2num(cell2mat(laboratoryResults_dalt.second_color(i)));
    valuesSColor = [valuesSColor sColor];                   
    sColor = sColor/360;                                    
    sColor = [sColor 1 1];                                 
    sColor = hsv2rgb(sColor);                               
    sColor = rgb2xyz(sColor);                               
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));  
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));  
    x_values = [x_values x_aux];                            
    y_values = [y_values y_aux];
    
    %Second Color
    tColor = str2num(cell2mat(laboratoryResults_dalt.third_color(i)));
    valuesTColor = [valuesTColor tColor];                   
    tColor = tColor/360;                                    
    tColor = [tColor 1 1];                                 
    tColor = hsv2rgb(tColor);                               
    tColor = rgb2xyz(tColor);                               
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));  
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));  
    x_values = [x_values x_aux];                            
    y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white');                 
    plot(x_values, y_values, 'Color', 'black');             
    x_values = [];                                          
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'lab_daltonicUsers'), 'png'); 

%% Online Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Regular Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

for i = 1 : height(onlineResults)                                  %draw every pair of responses.
    %First Color
    sColor = str2num(cell2mat(onlineResults.second_color(i)));     %cell2mat serve para converter cell para matriz de uint
    valuesSColor = [valuesSColor sColor];                   %store integers values of answers
    sColor = sColor/360;                                    %scale value to [0,1] instead of [0, 360]
    sColor = [sColor 1 1];                                 %form triplet (sColor, 1, 0.5)
    hsv_C1 = sColor;
    sColor = hsv2rgb(sColor);                               %hsv -> rgb, values between [0,1]
    sColor = rgb2xyz(sColor);                               %rgb -> xyz
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));  %x = X / (X + Y + Z)
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    %Second Color
    tColor = str2num(cell2mat(onlineResults.third_color(i)));
    valuesTColor = [valuesTColor tColor];                   %store integers values of answers
    tColor = tColor/360;                                    %scale value to [0,1] instead of [0, 360]
    tColor = [tColor 1 1];                                 %form triplet (tColor, 1, 0.5)
    hsv_C2 = tColor;
    tColor = hsv2rgb(tColor);                               %hsv -> rgb, values between [0,1]
    tColor = rgb2xyz(tColor);                               %rgb -> xyz
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));  %x = X / (X + Y + Z)
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    %% Categorize Colors - Bins
    
    %% Difference between C1/C2 and expected colors C1/C2
    diff_c1_expected = round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(2) y_pre_expectedColors(2)]]), 2);  % [given -C1- C2]
    diff_c2_expected = round(pdist([[x_values(2) y_values(2)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2);  % [given C1 -C2-]
    distance_expectedC1C2 = [distance_expectedC1C2 ; diff_c1_expected + diff_c2_expected];
    
    %% Difference between C1/C2 and other pairs which generate the same color       %% -- CHANGE HERE (ADD MORE PAIRS IF NEEDED)
    diff_c1_pair1c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair1(1) y_pair1(1)]]), 2);   diff_c2_pair1c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair1(2) y_pair1(2)]]), 2);
    distance_pair1 = [distance_pair1 ; diff_c1_pair1c1 + diff_c2_pair1c2];
    
    diff_c1_pair2c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair2(1) y_pair2(1)]]), 2);   diff_c2_pair2c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair2(2) y_pair2(2)]]), 2);
    distance_pair2 = [distance_pair2 ; diff_c1_pair2c1 + diff_c2_pair2c2];
    
    diff_c1_pair3c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair3(1) y_pair3(1)]]), 2);   diff_c2_pair3c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair3(2) y_pair3(2)]]), 2);
    distance_pair3 = [distance_pair3 ; diff_c1_pair3c1 + diff_c2_pair3c2];
    
    diff_c1_pair4c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair4(1) y_pair4(1)]]), 2);   diff_c2_pair4c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair4(2) y_pair4(2)]]), 2);
    distance_pair4 = [distance_pair4 ; diff_c1_pair4c1 + diff_c2_pair4c2];
    
    diff_c1_pair5c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair5(1) y_pair5(1)]]), 2);   diff_c2_pair5c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair5(2) y_pair5(2)]]), 2);
    distance_pair5 = [distance_pair5 ; diff_c1_pair5c1 + diff_c2_pair5c2];
    
    diff_c1_pair6c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair6(1) y_pair6(1)]]), 2);   diff_c2_pair6c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair6(2) y_pair6(2)]]), 2);
    distance_pair6 = [distance_pair6 ; diff_c1_pair6c1 + diff_c2_pair6c2];
    
    diff_c1_pair7c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair7(1) y_pair7(1)]]), 2);   diff_c2_pair7c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair7(2) y_pair7(2)]]), 2);
    distance_pair7 = [distance_pair7 ; diff_c1_pair7c1 + diff_c2_pair7c2];
    
    diff_c1_pair8c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair8(1) y_pair8(1)]]), 2);   diff_c2_pair8c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair8(2) y_pair8(2)]]), 2);
    distance_pair8 = [distance_pair8 ; diff_c1_pair8c1 + diff_c2_pair8c2];
    
    diff_c1_pair9c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair9(1) y_pair9(1)]]), 2);   diff_c2_pair9c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair9(2) y_pair9(2)]]), 2);
    distance_pair9 = [distance_pair9 ; diff_c1_pair9c1 + diff_c2_pair9c2];
    
    diff_c1_pair10c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair10(1) y_pair10(1)]]), 2);   diff_c2_pair10c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair10(2) y_pair10(2)]]), 2);
    distance_pair10 = [distance_pair10 ; diff_c1_pair10c1 + diff_c2_pair10c2];
    
    diff_c1_pair11c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair11(1) y_pair11(1)]]), 2);   diff_c2_pair11c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair11(2) y_pair11(2)]]), 2);
    distance_pair11 = [distance_pair11 ; diff_c1_pair11c1 + diff_c2_pair11c2];
    
    diff_c1_pair12c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair12(1) y_pair12(1)]]), 2);   diff_c2_pair12c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair12(2) y_pair12(2)]]), 2);
    distance_pair12 = [distance_pair12 ; diff_c1_pair12c1 + diff_c2_pair12c2];
    
    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Blend-it in HSV
    sColor_hsv = [(hsv_C1(1)*360) hsv_C1(2) hsv_C1(3)]; tColor_hsv = [(hsv_C2(1)*360) hsv_C2(2) hsv_C2(3)];     
    diff_angles = abs(sColor_hsv(1) - tColor_hsv(1));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        if sum_major > 360
            angle = rem((max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half), 360);
        else
            angle = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        end
    else
        angle = min([sColor_hsv(1) tColor_hsv(1)]) + (diff_angles / 2);
    end
    rColor = rgb2xyz(hsv2rgb(([(angle/360) sColor_hsv(2) sColor_hsv(3)])));                                  % hsv -> rgb -> xyz -> compare 
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_HSV = [distance_HSV; round(pdist([[x_aux y_aux]; [x_pre_models(1) y_pre_models(1)]]),2)];
    x_values_HSV = [x_values_HSV x_aux]; y_values_HSV = [y_values_HSV y_aux];
    
    %%%%%% Blend-it in CIE-LCh (XYZ -> Lab -> LCh)
    sColor_lch = sColor; tColor_lch = tColor;
    sColor_lch = applycform(applycform(sColor_lch, cformXYZ_Lab), cformLab_LCh); tColor_lch = applycform(applycform(tColor_lch, cformXYZ_Lab), cformLab_LCh);
    sColor_lch = [sColor_lch(1) sColor_lch(2) (sColor_lch(3)*360)]; tColor_lch = [tColor_lch(1) tColor_lch(2) (tColor_lch(3)*360)];
    l_aux = (abs(sColor_lch(1) - tColor_lch(1)) / 2) + min([sColor_lch(1) tColor_lch(1)]);  % diff between colors, and add half to the smallest
    c_aux = (abs(sColor_lch(2) - tColor_lch(2)) / 2) + min([sColor_lch(2) tColor_lch(2)]);
    diff_angles = abs(sColor_lch(3) - tColor_lch(3));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        if sum_major > 360
            h_aux = rem((max([sColor_lch(3) tColor_lch(3)]) + angle_small_half), 360);
        else
            h_aux = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        end
    else
        h_aux = min([sColor_lch(3) tColor_lch(3)]) + (diff_angles / 2);
    end
    rColor = applycform(applycform([l_aux c_aux (h_aux/360)], cformLCh_Lab), cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_LCh = [distance_LCh; round(pdist([[x_aux y_aux]; [x_pre_models(2) y_pre_models(2)]]), 2)];
    x_values_LCh = [x_values_LCh x_aux]; y_values_LCh = [y_values_LCh y_aux];
    
    %%%%%% Blend-it in CMYK
    sColor_cmyk = sColor; tColor_cmyk = tColor;
    sColor_cmyk = applycform(applycform(sColor_cmyk, cformXYZ_RGB), cformRGB_CMYK); tColor_cmyk = applycform(applycform(tColor_cmyk, cformXYZ_RGB), cformRGB_CMYK);
    sColor_cmyk = [sColor_cmyk(1) sColor_cmyk(2) sColor_cmyk(3)]; tColor_cmyk = [tColor_cmyk(1) tColor_cmyk(2) tColor_cmyk(3)]; %Exclude 'K' component
    c_aux = (abs(sColor_cmyk(1) - tColor_cmyk(1)) / 2) + min([sColor_cmyk(1) tColor_cmyk(1)]);
    m_aux = (abs(sColor_cmyk(2) - tColor_cmyk(2)) / 2) + min([sColor_cmyk(2) tColor_cmyk(2)]);
    y_aux = (abs(sColor_cmyk(3) - tColor_cmyk(3)) / 2) + min([sColor_cmyk(3) tColor_cmyk(3)]);
    rColor = applycform(applycform([c_aux m_aux y_aux 0], cformCMYK_RGB), cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_CMYK = [distance_CMYK; round(pdist([[x_aux y_aux]; [x_pre_models(3) y_pre_models(3)]]), 2)];
    x_values_CMYK = [x_values_CMYK x_aux]; y_values_CMYK = [y_values_CMYK y_aux];
    
    %%%%%% Blend-it in RGB
    sColor_rgb = sColor; tColor_rgb = tColor;
    sColor_rgb = applycform(sColor_rgb, cformXYZ_RGB); tColor_rgb = applycform(tColor_rgb, cformXYZ_RGB);
    r_aux = (abs(sColor_rgb(1) - tColor_rgb(1)) / 2) + min([sColor_rgb(1) tColor_rgb(1)]);
    g_aux = (abs(sColor_rgb(2) - tColor_rgb(2)) / 2) + min([sColor_rgb(2) tColor_rgb(2)]);
    b_aux = (abs(sColor_rgb(3) - tColor_rgb(3)) / 2) + min([sColor_rgb(3) tColor_rgb(3)]);
    rColor = applycform([r_aux g_aux b_aux], cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_RGB = [distance_RGB; round(pdist([[x_aux y_aux]; [x_pre_models(4) y_pre_models(4)]]), 2)];
    x_values_RGB = [x_values_RGB x_aux]; y_values_RGB = [y_values_RGB y_aux];
    
    %%%%%% Blend-it in CIE-Lab
    sColor_lab = sColor; tColor_lab = tColor;
    sColor_lab = applycform(sColor_lab, cformXYZ_Lab); tColor_lab = applycform(tColor_lab, cformXYZ_Lab);
    l_aux = (abs(sColor_lab(1) - tColor_lab(1)) / 2) + min([sColor_lab(1) tColor_lab(1)]);
    a_aux = (abs(sColor_lab(2) - tColor_lab(2)) / 2) + min([sColor_lab(2) tColor_lab(2)]);
    b_aux = (abs(sColor_lab(3) - tColor_lab(3)) / 2) + min([sColor_lab(3) tColor_lab(3)]);
    rColor = applycform([l_aux a_aux b_aux], cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_Lab = [distance_Lab; round(pdist([[x_aux y_aux]; [x_pre_models(5) y_pre_models(5)]]), 2)];
    x_values_Lab = [x_values_Lab x_aux]; y_values_Lab = [y_values_Lab y_aux];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_regularUsers'), 'png'); 

% Centroids of Color Models
centroid_HSV    = [centroid_HSV  ; [round(mean(x_values_HSV),2) round(mean(y_values_HSV),2)]];
centroid_LCh    = [centroid_LCh  ; [round(mean(x_values_LCh),2) round(mean(y_values_LCh),2)]];
centroid_CMYK   = [centroid_CMYK ; [round(mean(x_values_CMYK),2) round(mean(y_values_CMYK),2)]];
centroid_RGB    = [centroid_RGB  ; [round(mean(x_values_RGB),2) round(mean(y_values_RGB),2)]];
centroid_Lab    = [centroid_Lab  ; [round(mean(x_values_Lab),2) round(mean(y_values_Lab),2)]];

distance_centroid_HSV = [distance_centroid_HSV ; round(pdist([mean(x_values_HSV) mean(y_values_HSV); [x_pre_models(1) y_pre_models(1)]]), 2)];
distance_centroid_LCh = [distance_centroid_LCh ; round(pdist([mean(x_values_LCh) mean(y_values_LCh); [x_pre_models(2) y_pre_models(2)]]), 2)];
distance_centroid_CMYK = [distance_centroid_CMYK ; round(pdist([mean(x_values_CMYK) mean(y_values_CMYK); [x_pre_models(3) y_pre_models(3)]]), 2)];
distance_centroid_RGB = [distance_centroid_RGB ; round(pdist([mean(x_values_RGB) mean(y_values_RGB); [x_pre_models(4) y_pre_models(4)]]), 2)];
distance_centroid_Lab = [distance_centroid_Lab ; round(pdist([mean(x_values_Lab) mean(y_values_Lab); [x_pre_models(5) y_pre_models(5)]]), 2)];

diffs_table = table(distance_expectedC1C2, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
diffs_pairs = table(distance_pair1,distance_pair2,distance_pair3,distance_pair4,distance_pair5,distance_pair6,distance_pair7,distance_pair8,distance_pair9,distance_pair10,distance_pair11,distance_pair12);
diffs_table = [diffs_table diffs_pairs];

onlineResults = [onlineResults diffs_table];

% Plot Results for each Color Model
figure('NumberTitle','off');
cieplot();
title('Question 15: Online Responses According to HSV Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(1), y_pre_models(1), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_HSV, y_values_HSV, 50, 'white');                          % Draw responses mixed in HSV   
hold off;
saveas(gcf, fullfile(path, 'online_HSVresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Responses According to CIE-LCh Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(2), y_pre_models(2), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_LCh, y_values_LCh, 50, 'white');                          % Draw responses mixed in LCh   
hold off;
saveas(gcf, fullfile(path, 'online_LChresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Responses According to CMYK Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(3), y_pre_models(3), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_CMYK, y_values_CMYK, 50, 'white');                          % Draw responses mixed in CMYK   
hold off;
saveas(gcf, fullfile(path, 'online_CMYKresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Responses According to RGB Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(4), y_pre_models(4), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_RGB, y_values_RGB, 50, 'white');                          % Draw responses mixed in RGB   
hold off;
saveas(gcf, fullfile(path, 'online_RGBresponses'), 'png');

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Responses According to CIE-Lab Model', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;
scatter(x_pre_models(5), y_pre_models(5), 50, 'black', 'Filled');          % Draw expected response for this model
scatter(x_values_Lab, y_values_Lab, 50, 'white');                          % Draw responses mixed in Lab   
hold off;
saveas(gcf, fullfile(path, 'online_Labresponses'), 'png');

% Clean all the tables!
x_values_HSV = []; y_values_HSV = []; x_values_LCh = []; y_values_LCh = []; x_values_CMYK = []; y_values_CMYK = []; x_values_RGB = []; y_values_RGB = []; x_values_Lab = []; y_values_Lab = [];  
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC1C2 = [];
distance_pair1 = []; distance_pair2 = []; distance_pair3 = []; distance_pair4 = []; distance_pair5 = []; distance_pair6 = []; distance_pair7 = []; distance_pair8 = []; distance_pair9 = []; distance_pair10 = []; distance_pair11 = []; distance_pair12 = [];

%% Online Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

for i = 1 : height(onlineResults_dalt)
%First Color
    sColor = str2num(cell2mat(onlineResults_dalt.second_color(i)));
    valuesSColor = [valuesSColor sColor];                   
    sColor = sColor/360;                                    
    sColor = [sColor 1 .5];                                 
    sColor = hsv2rgb(sColor);                               
    sColor = rgb2xyz(sColor);                               
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));  
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));  
    x_values = [x_values x_aux];                            
    y_values = [y_values y_aux];
    
    %Second Color
    tColor = str2num(cell2mat(onlineResults_dalt.third_color(i)));
    valuesTColor = [valuesTColor tColor];                   
    tColor = tColor/360;                                    
    tColor = [tColor 1 .5];                                 
    tColor = hsv2rgb(tColor);                               
    tColor = rgb2xyz(tColor);                               
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));  
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));  
    x_values = [x_values x_aux];                            
    y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white');                 
    plot(x_values, y_values, 'Color', 'black');             
    x_values = [];                                          
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_daltonicUsers'), 'png'); 

%% Online Results - Uncalibrated Users

figure('NumberTitle','off');
cieplot();
title('Question 15: Online Uncalibrated Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

for i = 1 : height(onlineResults_uncal)                                  %draw every pair of responses.
    %First Color
    sColor = str2num(cell2mat(onlineResults_uncal.second_color(i)));     %cell2mat serve para converter cell para matriz de uint
    valuesSColor = [valuesSColor sColor];                   %store integers values of answers
    sColor = sColor/360;                                    %scale value to [0,1] instead of [0, 360]
    sColor = [sColor 1 1];                                 %form triplet (sColor, 1, 0.5)
    hsv_C1 = sColor;
    sColor = hsv2rgb(sColor);                               %hsv -> rgb, values between [0,1]
    sColor = rgb2xyz(sColor);                               %rgb -> xyz
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));  %x = X / (X + Y + Z)
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    %Second Color
    tColor = str2num(cell2mat(onlineResults_uncal.third_color(i)));
    valuesTColor = [valuesTColor tColor];                   %store integers values of answers
    tColor = tColor/360;                                    %scale value to [0,1] instead of [0, 360]
    tColor = [tColor 1 1];                                 %form triplet (tColor, 1, 0.5)
    hsv_C2 = tColor;
    tColor = hsv2rgb(tColor);                               %hsv -> rgb, values between [0,1]
    tColor = rgb2xyz(tColor);                               %rgb -> xyz
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));  %x = X / (X + Y + Z)
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    %% Categorize Colors - Bins
    
    %% Difference between C1/C2 and expected colors C1/C2
    diff_c1_expected = round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(2) y_pre_expectedColors(2)]]), 2);  % [given -C1- C2]
    diff_c2_expected = round(pdist([[x_values(2) y_values(2)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2);  % [given C1 -C2-]
    distance_expectedC1C2 = [distance_expectedC1C2 ; diff_c1_expected + diff_c2_expected];
    
    %% Difference between C1/C2 and other pairs which generate the same color       %% -- CHANGE HERE (ADD MORE PAIRS IF NEEDED)
    diff_c1_pair1c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair1(1) y_pair1(1)]]), 2);   diff_c2_pair1c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair1(2) y_pair1(2)]]), 2);
    distance_pair1 = [distance_pair1 ; diff_c1_pair1c1 + diff_c2_pair1c2];
    
    diff_c1_pair2c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair2(1) y_pair2(1)]]), 2);   diff_c2_pair2c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair2(2) y_pair2(2)]]), 2);
    distance_pair2 = [distance_pair2 ; diff_c1_pair2c1 + diff_c2_pair2c2];
    
    diff_c1_pair3c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair3(1) y_pair3(1)]]), 2);   diff_c2_pair3c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair3(2) y_pair3(2)]]), 2);
    distance_pair3 = [distance_pair3 ; diff_c1_pair3c1 + diff_c2_pair3c2];
    
    diff_c1_pair4c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair4(1) y_pair4(1)]]), 2);   diff_c2_pair4c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair4(2) y_pair4(2)]]), 2);
    distance_pair4 = [distance_pair4 ; diff_c1_pair4c1 + diff_c2_pair4c2];
    
    diff_c1_pair5c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair5(1) y_pair5(1)]]), 2);   diff_c2_pair5c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair5(2) y_pair5(2)]]), 2);
    distance_pair5 = [distance_pair5 ; diff_c1_pair5c1 + diff_c2_pair5c2];
    
    diff_c1_pair6c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair6(1) y_pair6(1)]]), 2);   diff_c2_pair6c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair6(2) y_pair6(2)]]), 2);
    distance_pair6 = [distance_pair6 ; diff_c1_pair6c1 + diff_c2_pair6c2];
    
    diff_c1_pair7c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair7(1) y_pair7(1)]]), 2);   diff_c2_pair7c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair7(2) y_pair7(2)]]), 2);
    distance_pair7 = [distance_pair7 ; diff_c1_pair7c1 + diff_c2_pair7c2];
    
    diff_c1_pair8c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair8(1) y_pair8(1)]]), 2);   diff_c2_pair8c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair8(2) y_pair8(2)]]), 2);
    distance_pair8 = [distance_pair8 ; diff_c1_pair8c1 + diff_c2_pair8c2];
    
    diff_c1_pair9c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair9(1) y_pair9(1)]]), 2);   diff_c2_pair9c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair9(2) y_pair9(2)]]), 2);
    distance_pair9 = [distance_pair9 ; diff_c1_pair9c1 + diff_c2_pair9c2];
    
    diff_c1_pair10c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair10(1) y_pair10(1)]]), 2);   diff_c2_pair10c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair10(2) y_pair10(2)]]), 2);
    distance_pair10 = [distance_pair10 ; diff_c1_pair10c1 + diff_c2_pair10c2];
    
    diff_c1_pair11c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair11(1) y_pair11(1)]]), 2);   diff_c2_pair11c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair11(2) y_pair11(2)]]), 2);
    distance_pair11 = [distance_pair11 ; diff_c1_pair11c1 + diff_c2_pair11c2];
    
    diff_c1_pair12c1 = round(pdist([[x_values(1) y_values(1)] ; [x_pair12(1) y_pair12(1)]]), 2);   diff_c2_pair12c2 = round(pdist([[x_values(2) y_values(2)] ; [x_pair12(2) y_pair12(2)]]), 2);
    distance_pair12 = [distance_pair12 ; diff_c1_pair12c1 + diff_c2_pair12c2];    
    
    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Blend-it in HSV
    sColor_hsv = [(hsv_C1(1)*360) hsv_C1(2) hsv_C1(3)]; tColor_hsv = [(hsv_C2(1)*360) hsv_C2(2) hsv_C2(3)];     
    diff_angles = abs(sColor_hsv(1) - tColor_hsv(1));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        if sum_major > 360
            angle = rem((max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half), 360);
        else
            angle = max([sColor_hsv(1) tColor_hsv(1)]) + angle_small_half;
        end
    else
        angle = min([sColor_hsv(1) tColor_hsv(1)]) + (diff_angles / 2);
    end
    rColor = rgb2xyz(hsv2rgb(([(angle/360) sColor_hsv(2) sColor_hsv(3)])));                                  % hsv -> rgb -> xyz -> compare 
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_HSV = [distance_HSV; round(pdist([[x_aux y_aux]; [x_pre_models(1) y_pre_models(1)]]),2)];
    x_values_HSV = [x_values_HSV x_aux]; y_values_HSV = [y_values_HSV y_aux];
    
    %%%%%% Blend-it in CIE-LCh (XYZ -> Lab -> LCh)
    sColor_lch = sColor; tColor_lch = tColor;
    sColor_lch = applycform(applycform(sColor_lch, cformXYZ_Lab), cformLab_LCh); tColor_lch = applycform(applycform(tColor_lch, cformXYZ_Lab), cformLab_LCh);
    sColor_lch = [sColor_lch(1) sColor_lch(2) (sColor_lch(3)*360)]; tColor_lch = [tColor_lch(1) tColor_lch(2) (tColor_lch(3)*360)];
    l_aux = (abs(sColor_lch(1) - tColor_lch(1)) / 2) + min([sColor_lch(1) tColor_lch(1)]);  % diff between colors, and add half to the smallest
    c_aux = (abs(sColor_lch(2) - tColor_lch(2)) / 2) + min([sColor_lch(2) tColor_lch(2)]);
    diff_angles = abs(sColor_lch(3) - tColor_lch(3));
    if diff_angles > 180
        angle_small = (360 - diff_angles);  % smallest angle
        angle_small_half = angle_small / 2;
        sum_major = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        if sum_major > 360
            h_aux = rem((max([sColor_lch(3) tColor_lch(3)]) + angle_small_half), 360);
        else
            h_aux = max([sColor_lch(3) tColor_lch(3)]) + angle_small_half;
        end
    else
        h_aux = min([sColor_lch(3) tColor_lch(3)]) + (diff_angles / 2);
    end
    rColor = applycform(applycform([l_aux c_aux (h_aux/360)], cformLCh_Lab), cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_LCh = [distance_LCh; round(pdist([[x_aux y_aux]; [x_pre_models(2) y_pre_models(2)]]), 2)];
    x_values_LCh = [x_values_LCh x_aux]; y_values_LCh = [y_values_LCh y_aux];
    
    %%%%%% Blend-it in CMYK
    sColor_cmyk = sColor; tColor_cmyk = tColor;
    sColor_cmyk = applycform(applycform(sColor_cmyk, cformXYZ_RGB), cformRGB_CMYK); tColor_cmyk = applycform(applycform(tColor_cmyk, cformXYZ_RGB), cformRGB_CMYK);
    sColor_cmyk = [sColor_cmyk(1) sColor_cmyk(2) sColor_cmyk(3)]; tColor_cmyk = [tColor_cmyk(1) tColor_cmyk(2) tColor_cmyk(3)]; %Exclude 'K' component
    c_aux = (abs(sColor_cmyk(1) - tColor_cmyk(1)) / 2) + min([sColor_cmyk(1) tColor_cmyk(1)]);
    m_aux = (abs(sColor_cmyk(2) - tColor_cmyk(2)) / 2) + min([sColor_cmyk(2) tColor_cmyk(2)]);
    y_aux = (abs(sColor_cmyk(3) - tColor_cmyk(3)) / 2) + min([sColor_cmyk(3) tColor_cmyk(3)]);
    rColor = applycform(applycform([c_aux m_aux y_aux 0], cformCMYK_RGB), cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_CMYK = [distance_CMYK; round(pdist([[x_aux y_aux]; [x_pre_models(3) y_pre_models(3)]]), 2)];
    x_values_CMYK = [x_values_CMYK x_aux]; y_values_CMYK = [y_values_CMYK y_aux];
    
    %%%%%% Blend-it in RGB
    sColor_rgb = sColor; tColor_rgb = tColor;
    sColor_rgb = applycform(sColor_rgb, cformXYZ_RGB); tColor_rgb = applycform(tColor_rgb, cformXYZ_RGB);
    r_aux = (abs(sColor_rgb(1) - tColor_rgb(1)) / 2) + min([sColor_rgb(1) tColor_rgb(1)]);
    g_aux = (abs(sColor_rgb(2) - tColor_rgb(2)) / 2) + min([sColor_rgb(2) tColor_rgb(2)]);
    b_aux = (abs(sColor_rgb(3) - tColor_rgb(3)) / 2) + min([sColor_rgb(3) tColor_rgb(3)]);
    rColor = applycform([r_aux g_aux b_aux], cformRGB_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_RGB = [distance_RGB; round(pdist([[x_aux y_aux]; [x_pre_models(4) y_pre_models(4)]]), 2)];
    x_values_RGB = [x_values_RGB x_aux]; y_values_RGB = [y_values_RGB y_aux];
    
    %%%%%% Blend-it in CIE-Lab
    sColor_lab = sColor; tColor_lab = tColor;
    sColor_lab = applycform(sColor_lab, cformXYZ_Lab); tColor_lab = applycform(tColor_lab, cformXYZ_Lab);
    l_aux = (abs(sColor_lab(1) - tColor_lab(1)) / 2) + min([sColor_lab(1) tColor_lab(1)]);
    a_aux = (abs(sColor_lab(2) - tColor_lab(2)) / 2) + min([sColor_lab(2) tColor_lab(2)]);
    b_aux = (abs(sColor_lab(3) - tColor_lab(3)) / 2) + min([sColor_lab(3) tColor_lab(3)]);
    rColor = applycform([l_aux a_aux b_aux], cformLab_XYZ);
    x_aux  = rColor(1)/(rColor(1) + rColor(2) + rColor(3)); y_aux = rColor(2)/(rColor(1) + rColor(2) + rColor(3));
    distance_Lab = [distance_Lab; round(pdist([[x_aux y_aux]; [x_pre_models(5) y_pre_models(5)]]), 2)];
    x_values_Lab = [x_values_Lab x_aux]; y_values_Lab = [y_values_Lab y_aux];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_uncalibratedUsers'), 'png'); 

diffs_table = table(distance_expectedC1C2, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
diffs_pairs = table(distance_pair1,distance_pair2,distance_pair3,distance_pair4,distance_pair5,distance_pair6,distance_pair7,distance_pair8,distance_pair9,distance_pair10,distance_pair11,distance_pair12);
diffs_table = [diffs_table diffs_pairs];

onlineResults_uncal = [onlineResults_uncal diffs_table];

% Centroids of Color Models
centroid_HSV    = [centroid_HSV  ; [round(mean(x_values_HSV),2) round(mean(y_values_HSV),2)]];
centroid_LCh    = [centroid_LCh  ; [round(mean(x_values_LCh),2) round(mean(y_values_LCh),2)]];
centroid_CMYK   = [centroid_CMYK ; [round(mean(x_values_CMYK),2) round(mean(y_values_CMYK),2)]];
centroid_RGB    = [centroid_RGB  ; [round(mean(x_values_RGB),2) round(mean(y_values_RGB),2)]];
centroid_Lab    = [centroid_Lab  ; [round(mean(x_values_Lab),2) round(mean(y_values_Lab),2)]];

distance_centroid_HSV = [distance_centroid_HSV ; round(pdist([mean(x_values_HSV) mean(y_values_HSV); [x_pre_models(1) y_pre_models(1)]]), 2)];
distance_centroid_LCh = [distance_centroid_LCh ; round(pdist([mean(x_values_LCh) mean(y_values_LCh); [x_pre_models(2) y_pre_models(2)]]), 2)];
distance_centroid_CMYK = [distance_centroid_CMYK ; round(pdist([mean(x_values_CMYK) mean(y_values_CMYK); [x_pre_models(3) y_pre_models(3)]]), 2)];
distance_centroid_RGB = [distance_centroid_RGB ; round(pdist([mean(x_values_RGB) mean(y_values_RGB); [x_pre_models(4) y_pre_models(4)]]), 2)];
distance_centroid_Lab = [distance_centroid_Lab ; round(pdist([mean(x_values_Lab) mean(y_values_Lab); [x_pre_models(5) y_pre_models(5)]]), 2)];

rowNames = {'Laboratory Users';'Online Users (Regular)';'Online Users (Uncalibrated)'};
centroidsTable  = table(centroid_HSV, distance_centroid_HSV, centroid_LCh, distance_centroid_LCh, centroid_CMYK, distance_centroid_CMYK, centroid_RGB, distance_centroid_RGB, centroid_Lab, distance_centroid_Lab, 'RowNames', rowNames);

%% Save Tables

rowNames = {'Laboratory Users';'Online Users (Regular)';'Online Users (Uncalibrated)';'Users aged Less Than 20 Years';'Users aged Between 20 and 29 Years';'Users aged Between 30 and 39 Years';'Users aged Between 40 and 49 Years';'Users aged Between 50 and 59 Years';'Users aged Above 60 Years';'Female Users';'Male Users';'Other Gender Users';};
centroidsTable  = table(centroid_HSV, distance_centroid_HSV, centroid_LCh, distance_centroid_LCh, centroid_CMYK, distance_centroid_CMYK, centroid_RGB, distance_centroid_RGB, centroid_Lab, distance_centroid_Lab, 'RowNames', rowNames);

writetable(onlineResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_online_regular.csv');   % Online Regular Users Results Digested
writetable(onlineResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_online_dalt.csv'); % Online Daltonic Users Results Digested
writetable(onlineResults_uncal, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_online_uncal.csv'); % Online Uncalibrated Users Results Digested

writetable(laboratoryResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_lab_regular.csv');     % Laboratory Regular Users Results Digested
writetable(laboratoryResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_lab_dalt.csv');   % Laboratory Daltonic Users Results Digested

writetable(centroidsTable, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_centroids.csv', 'WriteRowNames', true);   % Centroids of all users' responses.

writetable(demoResultsAge_20, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_20.csv', 'WriteRowNames', true);
writetable(demoResultsAge_20_29, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_20_29.csv', 'WriteRowNames', true);
writetable(demoResultsAge_30_39, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_30_39.csv', 'WriteRowNames', true);
writetable(demoResultsAge_40_49, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_40_49.csv', 'WriteRowNames', true);
writetable(demoResultsAge_50_59, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_50_59.csv', 'WriteRowNames', true);
writetable(demoResultsAge_60, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_age_60.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Female, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_femaleGender.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Male, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_maleGender.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Other, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 15/q15_otherGender.csv', 'WriteRowNames', true);