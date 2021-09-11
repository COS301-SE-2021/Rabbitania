import { Component, Input, ViewChild } from '@angular/core';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatSidenav } from '@angular/material/sidenav';
import { delay } from 'rxjs/operators';
import { AuthService } from '../services/firebase/auth.service';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList } from '@fortawesome/free-solid-svg-icons';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})

export class HomepageComponent {
  @ViewChild(MatSidenav)
  sidenav!: MatSidenav;
  auth: any;
  loggedIn = new BehaviorSubject<boolean>(false);

  // Font awesome icons
  faRocket = faRocket;
  faUsers = faUsers;
  faBriefcase = faBriefcase;
  faThList = faThList;
  //

  constructor(private observer: BreakpointObserver, private service: AuthService, private router: Router) {

  }

  ngAfterViewInit() {
    this.observer.observe("").pipe(delay(0.5)).subscribe((result) => {
        if (result.matches) {
          this.sidenav.mode = 'over';
          this.sidenav.close();
        } else {
          this.sidenav.mode = 'side';
          this.sidenav.open();
        }
    });
  }

  async signIn() {
    this.auth = await this.service.signIn();
    if(this.auth){
      this.loggedIn.next(true);
    }else{
      this.loggedIn.next(false);
    }
  }

  async signOut(){
    this.auth = await this.service.signOut();
    this.loggedIn.next(false);
  }
}
