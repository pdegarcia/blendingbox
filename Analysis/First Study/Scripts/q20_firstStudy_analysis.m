%% Question 20 - twoColorsObj: Green + Blue = Cyan
% Explanation: 
% This file is divided onto some main sections: processing the Laboratory
% Results (both Regular and Daltonic Users) and Online Results
%
% This File draws CIE diagrams and digestes the results to new CSV tables.
%
% #1 Step: Comparing the given answer C3 with the expected one.
% #2 Step: Compare C3 against pre-calculated results for each model,  
% HSV, CIE LCh, CMYK, RGB and CIE Lab.

close all;
ColorConverter;
process_colorBins;

path       = '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20';    % -- CHANGE HERE
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

tableU_lab = readtable(users_lab, 'Delimiter', ',');
tableU_online = readtable(users_online, 'Delimiter', ',');

tableR_lab = readtable(results_lab, 'Delimiter', ',');
tableR_online = readtable(results_online, 'Delimiter', ';');

tableDR_lab = readtable(daltonic_results_lab, 'Delimiter', ',');
tableDR_online = readtable(daltonic_results_online, 'Delimiter', ';');

tableUR_online = readtable(uncalibrated_results_online, 'Delimiter', ';');

%% Tables

% Laboratory Tables -- CHANGE HERE
laboratoryResults = tableR_lab(tableR_lab.id_question == 20,:); laboratoryResults = sortrows(laboratoryResults, 'id'); laboratoryResults.id_question = []; laboratoryResults.page_time = []; laboratoryResults.resets = []; 
laboratoryResults_dalt = tableDR_lab(tableDR_lab.id_question == 20,:); laboratoryResults_dalt = sortrows(laboratoryResults_dalt, 'id'); laboratoryResults_dalt.id_question = []; laboratoryResults_dalt.page_time = []; laboratoryResults_dalt.resets = [];

% Online Tables     -- CHANGE HERE
onlineResults = tableR_online(tableR_online.id_question == 20,:); onlineResults = sortrows(onlineResults, 'id'); onlineResults.id_question = []; onlineResults.page_time = []; onlineResults.resets = []; 
onlineResults_dalt = tableDR_online(tableDR_online.id_question == 20,:); onlineResults_dalt = sortrows(onlineResults_dalt, 'id'); onlineResults_dalt.id_question = []; onlineResults_dalt.page_time = []; onlineResults_dalt.resets = [];
onlineResults_uncal = tableUR_online(tableUR_online.id_question == 20,:); onlineResults_uncal = sortrows(onlineResults_uncal, 'id'); onlineResults_uncal.id_question = []; onlineResults_uncal.page_time = []; onlineResults_uncal.resets = [];

%% Pre-calculated Values

% Expected Colors   -- CHANGE HERE
given_color_C1 = hsvTable{2,{'H','S','V'}}; given_color_C1 = applycform((given_color_C1/255), cformRGB_XYZ);   % Position - 'G'
given_color_C2 = hsvTable{3,{'H','S','V'}}; given_color_C2 = applycform((given_color_C2/255), cformRGB_XYZ);    % Position - 'B'
expected_C3    = hsvTable{9,{'H','S','V'}}; expected_C3 = applycform((expected_C3/255), cformRGB_XYZ);             % Position - 'G+B'

% Results of this combination in each Color Model (Pair: 'R-G', Position 7) -- CHANGE HERE
pre_HSV  =  hsvTable{9,{'H','S','V'}};  pre_HSV  =  applycform((pre_HSV/255), cformRGB_XYZ);                  
pre_LCh  =  lchTable{9,{'L','C','h'}};  pre_LCh  =  applycform((pre_LCh/255), cformRGB_XYZ);                  
pre_CMYK =  cmykTable{9,{'C','M','Y'}}; pre_CMYK =  applycform((pre_CMYK/255), cformRGB_XYZ);
pre_RGB  =  rgbTable{9,{'R','G','B'}};  pre_RGB  =  applycform((pre_RGB/255), cformRGB_XYZ);
pre_Lab  =  labTable{9,{'L','a','b'}};  pre_Lab  =  applycform((pre_Lab/255), cformRGB_XYZ);

