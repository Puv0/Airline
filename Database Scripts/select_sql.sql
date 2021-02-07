---HENUZ FFC OLMAYAN, AMA BIR SEKILDE VERITABANIMIZDA TUTULAN KULLANICILAR
select c.customer_id, c.customer_name, c.passaport_number from customer c 
WHERE NOT EXISTS(
SELECT customer_id FROM ffc_customer_information f  WHERE c.customer_id = f.customer_id 
)


select * from flight_list_fare;