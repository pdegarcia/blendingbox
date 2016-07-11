close all;

valuesSColor = [];
valuesTColor = [];
x_pre = [];
y_pre = [];
x_values = [];
y_values = [];
x_aux = 0;
y_aux = 0;
pathOnline = '/Users/PauloGarcia/Documents/MATLAB/online_diagrams';

%% Analyze Online Users %%

users_online = 'data_first_onlineUsers.csv';
results_online = 'data_first_online_results.csv';
daltonic_results_online = 'data_first_online_daltonic_results.csv';
uncalibrated_results_online = 'data_first_online_uncalibrated_results.csv';

tableU_online = readtable(users_online, 'Delimiter', ',');
tableR_online = readtable(results_online, 'Delimiter', ';');
tableUR_online = readtable(uncalibrated_results_online, 'Delimiter', ';');
tableDR_online = readtable(daltonic_results_online, 'Delimiter', ';');

%% Question 1 - objTwoColors: Yellow = Red + Green

q1_online = tableR_online(tableR_online.id_question == 1,:); q1_online = sortrows(q1_online, 'id');
q1_dalt_online = tableDR_online(tableDR_online.id_question == 1,:); q1_dalt_online = sortrows(q1_dalt_online, 'id');

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

for i = 1 : height(q1_online)                                  %draw every pair of responses.
    %First Color
    sColor = str2num(cell2mat(q1_online.second_color(i)));     %cell2mat serve para converter cell para matriz de uint
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
    tColor = str2num(cell2mat(q1_online.third_color(i)));
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

