SELECT TOP (1000) [Emp_ID]
      ,[Employee_Name]
      ,[Gender]
      ,[Age]
      ,[Department]
      ,[Designation]
      ,[Salary]
      ,[Experience_Years]
      ,[Attendance_Percent]
      ,[Performance_Rating]
      ,[Attrition]
  FROM [HR_Analytics_Data].[dbo].[Sheet1$]

select * FROM [HR_Analytics_Data].[dbo].[Sheet1$]

SELECT COUNT(*) AS Total_Employees
FROM [HR_Analytics_Data].[dbo].[Sheet1$];

SELECT
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END)*100/COUNT(*),
2
) AS Attrition_Rate
FROM [HR_Analytics_Data].[dbo].[Sheet1$];

SELECT Department,
COUNT(*) AS Attrition_Count
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
WHERE Attrition='Yes'
GROUP BY Department
ORDER BY Attrition_Count DESC;

SELECT Department,
AVG(Salary) AS Avg_Salary
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Department
ORDER BY Avg_Salary DESC;

SELECT Department,
COUNT(*) AS Employee_Count
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Department
ORDER BY Employee_Count DESC;

SELECT TOP 10
Employee_Name,
Department,
Salary
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
ORDER BY Salary DESC;

SELECT
Employee_Name,
Department,
Performance_Rating
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
WHERE Performance_Rating = 5;

SELECT
Performance_Rating,
AVG(Attendance_Percent) AS Avg_Attendance
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Performance_Rating
ORDER BY Performance_Rating;

SELECT
Employee_Name,
Department,
Salary,
RANK() OVER(ORDER BY Salary DESC) AS Salary_Rank
FROM [HR_Analytics_Data].[dbo].[Sheet1$];

SELECT
CASE
    WHEN Age BETWEEN 20 AND 25 THEN '20-25'
    WHEN Age BETWEEN 26 AND 30 THEN '26-30'
    WHEN Age BETWEEN 31 AND 35 THEN '31-35'
    ELSE '36+'
END AS Age_Group,
COUNT(*) AS Employee_Count
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY
CASE
    WHEN Age BETWEEN 20 AND 25 THEN '20-25'
    WHEN Age BETWEEN 26 AND 30 THEN '26-30'
    WHEN Age BETWEEN 31 AND 35 THEN '31-35'
    ELSE '36+'
END;

SELECT Gender,
COUNT(*) AS Employee_Count,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM [HR_Analytics_Data].[dbo].[Sheet1$]),2) AS Percentage
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Gender;

SELECT Department,
MAX(Salary) AS Highest_Salary,
MIN(Salary) AS Lowest_Salary,
AVG(Salary) AS Avg_Salary
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Department;

SELECT Employee_Name,
Department,
Attendance_Percent
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
WHERE Attendance_Percent < 90
ORDER BY Attendance_Percent;

SELECT Employee_Name,
Department,
Performance_Rating,
Experience_Years
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
WHERE Performance_Rating >= 5
AND Experience_Years >= 5;

SELECT
Employee_Name,
Department,
Salary,
DENSE_RANK() OVER(
PARTITION BY Department
ORDER BY Salary DESC
) AS Dept_Rank
FROM [HR_Analytics_Data].[dbo].[Sheet1$];

SELECT Employee_Name,
Department,
Salary,
Experience_Years,
Attendance_Percent
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
WHERE Salary < 40000
AND Experience_Years <= 3
AND Attendance_Percent < 90;

SELECT
COUNT(*) AS Total_Employees,
AVG(Salary) AS Avg_Salary,
AVG(Attendance_Percent) AS Avg_Attendance,
AVG(Performance_Rating) AS Avg_Performance,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM [HR_Analytics_Data].[dbo].[Sheet1$];

SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(
        SUM(CASE WHEN Attrition='Yes' THEN 1.0 ELSE 0 END) * 100
        / COUNT(*),2
    ) AS Attrition_Rate
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Department
ORDER BY Attrition_Rate DESC;

SELECT
CASE
    WHEN Salary < 40000 THEN 'Low Salary'
    WHEN Salary BETWEEN 40000 AND 60000 THEN 'Medium Salary'
    ELSE 'High Salary'
END AS Salary_Band,
COUNT(*) AS Employees
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY
CASE
    WHEN Salary < 40000 THEN 'Low Salary'
    WHEN Salary BETWEEN 40000 AND 60000 THEN 'Medium Salary'
    ELSE 'High Salary'
END;

WITH SalaryRank AS
(

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Department
ORDER BY Salary DESC
) AS rn
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
)

SELECT
Department,
Employee_Name,
Salary
FROM SalaryRank
WHERE rn = 1;

SELECT
Performance_Rating,
AVG(Salary) AS Avg_Salary
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Performance_Rating
ORDER BY Performance_Rating;

SELECT
Department,
AVG(Experience_Years) AS Avg_Experience
FROM [HR_Analytics_Data].[dbo].[Sheet1$]
GROUP BY Department
ORDER BY Avg_Experience DESC;

SELECT *
FROM
(
    SELECT
    Employee_Name,
    Department,
    Salary,
    ROW_NUMBER() OVER
    (
        PARTITION BY Department
        ORDER BY Salary DESC
    ) AS rn
    FROM [HR_Analytics_Data].[dbo].[Sheet1$]
) x
WHERE rn <= 3;

SELECT
Employee_Name,
Department,
Salary,
Attendance_Percent,
Experience_Years,

CASE
    WHEN Salary < 40000
     AND Attendance_Percent < 90
     AND Experience_Years <= 3
    THEN 'High Risk'

    WHEN Salary < 45000
    THEN 'Medium Risk'

    ELSE 'Low Risk'
END AS Attrition_Risk
FROM [HR_Analytics_Data].[dbo].[Sheet1$];