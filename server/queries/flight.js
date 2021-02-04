const pool = require('../db')

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
    pool.query('SELECT * FROM flight_list_fare', (error,results)=>{

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
    allFlights
}