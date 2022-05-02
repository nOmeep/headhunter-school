select area_id,
       floor(avg(compensation_from))::INT                         AS avg_compensation_from,
       floor(avg(compensation_to))::INT                           AS avg_compensation_to,
       --Вроде как среднее арифмеическое 2х величин, но не пойму зачем :?
       floor(avg((compensation_from + compensation_to) / 2))::INT AS avg_total
from VACANCY
GROUP BY area_id;