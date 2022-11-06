SELECT DISTINCT
    emp1.id,
    emp1.employee_name
    emp2.id,
    emp2.employee_name
FROM
    travels.Employee AS emp1
    travels.Employee AS emp2
    travels.Trip AS trip1
    travels.Trip AS trip2
    travels.Flight AS flight1
    travels.Flight AS flight2
WHERE trip1.employee_id = emp1
    AND trip2.employee_id = emp2
    AND
    (
        (
            trip1.ticket_1_id = flight1.flight_number
            AND trip2.ticket_1_id = flight2.flight_number

            AND flight1.origin_city_id = flight2.origin_city_id
            AND flight1.destination_city_id = flight2.destination_city_id

            AND flight1.flight_number != flight2.flight_number
        )
        OR
        (
            trip1.ticket_2_id = flight1.flight_number
            AND trip2.ticket_2_id = flight2.flight_number

            AND flight1.origin_city_id = flight2.origin_city_id
            AND flight1.destination_city_id = flight2.destination_city_id

            AND flight1.flight_number != flight2.flight_number
        )
    );
