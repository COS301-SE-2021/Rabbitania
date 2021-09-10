import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import firebase from "firebase/compat/app";

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(public authFire: AngularFireAuth) { }

  async signIn() {
    const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
    const user = await this.authFire.signInWithPopup(googleAuthProvider);
   
    console.log(user.credential);
    console.log(user.user?.providerData);
    console.log(user.user?.displayName);
    console.log(user.user?.email);

    return user;
  }

  async signOut() {
    await this.authFire.signOut();
  }
}
