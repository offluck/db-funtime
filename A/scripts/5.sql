SELECT DISTINCT
    travels.Company.id,
    travels.company.company_name 
FROM
    travels.Company,
    travels.Employee,
    travels.Trip,
    travels.Flight
WHERE travels.Employee.comapny_id = travels.Company.id
    AND travels.Trip.employee_id = travels.Employee.id
    AND travels.enddate > NOW() - INTERVAL '1 month'
    AND travels.Trip.ticket_2_id = travels.Flight.flight_number
GROUP BY travels.Flight.origin_city_id;
