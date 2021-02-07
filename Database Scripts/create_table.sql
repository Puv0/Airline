CREATE TABLE Airport(
	airport_code CHAR(3) NOT NULL PRIMARY KEY,
	name text not null,
	city text not null,
	state text
);


CREATE TABLE Flight(
	flight_number CHAR(6) NOT NULL PRIMARY KEY,
	weekdays Integer,
	airline_id SERIAL,
	FOREIGN KEY (airline_id) REFERENCES Airline
	--TRIGGER airline_id eklenmeden önce airline.iata flightnumberın önüne gelecek.
);



CREATE TABLE Fare(
	fare_code varchar(7) NOT NULL,
	restriction char,
	amount NUMERIC NOT NULL,
	flight_number CHAR(6),
	PRIMARY KEY(fare_code,flight_number),
	FOREIGN KEY (flight_number) REFERENCES flight
	--TRIGGER IF FFC CUSTOMER BUY A TICKET DISCOUNT FARE
);


CREATE TABLE Flight_leg(
	flight_number CHAR(6) ,
	leg_number INTEGER NOT NULL ,
	departure_airport_code varchar(3)  NOT NULL,
	arrival_airport_code varchar(3) NOT NULL,
	scheduled_departure_time TIME NOT NULL,
	scheduled_arrival_time TIME NOT NULL,
	PRIMARY KEY(flight_number,leg_number),
	FOREIGN KEY (departure_airport_code) REFERENCES airport(airport_code),
	FOREIGN KEY (arrival_airport_code) REFERENCES airport(airport_code),
	FOREIGN KEY (flight_number) REFERENCES flight
);

CREATE TABLE Leg_instance(
	flight_number CHAR(6),
	leg_number INTEGER,
	date Date NOT NULL,
	number_of_available_seats INTEGER,
	airplane_id SERIAL,
	departure_airport_code varchar(3)NOT NULL,
	arrival_airport_code varchar(3) NOT NULL,
	departure_time TIME NOT NULL,
	arrival_time TIME NOT NULL,
	milleage INTEGER,
	--CHECK CONSTRAINT NUMBER OF AVAILABLE SEATS CAN NOT BE LARGER THAN airplane_id.total_number_of_seats
	PRIMARY KEY(flight_number,leg_number,date),
	FOREIGN KEY (departure_airport_code) REFERENCES airport(airport_code),
	FOREIGN KEY (airplane_id) REFERENCES airplane,
	FOREIGN KEY (arrival_airport_code) REFERENCES airport(airport_code),
	FOREIGN KEY (flight_number,leg_number) REFERENCES Flight_leg
);

ALTER TABLE leg_instance
ALTER COLUMN date

CREATE TABLE Seat_reservation(
	flight_number CHAR(6),
	customer_id SERIAL ,
	leg_number INTEGER,
	date date,
	seat_number varchar(3) NOT NULL,
	PRIMARY KEY(flight_number,leg_number,date,seat_number),
	FOREIGN KEY(flight_number,leg_number,date) REFERENCES Leg_instance,
	checked_in BOOLEAN NOT NULL DEFAULT false,
	FOREIGN KEY (customer_id) REFERENCES customer
	--TRIGGER WHEN CUSTOMER HAS SEAT UPDATE TOTAL MILLEAGE
);



CREATE TABLE Customer(
	customer_id SERIAL PRIMARY KEY,
	customer_phone varchar(10),
	customer_name TEXT NOT NULL,
	address TEXT,
	country TEXT,
	email TEXT UNIQUE,
	passaport_number CHAR(9) UNIQUE
	--TRIGGER IF A CUSTOMER ASSIGNED A FLIGHT THEN CREATE AN FFC CUSTOMER WITH THAT MILLEAUGE
);
--8A OPTION
CREATE TABLE Ffc(
	customer_id SERIAL,
	segment TEXT,
	total_milleage INTEGER,
	airline_id SERIAL,
	PRIMARY KEY(ffc_id),
	FOREIGN KEY(ffc_id) REFERENCES Customer,
	FOREIGN KEY(airline_id) REFERENCES airline
	--TRIGGER IF TOTAL_MILLEAUGE LARGER THAN X LEVEL UP TO ANOTHER SEGMENT
);

CREATE TABLE Flight_history(
	customer_id SERIAL ,
	flight_number CHAR(6), 
	leg_number INTEGER ,
	date date NOT NULL ,
	departure_airport_code varchar(3)NOT NULL,
	arrival_airport_code varchar(3) NOT NULL,
	milleage INTEGER,
	airline_id SERIAL,
	PRIMARY KEY(customer_id,flight_number,leg_number,date),
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
	FOREIGN KEY(flight_number,leg_number,date) REFERENCES Leg_instance,
	FOREIGN KEY(airline_id) REFERENCES Airline,
	FOREIGN KEY (departure_airport_code) REFERENCES airport(airport_code),
	FOREIGN KEY (arrival_airport_code) REFERENCES airport(airport_code)
	--LEG INSTANCE ATANINCA CUSTOMER'I Flight_historye eklesin
);


--8B TOTAL AND DISJOINT
CREATE TABLE Airline(
	company_id SERIAL PRIMARY KEY,
	company_name TEXT,
	contact TEXT,
	iata char(2)
);

CREATE TABLE Aircraft_manufacturer(
	company_id SERIAL PRIMARY KEY,
	company_name TEXT,
	contact TEXT
	--Bir sey ekle 
);

CREATE TABLE Airplane(
	airplane_id SERIAL PRIMARY KEY,
	airplane_type_name TEXT ,
	total_number_of_seat INTEGER
	FOREIGN KEY (airplane_type_name) REFERENCES airplane_type
);



CREATE TABLE Airplane_type(
	airplane_type_name TEXT PRIMARY KEY,
	--Rapora unique yazmışız olmayacak sanırım
	max_seats INTEGER
);

CREATE TABLE Can_land(
	airplane_type_name TEXT,
	airport_code CHAR(3) NOT NULL,
	FOREIGN KEY(airplane_type_name) REFERENCES  Airplane_type,
	FOREIGN KEY(airport_code) REFERENCES Airport
);

CREATE TABLE Has_airplane(
	airplane_id SERIAL,
	airline_id SERIAL,
	FOREIGN KEY(airplane_id) REFERENCES  Airplane,
	FOREIGN KEY(airline_id) REFERENCES Airline
);

CREATE TABLE Manufactured_by(
	airplane_type_name TEXT ,
	company_id SERIAL,
	FOREIGN KEY(airplane_type_name) REFERENCES  Airplane_type,
	FOREIGN KEY(company_id) REFERENCES Aircraft_manufacturer
);