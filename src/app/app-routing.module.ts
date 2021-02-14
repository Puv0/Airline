import { HistoryComponent } from './flight/history/history.component';
import { CheckinComponent } from './checkin/checkin.component';
import { FlightShowComponent } from './flight/flight-show/flight-show.component';
import { CustomerComponent } from './customer/customer.component';
import { FlightComponent } from './flight/flight.component';
import { HomeComponent } from './home/home.component';
import { NgModule, Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, Routes } from '@angular/router';
import { AirlineComponent } from './airline/airline.component';



const routes: Routes = [
{path:'home', component:HomeComponent},
{path:'airline',component:AirlineComponent},
{path:'flight',component:FlightComponent},
{path:'customer', component: CustomerComponent},
{path:'flight/:id' , component:FlightShowComponent},
{path:'checkin',component:CheckinComponent},
{path:'history',component:HistoryComponent}

];

@NgModule({
  declarations: [],
  imports: [
    [RouterModule.forRoot(routes)]
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
