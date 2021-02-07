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
    pool.query(`SELECT * from flight_list`, (error,results)=>{

        if(error) {console.log(err.stack)}
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


module.exports = {
    test,
    allFlights,
    selectDestinationFlight
}