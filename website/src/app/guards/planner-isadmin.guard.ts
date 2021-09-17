import { Injectable } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AccessDeniedComponent } from '../access-denied/access-denied.component';

@Injectable({
  providedIn: 'root'
})
export class PlannerIsadminGuard implements CanActivate {

  constructor(public model: MatDialog){

  }

  canActivate(): boolean  {
    var isAdmin = localStorage.getItem('isAdmin');
    if (isAdmin == "true") {
        return true;
    } else {
      let modelRef = this.model.open(AccessDeniedComponent,{
        width: '250px'
      });
  
      modelRef.afterClosed().subscribe(result => {
        if(result == "close"){
         return false;
        }
        return false;
      });
    }
    return false;
  } 
}
