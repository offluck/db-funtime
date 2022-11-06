# A

## Task №1
In this task we will use service [draw-sql](https://drawsql.app)

![a-1](https://github.com/offluck/db-funtime/blob/main/A/images/a-1.png)

## Task №2

```sql
CREATE SCHEMA IF NOT EXISTS travels;


CREATE TABLE travels.Employee (
    id INT PRIMARY KEY,
    employee_name VARCHAR(10),
    company_id INT
);

CREATE TABLE travels.Company (
    id INT PRIMARY KEY,
    company_name VARCHAR(10)
);

CREATE TABLE travels.Trip (
    id INT PRIMARY KEY,
    employee_id INT,
    startdate DATE,
    enddate DATE,
    cancelationdate DATE,
    hotel_id INT,
    ticket_1_id INT,
    ticket_2_id INT,
    branch_id INT
);

CREATE TABLE travels.Flight (
    flight_number INT PRIMARY KEY,
    oigin_city_id INT,
    destination_city_id INT,
    air_company VARCHAR(10),
    departure TIMESTAMP,
    ticket_price FLOAT
);

CREATE TABLE travels.Hotel (
    id INT PRIMARY KEY,
    hotel_name VARCHAR(10),
    hotel_address VARCHAR(10),
    city_id INT,
    room_charge FLOAT
);

CREATE TABLE travels.City (
    id INT PRIMARY KEY,
    city_name VARCHAR(10),
    branch_id INT
);

CREATE TABLE travels.Branch (
    id INT PRIMARY KEY,
    branch_name VARCHAR(10)
);


ALTER TABLE travels.Employee ADD FOREIGN KEY (company_id) REFERENCES travels.Company (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (employee_id) REFERENCES travels.Employee (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (hotel_id) REFERENCES travels.Hotel (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (branch_id) REFERENCES travels.Branch (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (ticket_1_id) REFERENCES travels.Flight (flight_number);

ALTER TABLE travels.Trip ADD FOREIGN KEY (ticket_2_id) REFERENCES travels.Flight (flight_number);

ALTER TABLE travels.Hotel ADD FOREIGN KEY (city_id) REFERENCES travels.City (id);

ALTER TABLE travels.Flight ADD FOREIGN KEY (oigin_city_id) REFERENCES travels.City (id);

ALTER TABLE travels.Flight ADD FOREIGN KEY (destination_city_id) REFERENCES travels.City (id);

ALTER TABLE travels.City ADD FOREIGN KEY (branch_id) REFERENCES travels.Branch (id);
```

## Task №3
```sql
SELECT DISTINCT
    travels.Hotel.id,
    travels.Hotel.hotel_name
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
    AND date_part('year', travels.Trip.startdate) = date_part('year', NOW())

    -- Hotels booked in these flights
    AND travels.Trip.hotel_id = travels.Hotel.id;
```

## Task №4
```sql
SELECT SUM(
    travels.Hotel.room_charge +
    flight1.ticket_price +
    flight2.ticket_price
    )
FROM
    travels.Company,
    travels.Employee,
    travels.Trip,
    travels.Hotel,
    travels.Flight AS flight1,
    travels.Flight AS flight2
WHERE travels.Employee.comapny_id = travels.Company.id
    AND travels.Trip.employee_id = travels.Employee.id
    AND travels.Trip.enddate > NOW() - INTERVAL '1 month'
    AND travels.Trip.hotel_id = travels.Hotel
    AND travels.Trip.ticket_1_id = flight1.flight_number
    AND travels.Trip.ticket_2_id = flight2.flight_number
GROUP BY travels.Trip.hotel_id;

```

## Task №5
```sql
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
```

## Task №6
```sql
SELECT travels.Branch.id, travels.Branch.branch_name
FROM
    travels.Branch,
    travels.Trip
WHERE travels.Trip.branch_id = travels.Branch.id
    AND travels.Trip.startdate - travels.Trip.cancelationdate <= INTERVAL '3 days'
GROUP BY travels.Trip.branch_id
ORDER BY COUNT(*)
LIMIT 3;
```

## Task №7
```sql
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
```
