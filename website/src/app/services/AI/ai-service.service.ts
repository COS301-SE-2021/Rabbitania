import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { QuestionnaireRequest } from 'src/app/interfaces/covid_questionnaire_interface';



@Injectable({
  providedIn: 'root'
})
export class AiServiceService {

  private bs = new BehaviorSubject<any>(null);

  constructor(private http: HttpClient, ) { }

async Post(_cough: any, _fever: any, _sore_throat: any, _shortness_of_breath: any, _head_ache: any, _gender: any, _test_indication: any): Promise<Observable<any>> {



    this.http.post<QuestionnaireRequest>('https://rabbitania-ai.herokuapp.com/api/predict', {
    cough: _cough,
    fever: _fever,
    sore_throat: _sore_throat,
    shortness_of_breath: _shortness_of_breath,
    head_ache: _head_ache,
    gender: _gender,
    test_indication: _test_indication,
  }).subscribe(
    (data) => {
      if (data) {
        this.bs.next(data);
        return this.bs.asObservable();

      } else{
        this.bs.next("Error 401: Unable to process request");
        return this.bs.asObservable();
      }
    },
    (error) => {
      console.log(error);
      alert('An unexpected error occurred');
      return error;
    }

  );
return this.bs.asObservable();

}

async Activate(email:string){
  this.http.put<QuestionnaireRequest>('https://localhost:5001/api/Node/ActivateNode', {
    userEmail : email
   }).subscribe((data) => {
    if(data){
      this.bs.next(data);
      return this.bs.asObservable();
    }
    else{
      this.bs.next("Error 401: Unable to process request");
      return this.bs.asObservable();
    }
  },
  (error)=> {
    console.log(error);
    alert('An unexpected error occurred');
    return error;
  }

  );
  return this.bs.asObservable();
}


}
