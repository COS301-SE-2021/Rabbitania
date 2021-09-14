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

  userobj:User = {
    "displayName": "",
    "email": "",
    "phoneNumber": "",
    "googleImgUrl": ""
  };

  constructor(
    public authFire: AngularFireAuth,
    private http: HttpClient,
    private userDetails: UserDetailsService,
    ) { }

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

    await this.http.post('https://localhost:5001/api/Auth/GoogleLogin', this.userobj, {observe: 'response'}).toPromise()
      .then((response) => {
          console.log(response.ok);
          if(response.ok === true || response.status === 201){
            this.authSuccess = true;
            this.userDetails.addUserDetails(this.userobj);
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
    this.userDetails.clearUserDetails();
  }
}
