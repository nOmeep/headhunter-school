--Т.к. индекс ускоряет поиск, то я решил поставить его на навзания вакансий, так как их чаще всего и используют, наверное
create index vacancy_title on vacancy (title);
--Соискателя может интересовать поиск по его специализации, а не по названию вакансии
create index specialization_name on specialization(id, name);
--Так как на сайте искать что-то могут не только сиоискатели, но и работадатели, поэтому есть смысл сделать индекс на
--название резюме и ключевые навыки в нем
create index cv_important_part on cv(skills, description);
--У каждого работадателя есть бюджет, поэтому также стоит выставить индекс на желаемую зарплату соискателя
create index cv_expected_salary on cv(salary_expectations);