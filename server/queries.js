const pool = require('./db')
/*
 OUR QUERRY'S goes here
 */
const getUsers =(req,response) =>{

    pool.query('SELECT * FROM airport', (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        response.status(200).json({
            msg:"succes",
            data:results.rows
        })
        }
    })
}

const test = (request,response)=>{
    pool.query('SELECT * FROM flight_history', (error,results)=>{

        if(error) {console.log(err.stack)}
        else{
        response.status(200).json({
            msg:"succes",
            data:results.rows
        })
        }
    })
}

const addCustomer = (request,response) =>{

    const{cust, cname,city} =request.body;
    pool.query('INSERT INTO customer(cust,cname,city) VALUES($1,$2,$3)',
    [cust,cname,city])
    .then(added =>{
        response.status(201).json({
            mesg:"Succsessly Added",
        })
    })
    .catch(err=>{
        response.status(404).json({
            msg:"Err"
        })
    })
}

module.exports = {
    getUsers,
    test,
    addCustomer
}