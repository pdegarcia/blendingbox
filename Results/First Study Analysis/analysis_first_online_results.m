close all;

%% Analyze Online Users %%

users_online = 'data_first_onlineUsers.csv';

results_online = 'data_first_online_results.csv';
daltonic_results_online = 'data_first_online_daltonic_results.csv';
uncalibrated_results_online = 'data_first_online_uncalibrated_results.csv';

tableU_online = readtable(users_online, 'Delimiter', ',');
tableR_online = readtable(results_online, 'Delimiter', ';');
tableUR_online = readtable(uncalibrated_results_online, 'Delimiter', ';');
tableDR_online = readtable(daltonic_results_online, 'Delimiter', ';');

%% Dividing Questions (Calibrated Users)

q1_online = tableR_online(tableR_online.id_question == 1,:); q1_online = sortrows(q1_online, 'id');
q2_online = tableR_online(tableR_online.id_question == 2,:); q2_online = sortrows(q2_online, 'id');
q3_online = tableR_online(tableR_online.id_question == 3,:); q3_online = sortrows(q3_online, 'id');
q4_online = tableR_online(tableR_online.id_question == 4,:); q4_online = sortrows(q4_online, 'id');
q5_online = tableR_online(tableR_online.id_question == 5,:); q5_online = sortrows(q5_online, 'id');
q6_online = tableR_online(tableR_online.id_question == 6,:); q6_online = sortrows(q6_online, 'id');
q7_online = tableR_online(tableR_online.id_question == 7,:); q7_online = sortrows(q7_online, 'id');
q8_online = tableR_online(tableR_online.id_question == 8,:); q8_online = sortrows(q8_online, 'id');
q9_online = tableR_online(tableR_online.id_question == 9,:); q9_online = sortrows(q9_online, 'id');
q10_online = tableR_online(tableR_online.id_question == 10,:); q10_online = sortrows(q10_online, 'id');
q11_online = tableR_online(tableR_online.id_question == 11,:); q11_online = sortrows(q11_online, 'id');
q12_online = tableR_online(tableR_online.id_question == 12,:); q12_online = sortrows(q12_online, 'id');
q13_online = tableR_online(tableR_online.id_question == 13,:); q13_online = sortrows(q13_online, 'id');
q14_online = tableR_online(tableR_online.id_question == 14,:); q14_online = sortrows(q14_online, 'id');
q15_online = tableR_online(tableR_online.id_question == 15,:); q15_online = sortrows(q15_online, 'id');
q16_online = tableR_online(tableR_online.id_question == 16,:); q16_online = sortrows(q16_online, 'id');
q17_online = tableR_online(tableR_online.id_question == 17,:); q17_online = sortrows(q17_online, 'id');
q18_online = tableR_online(tableR_online.id_question == 18,:); q18_online = sortrows(q18_online, 'id');
q19_online = tableR_online(tableR_online.id_question == 19,:); q19_online = sortrows(q19_online, 'id');
q20_online = tableR_online(tableR_online.id_question == 20,:); q20_online = sortrows(q20_online, 'id');
q21_online = tableR_online(tableR_online.id_question == 21,:); q21_online = sortrows(q21_online, 'id');
q22_online = tableR_online(tableR_online.id_question == 22,:); q22_online = sortrows(q22_online, 'id');
q23_online = tableR_online(tableR_online.id_question == 23,:); q23_online = sortrows(q23_online, 'id');
q24_online = tableR_online(tableR_online.id_question == 24,:); q24_online = sortrows(q24_online, 'id');
q25_online = tableR_online(tableR_online.id_question == 25,:); q25_online = sortrows(q25_online, 'id');
q26_online = tableR_online(tableR_online.id_question == 26,:); q26_online = sortrows(q26_online, 'id');
q27_online = tableR_online(tableR_online.id_question == 27,:); q27_online = sortrows(q27_online, 'id');
q28_online = tableR_online(tableR_online.id_question == 28,:); q28_online = sortrows(q28_online, 'id');
q29_online = tableR_online(tableR_online.id_question == 29,:); q29_online = sortrows(q29_online, 'id');
q30_online = tableR_online(tableR_online.id_question == 30,:); q30_online = sortrows(q30_online, 'id');
q31_online = tableR_online(tableR_online.id_question == 31,:); q31_online = sortrows(q31_online, 'id');
q32_online = tableR_online(tableR_online.id_question == 32,:); q32_online = sortrows(q32_online, 'id');


%% Dividing Questions (Bad-Calibrated Users)

