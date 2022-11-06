SELECT SUM(travels.Hotel.room_charge)
FROM
    travels.Company,
    travels.Employee,
    travels.Trip,
    travels.Flight,
    travels.Hotel
WHERE travels.Employee.comapny_id = travels.Company.id
    AND travels.Trip.employee_id = travels.Employee.id
    AND travels.enddate > NOW() - INTERVAL '1 month'
    AND travels.Trip.ticket_2_id = travels.Flight.flight_number
    AND travels.Trip.hotel_id = travels.Hotel.id
GROUP BY travels.Flight.origin_city_id;
