ALTER TABLE leg_instance
ADD CONSTRAINT date_check
CHECK(
	departure_time < arrival_time
);

select * from leg_instance;

ALTER TABLE airport
ADD CONSTRAINT airport_code_check
CHECK(
    airport_code SIMILAR TO '[A-Z][A-Z][A-Z]'
)

ALTER TABLE Airline
ADD CONSTRAINT iata_check
CHECK(
    iata SIMILAR TO '[A-Z][A-Z]'
);

ALTER TABLE seat_reservation
ADD CONSTRAINT seat_number_check
CHECK(
	seat_number SIMILAR TO '[0-9]+(A|B|C|F|D|E)'	
)

ALTER TABLE flight
ADD CONSTRAINT flight_number_check
CHECK(
	flight_number SIMILAR TO '[A-Z][A-Z][0-9]+'
)

ALTER TABLE fare
ADD CONSTRAINT restriction_check
CHECK(
	restriction SIMILAR TO '(R|N)'
);

ALTER TABLE fare
ADD CONSTRAINT fare_code_check
CHECK(
    fare_code SIMILAR TO '(F|J|W|Y)(E)([0-9][0-9]|[0-9][0-9](M)|[0-9](M))[A-Z][A-Z]'
);