% Coordinates XYY for Expected Colors (for CIE Chromaticity Diagram) 
x_pre_expectedColors = [given_color_C1(1)/(given_color_C1(1) + given_color_C1(2) + given_color_C1(3)) given_color_C2(1)/(given_color_C2(1) + given_color_C2(2) + given_color_C2(3)) expected_C3(1)/(expected_C3(1) + expected_C3(2) + expected_C3(3))];
y_pre_expectedColors = [given_color_C1(2)/(given_color_C1(1) + given_color_C1(2) + given_color_C1(3)) given_color_C2(2)/(given_color_C2(1) + given_color_C2(2) + given_color_C2(3)) expected_C3(2)/(expected_C3(1) + expected_C3(2) + expected_C3(3))];

% Coordinates XYY for Color Models' results
x_pre_models = [pre_HSV(1)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(1)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(1)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(1)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(1)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];
y_pre_models = [pre_HSV(2)/(pre_HSV(1) + pre_HSV(2) + pre_HSV(3)) pre_LCh(2)/(pre_LCh(1) + pre_LCh(2) + pre_LCh(3)) pre_CMYK(2)/(pre_CMYK(1) + pre_CMYK(2) + pre_CMYK(3)) pre_RGB(2)/(pre_RGB(1) + pre_RGB(2) + pre_RGB(3)) pre_Lab(2)/(pre_Lab(1) + pre_Lab(2) + pre_Lab(3))];

%% Laboratory Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 20: Laboratory Regular Users', 'FontSize', 13);              %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

% Draw every pair of responses.
for i = 1 : height(laboratoryResults)                                     
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

saveas(gcf, fullfile(path, 'lab_regularUsers'), 'png');

% Catenate all Tables               -- CHANGE HERE
diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
laboratoryResults = [laboratoryResults diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Laboratory Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 20: Laboratory Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

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
    
    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'lab_daltonicUsers'), 'png'); 

%% Online Results - Regular Users

figure('NumberTitle','off');
cieplot();
title('Question 20: Online Regular Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

for i = 1 : height(onlineResults)                                  %draw every pair of responses.
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

saveas(gcf, fullfile(path, 'online_regularUsers'), 'png'); 

diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
onlineResults = [onlineResults diffs_table];

% Clean all the tables!
distance_HSV = []; distance_LCh = []; distance_CMYK = []; distance_RGB = []; distance_Lab = [];
distance_expectedC3 = [];

%% Online Results - Daltonic Users

figure('NumberTitle','off');
cieplot();
title('Question 20: Online Daltonic Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

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
    
    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

saveas(gcf, fullfile(path, 'online_daltonicUsers'), 'png'); 

%% Online Results - Uncalibrated Users

figure('NumberTitle','off');
cieplot();
title('Question 20: Online Uncalibrated Users', 'FontSize', 13);                 %% -- CHANGE HERE
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre_expectedColors(1), y_pre_expectedColors(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(2), y_pre_expectedColors(2), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre_expectedColors(3), y_pre_expectedColors(3), 60, 'black');                   %draw EXPECTED COLOR

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

saveas(gcf, fullfile(path, 'online_uncalibratedUsers'), 'png'); 

diffs_table = table(distance_expectedC3, distance_HSV, distance_LCh, distance_CMYK, distance_RGB, distance_Lab);
onlineResults_uncal = [onlineResults_uncal diffs_table];

%% Save Tables

writetable(onlineResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20/q20_online_regular.csv');   % Online Regular Users Results Digested
writetable(onlineResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20/q20_online_dalt.csv'); % Online Daltonic Users Results Digested
writetable(onlineResults_uncal, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20/q20_online_uncal.csv'); % Online Uncalibrated Users Results Digested

writetable(laboratoryResults, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20/q20_lab_regular.csv');     % Laboratory Regular Users Results Digested
writetable(laboratoryResults_dalt, '/Users/PauloGarcia/Documents/MATLAB/Results/First Study/Question 20/q20_lab_dalt.csv');   % Laboratory Daltonic Users Results Digested