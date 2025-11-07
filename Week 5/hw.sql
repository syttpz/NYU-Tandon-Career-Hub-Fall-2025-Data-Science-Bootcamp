#lc1050

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;


#lc1667
SELECT
  user_id,
  CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;


#lc175
SELECT
  p.firstName,
  p.lastName,
  a.city,
  a.state
FROM Person AS p
LEFT JOIN Address AS a
  ON p.personId = a.personId;

#lc176
SELECT
  (SELECT MAX(salary)
   FROM Employee
   WHERE salary < (SELECT MAX(salary) FROM Employee)
  ) AS SecondHighestSalary;

#lc1327
SELECT
  p.product_name,
  SUM(o.unit) AS unit
FROM Products p
JOIN Orders   o ON p.product_id = o.product_id
WHERE YEAR(o.order_date) = 2020
  AND MONTH(o.order_date) = 2
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

#lc1378
SELECT
  u.unique_id,
  e.name
FROM Employees AS e
LEFT JOIN EmployeeUNI AS u
  ON e.id = u.id;

#lc550
WITH first_login AS (
  SELECT player_id, MIN(event_date) AS first_date
  FROM Activity
  GROUP BY player_id
)
SELECT
  ROUND(AVG(a2.player_id IS NOT NULL), 2) AS fraction
FROM first_login f
LEFT JOIN Activity a2
  ON a2.player_id = f.player_id
 AND a2.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY);

#lc1075
SELECT
  p.project_id,
  ROUND(AVG(e.experience_years), 2) AS average_years
FROM Project AS p
JOIN Employee AS e
  ON p.employee_id = e.employee_id
GROUP BY p.project_id;


#lc185
SELECT
  d.name AS Department,
  e.name AS Employee,
  e.salary AS Salary
FROM Employee e
JOIN Department d
  ON e.departmentId = d.id
WHERE 3 > (
  SELECT COUNT(DISTINCT e2.salary)
  FROM Employee e2
  WHERE e2.departmentId = e.departmentId
    AND e2.salary > e.salary
)
ORDER BY d.name, e.salary DESC, e.name;
