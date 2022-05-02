drop table if exists applicant;
drop table if exists VACANCY_RESPONSE;
drop table if exists cv;
drop table if exists specialization;
drop table if exists vacancy;
drop table if exists BUSYNESS;
drop table if exists AREA;
drop table if exists employer;

--Тип занятости
create table BUSYNESS
(
    id   serial primary key,
    type varchar(50) not null
);

--Специализация
create table SPECIALIZATION
(
    id   serial primary key,
    name varchar(50) not null
);

--Локация
create table AREA
(
    id   serial primary key,
    name varchar(50) not null
);

--Резюме
create table CV
(
    id                  serial primary key,

    specialization      integer references SPECIALIZATION (id),

    job_experience      text,
    busyness_type       integer references BUSYNESS (id),
    salary_expectations integer,

    skills              text,
    description         text,

    education           text,
    languages           text,
    /* Разные ж гражданства бывают */
    citizenship         text,

    created_at          date not null default now()
);

--Соискатель
create table applicant
(
    id_applicant  serial primary key,

    first_name    text not null,
    second_name   text not null,
    third_name    text,

    date_of_birth date not null,
    sex           text not null,

    email         text,
    phone_number  varchar(10),

    --У соискателя есть резюме
    cv            integer references CV (id)
);

--Работодатель
create table EMPLOYER
(
    id           serial primary key,

    company_name text not null,
    description  text not null
);

--Вкансия
create table VACANCY
(
    id                  serial primary key,

    compensation_from   integer,
    compensation_to     integer,

    title               text                             not null,
    experience_required text                             not null,
    busyness            integer references BUSYNESS (id) not null,
    area_id             integer                          not null,
    employer_id         integer references EMPLOYER (id) not null,
    description         text                             not null,

    created_at          date                             not null default now()
);

--Отклик на вакансию(пока не начал делать 5й номер даже не подумал добавлять эту таблицу)
create table VACANCY_RESPONSE
(
    id           serial primary key,
    vacancy_id   integer references VACANCY (id),
    employer_id  integer references EMPLOYER (id),
    responded_at date
);

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

select area_id,
       floor(avg(compensation_from))::INT                         AS avg_compensation_from,
       floor(avg(compensation_to))::INT                           AS avg_compensation_to,
       --Вроде как среднее арифмеическое 2х величин, но не пойму зачем :?
       floor(avg((compensation_from + compensation_to) / 2))::INT AS avg_total
from VACANCY
GROUP BY area_id;

select (
           select extract(month from created_at) as month_with_most_cv
           from CV
           group by month_with_most_cv
           order by count(id)
           limit 1
       ),
       (
           select extract(month from created_at) as month_with_most_vacancy
           from VACANCY
           group by month_with_most_vacancy
           order by count(id)
           limit 1
       );

select V.id, V.title
from VACANCY V
--К вакансиям присоединяем собравшие больше 5
left join VACANCY_RESPONSE VR on v.id = VR.vacancy_id
where V.created_at + interval '1 week' < VR.responded_at
group by v.id, V.title
having count(*) > 5;

--Т.к. индекс ускоряет поиск, то я решил поставить его на навзания вакансий, так как их чаще всего и используют, наверное
create index vacancy_title on vacancy (title);
--Соискателя может интересовать поиск по его специализации, а не по названию вакансии
create index specialization_name on specialization(id, name);
--Так как на сайте искать что-то могут не только сиоискатели, но и работадатели, поэтому есть смысл сделать индекс на
--название резюме и ключевые навыки в нем
create index cv_important_part on cv(skills, description);
--У каждого работадателя есть бюджет, поэтому также стоит выставить индекс на желаемую зарплату соискателя
create index cv_expected_salary on cv(salary_expectations);
