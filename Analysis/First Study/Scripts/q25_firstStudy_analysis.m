%% Question 25 - twoColorsObj: Magenta + Yellow = Red
% Explanation:
% This file is divided onto some main sections: processing the Laboratory
% Results (both Regular and Daltonic Users) and Online Results
%
% This File draws CIE diagrams and digestes the results to new CSV tables.
%
% #1 Step: Comparing the given answer C3 with the expected one.
% #2 Step: Compare C3 against pre-calculated results for each model,
% HSV, CIE LCh, CMYK, RGB and CIE Lab.

% close all;

path       = '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25';    % -- CHANGE HERE
profileICC_src = 'DEI-1';

x_pre_expectedColors = [];
y_pre_expectedColors = [];
x_aux = 0;
y_aux = 0;
x_values = [];
y_values = [];

distance_HSV = [];
distance_LCh = [];
distance_Lab = [];
distance_CMYK = [];
distance_RGB = [];
distance_expectedC3 = [];

distance_givenColor = [];
whiteAnswers = [];
rowsToEliminate = [];
C3_name = [];
foundC3 = 0;

profileICC      = iccread(profileICC_src);
cformICC        = makecform('mattrc', profileICC, 'Direction', 'forward');
cformRGB_XYZ    = makecform('srgb2xyz');

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
laboratoryResults = tableR_lab(tableR_lab.id_question == 25,:); laboratoryResults = sortrows(laboratoryResults, 'id'); laboratoryResults.id_question = []; laboratoryResults.page_time = []; laboratoryResults.resets = [];
laboratoryResults_dalt = tableDR_lab(tableDR_lab.id_question == 25,:); laboratoryResults_dalt = sortrows(laboratoryResults_dalt, 'id'); laboratoryResults_dalt.id_question = []; laboratoryResults_dalt.page_time = []; laboratoryResults_dalt.resets = [];

% Online Tables     -- CHANGE HERE
onlineResults = tableR_online(tableR_online.id_question == 25,:); onlineResults = sortrows(onlineResults, 'id'); onlineResults.id_question = []; onlineResults.page_time = []; onlineResults.resets = [];
onlineResults_dalt = tableDR_online(tableDR_online.id_question == 25,:); onlineResults_dalt = sortrows(onlineResults_dalt, 'id'); onlineResults_dalt.id_question = []; onlineResults_dalt.page_time = []; onlineResults_dalt.resets = [];
onlineResults_uncal = tableUR_online(tableUR_online.id_question == 25,:); onlineResults_uncal = sortrows(onlineResults_uncal, 'id'); onlineResults_uncal.id_question = []; onlineResults_uncal.page_time = []; onlineResults_uncal.resets = [];

% Demographic Tables -- CHANGE HERE
demoResultsAge_20        = tableDEM_age20(tableDEM_age20.id_question == 25,:); demoResultsAge_20 = sortrows(demoResultsAge_20, 'id'); demoResultsAge_20.id_question = []; demoResultsAge_20.page_time = []; demoResultsAge_20.resets = [];
demoResultsAge_20_29     = tableDEM_age20_29(tableDEM_age20_29.id_question == 25,:); demoResultsAge_20_29 = sortrows(demoResultsAge_20_29, 'id'); demoResultsAge_20_29.id_question = []; demoResultsAge_20_29.page_time = []; demoResultsAge_20_29.resets = [];
demoResultsAge_30_39     = tableDEM_age30_39(tableDEM_age30_39.id_question == 25,:); demoResultsAge_30_39 = sortrows(demoResultsAge_30_39, 'id'); demoResultsAge_30_39.id_question = []; demoResultsAge_30_39.page_time = []; demoResultsAge_30_39.resets = [];
demoResultsAge_40_49     = tableDEM_age40_49(tableDEM_age40_49.id_question == 25,:); demoResultsAge_40_49 = sortrows(demoResultsAge_40_49, 'id'); demoResultsAge_40_49.id_question = []; demoResultsAge_40_49.page_time = []; demoResultsAge_40_49.resets = [];
demoResultsAge_50_59     = tableDEM_age20_29(tableDEM_age20_29.id_question == 25,:); demoResultsAge_20_29 = sortrows(demoResultsAge_20_29, 'id'); demoResultsAge_50_59.id_question = []; demoResultsAge_50_59.page_time = []; demoResultsAge_50_59.resets = [];
demoResultsAge_60        = tableDEM_age60(tableDEM_age60.id_question == 25,:); demoResultsAge_60 = sortrows(demoResultsAge_60, 'id'); demoResultsAge_60.id_question = []; demoResultsAge_60.page_time = []; demoResultsAge_60.resets = [];
demoResultsGender_Female = tableDEM_genF(tableDEM_genF.id_question == 25,:); demoResultsGender_Female = sortrows(demoResultsGender_Female, 'id'); demoResultsGender_Female.id_question = []; demoResultsGender_Female.page_time = []; demoResultsGender_Female.resets = [];
demoResultsGender_Male   = tableDEM_genM(tableDEM_genM.id_question == 25,:); demoResultsGender_Male = sortrows(demoResultsGender_Male, 'id'); demoResultsGender_Male.id_question = []; demoResultsGender_Male.page_time = []; demoResultsGender_Male.resets = [];
demoResultsGender_Other  = tableDEM_genO(tableDEM_genO.id_question == 25,:); demoResultsGender_Other = sortrows(demoResultsGender_Other, 'id'); demoResultsGender_Other.id_question = []; demoResultsGender_Other.page_time = []; demoResultsGender_Other.resets = [];

