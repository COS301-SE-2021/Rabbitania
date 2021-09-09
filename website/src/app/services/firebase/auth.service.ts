import { Injectable } from '@angular/core';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import firebase from "firebase/compat/app";

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(public authFire: AngularFireAuth) { }

  signIn() {
    const googleAuthProvider = new firebase.auth.GoogleAuthProvider();
    const details = this.authFire.signInWithPopup(googleAuthProvider);
    return details;
  }

  signOut() {
    this.authFire.signOut();
  }
}
