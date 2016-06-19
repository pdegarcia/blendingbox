close all;

%% Analyze Laboratory Users %%

users_lab = 'data_first_labUsers.csv';
results_lab = 'data_first_laboratory_results.csv';
daltonic_results_lab = 'data_first_laboratory_daltonic_results.csv';

tableU_lab = readtable(users_lab, 'Delimiter', ',');
tableR_lab = readtable(results_lab, 'Delimiter', ';');
tableDR_lab = readtable(daltonic_results_lab, 'Delimiter', ';');

q1_lab = tableR_lab(tableR_lab.id_question == 1,:); q1_lab = sortrows(q1_lab, 'id');
q2_lab = tableR_lab(tableR_lab.id_question == 2,:); q2_lab = sortrows(q2_lab, 'id');
q3_lab = tableR_lab(tableR_lab.id_question == 3,:); q3_lab = sortrows(q3_lab, 'id');
q4_lab = tableR_lab(tableR_lab.id_question == 4,:); q4_lab = sortrows(q4_lab, 'id');
q5_lab = tableR_lab(tableR_lab.id_question == 5,:); q5_lab = sortrows(q5_lab, 'id');
q6_lab = tableR_lab(tableR_lab.id_question == 6,:); q6_lab = sortrows(q6_lab, 'id');
q7_lab = tableR_lab(tableR_lab.id_question == 7,:); q7_lab = sortrows(q7_lab, 'id');
q8_lab = tableR_lab(tableR_lab.id_question == 8,:); q8_lab = sortrows(q8_lab, 'id');
q9_lab = tableR_lab(tableR_lab.id_question == 9,:); q9_lab = sortrows(q9_lab, 'id');
q10_lab = tableR_lab(tableR_lab.id_question == 10,:); q10_lab = sortrows(q10_lab, 'id');
q11_lab = tableR_lab(tableR_lab.id_question == 11,:); q11_lab = sortrows(q11_lab, 'id');
q12_lab = tableR_lab(tableR_lab.id_question == 12,:); q12_lab = sortrows(q12_lab, 'id');
q13_lab = tableR_lab(tableR_lab.id_question == 13,:); q13_lab = sortrows(q13_lab, 'id');
q14_lab = tableR_lab(tableR_lab.id_question == 14,:); q14_lab = sortrows(q14_lab, 'id');
q15_lab = tableR_lab(tableR_lab.id_question == 15,:); q15_lab = sortrows(q15_lab, 'id');
q16_lab = tableR_lab(tableR_lab.id_question == 16,:); q16_lab = sortrows(q16_lab, 'id');
q17_lab = tableR_lab(tableR_lab.id_question == 17,:); q17_lab = sortrows(q17_lab, 'id');
q18_lab = tableR_lab(tableR_lab.id_question == 18,:); q18_lab = sortrows(q18_lab, 'id');
q19_lab = tableR_lab(tableR_lab.id_question == 19,:); q19_lab = sortrows(q19_lab, 'id');
q20_lab = tableR_lab(tableR_lab.id_question == 20,:); q20_lab = sortrows(q20_lab, 'id');
q21_lab = tableR_lab(tableR_lab.id_question == 21,:); q21_lab = sortrows(q21_lab, 'id');
q22_lab = tableR_lab(tableR_lab.id_question == 22,:); q22_lab = sortrows(q22_lab, 'id');
q23_lab = tableR_lab(tableR_lab.id_question == 23,:); q23_lab = sortrows(q23_lab, 'id');
q24_lab = tableR_lab(tableR_lab.id_question == 24,:); q24_lab = sortrows(q24_lab, 'id');
q25_lab = tableR_lab(tableR_lab.id_question == 25,:); q25_lab = sortrows(q25_lab, 'id');
q26_lab = tableR_lab(tableR_lab.id_question == 26,:); q26_lab = sortrows(q26_lab, 'id');
q27_lab = tableR_lab(tableR_lab.id_question == 27,:); q27_lab = sortrows(q27_lab, 'id');
q28_lab = tableR_lab(tableR_lab.id_question == 28,:); q28_lab = sortrows(q28_lab, 'id');
q29_lab = tableR_lab(tableR_lab.id_question == 29,:); q29_lab = sortrows(q29_lab, 'id');
q30_lab = tableR_lab(tableR_lab.id_question == 30,:); q30_lab = sortrows(q30_lab, 'id');
q31_lab = tableR_lab(tableR_lab.id_question == 31,:); q31_lab = sortrows(q31_lab, 'id');
q32_lab = tableR_lab(tableR_lab.id_question == 32,:); q32_lab = sortrows(q32_lab, 'id');

%% Dividing Questions (Daltonic Users)

