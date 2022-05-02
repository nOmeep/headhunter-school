select V.id, V.title
from VACANCY V
--К вакансиям присоединяем собравшие больше 5
left join VACANCY_RESPONSE VR on v.id = VR.vacancy_id
where V.created_at + interval '1 week' < VR.responded_at
group by v.id, V.title
having count(*) > 5;