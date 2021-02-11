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

}