q1_dalt_lab = tableDR_lab(tableDR_lab.id_question == 1,:); q1_dalt_lab = sortrows(q1_dalt_lab, 'id');
q2_dalt_lab = tableDR_lab(tableDR_lab.id_question == 2,:); q2_dalt_lab = sortrows(q2_dalt_lab, 'id');
q3_dalt_lab = tableDR_lab(tableDR_lab.id_question == 3,:); q3_dalt_lab = sortrows(q3_dalt_lab, 'id');
q4_dalt_lab = tableDR_lab(tableDR_lab.id_question == 4,:); q4_dalt_lab = sortrows(q4_dalt_lab, 'id');
q5_dalt_lab = tableDR_lab(tableDR_lab.id_question == 5,:); q5_dalt_lab = sortrows(q5_dalt_lab, 'id');
q6_dalt_lab = tableDR_lab(tableDR_lab.id_question == 6,:); q6_dalt_lab = sortrows(q6_dalt_lab, 'id');
q7_dalt_lab = tableDR_lab(tableDR_lab.id_question == 7,:); q7_dalt_lab = sortrows(q7_dalt_lab, 'id');
q8_dalt_lab = tableDR_lab(tableDR_lab.id_question == 8,:); q8_dalt_lab = sortrows(q8_dalt_lab, 'id');
q9_dalt_lab = tableDR_lab(tableDR_lab.id_question == 9,:); q9_dalt_lab = sortrows(q9_dalt_lab, 'id');
q10_dalt_lab = tableDR_lab(tableDR_lab.id_question == 10,:); q10_dalt_lab = sortrows(q10_dalt_lab, 'id');
q11_dalt_lab = tableDR_lab(tableDR_lab.id_question == 11,:); q11_dalt_lab = sortrows(q11_dalt_lab, 'id');
q12_dalt_lab = tableDR_lab(tableDR_lab.id_question == 12,:); q12_dalt_lab = sortrows(q12_dalt_lab, 'id');
q13_dalt_lab = tableDR_lab(tableDR_lab.id_question == 13,:); q13_dalt_lab = sortrows(q13_dalt_lab, 'id');
q14_dalt_lab = tableDR_lab(tableDR_lab.id_question == 14,:); q14_dalt_lab = sortrows(q14_dalt_lab, 'id');
q15_dalt_lab = tableDR_lab(tableDR_lab.id_question == 15,:); q15_dalt_lab = sortrows(q15_dalt_lab, 'id');
q16_dalt_lab = tableDR_lab(tableDR_lab.id_question == 16,:); q16_dalt_lab = sortrows(q16_dalt_lab, 'id');
q17_dalt_lab = tableDR_lab(tableDR_lab.id_question == 17,:); q17_dalt_lab = sortrows(q17_dalt_lab, 'id');
q18_dalt_lab = tableDR_lab(tableDR_lab.id_question == 18,:); q18_dalt_lab = sortrows(q18_dalt_lab, 'id');
q19_dalt_lab = tableDR_lab(tableDR_lab.id_question == 19,:); q19_dalt_lab = sortrows(q19_dalt_lab, 'id');
q20_dalt_lab = tableDR_lab(tableDR_lab.id_question == 20,:); q20_dalt_lab = sortrows(q20_dalt_lab, 'id');
q21_dalt_lab = tableDR_lab(tableDR_lab.id_question == 21,:); q21_dalt_lab = sortrows(q21_dalt_lab, 'id');
q22_dalt_lab = tableDR_lab(tableDR_lab.id_question == 22,:); q22_dalt_lab = sortrows(q22_dalt_lab, 'id');
q23_dalt_lab = tableDR_lab(tableDR_lab.id_question == 23,:); q23_dalt_lab = sortrows(q23_dalt_lab, 'id');
q24_dalt_lab = tableDR_lab(tableDR_lab.id_question == 24,:); q24_dalt_lab = sortrows(q24_dalt_lab, 'id');
q25_dalt_lab = tableDR_lab(tableDR_lab.id_question == 25,:); q25_dalt_lab = sortrows(q25_dalt_lab, 'id');
q26_dalt_lab = tableDR_lab(tableDR_lab.id_question == 26,:); q26_dalt_lab = sortrows(q26_dalt_lab, 'id');
q27_dalt_lab = tableDR_lab(tableDR_lab.id_question == 27,:); q27_dalt_lab = sortrows(q27_dalt_lab, 'id');
q28_dalt_lab = tableDR_lab(tableDR_lab.id_question == 28,:); q28_dalt_lab = sortrows(q28_dalt_lab, 'id');
q29_dalt_lab = tableDR_lab(tableDR_lab.id_question == 29,:); q29_dalt_lab = sortrows(q29_dalt_lab, 'id');
q30_dalt_lab = tableDR_lab(tableDR_lab.id_question == 30,:); q30_dalt_lab = sortrows(q30_dalt_lab, 'id');
q31_dalt_lab = tableDR_lab(tableDR_lab.id_question == 31,:); q31_dalt_lab = sortrows(q31_dalt_lab, 'id');
q32_dalt_lab = tableDR_lab(tableDR_lab.id_question == 32,:); q32_dalt_lab = sortrows(q32_dalt_lab, 'id');