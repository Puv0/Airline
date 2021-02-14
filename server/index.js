const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = process.env.port || 3000
const flight = require('./queries/flight')
const customer = require('./queries/customer')

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

app.get('/api/test',flight.test)

app.get('/api/flight', flight.allFlights)

app.get('/api/flight/this', flight.selectDestinationFlight)

app.get('/api/flight/:id', flight.getFlight);
app.get('/api/flight/:id/cost', flight.getCost);
app.get('/api/flight/:id/seat', flight.availableSeats);
app.get('/api/history',flight.getHistory);

app.patch('/api/flight/buy', flight.createTicket);

app.get('/api/customer', customer.getAllCustomers)

app.get('/api/customer/f',  customer.getFfcCustomers)

app.get('/api/customer/f/:id', customer.getCustomer)

app.get('/api/customer/flights/:id', customer.checkin);

app.patch('/api/customer/flights/checkin', customer.makeCheckin)

module.exports = app