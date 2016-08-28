%% SCRIPT TO RUN THE FIRST STUDY ANALYSIS
%
% This file computes the pre-calculated values for each color mixture,
% according to each color model: HSV, CIE-LCh, CMYK, RGB and CIE-Lab. Then
% it processes the Color Bins given by XKCD's study, conveying itself to
% the complete analysis of each question.
%
% Each question script generates a bunch of information:
% - Laboratory/Online Results: 
% __ Chromaticity diagrams for each question's responses, in every color model. 
% __ Chromaticity diagrams for each non-daltonic responses-pair.
% __ Chromaticity diagrams for each daltonic user responses-pair.
% __ Chromaticity diagrams for each uncalibrated user responses-pair (ONLINE RESULTS ONLY).
%
% - CSV tables for:
% __ Responses' Centroids.
% __ Regular Users Laboratory Results.
% __ Daltonic Users Laboratory Results.
% __ Regular Users Online Results.
% __ Daltonic Users Online Results.
% __ Uncalibrated Users Online Results.

% Clear previous executions.
clear all;
close all;

%% Convert values according to a .icc profile or not, generating RGB values
% Tables and Hexadecimal color codes.
disp(' ');
disp('-----------------------------------------------------------------------------------------');
disp('|                                  COLOR CONVERTER                                      |');
disp('-----------------------------------------------------------------------------------------');

ColorConverter; 

disp('>> Color Converter runned smooth. Finished.');

%% Create Color Bins table and other stuff.
disp(' ');
disp('-----------------------------------------------------------------------------------------');
disp('|                                    COLOR BINS                                         |');
disp('-----------------------------------------------------------------------------------------');

process_colorBins; % -- UNCOMMENT HERE TO PROCESS ALL COLOR BINS (WARNING: extensively resource-consuming task).
answers = ones(1,32);

%% Processing questions of type 'objTwoColors': OBJ (Given) = C1 (Requested) + C2 (Requested)
disp(' ');
disp('-----------------------------------------------------------------------------------------');
disp('|                                QUESTION ANALYSIS                                      |');
disp('-----------------------------------------------------------------------------------------');

try 
    q1_firstStudy_analysis;
catch
    answers(1,1) = 0;
end

try 
    q2_firstStudy_analysis;
catch
    answers(1,2) = 0;
end

try 
    q3_firstStudy_analysis;
catch
    answers(1,3) = 0;
end

try 
    q4_firstStudy_analysis;
catch
    answers(1,4) = 0;
end

try 
    q5_firstStudy_analysis;
catch
    answers(1,6) = 0;
end

try 
    q7_firstStudy_analysis;
catch
    answers(1,7) = 0;
end

try 
    q8_firstStudy_analysis;
catch
    answers(1,8) = 0;
end

try 
    q9_firstStudy_analysis;
catch
    answers(1,9) = 0;
end

try 
    q10_firstStudy_analysis;
catch
    answers(1,10) = 0;
end

try 
    q11_firstStudy_analysis;
catch
    answers(1,11) = 0;
end

try 
    q12_firstStudy_analysis;
catch
    answers(1,12) = 0;
end

try 
    q13_firstStudy_analysis;
catch
    answers(1,13) = 0;
end

try 
    q14_firstStudy_analysis;
catch
    answers(1,14) = 0;
end

try 
    q15_firstStudy_analysis;
catch
    answers(1,15) = 0;
end

try 
    q16_firstStudy_analysis;
catch
    answers(1,16) = 0;
end

try 
    q17_firstStudy_analysis;
catch
    answers(1,17) = 0;
end

try 
    q18_firstStudy_analysis;
catch
    answers(1,18) = 0;
end

try 
    q19_firstStudy_analysis;
catch
    answers(1,19) = 0;
end

try 
    q20_firstStudy_analysis;
catch
    answers(1,20) = 0;
end

try 
    q21_firstStudy_analysis;
catch
    answers(1,21) = 0;
end

try 
    q22_firstStudy_analysis;
catch
    answers(1,22) = 0;
end

try 
    q23_firstStudy_analysis;
catch
    answers(1,23) = 0;
end

try 
    q24_firstStudy_analysis;
catch
    answers(1,24) = 0;
end

try 
    q25_firstStudy_analysis;
catch
    answers(1,25) = 0;
end

try 
    q26_firstStudy_analysis;
catch
    answers(1,26) = 0;
end

try 
    q27_firstStudy_analysis;
catch
    answers(1,27) = 0;
end

try 
    q28_firstStudy_analysis;
catch
    answers(1,28) = 0;
end

try 
    q29_firstStudy_analysis;
catch
    answers(1,29) = 0;
end

try 
    q30_firstStudy_analysis;
catch
    answers(1,30) = 0;
end

try 
    q31_firstStudy_analysis;
catch
    answers(1,31) = 0;
end

try 
    q32_firstStudy_analysis;
catch
    answers(1,32) = 0;
end

successOne = ['             | ', num2str(answers(1,1)) , ' | ', num2str(answers(1,2)) ,' | ', num2str(answers(1,3)), ' | ', num2str(answers(1,4)), ' | ', num2str(answers(1,5)), ' | ', num2str(answers(1,6)), ' | ', num2str(answers(1,7)), ' | ', num2str(answers(1,8)), ' | ', num2str(answers(1,9)), ' | ', num2str(answers(1,10)), '  | ', num2str(answers(1,11)), '  | ', num2str(answers(1,12)), '  | ', num2str(answers(1,13)), '  | ', num2str(answers(1,14)), '  | ', num2str(answers(1,15)), '  | ', num2str(answers(1,16)), '  | ', num2str(answers(1,17)), '  |'];
successTwo = ['             | ', num2str(answers(1,18)), '  | ', num2str(answers(1,19)), '  | ', num2str(answers(1,20)), '  | ', num2str(answers(1,21)), '  | ', num2str(answers(1,22)), '  | ', num2str(answers(1,23)), '  | ', num2str(answers(1,24)), '  | ', num2str(answers(1,25)), '  | ', num2str(answers(1,26)), '  | ', num2str(answers(1,27)), '  | ', num2str(answers(1,28)), '  | ', num2str(answers(1,29)), '  | ', num2str(answers(1,30)), '  | ', num2str(answers(1,31)), '  | ', num2str(answers(1,32)) , '  |',];

%% RESULTS DISPLAY
disp(' ');
disp('-----------------------------------------------------------------------------------------');
disp('|                                      RESULTS                                          |');
disp('-----------------------------------------------------------------------------------------');

disp('              --- --- --- --- --- --- --- --- --- ---- ---- ---- ---- ---- ---- ---- ----');
disp('objTwoColors | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 |');
disp('              --- --- --- --- --- --- --- --- --- ---- ---- ---- ---- ---- ---- ---- ----');
disp(successOne);
disp('              --- --- --- --- --- --- --- --- --- ---- ---- ---- ---- ---- ---- ---- ----');

disp('              ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----');
disp('twoColorsObj | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 |');
disp('              ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----');
disp(successTwo);
disp('              ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----');

%% Close all plots generated.
close all; 
