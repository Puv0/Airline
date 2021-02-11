---HENUZ FFC OLMAYAN, AMA BIR SEKILDE VERITABANIMIZDA TUTULAN KULLANICILAR
select c.customer_id, c.customer_name, c.passaport_number from customer c 
WHERE NOT EXISTS(
SELECT customer_id FROM ffc_customer_information f  WHERE c.customer_id = f.customer_id 
)

---------
select c.customer_name, a.company_name, a.contact from customer c 
join reservation_history r
ON c.customer_id = r.customer_id
JOIN flight f
ON f.flight_number = r.flight_number
JOIN airline a 
ON a.company_id = f.airline_id
WHERE c.customer_id = 305




select * from flight_list;

select * from leg_instance
where flight_number ='PC7485'

select * from flight_cost;

select * from flight_list_fare;
