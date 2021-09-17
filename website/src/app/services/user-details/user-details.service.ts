import { Injectable } from '@angular/core';
import { User } from 'src/app/interfaces/user';
import { HttpClient, HttpResponse, HttpHeaders } from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class UserDetailsService {
  adminObj:any = {
    "userEmail": ""
  };

  constructor(private http: HttpClient) {}

  addUserDetails(user: User){
    localStorage.setItem('userDetails', JSON.stringify(user));
  }

  retrieveUserDetails(){
    return (JSON.parse(localStorage.getItem('userDetails') || '{}') || []);
  }

  clearUserDetails(){
    localStorage.removeItem('userDetails');
    localStorage.removeItem('isAdmin');
  }

  async checkAdmin(email : string | null | undefined) {
    if(email == null || email == undefined ){
      return;
    }

    this.adminObj = {
      "userEmail": email
    };

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        Authorization: 'Bearer ' + sessionStorage.getItem('token')
      }),
      observe: 'response' as const,
    };
    await this.http.post('https://localhost:5001/api/User/CheckAdmin', this.adminObj, httpOptions).toPromise()
        .then((response) => {
            console.log(response.ok);
            if(response.ok === true){
              if(response.body == true){
                localStorage.setItem('isAdmin', true.toString());
              }else if(response.body == false){
                localStorage.setItem('isAdmin', false.toString());
              }else{
                localStorage.setItem('isAdmin', 'Error: unknown');
              }
            }
        })
        .catch((error) => {
            console.log("Server error: " + error.message);
        }
    );
  }

}
