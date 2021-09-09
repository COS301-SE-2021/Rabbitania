import { Component, HostListener, OnInit } from '@angular/core';
import {MovableNodes} from '../services/ai-planner/movable-nodes';
import dummyData from '../../test_variables/dummy_node_json.json';
import { FormBuilder, Validators } from '@angular/forms';
import { MatSidenav } from '@angular/material/sidenav';
import { BreakpointObserver } from '@angular/cdk/layout';
import { delay } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { NodeServiceService } from '../../app/services/ai-planner/node-service.service';

@Component({
  selector: 'app-ai-planner',
  templateUrl: './ai-planner.component.html',
  styleUrls: ['./ai-planner.component.scss']
})
export class AIPlannerComponent implements OnInit {
  //1600x900 AKA a 16:9 ratio
  //80m x 45m screen -> 40m x 22.5m screen
  //user gets 1m square space to themselves 1m x 1m
  //1600 -> 80 = (1600/10)/2  
  //
  addNodeForm = this.fb.group({
    email: null,
  });

  editNodeForm = this.fb.group({
    email: null,
  });


  sidenav!: MatSidenav;
  
  constructor(private fb: FormBuilder, private observer: BreakpointObserver,private http: HttpClient,private service: NodeServiceService){
    this.onResize();
  }

  panelOpenState = false;
  public nodeList:{deskNumber:string, x:string,y:string}[] = dummyData;

  ngOnInit(): void {
    //APi call to get nodes pos/name/details
    this.onResize();

    this.addNodeForm = this.fb.group({
      email: null,
    });

    this.editNodeForm = this.fb.group({
        email: null,
      });

  }

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

  onSubmit(){
    console.log("submit");
  }

  addNode(){
  
  }



  ngAfterViewInit() {
    this.observer.observe("").pipe(delay(0.5)).subscribe((result) => {
        if (result.matches) {
          this.sidenav.mode = 'over';
          this.sidenav.close();
        } else {
          this.sidenav.mode = 'side';
          this.sidenav.open();
        }
    });
  }

}
