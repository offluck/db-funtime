# A

## Task №1
In this task we will use service [draw-sql](https://drawsql.app)

![a-1](https://github.com/offluck/db-funtime/blob/main/A/images/a-1.png)

## Task №2

```sql
CREATE SCHEMA IF NOT EXISTS travels;


CREATE TABLE travels.Employee (
    id INT PRIMARY KEY,
    employee_name VARCHAR(10)
);

CREATE TABLE travels.Trip (
    id INT PRIMARY KEY,
    employee_id INT,
    startdate DATE,
    enddate DATE,
    cancelationdate DATE,
    hotel_id INT,
    ticket_1_id INT,
    ticket_2_id INT
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
    city_name VARCHAR(10)
);


ALTER TABLE travels.Trip ADD FOREIGN KEY (employee_id) REFERENCES travels.Employee (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (hotel_id) REFERENCES travels.Hotel (id);

ALTER TABLE travels.Trip ADD FOREIGN KEY (ticket_1_id) REFERENCES travels.Flight (flight_number);

ALTER TABLE travels.Trip ADD FOREIGN KEY (ticket_2_id) REFERENCES travels.Flight (flight_number);

ALTER TABLE travels.Hotel ADD FOREIGN KEY (city_id) REFERENCES travels.City (id);

ALTER TABLE travels.Flight ADD FOREIGN KEY (oigin_city_id) REFERENCES travels.City (id);

ALTER TABLE travels.Flight ADD FOREIGN KEY (destination_city_id) REFERENCES travels.City (id);
```

## Task №3

## Task №4

## Task №5

## Task №6

## Task №7