%% Pre-calculated Values

% Expected Colors   -- CHANGE HERE
given_color_C1 = hsvTable{5,{'H','S','V'}}; given_color_C1 = applycform((given_color_C1/255), cformRGB_XYZ);   % Position - 'M'
given_color_C2 = hsvTable{6,{'H','S','V'}}; given_color_C2 = applycform((given_color_C2/255), cformRGB_XYZ);    % Position - 'Y'
expected_C3    = hsvTable{15,{'H','S','V'}}; expected_C3 = applycform((expected_C3/255), cformRGB_XYZ);             % Position - 'M+Y'

% Results of this combination in each Color Model  -- CHANGE HERE
pre_HSV  =  hsvTable{15,{'H','S','V'}};  pre_HSV  =  applycform((pre_HSV/255), cformRGB_XYZ);
pre_LCh  =  lchTable{14,{'L','C','h'}};  pre_LCh  =  applycform((pre_LCh/255), cformRGB_XYZ);
pre_CMYK =  cmykTable{14,{'C','M','Y'}}; pre_CMYK =  applycform((pre_CMYK/255), cformRGB_XYZ);
pre_RGB  =  rgbTable{14,{'R','G','B'}};  pre_RGB  =  applycform((pre_RGB/255), cformRGB_XYZ);
pre_Lab  =  labTable{14,{'L','a','b'}};  pre_Lab  =  applycform((pre_Lab/255), cformRGB_XYZ);

% Coordinates XYY for Expected Colors (for CIE Chromaticity Diagram)
x_pre_expectedColors = [given_color_C1(1)/(given_color_C1(1) + given_color_C1(2) + given_color_C1(3)) given_color_C2(1)/(given_color_C2(1) + given_color_C2(2) + given_color_C2(3)) expected_C3(1)/(expected_C3(1) + expected_C3(2) + expected_C3(3))];
y_pre_expectedColors = [given_color_C1(2)/(given_color_C1(1) + given_color_C1(2) + given_color_C1(3)) given_color_C2(2)/(given_color_C2(1) + given_color_C2(2) + given_color_C2(3)) expected_C3(2)/(expected_C3(1) + expected_C3(2) + expected_C3(3))];

% Coordinates XYY for Color Models' results
x_pre_models = [pre_HSV(1)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(1)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(1)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(1)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(1)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];
y_pre_models = [pre_HSV(2)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(2)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(2)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(2)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(2)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];

%% Laboratory Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 25: Laboratory Regular Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(laboratoryResults)
    %% Check if any Component is white or empty Answer
    tColor = str2num(cell2mat(laboratoryResults.third_color(i)));

    if tColor == 0
        whiteAnswers = [whiteAnswers ; laboratoryResults(i,:)];
        rowsToEliminate = [rowsToEliminate i];
        continue
    end

    %% Third Color - C3
    tColor = cell2mat(laboratoryResults.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'lab_regularUsers'), 'png'); close;
