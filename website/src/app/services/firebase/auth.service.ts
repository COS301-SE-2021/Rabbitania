import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import firebase from "firebase/compat/app";
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject, of } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private bs = new BehaviorSubject<Boolean>(false); // valid user or not

  constructor(
    public authFire: AngularFireAuth,
    private http: HttpClient
    ) { }

  async signIn() {
    const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
    const user = await this.authFire.signInWithPopup(googleAuthProvider);
   
    console.log(user.credential);
    console.log(user.user?.providerData);
    console.log(user.user?.displayName);
    console.log(user.user?.email);

    this.http.post<Boolean>('https://localhost:5001/api/Auth/GoogleLogin', {
      "displayName": "string",
      "email": "string",
      "phoneNumber": "string",
      "googleImgUrl": "string"
    }).subscribe(
        (data) => {
          if (data) {
            this.bs.next(true); // valid user
          } else{
            this.bs.next(false);
          }
        },
        (error) => {
          console.log(error);
          alert('Error with POST request in Autherization Service');
          return error;
        }
    );
    
    if(this.bs.value == true){
      return user;
    }else{
      return null;
    }
  }

  async signOut() {
    await this.authFire.signOut();
  }
}
