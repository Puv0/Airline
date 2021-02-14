const pool = require('../db')
var types = require('pg');



const test = (request,response)=>{
    pool.query('SELECT * FROM flight_history', (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        response.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })
}


const allFlights = (req,res)=>{
    pool.query(`select * from   
    (select Distinct *, 
                     rank ()OVER(
    partition by flight_number
    Order by flight_number,date) r
    from flight_list_fare ) a
    where r = 1
    order by flight_number`, (error,results)=>{

        if(error) {console.log(error.stack)}
        else{
            res.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })

}

const getCost = (req,res)=>{
    pool.query(`SELECT fare_code, amount from flight_cost
    WHERE flight_number = '${req.params.id}'`, (error,results)=>{

        if(error) {console.log(error.stack)}
        else{
            res.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })

}

const getFlight = (req,res)=>{

    const upper = req.params.id.toUpperCase();
    
    pool.query(`SELECT * from flight_list_fare
    WHERE flight_number = '${upper}'
    order by date`
    ,(error,results)=>{
        if(error) {console.log(error.stack)}
        else{
            res.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })
}

const selectDestinationFlight = (req,res)=>{

    destination = [req.body.from, req.body.to]

    pool.query(`SELECT * FROM flight_list_fare WHERE departure_airport_code = '${destination[0]}' AND
    Arrival_airport_code = '${destination[1]}'`, (error,results)=>{
            if(error) {console.log(error.stack)}
            else{           
                res.status(200).json({
                    msg:"succes",
                    data:results.rows
                })
            }
    })

}

const availableSeats = (req,res)=>{
    console.log(req.params.id)
    pool.query(`SELECT * from available_seats
    WHERE flight_number = '${req.params.id}'`, (error,results)=>{
        if(error){console.log(error.stack)}
        else{
            res.status(200).json({
                msg:"succes",
                data:results.rows
            })
        }
    })
}

const createTicket= (req,res)=>{
    
    console.log(req.body.date)
    
    pool.query(`UPDATE seat_reservation
    SET customer_id = ${req.body.customer_id}
    WHERE flight_number = '${req.body.flight_number}' and seat_number = '${req.body.seat_number}'`,
    (error,results)=>{
        if(error){console.log(error.stack)}
        else{
            res.status(201).json({
                msg:"Success"
            })
        }
    })
    
}

const getHistory = (req,res)=>{
    pool.query('SELECT * FROM flight_history order by milleage desc', (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        res.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })

} 


module.exports = {
    test,
    allFlights,
    selectDestinationFlight,
    getFlight,
    getCost,
    availableSeats,
    getHistory,
    createTicket
    
}