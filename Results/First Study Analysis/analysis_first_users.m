%% Entire Set of Users %%

users = 'data_first_allUsers.csv';
tableU = readtable(users, 'Delimiter', ',');
    tableU = sortrows(tableU, 'id');

ages = nominal(tableU.age);
gender = nominal(tableU.gender);
academic = nominal(tableU.academic_degree);
nationalities = nominal(tableU.nationality);
countries = nominal(tableU.country_residence);
languages = nominal(tableU.language);

% Sanitize Data %
academic(academic == 'Ensino Prim√°rio') = 'Ensino Primario';
academic(academic == 'Ensino Prim·rio') = 'Ensino Primario';
academic(academic == 'College') = 'Ensino Primario';

academic(academic == 'Ensino Secund√°rio') = 'Ensino Secundario';
academic(academic == 'Ensino Secund·rio') = 'Ensino Secundario';
academic(academic == 'High-School') = 'Ensino Secundario';

academic(academic == 'Bachelor Degree') = 'Ensino Superior - Licenciatura';
academic(academic == 'Master Degree') = 'Ensino Superior - Mestrado';
academic(academic == 'Doctoral Degree') = 'Ensino Superior - Doutoramento';

academic(academic == 'No Academic Degree') = 'Sem FormaÁ„o';