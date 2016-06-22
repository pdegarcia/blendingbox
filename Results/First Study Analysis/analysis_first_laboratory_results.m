close all;

valuesSColor = [];
valuesTColor = [];
x_pre = [];
y_pre = [];
x_values = [];
y_values = [];
x_aux = 0;
y_aux = 0;

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
    
    scatter(x_values, y_values, 50, 'red');                         %draw two responses
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
    
    scatter(x_values, y_values, 50, 'red');                 
    plot(x_values, y_values, 'Color', 'black');             
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;

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
    
    scatter(x_values, y_values, 50, 'red');                   
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
    
    scatter(x_values, y_values, 50, 'red');                 
    plot(x_values, y_values, 'Color', 'black');             
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;

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
    
    scatter(x_values, y_values, 50, 'red');                   
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
    
    scatter(x_values, y_values, 50, 'red');                 
    plot(x_values, y_values, 'Color', 'black');             
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;

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
    
    scatter(x_values, y_values, 50, 'red');                   
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
    
    scatter(x_values, y_values, 50, 'red');                 
    plot(x_values, y_values, 'Color', 'black');             
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = [];                                          
    y_values = [];
end
hold off;

%% Question 5

q5_lab = tableR_lab(tableR_lab.id_question == 5,:); q5_lab = sortrows(q5_lab, 'id');
q5_dalt_lab = tableDR_lab(tableDR_lab.id_question == 5,:); q5_dalt_lab = sortrows(q5_dalt_lab, 'id');

%% Question 6

q6_lab = tableR_lab(tableR_lab.id_question == 6,:); q6_lab = sortrows(q6_lab, 'id');
q6_dalt_lab = tableDR_lab(tableDR_lab.id_question == 6,:); q6_dalt_lab = sortrows(q6_dalt_lab, 'id');

%% Question 7

q7_lab = tableR_lab(tableR_lab.id_question == 7,:); q7_lab = sortrows(q7_lab, 'id');
q7_dalt_lab = tableDR_lab(tableDR_lab.id_question == 7,:); q7_dalt_lab = sortrows(q7_dalt_lab, 'id');

%% Question 8

q8_lab = tableR_lab(tableR_lab.id_question == 8,:); q8_lab = sortrows(q8_lab, 'id');
q8_dalt_lab = tableDR_lab(tableDR_lab.id_question == 8,:); q8_dalt_lab = sortrows(q8_dalt_lab, 'id');

%% Question 9

q9_lab = tableR_lab(tableR_lab.id_question == 9,:); q9_lab = sortrows(q9_lab, 'id');
q9_dalt_lab = tableDR_lab(tableDR_lab.id_question == 9,:); q9_dalt_lab = sortrows(q9_dalt_lab, 'id');

%% Question 10

q10_lab = tableR_lab(tableR_lab.id_question == 10,:); q10_lab = sortrows(q10_lab, 'id');
q10_dalt_lab = tableDR_lab(tableDR_lab.id_question == 10,:); q10_dalt_lab = sortrows(q10_dalt_lab, 'id');

%% Question 11

q11_lab = tableR_lab(tableR_lab.id_question == 11,:); q11_lab = sortrows(q11_lab, 'id');
q11_dalt_lab = tableDR_lab(tableDR_lab.id_question == 11,:); q11_dalt_lab = sortrows(q11_dalt_lab, 'id');

%% Question 12

q12_lab = tableR_lab(tableR_lab.id_question == 12,:); q12_lab = sortrows(q12_lab, 'id');
q12_dalt_lab = tableDR_lab(tableDR_lab.id_question == 12,:); q12_dalt_lab = sortrows(q12_dalt_lab, 'id');

%% Question 13

q13_lab = tableR_lab(tableR_lab.id_question == 13,:); q13_lab = sortrows(q13_lab, 'id');
q13_dalt_lab = tableDR_lab(tableDR_lab.id_question == 13,:); q13_dalt_lab = sortrows(q13_dalt_lab, 'id');

%% Question 14

q14_lab = tableR_lab(tableR_lab.id_question == 14,:); q14_lab = sortrows(q14_lab, 'id');
q14_dalt_lab = tableDR_lab(tableDR_lab.id_question == 14,:); q14_dalt_lab = sortrows(q14_dalt_lab, 'id');

%% Question 15

q15_lab = tableR_lab(tableR_lab.id_question == 15,:); q15_lab = sortrows(q15_lab, 'id');
q15_dalt_lab = tableDR_lab(tableDR_lab.id_question == 15,:); q15_dalt_lab = sortrows(q15_dalt_lab, 'id');

%% Question 16

q16_lab = tableR_lab(tableR_lab.id_question == 16,:); q16_lab = sortrows(q16_lab, 'id');
q16_dalt_lab = tableDR_lab(tableDR_lab.id_question == 16,:); q16_dalt_lab = sortrows(q16_dalt_lab, 'id');

%% Question 17

