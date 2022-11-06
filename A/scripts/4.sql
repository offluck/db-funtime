SELECT SUM(travels.Hotel.room_charge)
FROM
    travels.Company,
    travels.Employee,
    travels.Trip,
    travels.Hotel,

WHERE travels.Employee.comapny_id = travels.Company.id
    AND travels.Trip.employee_id = travels.Employee.id
    AND travels.Trip.enddate > NOW() - INTERVAL '1 month'
    AND travels.Trip.hotel_id = travels.Hotel
GROUP BY travels.Trip.hotel_id;
