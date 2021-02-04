import { Flight } from './flight.model';
import { FlightService } from './flight.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-flight',
  templateUrl: './flight.component.html',
  styleUrls: ['./flight.component.css']
})
export class FlightComponent implements OnInit {

  constructor(private flightService:FlightService) { }

   flights: Flight[] = [];

    /**
     * let userTestStatus: { id: number, name: string }[] = [
    { "id": 0, "name": "Available" },
    { "id": 1, "name": "Ready" },
    { "id": 2, "name": "Started" }
];
     */
  ngOnInit(): void {
    this.flightService.getAllFlight()
     .subscribe(asd=>{
       this.flights =asd.data;
       console.log(this.flights[0])
     })
      

  }

}
