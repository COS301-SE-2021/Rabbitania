import { Component, Input, OnInit, PipeTransform, ViewChild } from '@angular/core';
import { BreakpointObserver } from '@angular/cdk/layout';
import { MatSidenav } from '@angular/material/sidenav';
import { delay, map, startWith } from 'rxjs/operators';
import { AuthService } from '../services/firebase/auth.service';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList, faBook } from '@fortawesome/free-solid-svg-icons';
import { UserDetailsService } from '../services/user-details/user-details.service';
import { User } from '../interfaces/user';
import { MatDialog } from '@angular/material/dialog';
import { SignOutComponent } from '../sign-out/sign-out.component';
import { DecimalPipe } from '@angular/common';
import { Observable } from 'rxjs';
import { FormControl } from '@angular/forms';

interface Country {
  name: string;
  number: string;
  description: string;
  imgUrl: string;
}

@Component({
  selector: 'app-view-users-admin',
  templateUrl: './view-users-admin.component.html',
  styleUrls: ['./view-users-admin.component.scss'],
  providers: [DecimalPipe]
})

export class ViewUsersAdminComponent implements OnInit {
  @ViewChild(MatSidenav)
  sidenav!: MatSidenav;
  private router:Router;

  // User Information 
  countries$: Observable<Country[]>;
  filter = new FormControl('');

  USERS: Country[] = [
    {
      name: 'Matthew Harty',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'De Villiers Meiring',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'James Hullet',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'Joseph Harraway',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'James Hullet',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'Joseph Harraway',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'James Hullet',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    },
    {
      name: 'Joseph Harraway',
      number: 'f/f3/Flag_of_Russia.svg',
      description: 'Hello',
      imgUrl: 'img'
    }
  ];

  // Authorized User Detials
  user_displayName = "";
  user_googleUrl = "";

  // Font awesome icons
  faRocket = faRocket;
  faUsers = faUsers;
  faBriefcase = faBriefcase;
  faThList = faThList;
  faBook = faBook;
  //

  loggingIn = false;
  
  constructor(
    private observer: BreakpointObserver,
    private service: AuthService,
    router: Router,
    public model: MatDialog,
    pipe: DecimalPipe,
    private userService: UserDetailsService) {
      this.router = router;
      this.countries$ = this.filter.valueChanges.pipe(
        startWith(''),
        map(text => this.searchUsers(text, pipe))
      );
  }

  searchUsers(text: string, pipe: PipeTransform): Country[] {
    return this.USERS.filter(user => {
      const term = text.toLowerCase();
      return user.name.toLowerCase().includes(term);
    });
  }

  async ngOnInit(){
    var display = this.userService.retrieveUserDetails().displayName;
    if(display == undefined || null){
      console.log("Logged Out");
    }else{
      this.user_displayName = await this.userService.retrieveUserDetails().displayName;
      this.user_googleUrl = await this.userService.retrieveUserDetails().googleImgUrl;
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
    this.loggingIn = true;
    var res = await this.service.signIn();
    if(res){
      this.loggingIn = false;
    }else{
      this.loggingIn = false;
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
