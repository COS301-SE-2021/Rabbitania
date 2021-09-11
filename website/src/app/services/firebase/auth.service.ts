import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import firebase from "firebase/compat/app";
import { HttpClient, HttpResponse, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, BehaviorSubject, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  authSuccess: boolean = false;

  constructor(
    public authFire: AngularFireAuth,
    private http: HttpClient
    ) { }

  async signIn() {
    const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
    const user = await this.authFire.signInWithPopup(googleAuthProvider);
    var res = "";
    this.authSuccess = false;

    await this.http.post('https://localhost:5001/api/Auth/GoogleLogin', {
      "displayName": user.user?.displayName,
      "email": user.user?.email,
      "phoneNumber": user.user?.phoneNumber,
      "googleImgUrl": user.user?.photoURL
     }, {observe: 'response'}).toPromise()
      .then((response) => {
          console.log(response.ok);
          if(response.ok === true || response.status === 201){
            this.authSuccess = true;    
          }
      })
      .catch(() => {
          alert('You are not allowed to log into this website. \n\n Retro Rabbit Employees only!');
          return "Access Denied";
        }
    );
    
    return this.authSuccess;
  }

  async signOut() {
    await this.authFire.signOut();
  }
}
