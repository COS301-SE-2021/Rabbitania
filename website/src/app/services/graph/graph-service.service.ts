import { Injectable } from '@angular/core';
// import { Console } from 'console';
import { MovableNodes } from '../ai-planner/movable-nodes';

@Injectable({
  providedIn: 'root'
})
export class GraphServiceService {
  private AdjacencyList: Array<any> = []

  CreateGraph(nodes: any) {
    if(this.AdjacencyList.length <= 0){
      console.log("Graph is empty");
    }
    else{
      for(var i = 0; i<this.AdjacencyList.length; i++){

      }
    }
  }
  // AddVertex(vertex){

  // }
  // addEdge(vertex1, vertex2, weight){

  // }
  // removeEdge(vertex1, vertex2){

  // }
  // calculateWeight(vertext1, vertex2){

  // }

  constructor() { }
}
