import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AboutUsComponent } from './about-us/about-us.component';
import { AIPlannerComponent } from './ai-planner/ai-planner.component';
import { CovidQuestionnaireComponent } from './covid-questionnaire/covid-questionnaire.component';
import { DownloadApkComponent } from './download-apk/download-apk.component';
import { PlannerIsadminGuard } from './guards/planner-isadmin.guard';
import { HomepageComponent } from './homepage/homepage.component';
import { ViewUsersAdminComponent } from './view-users-admin/view-users-admin.component';

const routes: Routes = [
  {
    path: "", component: HomepageComponent
  },
  {
    path: "about-us", component: AboutUsComponent
  },
  {
    path: "download-apk", component: DownloadApkComponent
  },
  {
    path: "covid-questionnaire", component: CovidQuestionnaireComponent
  },
  {
    path: "ai-planner", component: AIPlannerComponent, canActivate: [PlannerIsadminGuard]
  },
  {
    path: "view-users-admin", component: ViewUsersAdminComponent, canActivate: [PlannerIsadminGuard]
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes,{onSameUrlNavigation:'reload'})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
