import { CustomerService } from './../../customer/customer.service';
import { FlightService } from './../flight.service';
import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-flight-show',
  templateUrl: './flight-show.component.html',
  styleUrls: ['./flight-show.component.css']
})
export class FlightShowComponent implements OnInit {

  constructor(  private route:ActivatedRoute,
    private flightService:FlightService,
    private customerService:CustomerService
    ) { }

    flights = []
    costs = []
    cost;
    amount;
    deneme;
    customer;

  ngOnInit(): void {
    this.route.snapshot.params.id
    
    this.flightService.getAFlight(this.route.snapshot.params.id)
    .subscribe(flight=>{
      this.flights = flight.data;
    })
    this.cost = {
      fare_code: String,
      amount: Number
    };
    this.flightService.getCosts(this.route.snapshot.params.id)
    .subscribe(costs =>{
      let new_cost;
      costs.data.forEach(element => {
          console.log(element)
          let fare_code = element.fare_code.substring(0,1);
          switch(fare_code){
            case 'J':{
              new_cost = 'First Class'
              break;
            }
            case 'Y':{
              new_cost = 'Business Class'
              break;
            }
            case 'W':{
              new_cost = 'Premium-economy Class'
              break;
            }
            case 'Y':{
              new_cost = 'Economy class'
              break;
            }
          }
          
        });
      this.costs = costs.data
    })

  }

  selectOption(amount:number, index: number){

    if(this.customer){
      const segment = this.customer.segment
      if(segment == 'Elite'){
          this.amount = amount - (amount*5)/100
      }
    }
    
    this.flights[index].amount = this.amount
    console.log("SELECT OPTION", amount);
    

  }

  
  customerCheck(customer_id:string){
    this.customerService.getCustomer(this.route.snapshot.params.id.substring(0,2),customer_id)
    .subscribe(customer => {
      console.log(customer)
      if(customer.data == 0){
        console.log("empty")
      }else{
        this.customer = customer.data[0]
        console.log(this.customer)
      }
    })
  }

  trackByFn(index, item) {
    return index;
  }

  buttonClick(customer){
    this.customer = customer
    if(this.customer ==""){
      console.log(this.customer)
    }else{
      console.log("boş")
    }
  }

}

 
