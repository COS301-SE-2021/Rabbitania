import { Component, OnInit } from '@angular/core';
import {MovableNodes} from '../services/ai-planner/movable-nodes';
import dummyData from '../../test_variables/dummy_node_json.json';

@Component({
  selector: 'app-ai-planner',
  templateUrl: './ai-planner.component.html',
  styleUrls: ['./ai-planner.component.scss']
})
export class AIPlannerComponent implements OnInit {

  panelOpenState = false;
  public nodeList:{deskNumber:string, x:string,y:string}[] = dummyData;

  ngOnInit(): void {
    console.log("Starting");
    //APi call to get nodes pos/name/details
    this.getDummyNodes();
  }


  // newMN1 = new MovableNodes(1,0,0);
  // newMN2 = new MovableNodes(2,977,0);
  // newMN3 = new MovableNodes(3,0,777);
  // newMN4 = new MovableNodes(4,977,777);
  // newMN5 = new MovableNodes(5,472,372);

  nodes: MovableNodes[] = [];

  getDummyNodes()
  {
    for(var i =0; i< dummyData.length;i++)
    {
      //console.log(dummyData[i].deskNumber);
      this.nodes.push(new MovableNodes(Number(dummyData[i].deskNumber),Number(dummyData[i].x),Number(dummyData[i].y)))
    }
    
  }

  addNode()
  {
    console.log("ADD NODE PAGE");
  }
}


