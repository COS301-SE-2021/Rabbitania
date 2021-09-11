import { Component, Input, ViewChild } from '@angular/core';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatSidenav } from '@angular/material/sidenav';
import { delay } from 'rxjs/operators';
import { AuthService } from '../services/firebase/auth.service';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})

export class HomepageComponent {
  @ViewChild(MatSidenav)
  sidenav!: MatSidenav;
  @Input() auth: any;
  
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

  signIn(){
    this.auth = this.service.signIn();
  }

  signOut(){
    this.auth = this.service.signOut();
  }
}
