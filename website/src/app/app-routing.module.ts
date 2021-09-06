import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CovidQuestionnaireComponent } from './covid-questionnaire/covid-questionnaire.component';

const routes: Routes = [{path : "covid-questionnaire", component : CovidQuestionnaireComponent}];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
