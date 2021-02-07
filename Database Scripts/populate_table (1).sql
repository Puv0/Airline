 
-------------------AIRPORT----------------

INSERT INTO Airport(Airport_code,Name,City,State)
 VALUES
 ('ESB','Esenboğa Havalimanı','Ankara','Turkey'),
 ('ADB','Adnan Menderes Havalimanı','Ankara','Turkey'),
 ('ADA','Adana Havalimanı','Adana','Turkey'),
 ('AYT','Antalya Havalimanı','Antalya','Turkey'),
 ('GZT','Gaziantep Havalimanı','Gaziantep','Turkey'),
 ('YEI','Bursa Yenisehir Havalimanı','Bursa','Turkey'),
 ('SAW','Sabiha Gokcen Havalimanı','Istanbul','Turkey'),
 ('ISL','Ataturk Havalimanı','Istanbul','Turkey'),
 ('KYA','Konya Havalimanı','Konya','Turkey'),
 ('TZX','Trabzon Havalimanı','Trabzon','Turkey');
 select * from airport;
 --------------------AIRLINE------------
 INSERT INTO airline(company_id,company_name,contact,iata)
 VALUES
 (2001,'Turk Hava Yollari','info@thy.com','TK'),
 (2002,'Pegasus','info@pegasus.com','PC'),
 (2003,'Sun Express','info@sunexpress.com','XQ'),
 (2004,'Anadolu Jet','info@anadolujet.com','AJ'),
 (2005,'Atlas Global','info@atlasglobal.com','KK');
 
 select * from airline;
 
 -------------------------Flight----------------
 INSERT INTO flight(flight_number,weekdays,airline_id)
 VALUES
 ('TK7267',2,2001),
 ('TK2474',3,2001),
 ('TK1487',1,2001),
 ('TK7685',1,2001),
 ('PC3012',2,2002),
 ('PC8766',1,2002),
 ('PC7485',2,2002),
 ('XQ9207',3,2003),
 ('XQ4897',1,2003),
 ('XQ9597',2,2003),
 ('AJ4897',3,2004),
 ('AJ9568',1,2004),
 ('KK9874',2,2005),
 ('KK1852',1,2005);
 
 
 select * from flight
 order by flight_number asc;
 
 --------------------------FARE----------------------
 INSERT INTO fare(fare_code,restriction,amount,flight_number)
 Values
('JE6MTR','R',230,'TK7267'),('YE4MTR','R',110,'TK7267'),
('FE15TR','R',430,'TK2474'),('YE45TR','N',130,'TK2474'),
('FE1MTR','R',600,'TK1487'),('WE15TR','N',530,'TK1487'),
('JE25TR','R',430,'TK7685'),('YE10TR','R',270,'TK7685'),
('FE1MTR','R',680,'PC3012'),('JE4MTR','N',450,'PC3012'),
('FE2MTR','N',450,'PC8766'),('JE15TR','N',350,'PC8766'),
('WE45TR','R',270,'PC7485'),('YE10TR','N',240,'PC7485'),
('JE2MTR','R',320,'XQ9207'),('WE2MTR','R',230,'XQ9207'),
('JE45TR','N',270,'XQ4897'),('WE15TR','N',170,'XQ4897'),
('FE45TR','R',630,'XQ9597'),('JE4MTR','R',470,'XQ9597'),
('FE15TR','R',320,'AJ4897'),('WE6MTR','N',140,'AJ4897'),
('FE6MTR','R',450,'AJ9568'),('YE15TR','R',320,'AJ9568'),
('JE45TR','N',360,'KK9874'),('WE15TR','N',250,'KK9874'),
('FE1MTR','R',190,'KK1852'),('JE45TR','N',160,'KK1852');


 select * from airplane;
 ------------------------AIRPLANE_TYPE_NAME-----------------
 INSERT INTO airplane_type(airplane_type_name,max_seats)
 VALUES
 ('Boeing 737-900ER',151),('Boeing 737 MAX 8',151),
 ('Boeing 777-300ER',349),('Boeing 787-9',300),
 ('Airbus A330-300',289),('Airbus A320-200',153),
 ('Airbus A330-200',250),('Airbus A350-900',319);
 select * from airplane_type;
 ------------------------AIRPLANE--------------------
 INSERT INTO airplane(airplane_id,airplane_type_name)
 VALUES
 (3001,'Boeing 737-900ER'),
 (3002,'Boeing 737 MAX 8'),
 (3003,'Boeing 777-300ER'),
 (3004,'Boeing 787-9'),
 (3005,'Airbus A330-300'),
 (3006,'Airbus A320-200'),
 (3007,'Airbus A330-200'),
 (3008,'Airbus A350-900');
 --Trigger working auto setting total_number_of_seats
 select * from airplane;
 ---------------------flight_leg-------------------------
