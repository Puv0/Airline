--TRIGGER THAT WHEN SOMEONE RESERVE AN SEAT REDUCE THE NUMBER OF AVAILABLE SEATS FOR THAT FLIGHT LEG
CREATE OR REPLACE FUNCTION reduce_seat() 
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN
	--NEW.number_of_available_seats = number_of_available_seats-1
	UPDATE Leg_instance set number_of_available_seats = number_of_available_seats-1;
	RETURN NEW;
END;
$$
CREATE TRIGGER reduce_available_seat
	After INSERT
	ON Seat_reservation
	FOR EACH ROW
	EXECUTE PROCEDURE reduce_seat()
	
---trigger that assign airplanetypemaxseat to airplane	
CREATE OR REPLACE FUNCTION max_seat()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN
	 UPDATE Airplane SET total_number_of_seats = (SELECT max_seats FROM Airplane_Type WHERE airplane_type_name = NEW.airplane_type_name)
	 WHERE airplane_type_name = NEW.airplane_type_name;
	RETURN NEW;
END;
$$
CREATE  TRIGGER set_max_seat
	AFTER INSERT ON Airplane
	FOR EACH ROW
	EXECUTE PROCEDURE max_seat();
		
-- 		select * from Airplane;
-- --------TRIGGER THAT ADD FLIGHT HISTORY

CREATE OR REPLACE FUNCTION add_flight_history()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN
	RAISE NOTICE 'old %, new %',OLD.checked_in, New.checked_in;
	IF OLD.checked_in = 'false' AND New.checked_in = 'true' THEN
	INSERT INTO Flight_history(customer_id,flight_number,leg_number,date,departure_airport_code,arrival_airport_code,milleage,airline_id)
	SELECT customer_id,flight_number,leg_number,date,departure_airport_code,arrival_airport_code,milleage,airline_id FROM reservation_history
	WHERE customer_id = New.Customer_id AND flight_number = New.flight_number AND date = New.date AND NEW.leg_number = leg_number;
	ELSE
	RAISE NOTICE 'Not checked in';
	END IF;
RETURN NEW;
END;
$$
CREATE TRIGGER flight_history_trigger
	AFTER UPDATE ON Seat_reservation
	FOR EACH ROW
	EXECUTE PROCEDURE add_flight_history();
-- --------------------------------


--------TRIGGER UPDATE TOTAL MILLEAUGE 

CREATE OR REPLACE FUNCTION update_total_milleage()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
DECLARE 
BEGIN
	--KULLANICI FFCDE VAR MI YOK MU !?
	IF (EXISTS(SELECT * FROM FFC WHERE New.customer_id= customer_id and airline_id = NEW.airline_id)) 
		THEN
	---FFC'DEKI CUSTOMER TOTAL MILLEAUGE değişecek
		RAISE NOTICE 'FFCDE VAR O Yüzden UPDATE GELECEK %' ,NEW.milleage;
		UPDATE Ffc set total_milleage = total_milleage + NEW.milleage
		WHERE NEW.customer_id = ffc_id;
	ELSE
		RAISE NOTICE 'FFCDE YOK O YUZDEN EKLIYOR %',NEW.milleage;
		INSERT INTO FFC(customer_id,segment,total_milleage,airline_id)
		VALUES(New.customer_id,'Classic',New.milleage,New.airline_id);
	END IF ;
RETURN NEW;
END;
$$
CREATE TRIGGER update_milleage
	AFTER INSERT ON flight_history
	FOR EACH ROW
	EXECUTE PROCEDURE update_total_milleage();

---- TRIGGER CUSTOMER SEGMENT LVL UP
CREATE OR REPLACE FUNCTION customer_lvl_up()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN	--THT 2001 THY
		IF (OLD.airline_id = 2001) THEN
			
			RAISE NOTICE 'Customer Segment Function %,%', OLD.total_milleage, NEW.total_milleage;
			IF (OLD.segment = 'Classic' AND NEW.total_milleage > 1000) THEN
			UPDATE ffc SET segment = 'Classic Plus'
			WHERE OLD.customer_id = customer_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Classic Plus' AND NEW.total_milleage > 2000) THEN
			UPDATE ffc SET segment = 'Elite'
			WHERE OLD.customer_id = customer_id AND NEW.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Elite' AND NEW.total_milleage > 3000) THEN
			UPDATE ffc SET segment = 'Elite Plus'
			WHERE OLD.customer_id = customer_id AND NEW.airline_id = airline_id;
			ELSE
				RAISE NOTICE 'NOtice';
			END IF ; 
		--PEGASUS 2002 
		ELSIF (Old.airline_id = 2002) THEN
			IF (OLD.segment = 'Bronze' AND NEW.total_milleage > 1000) THEN
			UPDATE ffc SET segment = 'Silver'
			WHERE OLD.customer_id = customer_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Silver' AND NEW.total_milleage > 1900) THEN
			UPDATE ffc SET segment = 'Gold'
			WHERE OLD.customer_id = customer_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Gold' AND NEW.total_milleage > 2900) THEN
			UPDATE ffc SET segment = 'Platinum'
			WHERE OLD.customer_id = customer_id AND OLD.airline_id = airline_id;
			ELSE
				RAISE NOTICE 'NOtice';
			END IF ; 
		END IF;
			RETURN NEW;
END;
$$
CREATE TRIGGER customer_segment_lvl_up
	AFTER UPDATE ON FFC
	FOR EACH ROW
	EXECUTE PROCEDURE customer_lvl_up();

----- TRIGGER FOR Controlling assigned airplane can be appropiete departure and arrival airport  
CREATE OR REPLACE FUNCTION check_can_land()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN
IF(EXISTS(
	select  DISTINCT * from flight_assigned_airplane f
	WHERE EXISTS( SELECT * from can_land c WHERE f.airplane_type_name = c.airplane_type_name AND c.airport_code = f.departure_airport_code)
	AND EXISTS (SELECT * from can_land c WHERE f.airplane_type_name = c.airplane_type_name AND c.airport_code = f.arrival_airport_code ) AND 
		 NEW.flight_number = f.flight_number
	ORDER BY airplane_type_name
	)) 
	
	THEN RAISE NOTICE 'HATA YOK';
	RAISE NOTICE '%      ', NEW.flight_number;
ELSE
	RAISE EXCEPTION 'This plane is not appropriate for this airport' ;
END IF;
RETURN NEW;
END;
$$
CREATE TRIGGER can_land_trigger
	AFTER INSERT ON leg_instance
	FOR EACH ROW
	EXECUTE PROCEDURE check_can_land()
	
	