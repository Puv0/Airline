const pg = require('pg')

//DATABASE CONNECTION
const config = {
    user :'postgres',
    host: 'localhost',
    database: 'Airline',
    password: 'postgres',
    port : 5432

}
 const pool = new pg.Pool(config);

pool.on('error', (err,client)=>{
    console.log("PLEASE");
    console.log(err," -- ",client)
})

module.exports = pool;
