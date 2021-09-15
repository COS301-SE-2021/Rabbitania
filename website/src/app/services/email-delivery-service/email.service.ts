import { HttpClient } from '@angular/common/http';
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
    this.http.post<EmailRequest>('https://localhost:5001/api/Notifications/SendEmailNotification',{
      payload : _payload,
      subject : _subject,
      email : _email,
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
    );
  return this.bs.asObservable();

  }
}
