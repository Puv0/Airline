import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class FlightService {

  apiUrl = "http://localhost:3000/api"

  constructor(private http:HttpClient) { }

  getAllFlight(){
    return this.http.get<any>(`${this.apiUrl}/flight`)
  }


  getAFlight(id:string){
    return this.http.get<any>(`${this.apiUrl}/flight/${id}`)
  }

  getCosts(id:string){
    return this.http.get<any>(`${this.apiUrl}/flight/${id}/cost`)

  }

  getSeats(id:string){
    return this.http.get<any>(`${this.apiUrl}/flight/${id}/seat`)

  }

  getHistory(){
    return this.http.get<any>(`${this.apiUrl}/history`)

  }

  createTicket(seat: any){
    let addCustomer = {
      flight_number : seat.flight_number,
      customer_id : seat.customer_id,
     // date : seat.date,
      seat_number: seat.seat_number
    }
    return this.http.patch(`${this.apiUrl}/flight/buy`,addCustomer);
  }

}