laboratoryResults(rowsToEliminate, :) = []; rowsToEliminate = [];

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
laboratoryResults = [laboratoryResults colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Laboratory Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 25: Laboratory Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

for i = 1 : height(laboratoryResults_dalt)
    %% Third Color - C3
    tColor = cell2mat(laboratoryResults_dalt.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'lab_daltonicUsers'), 'png'); close;
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
laboratoryResults_dalt = [laboratoryResults_dalt colors_names];
%% Online Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 25: Online Regular Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

for i = 1 : height(onlineResults)                                  %draw every pair of responses.
    %% Check if any Component is white or empty Answer
    tColor = str2num(cell2mat(onlineResults.third_color(i)));

    if tColor == 0
        whiteAnswers = [whiteAnswers ; onlineResults(i,:)];
        rowsToEliminate = [rowsToEliminate i];
        continue
    end

    %% Third Color - C3
    tColor = cell2mat(onlineResults.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_regularUsers'), 'png'); close;
onlineResults(rowsToEliminate, :) = []; rowsToEliminate = [];

diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
onlineResults = [onlineResults colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Online Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 25: Online Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

for i = 1 : height(onlineResults_dalt)
%% Third Color - C3
    tColor = cell2mat(onlineResults_dalt.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_daltonicUsers'), 'png'); close;

if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
onlineResults_dalt = [onlineResults_dalt colors_names];

%% Online Results - Uncalibrated Users

figure('NumberTitle','off');
cieplot();
title('Question 25: Online Uncalibrated Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

for i = 1 : height(onlineResults_uncal)                                  %draw every pair of responses.
    %% Third Color - C3
    tColor = cell2mat(onlineResults_uncal.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_uncalibratedUsers'), 'png'); close;

diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
onlineResults_uncal = [onlineResults_uncal colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE <= 20

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Less Than 20 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_20)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_20.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age20'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_20 = [demoResultsAge_20 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE 20 - 29

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Between 20 and 29 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_20_29)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_20_29.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age20_29'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_20_29 = [demoResultsAge_20_29 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE 30 - 39

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Between 30 and 39 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_30_39)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_30_39.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age30_39'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_30_39 = [demoResultsAge_30_39 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE 40 - 49

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Between 40 and 49 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_40_49)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_40_49.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age40_49'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_40_49 = [demoResultsAge_40_49 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE 50 - 59

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Between 50 and 59 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_50_59)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_50_59.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age50_59'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_50_59 = [demoResultsAge_50_59 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - AGE >= 60

figure('NumberTitle','off');
cieplot();
title('Question 25: Users Aged Over 60 Years', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsAge_60)
    %% Third Color - C3
    tColor = cell2mat(demoResultsAge_60.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_age60'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsAge_60 = [demoResultsAge_60 colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - GENDER Female

figure('NumberTitle','off');
cieplot();
title('Question 25: Female Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsGender_Female)
    %% Third Color - C3
    tColor = cell2mat(demoResultsGender_Female.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_genderFemale'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsGender_Female = [demoResultsGender_Female colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - GENDER Male

figure('NumberTitle','off');
cieplot();
title('Question 25: Male Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsGender_Male)
    %% Third Color - C3
    tColor = cell2mat(demoResultsGender_Male.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_genderMale'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsGender_Male = [demoResultsGender_Male colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Demographic Analysis - GENDER Other

figure('NumberTitle','off');
cieplot();
title('Question 25: Other Gender Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'diamond', 'black');                   %draw EXPECTED COLOR

scatter(x_pre_models(1), y_pre_models(1), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(1) + 0.02, y_pre_models(1), '\leftarrow HSV');
scatter(x_pre_models(2), y_pre_models(2), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(2) + 0.01, y_pre_models(2), ' \leftarrow LCh');
scatter(x_pre_models(3), y_pre_models(3), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(3) - 0.02, y_pre_models(3) + 0.03, 'CMYK');
scatter(x_pre_models(4), y_pre_models(4), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(4) + 0.01, y_pre_models(4) - 0.02, 'RGB');
scatter(x_pre_models(5), y_pre_models(5), 50, 'diamond', 'black', 'Filled');
text(x_pre_models(5) - 0.02, y_pre_models(5) - 0.03, 'Lab');

% Draw every pair of responses.
for i = 1 : height(demoResultsGender_Other)
    %% Third Color - C3
    tColor = cell2mat(demoResultsGender_Other.third_color(i));       % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);                    % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);                    % GG
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);                    % BB
    tColor = applycform([r g b], cformICC);
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));
    x_values = [x_values x_aux];                                        % store coordinates X and Y
    y_values = [y_values y_aux];

    %% Categorize Colors - Bins
    for j = 1 : length(colorBins)
        valuesofx = round(colorBins(j).XData, 1);
        valuesofy = round(colorBins(j).YData, 1);
        if foundC3 == 0 && ismember(round(x_values(1), 1), valuesofx) && ismember(round(y_values(1),1), valuesofy)
            color_C3 = colorBins(j).Tag;
            foundC3 = 1;
        end
    end

    if foundC3 == 0
        C3_name = [C3_name ; 'NA       '];
    else
        C3_name = [C3_name ; color_C3];
    end

    foundC3 = 0;

    %% Difference between C1/C2 and expected colors C1/C2
    distance_expectedC3 = [distance_expectedC3 ; round(pdist([[x_values(1) y_values(1)] ; [x_pre_expectedColors(3) y_pre_expectedColors(3)]]), 2)];  % [given given -C3-]

    %% Difference between C1/C2 blended onto Color Models against pre-calc values
    %%%%%% Compare-it in HSV
    distance_HSV = [distance_HSV; round(pdist([[x_values y_values]; [x_pre_models(1) y_pre_models(1)]]),2)];

    %%%%%% Compare-it in CIE-LCh
    distance_LCh = [distance_LCh; round(pdist([[x_values y_values]; [x_pre_models(2) y_pre_models(2)]]), 2)];

    %%%%%% Compare-it in CMYK
    distance_CMYK = [distance_CMYK; round(pdist([[x_values y_values]; [x_pre_models(3) y_pre_models(3)]]), 2)];

    %%%%%% Compare-it in RGB
    distance_RGB = [distance_RGB; round(pdist([[x_values y_values]; [x_pre_models(4) y_pre_models(4)]]), 2)];

    %%%%%% Blend-it in CIE-Lab
    distance_Lab = [distance_Lab; round(pdist([[x_values y_values]; [x_pre_models(5) y_pre_models(5)]]), 2)];

    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'demographic_genderOther'), 'png'); close;

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
if size(C3_name, 1) == 1
    colors_names = cell(1,1);
    colors_names(1,1) = cellstr(C3_name);
    colors_names = cell2table(colors_names);