for i = 1 : height(q1_dalt_online)
%First Color
    sColor = str2num(cell2mat(q1_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q1_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_1'), 'png');

%% Question 2 - objTwoColors: Magenta = Red + Blue

q2_online = tableR_online(tableR_online.id_question == 2,:); q2_online = sortrows(q2_online, 'id');
q2_dalt_online = tableDR_online(tableDR_online.id_question == 2,:); q2_dalt_online = sortrows(q2_dalt_online, 'id');

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

for i = 1 : height(q2_online)                                  
    %First Color
    sColor = str2num(cell2mat(q2_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q2_online.third_color(i)));
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

for i = 1 : height(q2_dalt_online)
%First Color
    sColor = str2num(cell2mat(q2_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q2_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_2'), 'png');

%% Question 3 - objTwoColors: Green = Red + Cyan

q3_online = tableR_online(tableR_online.id_question == 3,:); q3_online = sortrows(q3_online, 'id');
q3_dalt_online = tableDR_online(tableDR_online.id_question == 3,:); q3_dalt_online = sortrows(q3_dalt_online, 'id');

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

for i = 1 : height(q3_online)                                  
    %First Color
    sColor = str2num(cell2mat(q3_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q3_online.third_color(i)));
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

for i = 1 : height(q3_dalt_online)
%First Color
    sColor = str2num(cell2mat(q3_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q3_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_3'), 'png');

%% Question 4 - objTwoColors: Purple = Red + Cyan

q4_online = tableR_online(tableR_online.id_question == 4,:); q4_online = sortrows(q4_online, 'id');
q4_dalt_online = tableDR_online(tableDR_online.id_question == 4,:); q4_dalt_online = sortrows(q4_dalt_online, 'id');

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

for i = 1 : height(q4_online)                                  
    %First Color
    sColor = str2num(cell2mat(q4_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q4_online.third_color(i)));
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

for i = 1 : height(q4_dalt_online)
%First Color
    sColor = str2num(cell2mat(q4_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q4_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_4'), 'png');

%% Question 5 - objTwoColors: Dark Red = Red + Magenta 

q5_online = tableR_online(tableR_online.id_question == 5,:); q5_online = sortrows(q5_online, 'id');
q5_dalt_online = tableDR_online(tableDR_online.id_question == 5,:); q5_dalt_online = sortrows(q5_dalt_online, 'id');

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

for i = 1 : height(q5_online)                                  
    %First Color
    sColor = str2num(cell2mat(q5_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q5_online.third_color(i)));
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

for i = 1 : height(q5_dalt_online)
%First Color
    sColor = str2num(cell2mat(q5_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q5_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_5'), 'png');

%% Question 6 - objTwoColors: Orange = Red + Yellow

q6_online = tableR_online(tableR_online.id_question == 6,:); q6_online = sortrows(q6_online, 'id');
q6_dalt_online = tableDR_online(tableDR_online.id_question == 6,:); q6_dalt_online = sortrows(q6_dalt_online, 'id');

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

for i = 1 : height(q6_online)                                  
    %First Color
    sColor = str2num(cell2mat(q6_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q6_online.third_color(i)));
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

for i = 1 : height(q6_dalt_online)
%First Color
    sColor = str2num(cell2mat(q6_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q6_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_6'), 'png');

%% Question 7 - objTwoColors: Purplish-Blue = Cyan + Magenta

q7_online = tableR_online(tableR_online.id_question == 7,:); q7_online = sortrows(q7_online, 'id');
q7_dalt_online = tableDR_online(tableDR_online.id_question == 7,:); q7_dalt_online = sortrows(q7_dalt_online, 'id');

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

for i = 1 : height(q7_online)                                  
    %First Color
    sColor = str2num(cell2mat(q7_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q7_online.third_color(i)));
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

for i = 1 : height(q7_dalt_online)
%First Color
    sColor = str2num(cell2mat(q7_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q7_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_7'), 'png');

%% Question 8 - objTwoColors: Red = Magenta + Yellow

q8_online = tableR_online(tableR_online.id_question == 8,:); q8_online = sortrows(q8_online, 'id');
q8_dalt_online = tableDR_online(tableDR_online.id_question == 8,:); q8_dalt_online = sortrows(q8_dalt_online, 'id');

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

for i = 1 : height(q8_online)                                  
    %First Color
    sColor = str2num(cell2mat(q8_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q8_online.third_color(i)));
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

for i = 1 : height(q8_dalt_online)
%First Color
    sColor = str2num(cell2mat(q8_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q8_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_8'), 'png');

%% Question 9 - objTwoColors: Lime-Green = Green + Cyan 

q9_online = tableR_online(tableR_online.id_question == 9,:); q9_online = sortrows(q9_online, 'id');
q9_dalt_online = tableDR_online(tableDR_online.id_question == 9,:); q9_dalt_online = sortrows(q9_dalt_online, 'id');

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

for i = 1 : height(q9_online)                                  
    %First Color
    sColor = str2num(cell2mat(q9_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q9_online.third_color(i)));
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

for i = 1 : height(q9_dalt_online)
%First Color
    sColor = str2num(cell2mat(q9_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q9_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_9'), 'png');

%% Question 10 - objTwoColors: Blue = Green + Magenta

q10_online = tableR_online(tableR_online.id_question == 10,:); q10_online = sortrows(q10_online, 'id');
q10_dalt_online = tableDR_online(tableDR_online.id_question == 10,:); q10_dalt_online = sortrows(q10_dalt_online, 'id');

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

for i = 1 : height(q10_online)                                  
    %First Color
    sColor = str2num(cell2mat(q10_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q10_online.third_color(i)));
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

for i = 1 : height(q10_dalt_online)
%First Color
    sColor = str2num(cell2mat(q10_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q10_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_10'), 'png');

%% Question 11 - objTwoColors: Orange = Green + Magenta

q11_online = tableR_online(tableR_online.id_question == 11,:); q11_online = sortrows(q11_online, 'id');
q11_dalt_online = tableDR_online(tableDR_online.id_question == 11,:); q11_dalt_online = sortrows(q11_dalt_online, 'id');

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

for i = 1 : height(q11_online)                                  
    %First Color
    sColor = str2num(cell2mat(q11_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q11_online.third_color(i)));
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

for i = 1 : height(q11_dalt_online)
%First Color
    sColor = str2num(cell2mat(q11_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q11_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_11'), 'png');

%% Question 12 - objTwoColors: Lighter-Green = Green + Yellow

q12_online = tableR_online(tableR_online.id_question == 12,:); q12_online = sortrows(q12_online, 'id');
q12_dalt_online = tableDR_online(tableDR_online.id_question == 12,:); q12_dalt_online = sortrows(q12_dalt_online, 'id');

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

for i = 1 : height(q12_online)                                  
    %First Color
    sColor = str2num(cell2mat(q12_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q12_online.third_color(i)));
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

for i = 1 : height(q12_dalt_online)
%First Color
    sColor = str2num(cell2mat(q12_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q12_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_12'), 'png');

%% Question 13 - objTwoColors: Blue-? = Blue + Cyan

q13_online = tableR_online(tableR_online.id_question == 13,:); q13_online = sortrows(q13_online, 'id');
q13_dalt_online = tableDR_online(tableDR_online.id_question == 13,:); q13_dalt_online = sortrows(q13_dalt_online, 'id');

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

for i = 1 : height(q13_online)                                  
    %First Color
    sColor = str2num(cell2mat(q13_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q13_online.third_color(i)));
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

for i = 1 : height(q13_dalt_online)
%First Color
    sColor = str2num(cell2mat(q13_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q13_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_13'), 'png');

%% Question 14 - objTwoColors: Purple = Blue + Magenta

q14_online = tableR_online(tableR_online.id_question == 14,:); q14_online = sortrows(q14_online, 'id');
q14_dalt_online = tableDR_online(tableDR_online.id_question == 14,:); q14_dalt_online = sortrows(q14_dalt_online, 'id');

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

for i = 1 : height(q14_online)                                  
    %First Color
    sColor = str2num(cell2mat(q14_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q14_online.third_color(i)));
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

for i = 1 : height(q14_dalt_online)
%First Color
    sColor = str2num(cell2mat(q14_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q14_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_14'), 'png');

%% Question 15 - objTwoColors: Lime-Green = Blue + Yellow

q15_online = tableR_online(tableR_online.id_question == 15,:); q15_online = sortrows(q15_online, 'id');
q15_dalt_online = tableDR_online(tableDR_online.id_question == 15,:); q15_dalt_online = sortrows(q15_dalt_online, 'id');

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

for i = 1 : height(q15_online)                                  
    %First Color
    sColor = str2num(cell2mat(q15_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q15_online.third_color(i)));
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

for i = 1 : height(q15_dalt_online)
%First Color
    sColor = str2num(cell2mat(q15_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q15_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_15'), 'png');

%% Question 16 - objTwoColors: Red = Blue + Yellow

q16_online = tableR_online(tableR_online.id_question == 16,:); q16_online = sortrows(q16_online, 'id');
q16_dalt_online = tableDR_online(tableDR_online.id_question == 16,:); q16_dalt_online = sortrows(q16_dalt_online, 'id');

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

for i = 1 : height(q16_online)                                  
    %First Color
    sColor = str2num(cell2mat(q16_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q16_online.third_color(i)));
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

for i = 1 : height(q16_dalt_online)
%First Color
    sColor = str2num(cell2mat(q16_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q16_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_16'), 'png');

%% Question 17 - objTwoColors: Green = Cyan + Yellow

q17_online = tableR_online(tableR_online.id_question == 17,:); q17_online = sortrows(q17_online, 'id');
q17_dalt_online = tableDR_online(tableDR_online.id_question == 17,:); q17_dalt_online = sortrows(q17_dalt_online, 'id');

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

for i = 1 : height(q17_online)                                  
    %First Color
    sColor = str2num(cell2mat(q17_online.second_color(i)));     
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
    tColor = str2num(cell2mat(q17_online.third_color(i)));
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

for i = 1 : height(q17_dalt_online)
%First Color
    sColor = str2num(cell2mat(q17_dalt_online.second_color(i)));
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
    tColor = str2num(cell2mat(q17_dalt_online.third_color(i)));
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
saveas(gcf, fullfile(pathOnline, 'Question_17'), 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Question 18 - twoColorsObj: Red + Green = Yellow

q18_online = tableR_online(tableR_online.id_question == 18,:); q18_online = sortrows(q18_online, 'id');
q18_dalt_online = tableDR_online(tableDR_online.id_question == 18,:); q18_dalt_online = sortrows(q18_dalt_online, 'id');

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

for i = 1 : height(q18_online)                                  
    tColor = cell2mat(q18_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                         
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

for i = 1 : height(q18_dalt_online)
    tColor = cell2mat(q18_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_18'), 'png');

%% Question 19 - twoColorsObj: Red + Blue = Magenta

q19_online = tableR_online(tableR_online.id_question == 19,:); q19_online = sortrows(q19_online, 'id');
q19_dalt_online = tableDR_online(tableDR_online.id_question == 19,:); q19_dalt_online = sortrows(q19_dalt_online, 'id');

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

for i = 1 : height(q19_online)                                  
    tColor = cell2mat(q19_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q19_dalt_online)
    tColor = cell2mat(q19_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_19'), 'png');

%% Question 20 - twoColorsObj: Green + Blue = Cyan

q20_online = tableR_online(tableR_online.id_question == 20,:); q20_online = sortrows(q20_online, 'id');
q20_dalt_online = tableDR_online(tableDR_online.id_question == 20,:); q20_dalt_online = sortrows(q20_dalt_online, 'id');

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

for i = 1 : height(q20_online)                                  
    tColor = cell2mat(q20_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q20_dalt_online)
    tColor = cell2mat(q20_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_20'), 'png');

%% Question 21 - twoColorsObj: Red + Cyan = Green || Purple (HSV)

q21_online = tableR_online(tableR_online.id_question == 21,:); q21_online = sortrows(q21_online, 'id');
q21_dalt_online = tableDR_online(tableDR_online.id_question == 21,:); q21_dalt_online = sortrows(q21_dalt_online, 'id');

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

for i = 1 : height(q21_online)                                  
    tColor = cell2mat(q21_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q21_dalt_online)
    tColor = cell2mat(q21_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_21'), 'png');

%% Question 22 - twoColorsObj: Red + Magenta = Darker-Red

q22_online = tableR_online(tableR_online.id_question == 22,:); q22_online = sortrows(q22_online, 'id');
q22_dalt_online = tableDR_online(tableDR_online.id_question == 22,:); q22_dalt_online = sortrows(q22_dalt_online, 'id');

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

for i = 1 : height(q22_online)                                  
    tColor = cell2mat(q22_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q22_dalt_online)
    tColor = cell2mat(q22_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_22'), 'png');

%% Question 23 - twoColorsObj: Red + Yellow = Orange

q23_online = tableR_online(tableR_online.id_question == 23,:); q23_online = sortrows(q23_online, 'id');
q23_dalt_online = tableDR_online(tableDR_online.id_question == 23,:); q23_dalt_online = sortrows(q23_dalt_online, 'id');

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

for i = 1 : height(q23_online)                                  
    tColor = cell2mat(q23_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q23_dalt_online)
    tColor = cell2mat(q23_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_23'), 'png');

%% Question 24 - twoColorsObj: Cyan + Magenta = Purple

q24_online = tableR_online(tableR_online.id_question == 24,:); q24_online = sortrows(q24_online, 'id');
q24_dalt_online = tableDR_online(tableDR_online.id_question == 24,:); q24_dalt_online = sortrows(q24_dalt_online, 'id');

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

for i = 1 : height(q24_online)                                  
    tColor = cell2mat(q18_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q24_dalt_online)
    tColor = cell2mat(q24_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_24'), 'png');

%% Question 25 - twoColorsObj: Magenta + Yellow = Red

q25_online = tableR_online(tableR_online.id_question == 25,:); q25_online = sortrows(q25_online, 'id');
q25_dalt_online = tableDR_online(tableDR_online.id_question == 25,:); q25_dalt_online = sortrows(q25_dalt_online, 'id');

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

for i = 1 : height(q25_online)                                  
    tColor = cell2mat(q25_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q25_dalt_online)
    tColor = cell2mat(q25_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_25'), 'png');

%% Question 26 - twoColorsObj: Green + Cyan = Lime-green

q26_online = tableR_online(tableR_online.id_question == 26,:); q26_online = sortrows(q26_online, 'id');
q26_dalt_online = tableDR_online(tableDR_online.id_question == 26,:); q26_dalt_online = sortrows(q26_dalt_online, 'id');

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

for i = 1 : height(q26_online)                                  
    tColor = cell2mat(q26_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q26_dalt_online)
    tColor = cell2mat(q26_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_26'), 'png');

%% Question 27 - twoColorsObj: Green + Magenta = Blue || Orange (HSV)

q27_online = tableR_online(tableR_online.id_question == 27,:); q27_online = sortrows(q27_online, 'id');
q27_dalt_online = tableDR_online(tableDR_online.id_question == 27,:); q27_dalt_online = sortrows(q27_dalt_online, 'id');

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

for i = 1 : height(q27_online)                                  
    tColor = cell2mat(q27_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q27_dalt_online)
    tColor = cell2mat(q27_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_27'), 'png');

%% Question 28 - twoColorsObj: Green + Yellow = Yellower-Green

q28_online = tableR_online(tableR_online.id_question == 28,:); q28_online = sortrows(q28_online, 'id');
q28_dalt_online = tableDR_online(tableDR_online.id_question == 28,:); q28_dalt_online = sortrows(q28_dalt_online, 'id');

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

for i = 1 : height(q28_online)                                  
    tColor = cell2mat(q28_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q28_dalt_online)
    tColor = cell2mat(q28_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_28'), 'png');

%% Question 29 - twoColorsObj: Blue + Cyan = Darker-Blue

q29_online = tableR_online(tableR_online.id_question == 29,:); q29_online = sortrows(q29_online, 'id');
q29_dalt_online = tableDR_online(tableDR_online.id_question == 29,:); q29_dalt_online = sortrows(q29_dalt_online, 'id');

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

for i = 1 : height(q29_online)                                  
    tColor = cell2mat(q29_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q29_dalt_online)
    tColor = cell2mat(q29_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_29'), 'png');

%% Question 30 - twoColorsObj: Blue + Magenta = Purple 

q30_online = tableR_online(tableR_online.id_question == 30,:); q30_online = sortrows(q30_online, 'id');
q30_dalt_online = tableDR_online(tableDR_online.id_question == 30,:); q30_dalt_online = sortrows(q30_dalt_online, 'id');

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

for i = 1 : height(q30_online)                                  
    tColor = cell2mat(q30_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q30_dalt_online)
    tColor = cell2mat(q30_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_30'), 'png');

%% Question 31 - twoColorsObj: Blue + Yellow = Lime-Green || Red (HSV)

q31_online = tableR_online(tableR_online.id_question == 31,:); q31_online = sortrows(q31_online, 'id');
q31_dalt_online = tableDR_online(tableDR_online.id_question == 31,:); q31_dalt_online = sortrows(q31_dalt_online, 'id');

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

for i = 1 : height(q31_online)                                  
    tColor = cell2mat(q31_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q31_dalt_online)
    tColor = cell2mat(q31_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_31'), 'png');

%% Question 32 - twoColorsObj: Cyan + Yellow = Green

q32_online = tableR_online(tableR_online.id_question == 32,:); q32_online = sortrows(q32_online, 'id');
q32_dalt_online = tableDR_online(tableDR_online.id_question == 32,:); q32_dalt_online = sortrows(q32_dalt_online, 'id');

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

for i = 1 : height(q32_online)                                  
    tColor = cell2mat(q32_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
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

for i = 1 : height(q32_dalt_online)
    tColor = cell2mat(q32_online.third_color(i));              % #RRGGBB
    r = (hex2dec(strcat(tColor(2), tColor(3)))/255);        % RR
    g = (hex2dec(strcat(tColor(4), tColor(5)))/255);        % GG    
    b = (hex2dec(strcat(tColor(6), tColor(7)))/255);        % BB
    tColor = rgb2xyz([r g b]);                             
    x_aux = tColor(1)/(tColor(1) + tColor(2) + tColor(3)); y_aux = tColor(2)/(tColor(1) + tColor(2) + tColor(3)); 
    x_values = [x_values x_aux]; y_values = [y_values y_aux];
    
    scatter(x_values, y_values, 50, 'white'); plot(x_values, y_values, 'Color', 'black');               
    text(x_values + 0.01, y_values, strcat('\leftarrow ',num2str(i)), 'FontSize', 10);                           %identify the points
    x_values = []; y_values = [];
end
hold off;
saveas(gcf, fullfile(pathOnline, 'Question_32'), 'png');