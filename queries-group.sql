-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT YEAR(`enrolment_date`) as `year`, COUNT(`id`) as `count_enrolment`
FROM `students`
GROUP BY YEAR(`enrolment_date`);

--2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT `office_address`, COUNT(`id`) as `count_building`
FROM `teachers`
GROUP BY `office_address`;

--3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_id`, AVG(`vote`) as `average_vote`
FROM `exam_student`  
GROUP BY `exam_id`;

--4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT `department_id`, COUNT(`id`) as `degrees_for_department`
FROM `degrees`
GROUP BY `department_id`;