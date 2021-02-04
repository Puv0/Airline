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

];

@NgModule({
  declarations: [],
  imports: [
    [RouterModule.forRoot(routes)]
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
