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