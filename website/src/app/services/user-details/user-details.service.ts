import { Injectable } from '@angular/core';
import { User } from 'src/app/interfaces/user';
import { HttpClient, HttpResponse, HttpHeaders } from '@angular/common/http';
@Injectable({
  providedIn: 'root'
})
export class UserDetailsService {

  constructor(private http: HttpClient) {}

  addUserDetails(user: User){
    localStorage.setItem('userDetails', JSON.stringify(user));
  }

  retrieveUserDetails(){
    return (JSON.parse(localStorage.getItem('userDetails') || '{}') || []);
  }

  clearUserDetails(){
    localStorage.removeItem('userDetails');
  }

  async checkAdmin(email : string | null | undefined) {
    if(email == null || email == undefined ){
      return;
    }

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        Authorization: 'Bearer ' + sessionStorage.getItem('token')
      }),
      observe: 'response' as const,
    };
    await this.http.post('https://localhost:5001/api/Auth/GoogleLogin', email, httpOptions).toPromise()
        .then((response) => {
            console.log(response.ok);
            if(response.ok === true){
              if(response.body == true){
                localStorage.setItem('isAdmin', true.toString());
                return true;
              }else if(response.body == false){
                localStorage.setItem('isAdmin', false.toString());
                return false;
              }else{
                localStorage.setItem('isAdmin', 'Error: unknown');
                return false;
              }
            }
            return false;
        })
        .catch((error) => {
            console.log("Server error: " + error.message);
        }
    );
  }

}
