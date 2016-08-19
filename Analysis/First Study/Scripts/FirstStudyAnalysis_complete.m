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

% Convert values according to a .icc profile or not, generating RGB values
% Tables and Hexadecimal color codes.
ColorConverter; 

% Create Color Bins table and other stuff.
process_colorBins; % -- UNCOMMENT HERE TO PROCESS ALL COLOR BINS (WARNING: extensively resource-consuming task).

% Processing questions of type 'objTwoColors': OBJ (Given) = C1 (Requested) + C2 (Requested)
q1_firstStudy_analysis;
q2_firstStudy_analysis;
q3_firstStudy_analysis;
q4_firstStudy_analysis;
q5_firstStudy_analysis;
q6_firstStudy_analysis;
q7_firstStudy_analysis;
q8_firstStudy_analysis;
q9_firstStudy_analysis;
q10_firstStudy_analysis;
q11_firstStudy_analysis;
q12_firstStudy_analysis;
q13_firstStudy_analysis;
q14_firstStudy_analysis;
q15_firstStudy_analysis;
q16_firstStudy_analysis;
q17_firstStudy_analysis;

% Processing questions of type 'twoColorsObj': C1 (Given) + C2 (Given) = OBJ (Requested)
% q18_firstStudy_analysis;
% q19_firstStudy_analysis;
% q20_firstStudy_analysis;
% q21_firstStudy_analysis;
% q22_firstStudy_analysis;
% q23_firstStudy_analysis;
% q24_firstStudy_analysis;
% q25_firstStudy_analysis;
% q26_firstStudy_analysis;
% q27_firstStudy_analysis;
% q28_firstStudy_analysis;
% q29_firstStudy_analysis;
% q30_firstStudy_analysis;
% q31_firstStudy_analysis;
% q32_firstStudy_analysis;

% Close all plots generated.
close all; 