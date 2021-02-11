import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { NavBarComponent } from './nav-bar/nav-bar.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AppRoutingModule } from './app-routing.module';
import { AirlineComponent } from './airline/airline.component';
import { FlightComponent } from './flight/flight.component';
import { HttpClientModule, } from '@angular/common/http';
import { CustomerComponent } from './customer/customer.component';
import { FlightShowComponent } from './flight/flight-show/flight-show.component';
import { CheckinComponent } from './checkin/checkin.component';
import { FormsModule } from '@angular/forms';



@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    NavBarComponent,
    AirlineComponent,
    FlightComponent,
    CustomerComponent,
    FlightShowComponent,
    CheckinComponent
  ],
  imports: [
    BrowserModule,
    NgbModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