q17_lab = tableR_lab(tableR_lab.id_question == 17,:); q17_lab = sortrows(q17_lab, 'id');
q17_dalt_lab = tableDR_lab(tableDR_lab.id_question == 17,:); q17_dalt_lab = sortrows(q17_dalt_lab, 'id');

%% Question 18

q18_lab = tableR_lab(tableR_lab.id_question == 18,:); q18_lab = sortrows(q18_lab, 'id');
q18_dalt_lab = tableDR_lab(tableDR_lab.id_question == 18,:); q18_dalt_lab = sortrows(q18_dalt_lab, 'id');

%% Question 19

q19_lab = tableR_lab(tableR_lab.id_question == 19,:); q19_lab = sortrows(q19_lab, 'id');
q19_dalt_lab = tableDR_lab(tableDR_lab.id_question == 19,:); q19_dalt_lab = sortrows(q19_dalt_lab, 'id');

%% Question 20

q20_lab = tableR_lab(tableR_lab.id_question == 20,:); q20_lab = sortrows(q20_lab, 'id');
q20_dalt_lab = tableDR_lab(tableDR_lab.id_question == 20,:); q20_dalt_lab = sortrows(q20_dalt_lab, 'id');

%% Question 21

q21_lab = tableR_lab(tableR_lab.id_question == 21,:); q21_lab = sortrows(q21_lab, 'id');
q21_dalt_lab = tableDR_lab(tableDR_lab.id_question == 21,:); q21_dalt_lab = sortrows(q21_dalt_lab, 'id');

%% Question 22

q22_lab = tableR_lab(tableR_lab.id_question == 22,:); q22_lab = sortrows(q22_lab, 'id');
q22_dalt_lab = tableDR_lab(tableDR_lab.id_question == 22,:); q22_dalt_lab = sortrows(q22_dalt_lab, 'id');

%% Question 23

q23_lab = tableR_lab(tableR_lab.id_question == 23,:); q23_lab = sortrows(q23_lab, 'id');
q23_dalt_lab = tableDR_lab(tableDR_lab.id_question == 23,:); q23_dalt_lab = sortrows(q23_dalt_lab, 'id');

%% Question 24

q24_lab = tableR_lab(tableR_lab.id_question == 24,:); q24_lab = sortrows(q24_lab, 'id');
q24_dalt_lab = tableDR_lab(tableDR_lab.id_question == 24,:); q24_dalt_lab = sortrows(q24_dalt_lab, 'id');

%% Question 25

q25_lab = tableR_lab(tableR_lab.id_question == 25,:); q25_lab = sortrows(q25_lab, 'id');
q25_dalt_lab = tableDR_lab(tableDR_lab.id_question == 25,:); q25_dalt_lab = sortrows(q25_dalt_lab, 'id');

%% Quetsion 26

q26_lab = tableR_lab(tableR_lab.id_question == 26,:); q26_lab = sortrows(q26_lab, 'id');
q26_dalt_lab = tableDR_lab(tableDR_lab.id_question == 26,:); q26_dalt_lab = sortrows(q26_dalt_lab, 'id');

%% Question 27

q27_lab = tableR_lab(tableR_lab.id_question == 27,:); q27_lab = sortrows(q27_lab, 'id');
q27_dalt_lab = tableDR_lab(tableDR_lab.id_question == 27,:); q27_dalt_lab = sortrows(q27_dalt_lab, 'id');

%% Question 28

q28_lab = tableR_lab(tableR_lab.id_question == 28,:); q28_lab = sortrows(q28_lab, 'id');
q28_dalt_lab = tableDR_lab(tableDR_lab.id_question == 28,:); q28_dalt_lab = sortrows(q28_dalt_lab, 'id');

%% Question 29

q29_lab = tableR_lab(tableR_lab.id_question == 29,:); q29_lab = sortrows(q29_lab, 'id');
q29_dalt_lab = tableDR_lab(tableDR_lab.id_question == 29,:); q29_dalt_lab = sortrows(q29_dalt_lab, 'id');

%% Question 30

q30_lab = tableR_lab(tableR_lab.id_question == 30,:); q30_lab = sortrows(q30_lab, 'id');
q30_dalt_lab = tableDR_lab(tableDR_lab.id_question == 30,:); q30_dalt_lab = sortrows(q30_dalt_lab, 'id');

%% Question 31

q31_lab = tableR_lab(tableR_lab.id_question == 31,:); q31_lab = sortrows(q31_lab, 'id');
q31_dalt_lab = tableDR_lab(tableDR_lab.id_question == 31,:); q31_dalt_lab = sortrows(q31_dalt_lab, 'id');

%% Question 32

q32_lab = tableR_lab(tableR_lab.id_question == 32,:); q32_lab = sortrows(q32_lab, 'id');
q32_dalt_lab = tableDR_lab(tableDR_lab.id_question == 32,:); q32_dalt_lab = sortrows(q32_dalt_lab, 'id');

%% Display results

