import { Component, Input, OnInit, ViewChild } from '@angular/core';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatSidenav } from '@angular/material/sidenav';
import { delay } from 'rxjs/operators';
import { AuthService } from '../services/firebase/auth.service';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList } from '@fortawesome/free-solid-svg-icons';
import { BehaviorSubject } from 'rxjs';
import { UserDetailsService } from '../services/user-details/user-details.service';
import { User } from '../interfaces/user';
import { MatDialog } from '@angular/material/dialog';
import { SignOutComponent } from '../sign-out/sign-out.component';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.scss']
})

export class HomepageComponent implements OnInit {
  @ViewChild(MatSidenav)
  sidenav!: MatSidenav;
  private router:Router;

  // Authorized User Detials
  user_displayName = "";
  user_googleUrl = "";

  // Font awesome icons
  faRocket = faRocket;
  faUsers = faUsers;
  faBriefcase = faBriefcase;
  faThList = faThList;
  //

  constructor(
    private observer: BreakpointObserver, 
    private service: AuthService, 
    router: Router,
    public model: MatDialog,
    private userService: UserDetailsService) {
      this.router = router;
  }

  ngOnInit(){
    var display = this.userService.retrieveUserDetails().displayName;
    if(display == undefined || null){
      console.log("Logged Out");
    }else{
      this.user_displayName = this.userService.retrieveUserDetails().displayName;
      this.user_googleUrl = this.userService.retrieveUserDetails().googleImgUrl;
    }
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
    var res = await this.service.signIn();
    if(res){
      
    }else{
      
    }
    this.ngOnInit();
  }

  async signOut(){
    let modelRef = this.model.open(SignOutComponent,{
      width: '250px'
    });

    modelRef.afterClosed().subscribe(result => {
      if(result == "yes"){
        this.service.signOut();
        window.location.reload();
      }
      if(result == "no"){
        // do nothing
      }
    });
  }
}
