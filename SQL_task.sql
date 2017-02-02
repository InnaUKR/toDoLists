--1. get all statuses, not repeating, alphabetically ordered
SELECT DISTINCT status
FROM tasks
ORDER BY status;

--2. get the count of all tasks in each project, order by tasks count descending
SELECT P.name, COUNT(T.project_id) 
FROM projects P 
LEFT JOIN tasks T ON P.id = T.project_id 
GROUP BY P.name 
ORDER BY COUNT(T.project_id) DESC;

--3. get the count of all tasks in each project, order by projects names
SELECT P.name, COUNT(T.project_id) 
FROM projects P 
LEFT JOIN tasks T ON P.id = T.project_id 
GROUP BY P.name 
ORDER BY P.name;

--4. get the tasks for all projects having the name beginning with “N” letter
SELECT T.name 
FROM tasks T, projects P 
WHERE P.name LIKE 'N%' AND P.id =T.id;

--5. get the list of all projects containing the ‘a’ letter in the middle of the name, and show the tasks count near each project. 
--   Mention that there can exist projects without tasks and tasks with project_id=NULL
SELECT P.name, COUNT(T.project_id) 
FROM projects P 
LEFT JOIN tasks T ON P.id = T.project_id 
WHERE P.name LIKE '%a%'
GROUP BY P.name 
--I think it's useful to add order by tasks count descending ^_^
ORDER BY COUNT(T.project_id) DESC;

--6. get the list of tasks with duplicate names. Order alphabetically
SELECT name
FROM tasks
GROUP BY name
HAVING COUNT(name)>1
ORDER BY name;

--7. get the list of tasks having several exact matches of both name and status, from the project ‘Garage’. Order by matches count
SELECT T.name, COUNT(T.project_id)--,T.status
FROM tasks T 
INNER JOIN projects P ON P.id=T.project_id
WHERE P.name LIKE 'Garage'
GROUP BY T.name, T.status
HAVING COUNT(T.project_id)>1
ORDER BY COUNT(T.project_id);

--8. get the list of project names having more than 10 tasks in status ‘completed’. Order by project_id
SELECT DISTINCT  P.id, P.name
FROM projects P, tasks T 
WHERE P.id=T.project_id AND T.status=‘completed’
GROUP BY P.id
HAVING COUNT(T.status)>10  
ORDER BY P.id;
