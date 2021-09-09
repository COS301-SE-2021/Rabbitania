import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { NodeRequest } from 'src/app/interfaces/ai-planner-node-interface.ts';

@Injectable({
  providedIn: 'root'
})
export class NodeServiceService {

  private bs = new BehaviorSubject<any>(null);

  constructor(private http: HttpClient, ) { }

  async Post(_userEmail: any, _xPos: any, _yPos: any, _actice: boolean): Promise<Observable<any>> {

      this.http.post<NodeRequest>('https://10.0.2.2:5001/api/Node/CreateNode', {
      userEmail: _userEmail,
      xPos: _xPos,
      yPos: _yPos,
      actice: _actice,
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
}