q1_unc_online = tableUR_online(tableUR_online.id_question == 1,:); q1_unc_online = sortrows(q1_unc_online, 'id');
q2_unc_online = tableUR_online(tableUR_online.id_question == 2,:); q2_unc_online = sortrows(q2_unc_online, 'id');
q3_unc_online = tableUR_online(tableUR_online.id_question == 3,:); q3_unc_online = sortrows(q3_unc_online, 'id');
q4_unc_online = tableUR_online(tableUR_online.id_question == 4,:); q4_unc_online = sortrows(q4_unc_online, 'id');
q5_unc_online = tableUR_online(tableUR_online.id_question == 5,:); q5_unc_online = sortrows(q5_unc_online, 'id');
q6_unc_online = tableUR_online(tableUR_online.id_question == 6,:); q6_unc_online = sortrows(q6_unc_online, 'id');
q7_unc_online = tableUR_online(tableUR_online.id_question == 7,:); q7_unc_online = sortrows(q7_unc_online, 'id');
q8_unc_online = tableUR_online(tableUR_online.id_question == 8,:); q8_unc_online = sortrows(q8_unc_online, 'id');
q9_unc_online = tableUR_online(tableUR_online.id_question == 9,:); q9_unc_online = sortrows(q9_unc_online, 'id');
q10_unc_online = tableUR_online(tableUR_online.id_question == 10,:); q10_unc_online = sortrows(q10_unc_online, 'id');
q11_unc_online = tableUR_online(tableUR_online.id_question == 11,:); q11_unc_online = sortrows(q11_unc_online, 'id');
q12_unc_online = tableUR_online(tableUR_online.id_question == 12,:); q12_unc_online = sortrows(q12_unc_online, 'id');
q13_unc_online = tableUR_online(tableUR_online.id_question == 13,:); q13_unc_online = sortrows(q13_unc_online, 'id');
q14_unc_online = tableUR_online(tableUR_online.id_question == 14,:); q14_unc_online = sortrows(q14_unc_online, 'id');
q15_unc_online = tableUR_online(tableUR_online.id_question == 15,:); q15_unc_online = sortrows(q15_unc_online, 'id');
q16_unc_online = tableUR_online(tableUR_online.id_question == 16,:); q16_unc_online = sortrows(q16_unc_online, 'id');
q17_unc_online = tableUR_online(tableUR_online.id_question == 17,:); q17_unc_online = sortrows(q17_unc_online, 'id');
q18_unc_online = tableUR_online(tableUR_online.id_question == 18,:); q18_unc_online = sortrows(q18_unc_online, 'id');
q19_unc_online = tableUR_online(tableUR_online.id_question == 19,:); q19_unc_online = sortrows(q19_unc_online, 'id');
q20_unc_online = tableUR_online(tableUR_online.id_question == 20,:); q20_unc_online = sortrows(q20_unc_online, 'id');
q21_unc_online = tableUR_online(tableUR_online.id_question == 21,:); q21_unc_online = sortrows(q21_unc_online, 'id');
q22_unc_online = tableUR_online(tableUR_online.id_question == 22,:); q22_unc_online = sortrows(q22_unc_online, 'id');
q23_unc_online = tableUR_online(tableUR_online.id_question == 23,:); q23_unc_online = sortrows(q23_unc_online, 'id');
q24_unc_online = tableUR_online(tableUR_online.id_question == 24,:); q24_unc_online = sortrows(q24_unc_online, 'id');
q25_unc_online = tableUR_online(tableUR_online.id_question == 25,:); q25_unc_online = sortrows(q25_unc_online, 'id');
q26_unc_online = tableUR_online(tableUR_online.id_question == 26,:); q26_unc_online = sortrows(q26_unc_online, 'id');
q27_unc_online = tableUR_online(tableUR_online.id_question == 27,:); q27_unc_online = sortrows(q27_unc_online, 'id');
q28_unc_online = tableUR_online(tableUR_online.id_question == 28,:); q28_unc_online = sortrows(q28_unc_online, 'id');
q29_unc_online = tableUR_online(tableUR_online.id_question == 29,:); q29_unc_online = sortrows(q29_unc_online, 'id');
q30_unc_online = tableUR_online(tableUR_online.id_question == 30,:); q30_unc_online = sortrows(q30_unc_online, 'id');
q31_unc_online = tableUR_online(tableUR_online.id_question == 31,:); q31_unc_online = sortrows(q31_unc_online, 'id');
q32_unc_online = tableUR_online(tableUR_online.id_question == 32,:); q32_unc_online = sortrows(q32_unc_online, 'id');

%% Dividing Questions (Daltonic Users)

