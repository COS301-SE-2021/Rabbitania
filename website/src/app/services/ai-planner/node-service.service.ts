import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { NodeGetAllRequest, NodeRequest } from 'src/app/interfaces/ai-planner-node-interface';

@Injectable({
  providedIn: 'root'
})
export class NodeServiceService {

  private bs = new BehaviorSubject<any>(null);

  constructor(private http: HttpClient, ) { }

  async Save(node: any){
  console.log("this is the node array :  " + node);
    this.http.put('https://localhost:5001/api/Node/SaveNodes', {
      nodes: node,
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

  async Delete(nodeId: number){
    this.http.post('https://localhost:5001/api/Node/DeleteNode', {
      nodeId: nodeId,
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

  async Get(){
    this.http.get('https://localhost:5001/api/Node/GetAllNodes', {
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

  async Post(_userEmail: string, _xPos: any, _yPos: any, _active: boolean): Promise<Observable<any>> {

      this.http.post<NodeRequest>('https://localhost:5001/api/Node/CreateNode', {
      userEmail: _userEmail,
      xPos: _xPos,
      yPos: _yPos,
      active: _active
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
