--1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`id` ,`students`.`name`, `students`.`surname`, `students`.`degree_id`
FROM `students` 
INNER JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `students`.`degree_id` = 53;

--2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT `degrees`.`department_id`, `departments`.`name` as `department_name`, `degrees`.`id` as `degree_id`, `degrees`.`name` as `degree_name`, `degrees`.level
FROM `departments` 
JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = "Dipartimento di Neuroscienze" AND `degrees`.`level` = "magistrale";

--3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT  `course_teacher`.`course_id`, `courses`.`name` as `course_name`, `course_teacher`.`teacher_id`, `teachers`.`name` as `teacher_name`, `teachers`.`surname` as `teacher_surname`
FROM `teachers`
JOIN `course_teacher` ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` ON `course_teacher`.`course_id` = `courses`.`id`
WHERE `teachers`.`id` = 44;

--4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`id` as `student_id`, `students`.`name` as `student_name`, `students`.`surname` as `student_surname`, `departments`.`id` as `department_id`, `departments`.`name` as `department_name`, `degrees`.`id` as `degree_id`, `degrees`.`name` as `degree_name`,`degrees`.`level`
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
JOIN `students` ON `students`.`degree_id` = `degrees`.`id`  
ORDER BY `student_surname` ASC, `student_name` ASC;

--5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`id` as `degree_id`, `degrees`.`name` as `degree_name`, `degrees`.`level`, `course_teacher`.`course_id`, `courses`.`name` as `course_name`, `courses`.`period`, `courses`.`year`, `courses`.`cfu`, `course_teacher`.`teacher_id`, `teachers`.`name` as `teacher_name`, `teachers`.`surname` as `teacher_surname`
FROM `degrees`
JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`;

--6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT `teachers`.`id` AS `teacher_id`, `teachers`.`name` AS `teacher_name`, `teachers`.`surname` AS `teacher_surname`, `departments`.`id` AS `department_id`, `departments`.`name` AS `department_name`
FROM `departments`
JOIN `degrees` ON `degrees`.`department_id` = `departments`.`id`
JOIN `courses` ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher` ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `departments`.`name` = "Dipartimento di Matematica"
GROUP BY `teachers`.`id`, `teachers`.`name`, `teachers`.`surname`, `departments`.`id`, `departments`.`name`;


--7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.

SELECT DISTINCT `students`.`id`, `students`.`name` AS `students_name`, `students`.`surname` AS `students_surname`, MAX(`exam_student`.`vote`) AS `max_vote`, `exams`.`course_id`, COUNT(`exams`.`course_id`) AS `try_exams`
FROM `students`
JOIN `exam_student` ON `students`.`id` = `exam_student`.`student_id`
JOIN `exams` ON `exams`.`id` = `exam_student`.`exam_id`
GROUP BY `students`.`id`, `students_name`, `students_surname`,`exams`.`course_id`
HAVING `max_vote` > 18  
ORDER BY `students`.`id`  ASC;
