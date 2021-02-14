import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(private http:HttpClient) { }

  apiUrl = "http://localhost:3000/api"

  getAllCustomer(){
    return this.http.get<any>(`${this.apiUrl}/customer`)
  }


  getFFcCustomer(){
    return this.http.get<any>(`${this.apiUrl}/customer/f`)

  }
  getCustomer(flight:string, id:string){
    id = flight + id;
    console.log(id)
    return this.http.get<any>(`${this.apiUrl}/customer/f/${id}`)
  }

  getCheckin(id:string){
    return this.http.get<any>(`${this.apiUrl}/customer/flights/${id}`)
  }

  makeCheckin(checked_in : any){
    return this.http.patch<any>(`${this.apiUrl}/customer/flights/checkin`,checked_in)
  }

}
