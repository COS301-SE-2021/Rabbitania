import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import {MatExpansionModule} from '@angular/material/expansion';
import {MatDividerModule} from '@angular/material/divider';
import {MatListModule} from '@angular/material/list';
import {MatButtonModule} from '@angular/material/button';
import {MatSidenavModule} from '@angular/material/sidenav';
import { HostListener } from "@angular/core";
import {MatTabsModule} from '@angular/material/tabs';
import { CovidQuestionnaireComponent } from './covid-questionnaire/covid-questionnaire.component';
import { FormsModule, ReactiveFormsModule} from '@angular/forms';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatRadioModule} from '@angular/material/radio';
import {MatCheckboxModule} from '@angular/material/checkbox';
import { HttpClientModule } from '@angular/common/http';
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { HomepageComponent } from './homepage/homepage.component';
import {MatIconModule} from '@angular/material/icon';
import {MatToolbarModule} from '@angular/material/toolbar';
import { MatInputModule } from '@angular/material/input';
import {MatMenuModule} from '@angular/material/menu';
import { AIPlannerComponent } from './ai-planner/ai-planner.component';
import { MatDialogModule } from '@angular/material/dialog';
import { MatCardModule } from '@angular/material/card';
import { MatGridListModule } from '@angular/material/grid-list';

import { AngularFireModule } from "@angular/fire/compat";
import { AngularFireAuthModule } from '@angular/fire/compat/auth';
import { environment } from 'src/environments/environment';
import { FontAwesomeModule } from '@fortawesome/angular-fontawesome';
import { SignOutComponent } from './sign-out/sign-out.component';
import { AboutUsComponent } from './about-us/about-us.component';
import { AiPopupComponent } from './ai-popup/ai-popup.component';
import { AccessDeniedComponent } from './access-denied/access-denied.component';
import { DomainCheckComponent } from './domain-check/domain-check.component';
import { ViewUsersAdminComponent } from './view-users-admin/view-users-admin.component';
import { DownloadApkComponent } from './download-apk/download-apk.component';

@NgModule({
  declarations: [
    AppComponent,
    HomepageComponent,
    CovidQuestionnaireComponent,
    AIPlannerComponent,
    SignOutComponent,
    AboutUsComponent,
    AiPopupComponent,
    AccessDeniedComponent,
    DomainCheckComponent,
    ViewUsersAdminComponent,
    DownloadApkComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    AngularFireModule.initializeApp(environment.firebaseConfig),
    AngularFireAuthModule,
    BrowserAnimationsModule,
    DragDropModule, NgbModule,MatCardModule,
    MatGridListModule,
    MatExpansionModule,MatDividerModule,
    MatListModule,MatButtonModule,MatSidenavModule,MatTabsModule,
    MatIconModule,
    MatToolbarModule,
    FormsModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatRadioModule,
    MatCheckboxModule,
    MatDialogModule,
    HttpClientModule,
    MatExpansionModule,MatDividerModule,
    MatListModule,MatButtonModule,MatSidenavModule,MatTabsModule,MatIconModule,MatFormFieldModule,FormsModule,ReactiveFormsModule,MatInputModule, MatMenuModule, 
    FontAwesomeModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

platformBrowserDynamic().bootstrapModule(AppModule)
  .catch(err => console.error(err));

