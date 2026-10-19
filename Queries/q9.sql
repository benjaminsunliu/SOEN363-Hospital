-- Group by unit type and find the average of exit - entry time using aggregate
SELECT  u.unit_type, AVG(u.exit_datetime - u.entry_datetime) AS avg
FROM Unit_Stays u
WHERE u.unit_type IN ('ICU', 'CCU')
GROUP BY u.unit_type