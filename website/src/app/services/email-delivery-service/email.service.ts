import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { EmailRequest } from 'src/app/interfaces/email';

@Injectable({
  providedIn: 'root'
})
export class EmailService {

  private bs = new BehaviorSubject<any>(null);

  constructor(private http: HttpClient, ) { }

  async SendEmail(_payload : any, _subject : any, _email : any){
    console.log(sessionStorage.getItem('token'));
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + sessionStorage.getItem('token')
      }),
    };
    this.http.post<EmailRequest>('https://rabbitania-runtimeterrors.herokuapp.com/api/Notifications/SendEmailNotification',{
      payload : _payload,
      subject : _subject,
      email : _email,
    },httpOptions).subscribe(
      (data) => {
        if (data) {
          this.bs.next(data);
          return this.bs.asObservable();

        } else{
          this.bs.next("Error 401: Unable to process request");
          return this.bs.asObservable();
        }
      },
    );
  return this.bs.asObservable();

  }
}