INSERT INTO flight_leg(flight_number,leg_number,departure_airport_code,arrival_airport_code,
					   scheduled_departure_time,scheduled_arrival_time)
VALUES
('TK7267',1,'ESB','ADB','18:00','19:30'),('TK2474',1,'ADB','ESB','23:00','01:30'),
('TK1487',1,'GZT','YEI','17:00','19:00'),('TK7685',1,'SAW','GZT','16:00','18:00'),
('TK7685',2,'GZT','TZX','21:00','23:00'),('PC8766',1,'KYA','ISL','01:00','03:00'),
('PC7485',1,'GZT','AYT','13:00','15:00'),('PC3012',1,'ADA','ESB','19:00','22:00'),
('XQ4897',1,'ISL','ESB','08:00','11:00'),('XQ4897',2,'ESB','TZX','14:00','16:00'),
('XQ9597',1,'KYA','SAW','07:00','09:00'),('XQ9207',1,'ADB','ADA','20:00','22:00'),
('AJ4897',1,'ADB','TZX','16:00','18:00'),('AJ9568',1,'ADA','KYA','19:00','21:00'),
('KK9874',1,'ISL','ESB','21:00','23:00'),('KK1852',1,'ADB','KYA','20:00','22:00');
 select * from flight_leg;
 -------------------leg_instance-----------------------
 INSERT INTO leg_instance(flight_number,leg_number,date,number_of_available_seats,airplane_id,
						  departure_airport_code,arrival_airport_code,
						  departure_time,arrival_time,milleage)
VALUES
('TK7267',1,'2021-02-15',151,3001,'ESB','ADB','18:00','19:24',324),
('TK7267',1,'2021-02-18',151,3001,'ESB','ADB','18:01','19:23',324),
('TK2474',1,'2021-02-15',151,3002,'ADB','ESB','23:03','01:36',324),
('TK2474',1,'2021-02-17',151,3002,'ADB','ESB','23:05','01:30',324),
('TK2474',1,'2021-02-19',151,3002,'ADB','ESB','23:12','01:35',324),
('TK1487',1,'2021-02-17',371,3008,'GZT','YEI','17:05','19:10',639),
('TK7685',1,'2021-02-18',151,3002,'SAW','GZT','16:00','18:00',707),
('TK7685',2,'2021-02-18',151,3002,'GZT','TZX','21:00','23:00',490),
('PC8766',1,'2021-02-20',349,3003,'KYA','ISL','01:06','03:20',434),
('PC7485',1,'2021-02-19',319,3004,'GZT','AYT','13:10','15:05',511),
('PC7485',1,'2021-02-21',319,3004,'GZT','AYT','13:15','15:03',511),
('PC3012',1,'2021-02-22',319,3008,'ADA','ESB','19:33','21:09',308),
('PC3012',1,'2021-02-23',319,3008,'ADA','ESB','19:31','21:05',308),
('XQ4897',1,'2021-02-18',349,3003,'ISL','ESB','08:30','11:30',275),
('XQ4897',2,'2021-02-18',349,3003,'ESB','TZX','14:00','16:00',456),
('XQ9597',1,'2021-02-16',151,3002,'KYA','SAW','07:15','09:23',434),
('XQ9597',1,'2021-02-18',151,3002,'KYA','SAW','07:16','09:30',434),
('XQ9207',1,'2021-02-15',349,3003,'ADB','ADA','21:00','22:34',559),
('XQ9207',1,'2021-02-17',349,3003,'ADB','ADA','21:01','22:33',559),
('XQ9207',1,'2021-02-19',349,3003,'ADB','ADA','21:06','22:30',559),
('AJ4897',1,'2021-02-15',300,3004,'ADB','TZX','16:05','18:30',879),
('AJ9568',1,'2021-02-16',289,3005,'ADA','KYA','19:30','21:35',167),
('AJ9568',1,'2021-02-18',289,3005,'ADA','KYA','19:35','21:30',167),
('KK9874',1,'2021-02-16',153,3006,'ISL','ESB','21:12','23:15',275),
('KK1852',1,'2021-02-16',250,3007,'ADB','KYA','20:12','22:15',347);



