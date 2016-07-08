close all;

valuesSColor = [];
valuesTColor = [];
x_pre = [];
y_pre = [];
x_values = [];
y_values = [];
x_aux = 0;
y_aux = 0;
pathLab = '/Users/PauloGarcia/Documents/MATLAB/lab_diagrams';

profileSrc = 'DEI-1';                % MODIFY PROFILE NAME.

profile = iccread(profileSrc);
iccTransform = makecform('mattrc', profile, 'Direction', 'forward');

%% Analyze Laboratory Users %%

users_lab = 'data_first_labUsers.csv';
results_lab = 'data_first_laboratory_results.csv';
daltonic_results_lab = 'data_first_laboratory_daltonic_results.csv';

tableU_lab = readtable(users_lab, 'Delimiter', ',');
tableR_lab = readtable(results_lab, 'Delimiter', ',');
tableDR_lab = readtable(daltonic_results_lab, 'Delimiter', ',');

%% Question 1 - objTwoColors: Yellow = Red + Green

q1_lab = tableR_lab(tableR_lab.id_question == 1,:); q1_lab = sortrows(q1_lab, 'id');
q1_dalt_lab = tableDR_lab(tableDR_lab.id_question == 1,:); q1_dalt_lab = sortrows(q1_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(60/360) 1 1]));         %yellow - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(120/360) 1 1]));    %green  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 1: Yellow (Given) = Red (Exp) + Green (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 1: Yellow (Given) = Red (Exp) + Green (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q1_lab)                                  %draw every pair of responses.
    %First Color
    sColor = str2num(cell2mat(q1_lab.second_color(i)));     %cell2mat serve para converter cell para matriz de uint
    valuesSColor = [valuesSColor sColor];                   %store integers values of answers
    sColor = sColor/360;                                    %scale value to [0,1] instead of [0, 360]
    sColor = [sColor 1 .5];                                 %form triplet (sColor, 1, 0.5)
    sColor = hsv2rgb(sColor);                               %hsv -> rgb, values between [0,1]
    sColor = rgb2xyz(sColor);                               %rgb -> xyz
    x_aux = sColor(1)/(sColor(1) + sColor(2) + sColor(3));  %x = X / (X + Y + Z)
    y_aux = sColor(2)/(sColor(1) + sColor(2) + sColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    %Second Color
    tColor = str2num(cell2mat(q1_lab.third_color(i)));
    valuesTColor = [valuesTColor tColor];                   %store integers values of answers
    tColor = tColor/360;                                    %scale value to [0,1] instead of [0, 360]
    tColor = [tColor 1 .5];                                 %form triplet (tColor, 1, 0.5)
    tColor = hsv2rgb(tColor);                               %hsv -> rgb, values between [0,1]
    tColor = rgb2xyz(tColor);                               %rgb -> xyz
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3));  %x = X / (X + Y + Z)
    y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3));  %x = Y / (X + Y + Z)
    x_values = [x_values x_aux];                                    %store coordinates X and Y
    y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white');                         %draw two responses
    plot(x_values, y_values, 'Color', 'black');                     %draw relations between answers
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                              %clean the arrays
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q1_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q1_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q1_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_1'), 'png');

%% Question 2 - objTwoColors: Magenta = Red + Blue

