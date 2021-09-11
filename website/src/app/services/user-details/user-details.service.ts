import { Injectable } from '@angular/core';
import { User } from 'src/app/interfaces/user';

@Injectable({
  providedIn: 'root'
})
export class UserDetailsService {

  constructor() {}

  addUserDetails(user: User){
    localStorage.setItem('userDetails', JSON.stringify(user));
  }

  retrieveUserDetails(){
    return (JSON.parse(localStorage.getItem('userDetails') || '{}') || []);
  }

  clearUserDetails(){
    localStorage.removeItem('userDetails');
  }

}
