const { response } = require('express');
const pool = require('../db');


const getAllCustomers = (request,response)=>{
    pool.query(`select c.customer_id, c.customer_name, c.passaport_number from customer c 
    WHERE NOT EXISTS(
    SELECT customer_id FROM ffc_customer_information f  WHERE c.customer_id = f.customer_id 
    )`, (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        response.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })
}

const getFfcCustomers = (request,response)=>{

    pool.query('SELECT * FROM ffc_customer_information', (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        response.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })

}

const checkin = (req,res)=>{
    console.log(req.params.id)
    pool.query(`SELECT * FROM reservation_history
    WHERE customer_id = ${req.params.id}`, (error,results)=>{

        if(error) {console.log(error.stack)}
        else{
        res.status(200).json({
            msg:"succes",
            data:results.rows
        })}
    })
}

const makeCheckin= (req,res)=>{
    
    
    pool.query(`UPDATE seat_reservation
    SET checked_in = 'true'
    WHERE flight_number = '${req.body.flight_number}' and seat_number = '${req.body.seat_number}' 
    and customer_id = ${req.body.customer_id} RETURNING *`,
    (error,results)=>{
        
        if(error){console.log(error.stack)}
        else{
            res.status(201).json({
                msg:results.command,
                res:results
            })
        }
    })
    
}


const getCustomer = (req,res)=>{
    const iata = req.params.id.substring(0,2)
    const id  = req.params.id.substring(2,6)
    pool.query(`
        SELECT * from ffc_customer_information
        WHERE customer_id = '${id}' and iata='${iata}'
        `,(error,results)=>{
            if(error) { console.log(error.stack)}
            else{
                if(results.rowCount == 0){
                    res.status(201).json({
                        msg:"no one",
                        data:0
                    })
                }else{
                res.status(201).json({
                    msg:"succes",
                    data:results.rows
                })
            }
            }
        })
}



module.exports = {
    getAllCustomers,
    getFfcCustomers,
    getCustomer,
    checkin,
    makeCheckin
}