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
  flag: string;
  area: number;
  population: number;
}

const COUNTRIES: Country[] = [
  {
    name: 'Russia',
    flag: 'f/f3/Flag_of_Russia.svg',
    area: 17075200,
    population: 146989754
  },
  {
    name: 'Canada',
    flag: 'c/cf/Flag_of_Canada.svg',
    area: 9976140,
    population: 36624199
  },
  {
    name: 'United States',
    flag: 'a/a4/Flag_of_the_United_States.svg',
    area: 9629091,
    population: 324459463
  },
  {
    name: 'China',
    flag: 'f/fa/Flag_of_the_People%27s_Republic_of_China.svg',
    area: 9596960,
    population: 1409517397
  }
];

function search(text: string, pipe: PipeTransform): Country[] {
  return COUNTRIES.filter(country => {
    const term = text.toLowerCase();
    return country.name.toLowerCase().includes(term)
        || pipe.transform(country.area).includes(term)
        || pipe.transform(country.population).includes(term);
  });
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
  countries$: Observable<Country[]>;
  filter = new FormControl('');

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
        map(text => search(text, pipe))
      );
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
