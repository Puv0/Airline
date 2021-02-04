---TRIGGER THAT WHEN SOMEONE RESERVE AN SEAT REDUCE THE NUMBER OF AVAILABLE SEATS FOR THAT FLIGHT LEG
-- CREATE OR REPLACE FUNCTION reduce_seat() 
-- 	RETURNS TRIGGER
-- 	LANGUAGE PLPGSQL
-- AS $$
-- BEGIN
-- 	--NEW.number_of_available_seats = number_of_available_seats-1
-- 	UPDATE Leg_instance set number_of_available_seats = number_of_available_seats-1;
-- 	RETURN NEW;
-- END;
-- $$
-- CREATE TRIGGER reduce_available_seat
-- 	After INSERT
-- 	ON Seat_reservation
-- 	FOR EACH ROW
-- 	EXECUTE PROCEDURE reduce_seat()
	
---trigger that assign airplanetypemaxseat to airplane	
-- CREATE OR REPLACE FUNCTION max_seat()
-- 	RETURNS TRIGGER
-- 	LANGUAGE PLPGSQL
-- AS $$
-- BEGIN
-- 	 UPDATE Airplane SET total_number_of_seats = (SELECT max_seats FROM Airplane_Type WHERE airplane_type_name = NEW.airplane_type_name)
-- 	 WHERE airplane_type_name = NEW.airplane_type_name;
-- 	RETURN NEW;
-- END;
-- $$
-- CREATE  TRIGGER set_max_seat
-- 	AFTER INSERT ON Airplane
-- 	FOR EACH ROW
-- 	EXECUTE PROCEDURE max_seat();
		
-- --------TRIGGER THAT ADD FLIGHT HISTORY

CREATE OR REPLACE FUNCTION add_flight_history()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
AS $$
BEGIN
	RAISE NOTICE 'old %, new %',OLD.checked_in, New.checked_in;
	IF OLD.checked_in = 'false' AND New.checked_in = 'true' THEN
	INSERT INTO Flight_history(customer_id,flight_number,leg_number,date,milleage,airline_id)
	SELECT customer_id,flight_number,leg_number,date,milleage,airline_id FROM customer_flights
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
	IF (EXISTS(SELECT * FROM FFC WHERE New.customer_id= ffc_id and airline_id = NEW.airline_id)) 
		THEN
	---FFC'DEKI CUSTOMER TOTAL MILLEAUGE değişecek
		UPDATE Ffc set total_milleage = total_milleage + NEW.milleage
		WHERE NEW.customer_id = ffc_id;
	ELSE
		INSERT INTO FFC(ffc_id,segment,total_milleage,airline_id)
		VALUES(New.customer_id,'None',New.milleage,New.airline_id);
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
BEGIN	--THT 2002 PEGASUS
		IF (OLD.airline_id = 2001) THEN
			IF (OLD.segment = 'Classic' AND OLD.total_milleage > 600) THEN
			UPDATE ffc SET segment = 'Classic Plus'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Classic Plus' AND OLD.total_milleage > 1000) THEN
			UPDATE ffc SET segment = 'Elite'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Elite' AND OLD.total_milleage > 2600) THEN
			UPDATE ffc SET segment = 'Elite Plus'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
			ELSE
				RAISE NOTICE 'NOtice';
			END IF ; 
		ELSIF (Old.airpilne_id = 2002) THEN
			IF (OLD.segment = 'Bronze' AND OLD.total_milleage > 300) THEN
			UPDATE ffc SET segment = 'Silver'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Silver' AND OLD.total_milleage > 600) THEN
			UPDATE ffc SET segment = 'Gold'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
			
			ELSIF (OLD.segment = 'Gold' AND OLD.total_milleage > 1400) THEN
			UPDATE ffc SET segment = 'Platinum'
			WHERE OLD.ffc_id = ffc_id AND OLD.airline_id = airline_id;
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