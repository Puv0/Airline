import { CustomerService } from './../customer/customer.service';
import { FormGroup,FormControl } from '@angular/forms';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-checkin',
  templateUrl: './checkin.component.html',
  styleUrls: ['./checkin.component.css']
})
export class CheckinComponent implements OnInit {

  show;
  customer;
  flights;
  checkedin;

  constructor(private customerService:CustomerService) { }
  customerForm= new FormGroup({
    id: new FormControl("")
  })
  ngOnInit(): void {
    this.show = false;
    this.checkedin= false;
  }
  
  onSubmit(){
    const customer_id = this.customerForm.value.id
    console.log("asdasdasdasd", customer_id)
    this.customerService.getCheckin(customer_id)
  .subscribe(flights => {
    if(flights.data == 0){
      console.log("empty")
    }else{
      console.log(flights)
      this.flights = flights.data;
      this.show = true

    }
  })
    
}

buttonClick(i:number){
  let seat_reservation = {
    flight_number : String,
    customer_id : String,
    //date : String,
    seat_number: String,
  }
  console.log()
 
    
    seat_reservation.customer_id = this.flights[i].customer_id
    seat_reservation.flight_number = this.flights[i].flight_number
    //seat_reservation.date =  this.flights[i].date.substring(0,10)
    seat_reservation.seat_number = this.flights[i].seat_number
    this.customerService.makeCheckin(seat_reservation)
    .subscribe(data =>{
      console.log(data.res.rows[0].checked_in)
      this.checkedin = data.res.rows[0].checked_in
      console.log(this.checkedin)
      this.show = false ;
    })
}
}