select * from leg_instance;
----------------CUSTOMER----------
INSERT INTO customer(customer_id,customer_phone,customer_name,address,country,email,passaport_number)
VALUES
(301,5555550101,'Arda','Adana','Turkey','Arda@db.com','U968455'),
(302,5555550202,'Ahmet','Izmir','Turkey','Ahmet@db.com','U968456'),
(303,5555550303,'Fatih','Bursa','Turkey','Fatih@db.com','U968457'),
(304,5555550404,'Ali','Istanbul','Turkey','Ali@db.com','U968458'),
(305,5555550505,'Murat','Ankara','Turkey','Murat@db.com','U968459'),
(306,5555550606,'Veysel','Edirne','Turkey','Veysel@db.com','U968460'),
(307,5555550707,'Ayse','Ordu','Turkey','Ayse@db.com','U968461'),
(308,5555550808,'Fatma','Sivas','Turkey','Fatma@db.com','U968462'),
(309,5555550909,'Melih','Canakkale','Turkey','Melih@db.com','U968463'),
(310,5555551010,'Mert','Kastamonu','Turkey','Mert@db.com','U968464'),
(311,5555551111,'Resul','Antalya','Turkey','Resul@db.com','U968465'),
(312,5555551212,'Osman','Izmir','Turkey','Osman@db.com','U968466'),
(313,5555551313,'Mehmet','Erzurum','Turkey','Mehmet@db.com','U968467'),
(314,5555551414,'Aysu','Usak','Turkey','Aysu@db.com','U968468'),
(315,5555551515,'Irem','Izmir','Turkey','Irem@db.com','U968469'),
(316,5555551616,'Yaren','Samsun','Turkey','Yaren@db.com','U968470'),
(317,5555551717,'Damla','Eskisehir','Turkey','Damla@db.com','U968471'),
(318,5555551818,'Sevgi','Ankara','Turkey','Sevgi@db.com','U968472'),
(319,5555551919,'Burak','Samsun','Turkey','Burak@db.com','U968473'),
(320,5555552020,'Kaan','Ordu','Turkey','Kaan@db.com','U968474');
select * from customer;
 ----------------SEAT_RESERVATION----------------------
 INSERT INTO seat_reservation(flight_number,customer_id,leg_number,date,seat_number)
 VALUES  ('TK7685',310,1,'2021-02-18','16C'),
 ('TK7267',301,1,'2021-02-15','7A'),
 ('TK2474',301,1,'2021-02-17','8A'),
 ('TK7267',302,1,'2021-02-15','9F'),
 ('TK2474',303,1,'2021-02-17','12C'),
 ('TK2474',304,1,'2021-02-19','24A'),
 ('TK1487',305,1,'2021-02-17','32F'),
 ('TK1487',306,1,'2021-02-17','12D'),
 ('TK1487',307,1,'2021-02-17','15A'),
 ('TK7685',308,1,'2021-02-18','19C'),
 ('TK7685',309,1,'2021-02-18','21A'),
 ('TK7685',309,2,'2021-02-18','23A'),
 ('TK7685',310,1,'2021-02-18','16C'),
 ('PC8766',311,1,'2021-02-20','15F'),
 ('PC8766',312,1,'2021-02-20','18C'),
 ('XQ4897',313,1,'2021-02-18','28E'),
 ('XQ4897',314,1,'2021-02-18','15B'),
 ('XQ9597',315,1,'2021-02-18','29C'),
 ('XQ9597',316,1,'2021-02-18','17F'),
 ('AJ4897',317,1,'2021-02-15','14E'),
 ('KK9874',318,1,'2021-02-16','19B'),
 ('KK1852',319,1,'2021-02-16','27A'),
 ('KK9874',320,1,'2021-02-16','4A');
 
 delete  from seat_reservation;
 
 select r.*,s.seat_number from reservation_history r
 INNER JOIN seat_reservation s
 ON s.customer_id = r.customer_id and s.date = r.date
 where milleage>500;

 
 select * from seat_reservation;
 
 INSERT INTO seat_reservation(flight_number,customer_id,leg_number,date,seat_number)
 VALUES('TK2474',310,1,'2021.02.17','3C'),
  ('TK7685',310,1,'2021-02-18','16C'),
  ('TK1487',310,1,'2021-02-17','16C');

 select * from 
 
 
 delete  from seat_reservation
 WHERE customer_id = 310;
 
 delete from flight_history;
 
 update seat_reservation
 set checked_in = true
 where customer_id = 310 AND
 flight_number = 'TK1487';

