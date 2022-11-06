SELECT DISTINCT travels.Hotel.id, travels.Hotel.hotel_name
FROM
    travels.Employee,
    travels.Trip,
    travels.Flight,
    travels.City AS from_city,
    travels.City AS to_city,
    travels.Hotel
WHERE travels.Employee.id = travels.Trip.employee_id
    AND travels.Trip.ticket_1_id = travels.Flight.flight_number

    -- Employees who travel from Berlin to Paris
    AND travels.Flight.origin_city_id = from_city.id
    AND travels.Flight.destination_city_id = from_city.id
    AND from_city.name LIKE "%Berlin%"
    AND to_city.name LIKE "%Paris%"

    -- Employees who travel this year and their flights were not cancelled
    AND travels.Trip.canceletiondate IS NULL
    AND travels.Trip.startdate
        BETWEEN to_date('01-01-2022', 'dd-mm-yyyy')
        AND to_date('31-12-2022', 'dd-mm-yyyy')

    -- Hotels booked in these flights
    AND travels.Trip.hotel_id = travels.Hotel.id;
