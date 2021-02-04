-- ---AIRPORT-------
--  INSERT INTO Airport(Airport_code,Name,City,State)
--  VALUES
--  ('ESB','Esenboğa Havalimanı','Ankara',Null),
--  ('ADB','Adnan Menderes Havalimanı','Ankara',Null),
--  ('ADA','Adana Havalimanı','Adana',Null);
 


-- -- AIRLINE-----------
-- INSERT INTO Airline(Company_id,Company_name,contact,Iata)
-- VALUES(2001,'Türk Hava Yolları','info@thy.com','TK'),
-- (2002,'Pegasus','info@pegasus.com','PC'),
-- (2003,'SunExpress','info@sunexpress.com','XQ');


-- select * from airline;

-- -- AIRCRAFT MANUFACTURER----------

-- INSERT INTO Aircraft_Manufacturer(Company_id,Company_name,contact)
-- VALUES(1001,'Boeing','info@boeing.com'),
-- 	(1002,'Airbus','info@airbus.com')


-- select * from Aircraft_Manufacturer;

-- ---Airplane Type---------------

-- INSERT INTO Airplane_type(Airplane_type_name,max_seats)
-- VALUES('Boeing B747-400D',371),
-- ('Boeing B747-8I',364),
-- ('A330-300',236),
-- ('A350-900',319);

-- select * from airplane_type;

-- select * from Airplane_type;

-- ---Airplane--------------

-- INSERT INTO Airplane(Airplane_id,airplane_type_name)
-- VALUES(3001,'Boeing B747-400D'),

		
--  INSERT INTO Airplane(Airplane_id,airplane_type_name)
-- VALUES(3002,'Boeing B747-8I'); -364

-- INSERT INTO Airplane(Airplane_id,airplane_type_name)
-- VALUES(3003,'A330-300');

--  INSERT INTO Airplane(Airplane_id,airplane_type_name)
--  VALUES(3004,'A350-900');


--DELETE FROM Airplane WHERE airplane_id = 3002;



-- --FLIGHT -------------

INSERT INTO Flight(Flight_number,weekdays,airline_id)
 VALUES('TK7267','03.02.2021','2001');

-- select * from flight;

-------FARE
select * from fare;
INSERT INTO Fare(fare_code,amount,flight_number,restriction)
Values('YE4MTR',112.99,'TK7267','N'),
('JE6MTR',230.99,'TK7267','R');

-- --Customer-----------

select * from customer;
INSERT INTO Customer(customer_id,Customer_phone,Customer_name,Address,country,Email,Passaport_number)
VALUES(301,'5555550102','Arda',	'Adana','Turkey','Arda@db.com','U751648');

-- INSERT INTO Customer(customer_id,Customer_phone,Customer_name,Address,country,Email,Passaport_number,Total_milleage)
-- VALUES(302	,'5555550202'	,'Ahmet'	,'Izmir'	,'Turkey'	,'Ahmet@db.com'	,'U124985'	,297.01);

-- INSERT INTO Customer(customer_id,Customer_phone,Customer_name,Address,country,Email,Passaport_number,Total_milleage)
-- VALUES(303,'5555550303','Fatih'	,'Bursa','Turkey','Fatih@db.com','U149875'	,297.01),
-- (304,'5555550404','Ali','Istanbul','Turkey','Ali@db.com',	'U954213',	297.01);
INSERT INTO Customer(customer_id,Customer_phone,Customer_name,Address,country,Email,Passaport_number)
VALUES(305,'5555550303','mehmet','Bursa','Turkey','Fatidfh@db.com','U149871')

-- ---Flight_leg------------
-- select * from flight_Leg;
 

INSERT INTO Flight_leg(Flight_Number,Leg_number,Departure_airport_code,Arrival_airport_code,Scheduled_departure_time,Scheduled_arrival_time)
VALUES('TK7267',2,'ADB','ADA','18:00:00','19:30:00');


-- ---leg_instance---------

-- select * from leg_instance;
--INSERT INTO leg_instance(Flight_number,Leg_number,Date,Number_of_available_seats,Airplane_id,Departure_airport_code,Arrival_airport_code,Departure_time,Arrival_time,Milleage)
VALUES ('TK7267','2','2/2/2021','371','3001','ADB','ADA','18:00','19:24',297.01);

-- --Seat_Reservation---------
-- select * from leg_instance;
 select * from seat_reservation;
select * from flight_history;

delete from flight_history
where customer_id = 301;

select * from customer_flights;


 INSERT INTO seat_reservation(Flight_number,Customer_id,Leg_number,Date,Seat_number)
VALUES('TK7267','301',1,'2/2/2021','25F');

UPDATE seat_reservation SET checked_in = True
WHERE customer_id = 301 and  leg_number = 2;

DELETE FROM seat_reservation
where customer_id =301;


select * from ffc;

DELETE from ffc where ffc_id = 301;



-- INSERT INTO seat_reservation(Flight_number,Customer_id,Leg_number,Date,Seat_number)
-- VALUES('TK7267','302',1	,'2/2/2021','29A');

 INSERT INTO seat_reservation(Flight_number,Customer_id,Leg_number,Date,Seat_number)
 VALUES('TK7267','303',1,'2/2/2021','30A');
 
  INSERT INTO seat_reservation(Flight_number,Customer_id,Leg_number,Date,Seat_number)
 VALUES('TK7267','304',1,'2/2/2021','31A');

-- ---------------------
select * from customer;

select * from Seat_reservation;

UPDATE seat_reservation SET checked_in = true
WHERE customer_id = 304;

select * from seat_reservation
WHERE seat_number ='31A';

select * from flight_history;

--IF CHECKED IN IS TRUE ADD FLIGHT RECORD TO THE FLIGHT HISTORY.

