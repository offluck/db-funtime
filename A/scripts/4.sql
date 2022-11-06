SELECT DISTINCT
    travels.Company.id,
    travels.company.company_name 
FROM
    travels.Company,
    travels.Employee,
    travels.Trip
WHERE travels.Employee.comapny_id = travels.Company.id
    AND travels.Trip.employee_id = travels.Employee.id
GROUP BY travels.Trip.hotel_id