q2_lab = tableR_lab(tableR_lab.id_question == 2,:); q2_lab = sortrows(q2_lab, 'id');
q2_dalt_lab = tableDR_lab(tableDR_lab.id_question == 2,:); q2_dalt_lab = sortrows(q2_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(300/360) 1 1]));        %magenta - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(240/360) 1 1]));    %blue  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 2: Magenta (Given) = Red (Exp) + Blue (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 2: Magenta (Given) = Red (Exp) + Blue (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q2_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q2_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q2_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q2_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q2_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q2_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_2'), 'png');

%% Question 3 - objTwoColors: Green = Red + Cyan

q3_lab = tableR_lab(tableR_lab.id_question == 3,:); q3_lab = sortrows(q3_lab, 'id');
q3_dalt_lab = tableDR_lab(tableDR_lab.id_question == 3,:); q3_dalt_lab = sortrows(q3_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(90/360) 1 1]));        %green - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));    %cyan  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 3: Green (Given) = Red (Exp) + Cyan (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 3: Green(Given) = Red (Exp) + Cyan (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q3_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q3_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q3_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q3_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q3_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q3_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_3'), 'png');

%% Question 4 - objTwoColors: Purple = Red + Cyan

q4_lab = tableR_lab(tableR_lab.id_question == 4,:); q4_lab = sortrows(q4_lab, 'id');
q4_dalt_lab = tableDR_lab(tableDR_lab.id_question == 4,:); q4_dalt_lab = sortrows(q4_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(270/360) 1 1]));        %purple - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));    %cyan  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 4: Purple (Given) = Red (Exp) + Cyan (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 4: Purple (Given) = Red (Exp) + Cyan (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q4_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q4_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q4_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q4_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q4_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q4_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_4'), 'png');

%% Question 5 - objTwoColors: Dark Red = Red + Magenta 

q5_lab = tableR_lab(tableR_lab.id_question == 5,:); q5_lab = sortrows(q5_lab, 'id');
q5_dalt_lab = tableDR_lab(tableDR_lab.id_question == 5,:); q5_dalt_lab = sortrows(q5_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(330/360) 1 1]));        %dark red - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    %magenta  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 5: Dark Red (Given) = Red (Exp) + Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 5: Dark Red (Given) = Red (Exp) + Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q5_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q5_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q5_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q5_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q5_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q5_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_5'), 'png');

%% Question 6 - objTwoColors: Orange = Red + Yellow

q6_lab = tableR_lab(tableR_lab.id_question == 6,:); q6_lab = sortrows(q6_lab, 'id');
q6_dalt_lab = tableDR_lab(tableDR_lab.id_question == 6,:); q6_dalt_lab = sortrows(q6_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(30/360) 1 1]));        %orange - HSV
expected_color1 = rgb2xyz(hsv2rgb([0 1 1]));            %red    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));    %yellow  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 6: Orange (Given) = Red (Exp) + Yellow(Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 6: Orange (Given) = Red (Exp) + Yellow(Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q6_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q6_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q6_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q6_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q6_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q6_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_6'), 'png');

%% Question 7 - objTwoColors: Purplish-Blue = Cyan + Magenta

q7_lab = tableR_lab(tableR_lab.id_question == 7,:); q7_lab = sortrows(q7_lab, 'id');
q7_dalt_lab = tableDR_lab(tableDR_lab.id_question == 7,:); q7_dalt_lab = sortrows(q7_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(240/360) 1 1]));        %purplish-blue - HSV
expected_color1 = rgb2xyz(hsv2rgb([(180/360) 1 1]));    %cyan    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    %magenta  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 7: Purplish-Blue (Given) = Cyan (Exp) + Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 7: Purplish-Blue (Given) = Cyan (Exp) + Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q7_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q7_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q7_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q7_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q7_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q7_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_7'), 'png');

%% Question 8 - objTwoColors: Red = Magenta + Yellow

q8_lab = tableR_lab(tableR_lab.id_question == 8,:); q8_lab = sortrows(q8_lab, 'id');
q8_dalt_lab = tableDR_lab(tableDR_lab.id_question == 8,:); q8_dalt_lab = sortrows(q8_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(0/360) 1 1]));        %red - HSV
expected_color1 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    %magenta    - HSV
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));    %yellow  - HSV

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 8: Red (Given) = Magenta (Exp) + Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 8: Red (Given) = Magenta (Exp) + Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q8_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q8_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q8_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q8_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q8_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q8_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_8'), 'png');

%% Question 9 - objTwoColors: Lime-Green = Green + Cyan 

