import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PlannerIsadminGuard implements CanActivate {
  canActivate(): boolean  {
    var isAdmin = localStorage.getItem('isAdmin');
    if (isAdmin == "true") {
        return true;
    } else {
        return false;
    }
  } 
}
