import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AIPlannerComponent } from './ai-planner/ai-planner.component';
import { HomepageComponent } from './homepage/homepage.component';

const routes: Routes = [
  {
    path: '', component: HomepageComponent
  },
  {
    path: 'planner', component: AIPlannerComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
