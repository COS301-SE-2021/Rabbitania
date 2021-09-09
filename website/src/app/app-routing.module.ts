import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CovidQuestionnaireComponent } from './covid-questionnaire/covid-questionnaire.component';
import { HomepageComponent } from './homepage/homepage.component';

const routes: Routes = [
  {
    path: "", component: HomepageComponent
  },
  {
    path : "covid-questionnaire", component : CovidQuestionnaireComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
