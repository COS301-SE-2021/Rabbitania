import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { NodeGetAllRequest, NodeRequest } from 'src/app/interfaces/ai-planner-node-interface';
import { AngularFireAuth } from '@angular/fire/compat/auth';
import { AuthService } from '../firebase/auth.service';
@Injectable({
  providedIn: 'root'
})
export class NodeServiceService {

  private bs = new BehaviorSubject<any>(null);
  constructor(private http: HttpClient,public authFire: AngularFireAuth ) { }

  token = {
    token: ' '
  };
  //functionality
  async getToken() : Promise<any> {
    await this.authFire.currentUser.then(async (data) => {
      await data?.getIdToken().then((returned) => {
        this.token = {
          token: returned,
        }
      });
    });
  }
  async Token(){
    await this.getToken();
    var token = sessionStorage.getItem('token');
    if((this.token.token).length <10)
    {
      return token;
    }
    else
    {
      return this.token.token;
    }
  }

  async Save(node: any){
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + await this.Token()
      }),
      'observe': 'response' as const,
    };
    this.http.put('https://rabbitania-runtimeterrors.herokuapp.com/api/Node/SaveNodes', {
      nodes: node,
    },httpOptions).subscribe(
      (data) => {
        if (data) {
          this.bs.next(data);
          return this.bs.asObservable();
        } else{
          console.log("Error 401: Unable to process request");
          return this.bs.asObservable();
        }
      },
      (error) => {
        console.log(error);
        console.log('An unexpected error occurred');
        return error;
      }

    );
  return this.bs.asObservable();
  }

  async Delete(nodeId: number){
    const options = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + await this.Token()
      }),
      body: {
        nodeId: nodeId,
      },
    };

    this.http.delete('https://rabbitania-runtimeterrors.herokuapp.com/api/Node/DeleteNode', options).subscribe(
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
        console.log('An unexpected error occurred');
        return error;
      }

    );
  return this.bs.asObservable();
  }



  async Get(){

    const headers = { 'Authorization': 'Bearer ' + await this.Token()};
    this.http.get('https://rabbitania-runtimeterrors.herokuapp.com/api/Node/GetAllNodes',{headers}).subscribe(
      (data) => {
        if (data) {
          this.bs.next(data);
          return this.bs.asObservable();
        } else{
          console.log("Error 401: Unable to process request");
          return this.bs.asObservable();
        }
      },
      (error) => {
        console.log("UNKNOWN ERROR...");
        return error;
      }

    );
  return this.bs.asObservable();
  }

  async Post(_userEmail: string, _xPos: any, _yPos: any, _active: boolean): Promise<Observable<any>> {

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + await this.Token()
      }),
      'observe': 'response' as const,
    };

      this.http.post<NodeRequest>('https://rabbitania-runtimeterrors.herokuapp.com/api/Node/CreateNode', {
      userEmail: _userEmail,
      xPos: _xPos,
      yPos: _yPos,
      active: _active
    },httpOptions).subscribe(
      (data) => {
        if (data) {
          this.bs.next(data);
          return this.bs.asObservable();
        } else{
          console.log("Error 401: Unable to process request")
          return this.bs.asObservable();
        }
      },
      (error) => {
        console.log(error);
        return error;
      }
    );
  return this.bs.asObservable();
  }
}