q1_dalt_online = tableDR_online(tableDR_online.id_question == 1,:); q1_dalt_online = sortrows(q1_dalt_online, 'id');
q2_dalt_online = tableDR_online(tableDR_online.id_question == 2,:); q2_dalt_online = sortrows(q2_dalt_online, 'id');
q3_dalt_online = tableDR_online(tableDR_online.id_question == 3,:); q3_dalt_online = sortrows(q3_dalt_online, 'id');
q4_dalt_online = tableDR_online(tableDR_online.id_question == 4,:); q4_dalt_online = sortrows(q4_dalt_online, 'id');
q5_dalt_online = tableDR_online(tableDR_online.id_question == 5,:); q5_dalt_online = sortrows(q5_dalt_online, 'id');
q6_dalt_online = tableDR_online(tableDR_online.id_question == 6,:); q6_dalt_online = sortrows(q6_dalt_online, 'id');
q7_dalt_online = tableDR_online(tableDR_online.id_question == 7,:); q7_dalt_online = sortrows(q7_dalt_online, 'id');
q8_dalt_online = tableDR_online(tableDR_online.id_question == 8,:); q8_dalt_online = sortrows(q8_dalt_online, 'id');
q9_dalt_online = tableDR_online(tableDR_online.id_question == 9,:); q9_dalt_online = sortrows(q9_dalt_online, 'id');
q10_dalt_online = tableDR_online(tableDR_online.id_question == 10,:); q10_dalt_online = sortrows(q10_dalt_online, 'id');
q11_dalt_online = tableDR_online(tableDR_online.id_question == 11,:); q11_dalt_online = sortrows(q11_dalt_online, 'id');
q12_dalt_online = tableDR_online(tableDR_online.id_question == 12,:); q12_dalt_online = sortrows(q12_dalt_online, 'id');
q13_dalt_online = tableDR_online(tableDR_online.id_question == 13,:); q13_dalt_online = sortrows(q13_dalt_online, 'id');
q14_dalt_online = tableDR_online(tableDR_online.id_question == 14,:); q14_dalt_online = sortrows(q14_dalt_online, 'id');
q15_dalt_online = tableDR_online(tableDR_online.id_question == 15,:); q15_dalt_online = sortrows(q15_dalt_online, 'id');
q16_dalt_online = tableDR_online(tableDR_online.id_question == 16,:); q16_dalt_online = sortrows(q16_dalt_online, 'id');
q17_dalt_online = tableDR_online(tableDR_online.id_question == 17,:); q17_dalt_online = sortrows(q17_dalt_online, 'id');
q18_dalt_online = tableDR_online(tableDR_online.id_question == 18,:); q18_dalt_online = sortrows(q18_dalt_online, 'id');
q19_dalt_online = tableDR_online(tableDR_online.id_question == 19,:); q19_dalt_online = sortrows(q19_dalt_online, 'id');
q20_dalt_online = tableDR_online(tableDR_online.id_question == 20,:); q20_dalt_online = sortrows(q20_dalt_online, 'id');
q21_dalt_online = tableDR_online(tableDR_online.id_question == 21,:); q21_dalt_online = sortrows(q21_dalt_online, 'id');
q22_dalt_online = tableDR_online(tableDR_online.id_question == 22,:); q22_dalt_online = sortrows(q22_dalt_online, 'id');
q23_dalt_online = tableDR_online(tableDR_online.id_question == 23,:); q23_dalt_online = sortrows(q23_dalt_online, 'id');
q24_dalt_online = tableDR_online(tableDR_online.id_question == 24,:); q24_dalt_online = sortrows(q24_dalt_online, 'id');
q25_dalt_online = tableDR_online(tableDR_online.id_question == 25,:); q25_dalt_online = sortrows(q25_dalt_online, 'id');
q26_dalt_online = tableDR_online(tableDR_online.id_question == 26,:); q26_dalt_online = sortrows(q26_dalt_online, 'id');
q27_dalt_online = tableDR_online(tableDR_online.id_question == 27,:); q27_dalt_online = sortrows(q27_dalt_online, 'id');
q28_dalt_online = tableDR_online(tableDR_online.id_question == 28,:); q28_dalt_online = sortrows(q28_dalt_online, 'id');
q29_dalt_online = tableDR_online(tableDR_online.id_question == 29,:); q29_dalt_online = sortrows(q29_dalt_online, 'id');
q30_dalt_online = tableDR_online(tableDR_online.id_question == 30,:); q30_dalt_online = sortrows(q30_dalt_online, 'id');
q31_dalt_online = tableDR_online(tableDR_online.id_question == 31,:); q31_dalt_online = sortrows(q31_dalt_online, 'id');
q32_dalt_online = tableDR_online(tableDR_online.id_question == 32,:); q32_dalt_online = sortrows(q32_dalt_online, 'id');