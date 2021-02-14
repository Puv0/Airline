import { FlightService } from './../flight.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-history',
  templateUrl: './history.component.html',
  styleUrls: ['./history.component.css']
})
export class HistoryComponent implements OnInit {

  constructor(private flightService:FlightService) { }

  flights:[]
  ngOnInit(): void {
    this.flightService.getHistory()
    .subscribe(data =>{
      console.log(data)
      this.flights = data.data
      console.log(this.flights)
    })
  }

}
