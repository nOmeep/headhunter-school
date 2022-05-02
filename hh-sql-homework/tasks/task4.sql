select
    (
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