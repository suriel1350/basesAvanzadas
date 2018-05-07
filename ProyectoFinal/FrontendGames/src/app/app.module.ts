import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { routing, appRoutingProviders } from './app.routing';

import { AppComponent } from './app.component';
import { Ng2SearchPipeModule } from 'ng2-search-filter';
import { DataTableModule } from 'angular2-datatable';

import { HomeComponent } from './components/home.component';
import { UserEditComponent } from './components/user-edit.component';
import { UsuariosGetComponent } from './components/get-usuarios-registrados.component';
import { UsuarioEditComponent } from './components/editar-user.component';
import { SendEmailTokenComponent } from './components/send-email-token.component';
import { ConsolaComponent } from './components/ver-consolas.component';
import { AddConsolaComponent } from './components/agregar-consola.component'; 

import { VideojuegosGetComponent } from './components/get-videojuegos.component';
import { VideojuegoCreateComponent } from './components/create-videojuego.component';
import { AccesoriosGetComponent } from './components/get-accesorios.component';
import { AccesorioCreateComponent } from './components/create-accesorio.component';
import { CarritoGetComponent } from './components/get-carrito.component';
import { VentasComponent } from './components/get-ventas.component';
import { DetallesMysqlComponent } from './components/get-details-mysql.component';
import { DetallesPostgresComponent } from './components/get-details-postgres.component';
import { ConsolaEditComponent } from './components/editar-consola.component';
import { AccesorioEditComponent } from './components/editar-accesorio.component';
import { VideojuegoEditComponent } from './components/editar-videojuego.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    UserEditComponent,
    UsuariosGetComponent,
    UsuarioEditComponent,
    SendEmailTokenComponent,
    ConsolaComponent,
    AddConsolaComponent,
    VideojuegosGetComponent,
    VideojuegoCreateComponent,
    AccesoriosGetComponent,
    AccesorioCreateComponent,
    CarritoGetComponent,
    VentasComponent,
    DetallesMysqlComponent,
    DetallesPostgresComponent,
    ConsolaEditComponent,
    AccesorioEditComponent,
    VideojuegoEditComponent
  ],
  imports: [
    BrowserModule,
    Ng2SearchPipeModule,
    FormsModule,
    HttpModule,
    DataTableModule,
    routing
  ],
  providers: [appRoutingProviders],
  bootstrap: [AppComponent]
})
export class AppModule { }
