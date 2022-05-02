--Виды занятости
insert into BUSYNESS(type)
values ('Частичная занятость'),
       ('Полная занятость');

--Виды специализаций
insert into SPECIALIZATION(name)
values ('IT'),
       ('Маркетинг'),
       ('Логистика'),
       ('Спорт'),
       ('Юриспруденция');

--Виды локаций
insert into AREA(name)
values ('Москва и МО'),
       ('Санкт-Петербург'),
       ('Омск'),
       ('Казань');

--Работодатели
insert into EMPLOYER(company_name, description)
values ('HH', 'описание 1'),
       ('Рога и копыта', 'описание 2'),
       ('АбобаТех', 'описание 3');

--select * from AREA;
--select * from SPECIALIZATION;
--select * from BUSYNESS;
--select * from EMPLOYER;

DO
$$
    DECLARE
        CV_AMOUNT      CONSTANT int = 100000;
        VACANCY_AMOUNT CONSTANT int = 10000;
    BEGIN
        with samle_vacancies(
                             id,
                             compensation_from,
                             compensation_to,
                             title,
                             experience_required,
                             busyness,
                             area_id,
                             employer_id,
                             description
            ) AS (
            SELECT generate_series(1, VACANCY_AMOUNT)     AS id,
                   floor(random() * 20000 + 2000)::INT    AS compensation_from,
                   floor(random() * 1000000 + 60000)::INT AS compensation_to,
                   md5(random()::text)                    AS title,
                   floor(random() * 5 + 1)::INT           AS experience_required,
                   floor(random() * 2 + 1)::INT           AS busyness,
                   floor(random() * 4 + 1)::INT           AS area_id,
                   floor(random() * 3 + 1)::INT           AS employer_id,
                   md5(random()::text)                    AS description
        )
        insert
        into vacancy(id,
                     compensation_from,
                     compensation_to,
                     title,
                     experience_required,
                     busyness,
                     area_id,
                     employer_id,
                     description)
        select id,
               compensation_from,
               compensation_to,
               title,
               experience_required,
               busyness,
               area_id,
               employer_id,
               description
        from samle_vacancies;

        with sample_cv(
                       id,
                       specialization,
                       job_experience,
                       busyness_type,
                       salary_expectations,
                       skills,
                       description,
                       education,
                       languages,
                       citizenship
            ) AS (
            SELECT generate_series(1, CV_AMOUNT)         as id,
                   floor(random() * 5 + 1)::INT          as specialization,
                   floor(random() * 12)::INT             as job_experience,
                   floor(random() * 2 + 1)::INT          as busyness_type,
                   floor(random() * 500000 + 50000)::INT as salary_expectations,
                   md5(random()::text)                   as skills,
                   md5(random()::text)                   as description,
                   md5(random()::text)                   as education,
                   md5(random()::text)                   as languages,
                   md5(random()::text)                   as citizenship
        )
        insert
        into CV (id,
                 specialization,
                 job_experience,
                 busyness_type,
                 salary_expectations,
                 skills,
                 description,
                 education,
                 languages,
                 citizenship)
        select id,
               specialization,
               job_experience,
               busyness_type,
               salary_expectations,
               skills,
               description,
               education,
               languages,
               citizenship
        from sample_cv;

        with sample_vacancy_responces(
                                      id,
                                      vacancy_id,
                                      employer_id,
                                      responded_at
            ) AS (
            select generate_series(1, VACANCY_AMOUNT)                     AS id,
                   floor(random() * VACANCY_AMOUNT + 1)::INT              AS vacancy_id,
                   floor(random() * 3 + 1)::INT                           AS employer_id,
                   now() + floor(random() * 100) * INTERVAL '1 day' AS responded_at
        )
        insert
        into VACANCY_RESPONSE (id, vacancy_id, employer_id, responded_at)
        select id,
               vacancy_id,
               employer_id,
               responded_at
        from sample_vacancy_responces;
    END
$$;