else
    colors_names = table(C3_name);
end

C3_name = [];
demoResultsGender_Other = [demoResultsGender_Other colors_names diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Save Tables

writetable(onlineResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_online_regular.csv');   % Online Regular Users Results Digested
writetable(onlineResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_online_dalt.csv'); % Online Daltonic Users Results Digested
writetable(onlineResults_uncal, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_online_uncal.csv'); % Online Uncalibrated Users Results Digested

writetable(laboratoryResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_lab_regular.csv');     % Laboratory Regular Users Results Digested
writetable(laboratoryResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_lab_dalt.csv');   % Laboratory Daltonic Users Results Digested

if isempty(whiteAnswers) ~= 1
    writetable(whiteAnswers,  '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_whiteAnswers.csv')
end

writetable(demoResultsAge_20, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_20.csv', 'WriteRowNames', true);
writetable(demoResultsAge_20_29, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_20_29.csv', 'WriteRowNames', true);
writetable(demoResultsAge_30_39, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_30_39.csv', 'WriteRowNames', true);
writetable(demoResultsAge_40_49, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_40_49.csv', 'WriteRowNames', true);
writetable(demoResultsAge_50_59, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_50_59.csv', 'WriteRowNames', true);
writetable(demoResultsAge_60, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_age_60.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Female, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_femaleGender.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Male, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_maleGender.csv', 'WriteRowNames', true);
writetable(demoResultsGender_Other, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 25/q25_otherGender.csv', 'WriteRowNames', true);
