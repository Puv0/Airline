--- THIS VIEW TABLE'S FIND THE CUSTOMER WHO FLIGHT WITH WHICH LEG INSTANCE
--- CHECK DOES THIS TABLE UPDATE WHEN ANOTHER FLIGHTS ADDED?

--Flight history tablosu oluşturabilmek adına böyle bir tablo oluşturup, triggerı tetikledik, REZERVE EDEN AMA HENÜZ CHECKED IN OLMAYAN 
-- YOLCULAR
CREATE OR REPLACE VIEW Customer_flights AS
select s.customer_id,l.leg_number,l.flight_number,l.date,l.milleage,f.airline_id from seat_reservation s
INNER JOIN leg_instance l
ON s.flight_number = l.flight_number AND s.leg_number = l.leg_number
INNER JOIN flight f
ON f.flight_number = l.flight_number;
----

select * from flight_history;




CREATE OR REPLACE VIEW flight_list_fare AS
SELECT f.flight_number,f.leg_number,f.departure_airport_code,f.arrival_airport_code,
f.scheduled_departure_time,f.scheduled_arrival_time,fa.fare_code,fa.amount
FROM flight_leg f
INNER JOIN Fare fa
ON f.flight_number=fa.flight_number
