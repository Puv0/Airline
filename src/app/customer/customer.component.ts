import { FfcCustomer } from './ffcustomer.model';
import { Customer } from './customer.model';
import { CustomerService } from './customer.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.css']
})
export class CustomerComponent implements OnInit {

  constructor(private customerService:CustomerService) { }

  customers: Customer[] = []
  ffcustomer: FfcCustomer[] = []

  ngOnInit(): void {

    this.customerService.getAllCustomer()
    .subscribe(customers => {
      console.log(customers)
        this.customers = customers.data;
    })
  
    this.customerService.getFFcCustomer()
    .subscribe(ffc=>{
      console.log(ffc)
      this.ffcustomer = ffc.data;
    })
  
  
  }

}