select * from flight_history;

select * from reservation_history;

select * from seat_reservation;

select * from ffc;
delete from ffc;
 --------------------HAS_AIRPLANE---------------------
 INSERT INTO has_airplane(airplane_id,airline_id)
 VALUES
 (3001,2001), (3002,2001),
 (3008,2001), (3003,2002),
 (3004,2002), (3008,2002),
 (3003,2003), (3002,2003),
 (3004,2004), (3005,2004),
 (3006,2005), (3007,2005);
 
 select * from has_airplane
 ----------------------Aircraft_manufacturer------------------
 INSERT INTO aircraft_manufacturer (company_id,company_name,contact)
 VALUES
 (1001,'Boeing','info@boeing.com'),
 (1002,'Airbus','info@airbus.com');
 select * from aircraft_manufacturer
 -------------------Manufactured_by----------------------
 INSERT INTO manufactured_by(airplane_type_name,company_id)
 VALUES
 ('Boeing 737-900ER',1001),
 ('Boeing 737 MAX 8',1001),
 ('Boeing 777-300ER',1001),
 ('Boeing 787-9',1001),
 ('Airbus A330-300',1002),
 ('Airbus A320-200',1002),
 ('Airbus A330-200',1002),
 ('Airbus A350-900',1002);
 select * from manufactured_by
 
 
 ---------------------can_land------------------
 INSERT INTO can_land (airplane_type_name,airport_code)
 VALUES
 ('Boeing 737-900ER','ESB'), ('Boeing 737-900ER','ADB'),
 ('Boeing 737-900ER','ADA'), ('Boeing 737-900ER','AYT'),
  ('Boeing 737 MAX 8','ESB'),  ('Boeing 737 MAX 8','ADB'),
  ('Boeing 737 MAX 8','ISL'),  ('Boeing 777-300ER','SAW'),
  ('Boeing 777-300ER','ESB'),  ('Boeing 777-300ER','TZX'),
  ('Boeing 777-300ER','KYA'),  ('Boeing 787-9','KYA'),
  ('Boeing 787-9','ESB'),  ('Boeing 787-9','ISL'),
  ('Boeing 787-9','SAW'),  ('Airbus A330-300','SAW'),
  ('Airbus A330-300','ISL'),  ('Airbus A330-300','TZX'),
  ('Airbus A330-300','YEI'),  ('Airbus A330-300','GZT'),
  ('Airbus A320-200','AYT'),  ('Airbus A320-200','SAW'),
  ('Airbus A320-200','ISL'),  ('Airbus A320-200','ESB'),
  ('Airbus A330-200','GZT'),  ('Airbus A330-200','KYA'),
  ('Airbus A330-200','YEI'),  ('Airbus A330-200','TZX'),
  ('Airbus A350-900','SAW'),  ('Airbus A350-900','ISL'),
  ('Airbus A350-900','ESB'),  ('Airbus A350-900','KYA'),
  ('Airbus A350-900','AYT'),  ('Airbus A350-900','GZT');    
  
 select * from can_land