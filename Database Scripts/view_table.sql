--- THIS VIEW TABLE'S FIND THE CUSTOMER WHO FLIGHT WITH WHICH LEG INSTANCE
--- CHECK DOES THIS TABLE UPDATE WHEN ANOTHER FLIGHTS ADDED?
----
---This is view table is usefull when we need to insert a record in flight_history table when a customer checked in a flight we immediately fire trigger and add him/her to flight_history table

CREATE OR REPLACE VIEW reservation_history AS
SELECT s.customer_id,
l.flight_number, 
l.leg_number,
l.date,
l.departure_airport_code,
l.arrival_airport_code,
l.milleage,
f.airline_id
from seat_reservation s
INNER JOIN leg_instance l
ON l.flight_number = s.flight_number and l.leg_number = s.leg_number and l.date = s.date
INNER JOIN flight f
ON f.flight_number = l.flight_number
ORDER BY customer_id;

---Flight_list is a view table for showing customers all available flights 
CREATE OR REPLACE VIEW flight_list AS
SELECT f.flight_number, f.leg_number,f.departure_airport_code,f.arrival_airport_code,
f.scheduled_departure_time,f.scheduled_arrival_time,
d.city as From,
	a.city as To
FROM flight_leg f
JOIN airport d ON d.airport_code = f.departure_airport_code
JOIN airport a ON a.airport_code = f.arrival_airport_code

ORDER BY flight_number;

-- FFC_customer_information is showing which customers are ffc of which airline company.
CREATE OR REPLACE VIEW ffc_customer_information AS
select c.customer_id,c.customer_name,c.passaport_number,f.segment,f.total_milleage,a.iata, a.company_name from customer c
INNER JOIN ffc f
ON c.customer_id = f.customer_id
INNER JOIN airline a
ON a.company_id = f.airline_id;


---This view table demonstrate different fare each flight (like business or economy etc)
CREATE OR REPLACE VIEW Flight_cost AS
select f.flight_number, m.fare_code, m.amount from flight f
INNER JOIN fare m
ON f.flight_number =m.flight_number;

CREATE OR REPLACE VIEW Flight_assigned_airplane AS
select l.flight_number, l.departure_airport_code, l.arrival_airport_code ,a.airplane_type_name,a.airplane_id  from leg_instance l
LEFT JOIN airplane a
ON a.airplane_id = l.airplane_id;

CREATE OR REPLACE VIEW flight_list_fare AS
 SELECT f.flight_number,
    f.leg_number,
	f.date,
    f.departure_airport_code,
    f.arrival_airport_code,
    f.departure_time,
    f.arrival_time,
	d.city as From,
	a.city as To
   FROM leg_instance f
	 JOIN airport d ON d.airport_code = f.departure_airport_code
	 JOIN airport a ON a.airport_code = f.arrival_airport_code
	 ORDER BY flight_number, date;
	 

CREATE OR REPLACE VIEW that_flight_seats AS 
select * from leg_instance l
LEFT JOIN seat_reservation s
ON s.seat_number = l.seat_number;

CREATE OR REPLACE VIEW  that_flight_seats as
select s.flight_number, s.customer_id, s.seat_number, l.date from seat_reservation s
LEFT JOIN leg_instance l
ON l.flight_number = s.flight_number
Left JOIN customer c
ON c.customer_id = s.customer_id;





