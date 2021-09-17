import { GoogleCredentials } from './../../interfaces/google-auth-creds';
import { User } from 'src/app/interfaces/user';
import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import firebase from "firebase/compat/app";
import { HttpClient, HttpResponse, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { UserDetailsService } from '../user-details/user-details.service';


@Injectable({
  providedIn: 'root'
})
export class AuthService {
  
  authSuccess: boolean = false;

  token = {
    token: ''
  };

  userobj:User = {
    "displayName": "",
    "email": "",
    "phoneNumber": "",
    "googleImgUrl": ""
  };

  constructor(
    public authFire: AngularFireAuth,
    private http: HttpClient,
    private userDetails: UserDetailsService) {

    }
  
  async setToken() : Promise<any> {
    await this.authFire.currentUser.then(async (data) => {
      await data?.getIdTokenResult().then((returned) => {
        this.token = {
          token: returned.token,
        }
        sessionStorage.setItem('token' , returned.token);
      });
    });
  }

  getToken(){
    var token = sessionStorage.getItem('token');
    return token;
  }

  async Token(){
    await this.setToken();
    return this.token.token;
  }

  async signIn() {
    const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
    const user = await this.authFire.signInWithPopup(googleAuthProvider);
    this.authSuccess = false;
    
    this.userobj = {
      "displayName": user.user?.displayName,
      "email": user.user?.email,
      "phoneNumber": user.user?.phoneNumber,
      "googleImgUrl": user.user?.photoURL
    };

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        Authorization: 'Bearer ' + await this.Token()
      }),
      observe: 'response' as const,
    };
    await this.http.post('https://localhost:5001/api/Auth/GoogleLogin', this.userobj, httpOptions).toPromise()
        .then((response) => {
            console.log(response.ok);
            if(response.ok === true || response.status === 201){
              this.authSuccess = true;
              this.userDetails.addUserDetails(this.userobj);
              this.userDetails.checkAdmin(this.userobj.email);
            }
        })
        .catch((error) => {
            console.log("Server error: " + error.message);
            this.authSuccess = false;
        }
      );

    return this.authSuccess;
  }

  async signOut() {
    await this.authFire.signOut();
    sessionStorage.removeItem('token');
    this.userDetails.clearUserDetails();
  }

}