q9_lab = tableR_lab(tableR_lab.id_question == 9,:); q9_lab = sortrows(q9_lab, 'id');
q9_dalt_lab = tableDR_lab(tableDR_lab.id_question == 9,:); q9_dalt_lab = sortrows(q9_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(150/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 9: Lime-Green (Given) = Green (Exp) + Cyan (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 9: Lime-Green (Given) = Green (Exp) + Cyan (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q9_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q9_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q9_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q9_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q9_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q9_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_9'), 'png');

%% Question 10 - objTwoColors: Blue = Green + Magenta

q10_lab = tableR_lab(tableR_lab.id_question == 10,:); q10_lab = sortrows(q10_lab, 'id');
q10_dalt_lab = tableDR_lab(tableDR_lab.id_question == 10,:); q10_dalt_lab = sortrows(q10_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(210/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 10: Blue (Given) = Green (Exp) + Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 10: Blue (Given) = Green (Exp) + Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q10_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q10_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q10_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q10_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q10_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q10_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_10'), 'png');

%% Question 11 - objTwoColors: Orange = Green + Magenta

q11_lab = tableR_lab(tableR_lab.id_question == 11,:); q11_lab = sortrows(q11_lab, 'id');
q11_dalt_lab = tableDR_lab(tableDR_lab.id_question == 11,:); q11_dalt_lab = sortrows(q11_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(30/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 11: Orange (Given) = Green (Exp) + Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 11: Orange (Given) = Green (Exp) + Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q11_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q11_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q11_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q11_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q11_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q11_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_11'), 'png');

%% Question 12 - objTwoColors: Lighter-Green = Green + Yellow

q12_lab = tableR_lab(tableR_lab.id_question == 12,:); q12_lab = sortrows(q12_lab, 'id');
q12_dalt_lab = tableDR_lab(tableDR_lab.id_question == 12,:); q12_dalt_lab = sortrows(q12_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(90/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));   

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 12: Lighter-Green (Given) = Green (Exp) + Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 12: Lighter-Green (Given) = Green (Exp) + Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q12_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q12_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q12_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q12_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q12_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q12_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_12'), 'png');

%% Question 13 - objTwoColors: Blue-? = Blue + Cyan

q13_lab = tableR_lab(tableR_lab.id_question == 13,:); q13_lab = sortrows(q13_lab, 'id');
q13_dalt_lab = tableDR_lab(tableDR_lab.id_question == 13,:); q13_dalt_lab = sortrows(q13_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(210/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 13: Blue-? (Given) = Blue (Exp) + Cyan (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 13: Blue-? (Given) = Blue (Exp) + Cyan (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q13_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q13_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q13_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q13_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q13_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q13_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_13'), 'png');

%% Question 14 - objTwoColors: Purple = Blue + Magenta

q14_lab = tableR_lab(tableR_lab.id_question == 14,:); q14_lab = sortrows(q14_lab, 'id');
q14_dalt_lab = tableDR_lab(tableDR_lab.id_question == 14,:); q14_dalt_lab = sortrows(q14_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(270/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 14: Purple (Given) = Blue (Exp) + Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 14: Purple (Given) = Blue (Exp) + Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q14_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q14_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q14_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q14_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q14_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q14_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_14'), 'png');

%% Question 15 - objTwoColors: Lime-Green = Blue + Yellow

q15_lab = tableR_lab(tableR_lab.id_question == 15,:); q15_lab = sortrows(q15_lab, 'id');
q15_dalt_lab = tableDR_lab(tableDR_lab.id_question == 15,:); q15_dalt_lab = sortrows(q15_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(150/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1]));   
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));    

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 15: Lime-Green (Given) = Blue (Exp) + Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 15: Lime-Green (Given) = Blue (Exp) + Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q15_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q15_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q15_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q15_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q15_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q15_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_15'), 'png');

%% Question 16 - objTwoColors: Red = Blue + Yellow

q16_lab = tableR_lab(tableR_lab.id_question == 16,:); q16_lab = sortrows(q16_lab, 'id');
q16_dalt_lab = tableDR_lab(tableDR_lab.id_question == 16,:); q16_dalt_lab = sortrows(q16_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(330/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1]));    
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));   

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 16: Red (Given) = Blue (Exp) + Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 16: Red (Given) = Blue (Exp) + Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q16_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q16_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q16_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q16_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q16_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q16_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_16'), 'png');

%% Question 17 - objTwoColors: Green = Cyan + Yellow

q17_lab = tableR_lab(tableR_lab.id_question == 17,:); q17_lab = sortrows(q17_lab, 'id');
q17_dalt_lab = tableDR_lab(tableDR_lab.id_question == 17,:); q17_dalt_lab = sortrows(q17_dalt_lab, 'id');

given_color = rgb2xyz(hsv2rgb([(120/360) 1 1]));        
expected_color1 = rgb2xyz(hsv2rgb([(180/360) 1 1]));
expected_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1])); 

x_pre = [given_color(1)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color(2)/(given_color(1) + given_color(2) + given_color(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 17: Green (Given) = Cyan (Exp) + Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 17: Green (Given) = Cyan (Exp) + Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot();
title('Non-Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q17_lab)                                  
    %First Color
    sColor = str2num(cell2mat(q17_lab.second_color(i)));     
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
    tColor = str2num(cell2mat(q17_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                            
    y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot();
title('Daltonic Answers');
xlabel('X Value');
ylabel('Y Value');
hold on;

scatter(x_pre(1), y_pre(1), 60, 'black', 'Filled');         %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black');                   %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q17_dalt_lab)
%First Color
    sColor = str2num(cell2mat(q17_dalt_lab.second_color(i)));
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
    tColor = str2num(cell2mat(q17_dalt_lab.third_color(i)));
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
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_17'), 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Question 18 - twoColorsObj: Red + Green = Yellow

q18_lab = tableR_lab(tableR_lab.id_question == 18,:); q18_lab = sortrows(q18_lab, 'id');
q18_dalt_lab = tableDR_lab(tableDR_lab.id_question == 18,:); q18_dalt_lab = sortrows(q18_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([0 1 1])); given_color2 = rgb2xyz(hsv2rgb([(120/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(60/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 18: Red (Giv) + Green (Giv) = Yellow (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 18: Red (Giv) + Green (Giv) = Yellow (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q18_lab)                                  
    tColor = cell2mat(q18_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q18_dalt_lab)
    tColor = cell2mat(q18_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_18'), 'png');

%% Question 19 - twoColorsObj: Red + Blue = Magenta

q19_lab = tableR_lab(tableR_lab.id_question == 19,:); q19_lab = sortrows(q19_lab, 'id');
q19_dalt_lab = tableDR_lab(tableDR_lab.id_question == 19,:); q19_dalt_lab = sortrows(q19_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([0 1 1])); given_color2 = rgb2xyz(hsv2rgb([(240/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(300/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 19: Red (Giv) + Blue (Giv) = Magenta (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 19: Red (Giv) + Blue (Giv) = Magenta (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q19_lab)                                  
    tColor = cell2mat(q19_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q19_dalt_lab)
    tColor = cell2mat(q19_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_19'), 'png');

%% Question 20 - twoColorsObj: Green + Blue = Cyan

q20_lab = tableR_lab(tableR_lab.id_question == 20,:); q20_lab = sortrows(q20_lab, 'id');
q20_dalt_lab = tableDR_lab(tableDR_lab.id_question == 20,:); q20_dalt_lab = sortrows(q20_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(240/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(180/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 20: Green (Giv) + Blue (Giv) = Cyan (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 20: Green (Giv) + Blue (Giv) = Cyan (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q20_lab)                                  
    tColor = cell2mat(q20_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q20_dalt_lab)
    tColor = cell2mat(q20_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_20'), 'png');

%% Question 21 - twoColorsObj: Red + Cyan = Green || Purple (HSV)

q21_lab = tableR_lab(tableR_lab.id_question == 21,:); q21_lab = sortrows(q21_lab, 'id');
q21_dalt_lab = tableDR_lab(tableDR_lab.id_question == 21,:); q21_dalt_lab = sortrows(q21_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([0 1 1])); given_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));
expected_color1 = rgb2xyz(hsv2rgb([(90/360) 1 1])); expected_color2 = rgb2xyz(hsv2rgb([(270/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 21: Red (Giv) + Cyan (Giv) = Green (Exp) || Purple (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 21: Red (Giv) + Cyan (Giv) = Green (Exp) || Purple (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR 1
scatter(x_pre(4), y_pre(4), 60, 'black', 'Filled');         %draw EXPECTED COLOR 2
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q21_lab)                                  
    tColor = cell2mat(q21_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR 1
scatter(x_pre(4), y_pre(4), 60, 'black', 'Filled');         %draw EXPECTED COLOR 2
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q21_dalt_lab)
    tColor = cell2mat(q21_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_21'), 'png');

%% Question 22 - twoColorsObj: Red + Magenta = Darker-Red

q22_lab = tableR_lab(tableR_lab.id_question == 22,:); q22_lab = sortrows(q22_lab, 'id');
q22_dalt_lab = tableDR_lab(tableDR_lab.id_question == 22,:); q22_dalt_lab = sortrows(q22_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([0 1 1])); given_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(330/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 22: Red (Giv) + Magenta (Giv) = Darker-Red (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 22: Red (Giv) + Magenta (Giv) = Darker-Red (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q22_lab)                                  
    tColor = cell2mat(q22_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q22_dalt_lab)
    tColor = cell2mat(q22_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_22'), 'png');

%% Question 23 - twoColorsObj: Red + Yellow = Orange

q23_lab = tableR_lab(tableR_lab.id_question == 23,:); q23_lab = sortrows(q23_lab, 'id');
q23_dalt_lab = tableDR_lab(tableDR_lab.id_question == 23,:); q23_dalt_lab = sortrows(q23_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([0 1 1])); given_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(30/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 23: Red (Giv) + Yellow (Giv) = Orange (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 23: Red (Giv) + Yellow (Giv) = Orange (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q23_lab)                                  
    tColor = cell2mat(q23_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q23_dalt_lab)
    tColor = cell2mat(q23_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_23'), 'png');

%% Question 24 - twoColorsObj: Cyan + Magenta = Purple

q24_lab = tableR_lab(tableR_lab.id_question == 24,:); q24_lab = sortrows(q24_lab, 'id');
q24_dalt_lab = tableDR_lab(tableDR_lab.id_question == 24,:); q24_dalt_lab = sortrows(q24_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(180/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(240/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 24: Cyan (Giv) + Magenta (Giv) = Purple (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 24: Cyan (Giv) + Magenta (Giv) = Purple (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q24_lab)                                  
    tColor = cell2mat(q18_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q24_dalt_lab)
    tColor = cell2mat(q24_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_24'), 'png');

%% Question 25 - twoColorsObj: Magenta + Yellow = Red

q25_lab = tableR_lab(tableR_lab.id_question == 25,:); q25_lab = sortrows(q25_lab, 'id');
q25_dalt_lab = tableDR_lab(tableDR_lab.id_question == 25,:); q25_dalt_lab = sortrows(q25_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(300/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(0/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 25: Magenta (Giv) + Yellow (Giv) = Red (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 25: Magenta (Giv) + Yellow (Giv) = Red (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q25_lab)                                  
    tColor = cell2mat(q25_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q25_dalt_lab)
    tColor = cell2mat(q25_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_25'), 'png');

%% Question 26 - twoColorsObj: Green + Cyan = Lime-green

q26_lab = tableR_lab(tableR_lab.id_question == 26,:); q26_lab = sortrows(q26_lab, 'id');
q26_dalt_lab = tableDR_lab(tableDR_lab.id_question == 26,:); q26_dalt_lab = sortrows(q26_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(150/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 26: Green (Giv) + Cyan (Giv) = Lime-Green (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 26: Green (Giv) + Cyan (Giv) = Lime-Green (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q26_lab)                                  
    tColor = cell2mat(q26_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q26_dalt_lab)
    tColor = cell2mat(q26_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_26'), 'png');

%% Question 27 - twoColorsObj: Green + Magenta = Blue || Orange (HSV)

q27_lab = tableR_lab(tableR_lab.id_question == 27,:); q27_lab = sortrows(q27_lab, 'id');
q27_dalt_lab = tableDR_lab(tableDR_lab.id_question == 27,:); q27_dalt_lab = sortrows(q27_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(210/360) 1 1])); expected_color2 = rgb2xyz(hsv2rgb([(30/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 27: Green (Giv) + Magenta (Giv) = Blue (Exp) || Orange (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 27: Green (Giv) + Magenta (Giv) = Blue (Exp) || Orange (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR 1
scatter(x_pre(4), y_pre(4), 60, 'black', 'Filled');         %draw EXPECTED COLOR 2
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q27_lab)                                  
    tColor = cell2mat(q27_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR 1
scatter(x_pre(4), y_pre(4), 60, 'black', 'Filled');         %draw EXPECTED COLOR 2
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q27_dalt_lab)
    tColor = cell2mat(q27_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_27'), 'png');

%% Question 28 - twoColorsObj: Green + Yellow = Yellower-Green

q28_lab = tableR_lab(tableR_lab.id_question == 28,:); q28_lab = sortrows(q28_lab, 'id');
q28_dalt_lab = tableDR_lab(tableDR_lab.id_question == 28,:); q28_dalt_lab = sortrows(q28_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(120/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(90/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 28: Green (Giv) + Yellow (Giv) = Yellower-Green (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 28: Green (Giv) + Yellow (Giv) = Yellower-Green (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q28_lab)                                  
    tColor = cell2mat(q28_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q28_dalt_lab)
    tColor = cell2mat(q28_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_28'), 'png');

%% Question 29 - twoColorsObj: Blue + Cyan = Darker-Blue

q29_lab = tableR_lab(tableR_lab.id_question == 29,:); q29_lab = sortrows(q29_lab, 'id');
q29_dalt_lab = tableDR_lab(tableDR_lab.id_question == 29,:); q29_dalt_lab = sortrows(q29_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(180/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(210/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 29: Blue (Giv) + Cyan (Giv) = Darker-Blue (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 29: Blue (Giv) + Cyan (Giv) = Darker-Blue (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q29_lab)                                  
    tColor = cell2mat(q29_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q29_dalt_lab)
    tColor = cell2mat(q29_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_29'), 'png');

%% Question 30 - twoColorsObj: Blue + Magenta = Purple 

q30_lab = tableR_lab(tableR_lab.id_question == 30,:); q30_lab = sortrows(q30_lab, 'id');
q30_dalt_lab = tableDR_lab(tableDR_lab.id_question == 30,:); q30_dalt_lab = sortrows(q30_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(300/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(270/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 30: Blue (Giv) + Magenta (Giv) = Purple (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 30: Blue (Giv) + Magenta (Giv) = Purple (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q30_lab)                                  
    tColor = cell2mat(q30_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q30_dalt_lab)
    tColor = cell2mat(q30_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_30'), 'png');

%% Question 31 - twoColorsObj: Blue + Yellow = Lime-Green || Red (HSV)

q31_lab = tableR_lab(tableR_lab.id_question == 31,:); q31_lab = sortrows(q31_lab, 'id');
q31_dalt_lab = tableDR_lab(tableDR_lab.id_question == 31,:); q31_dalt_lab = sortrows(q31_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(240/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(150/360) 1 1])); expected_color2 = rgb2xyz(hsv2rgb([(330/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(1)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(1)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color1(2)/(expected_color1(1) + expected_color1(2) + expected_color1(3)) expected_color2(2)/(expected_color2(1) + expected_color2(2) + expected_color2(3))];

figure('Name','Question 31: Blue (Giv) + Yellow (Giv) = Lime-Green (Exp) || Red (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 31: Blue (Giv) + Yellow (Giv) = Lime-Green (Exp) || Red (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR 1
scatter(x_pre(4), y_pre(4), 60, 'black', 'Filled');         %draw EXPECTED COLOR 2
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q31_lab)                                  
    tColor = cell2mat(q31_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q31_dalt_lab)
    tColor = cell2mat(q31_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_31'), 'png');

%% Question 32 - twoColorsObj: Cyan + Yellow = Green

q32_lab = tableR_lab(tableR_lab.id_question == 32,:); q32_lab = sortrows(q32_lab, 'id');
q32_dalt_lab = tableDR_lab(tableDR_lab.id_question == 32,:); q32_dalt_lab = sortrows(q32_dalt_lab, 'id');

given_color1 = rgb2xyz(hsv2rgb([(180/360) 1 1])); given_color2 = rgb2xyz(hsv2rgb([(60/360) 1 1]));
expected_color = rgb2xyz(hsv2rgb([(120/360) 1 1]));

x_pre = [given_color1(1)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(1)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(1)/(expected_color(1) + expected_color(2) + expected_color(3))];
y_pre = [given_color1(2)/(given_color1(1) + given_color1(2) + given_color1(3)) given_color2(2)/(given_color2(1) + given_color2(2) + given_color2(3)) expected_color(2)/(expected_color(1) + expected_color(2) + expected_color(3))];

figure('Name','Question 32: Cyan (Giv) + Yellow (Giv) = Green (Exp)', 'NumberTitle','off', 'Toolbar', 'none');
%title('Question 32: Cyan (Giv) + Yellow (Giv) = Green (Exp)', 'FontSize', 13);
subplot(1,2,1); %for non-daltonic answers
cieplot(); title('Non-Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q32_lab)                                  
    tColor = cell2mat(q32_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;

subplot(1,2,2); %for daltonic answers
cieplot(); title('Daltonic Answers'); xlabel('X Value'); ylabel('Y Value'); hold on;

scatter(x_pre(1), y_pre(1), 60, 'black');                   %draw GIVEN COLOR
scatter(x_pre(2), y_pre(2), 60, 'black');                   %draw EXPECTED COLOR
scatter(x_pre(3), y_pre(3), 60, 'black', 'Filled');         %draw EXPECTED COLOR
plot(x_pre, y_pre, '--', 'Color', 'white');

for i = 1 : height(q32_dalt_lab)
    tColor = cell2mat(q32_lab.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = applycform([r g b], iccTransform);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathLab, 'Question_32'), 'png');