import { CustomerService } from './../../customer/customer.service';
import { FlightService } from './../flight.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {FormBuilder, FormControl, FormGroup} from '@angular/forms';

@Component({
  selector: 'app-flight-show',
  templateUrl: './flight-show.component.html',
  styleUrls: ['./flight-show.component.css']
})
export class FlightShowComponent implements OnInit {

  constructor(private route:ActivatedRoute,
    private flightService:FlightService,
    private customerService:CustomerService
    ) { }

    flights = []
    costs = []
    cost;
    amount;
    customer;
    show;
    seats = [];

    customerForm= new FormGroup({
      id: new FormControl("")
    })



  ngOnInit(): void {
    this.route.snapshot.params.id
    this.show = false ;
    this.flightService.getAFlight(this.route.snapshot.params.id)
    .subscribe(flight=>{
      this.flights = flight.data;
      console.log(this.flights[0].date)
    })
    
    this.flightService.getCosts(this.route.snapshot.params.id)
    .subscribe(costs =>{

      costs.data.forEach(element => {
          let fare_code = element.fare_code.substring(0,1);
          switch(fare_code){
            case 'J':{
              element.fare_code = "Business Class"
              break;
            }
            case 'Y':{
              element.fare_code = 'Economoy Class'
              break;
            }
            case 'W':{
              element.fare_code = 'Premium-economy Class'
              break;
            }
            case 'F':{
              element.fare_code = 'First class'
              break;
            }
          }
        });
      this.costs = costs.data
    })

    this.flightService.getSeats(this.route.snapshot.params.id)
    .subscribe(seat=>{
      this.seats = seat.data
      console.log(this.seats)
    })
  }

  selectOption(amount:number, index: number){
    console.log(this.costs)
    if(this.customer){
      const segment = this.customer.segment
      console.log(segment)
      if(segment == 'Classic'){
          this.amount = amount - (amount*5)/100
      }else if(segment =='Elite'){
        this.amount = amount - (amount*10)/100
      }
      else if(segment =='Elite Plus'){
        this.amount = amount - (amount*15)/100
      }else if(segment =='Bronze'){
        this.amount = amount - (amount*10)/100
      }else if(segment =='Silver'){
        this.amount = amount - (amount*15)/100
      }else if(segment =='Gold'){
        this.amount = amount - (amount*20)/100
      }else if(segment =='Moon'){
        this.amount = amount - (amount*8)/100
      }else if(segment =='Sun'){
        this.amount = amount - (amount*15)/100
      }else if(segment =='Miles'){
        this.amount = amount - (amount*8)/100
      }else if(segment =='Smiles'){
        this.amount = amount - (amount*15)/100
      }else if(segment =='Atlas'){
        this.amount = amount - (amount*5)/100
      }else if(segment =='Global'){
        this.amount = amount - (amount*10)/100
      }
    }
    
    this.flights[index].amount = this.amount
  
  }

  seatOption(){
    
  }

  /*
  customerCheck(customer_id:string){
    this.customerService.getCustomer(this.route.snapshot.params.id.substring(0,2),customer_id)
    .subscribe(customer => {
      if(customer.data == 0){
        console.log("empty")
      }else{
        this.customer = customer.data[0]
        console.log(this.customer)
      }
    })
  }
  */
    onSubmit(){
      const customer_id = this.customerForm.value.id
      console.log("asdasdasdasd", customer_id)
      this.customerService.getCustomer(this.route.snapshot.params.id.substring(0,2),customer_id)
    .subscribe(customer => {
      if(customer.data == 0){
        console.log("empty")
      }else{
        this.customer = customer.data[0]
        console.log(this.customer)
        this.show = true;
        console.log(this.show)
        console.log(this.customer)
      
      }
    })
      
  }

  trackByFn(index, item) {
    return index;
  }

  trackByOther(index, item) {
    return index;
  }

  buttonClick(i:number){
    let seat_reservation = {
      flight_number : String,
      customer_id : String,
      //date : String,
      seat_number: String,
    }
  
    if(this.customer !== undefined){
      
      seat_reservation.customer_id = this.customer.customer_id
      seat_reservation.flight_number = this.flights[i].flight_number
      //seat_reservation.date =  this.flights[i].date.substring(0,10)
      seat_reservation.seat_number = this.seats[i].seat_number

      console.log("FASFASFASD", seat_reservation)
      this.flightService.createTicket(seat_reservation)
      .subscribe(success=>{
        console.log(success);
      })
    }else{
      console.log("boş")
    }
  }

}