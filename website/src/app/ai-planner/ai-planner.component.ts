import { Component, HostListener, OnInit } from '@angular/core';
import {MovableNodes} from '../services/ai-planner/movable-nodes';
import dummyData from '../../test_variables/dummy_node_json.json';

@Component({
  selector: 'app-ai-planner',
  templateUrl: './ai-planner.component.html',
  styleUrls: ['./ai-planner.component.scss']
})
export class AIPlannerComponent implements OnInit {
  //1600x900 AKA a 16:9 ratio
  //80m x 45m screen
  //user gets 1m square space to themselves 1m x 1m
  //1600 -> 80 = (1600/10)/2  
  //

  constructor(){
    this.onResize();
  }

  panelOpenState = false;
  public nodeList:{deskNumber:string, x:string,y:string}[] = dummyData;

  ngOnInit(): void {
    console.log("Starting");
    //APi call to get nodes pos/name/details
    this.onResize();
  }


  // newMN1 = new MovableNodes(1,0,0);
  // newMN2 = new MovableNodes(2,977,0);
  // newMN3 = new MovableNodes(3,0,777);
  // newMN4 = new MovableNodes(4,977,777);
  // newMN5 = new MovableNodes(5,472,372);

  nodes: MovableNodes[] = [];

  screenHeight!: number;
  screenWidth!: number;

  getDummyNodes(multiplier: number)
  {
    this.nodes = [];
    for(var i =0; i< dummyData.length;i++)
    {
      //console.log(dummyData[i].deskNumber);
      this.nodes.push(new MovableNodes(Number(dummyData[i].deskNumber),Number(dummyData[i].x)*multiplier,Number(dummyData[i].y)*multiplier))
    }
    
  }

  addNode()
  {
    console.log("ADD NODE PAGE");
  }

  @HostListener("window:resize", [])
  onResize() {
    
    
    this.screenHeight = window.innerHeight;
    this.screenWidth = window.innerWidth;
    //console.log(this.screenHeight, this.screenWidth);

    if(this.screenWidth >= 1700)
    {
      this.getDummyNodes(4);
    }
    else if(this.screenWidth >= 1100)
    {
      this.getDummyNodes(2.5);
    }
    else if(this.screenWidth >= 820)
    {
      this.getDummyNodes(2);
    }
    else if(this.screenWidth >= 720)
    {
      this.getDummyNodes(1.6);
    }
    else if(this.screenWidth >= 540)
    {
      this.getDummyNodes(1.0);
    }
    else
    { 
      this.getDummyNodes(0.8);
    }





  }

}


