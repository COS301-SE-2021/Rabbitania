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
    this.authFire.signInWithPopup(googleAuthProvider);
  }

  signOut() {
    this.authFire.signOut();
  }
}
