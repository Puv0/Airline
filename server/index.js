const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = process.env.port || 3000
const query = require('./queries');
const flight = require('./queries/flight')

app.use(bodyParser.json())

app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)
//ENABLING CORS 
app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader(
      "Access-Control-Allow-Headers",
      "Origin, X-Requested-With, Content-Type, Accept, Authorization"
    );
    res.setHeader(
      "Access-Control-Allow-Methods",
      "GET, POST, PATCH, PUT, DELETE, OPTIONS"
    );
    next();
 });


app.get('/', (req,res)=> {
    res.json({msg:"Hello World"})
})


//ALL ROUTES FOR OUR QUERRYS

app.get('/api/user',query.getUsers)

app.get('/api/test', query.test)

app.get('/api/flight', flight.allFlights)

app.post('/api/user/create',query.addCustomer)

module.exports = app