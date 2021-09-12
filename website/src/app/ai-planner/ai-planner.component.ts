import { Component, HostListener, OnInit } from '@angular/core';
import {MovableNodes} from '../services/ai-planner/movable-nodes';
import dummyData from '../../test_variables/dummy_node_json.json';
import { FormBuilder, Validators } from '@angular/forms';
import { MatSidenav } from '@angular/material/sidenav';
import { BreakpointObserver } from '@angular/cdk/layout';
import { delay } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { NodeServiceService } from '../../app/services/ai-planner/node-service.service';
import { NodeGetAllRequest } from '../../app/interfaces/ai-planner-node-interface';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList } from '@fortawesome/free-solid-svg-icons';

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

  faRocket = faRocket;
  faUsers = faUsers;
  faBriefcase = faBriefcase;
  faThList = faThList;

  sidenav!: MatSidenav;
  panelOpenState = false;

  addNodeForm = this.fb.group({
    email: null,
  });

  editNodeForm = this.fb.group({
    email: null,
  });



  constructor(private fb: FormBuilder, private observer: BreakpointObserver,private http: HttpClient,private service: NodeServiceService){
    this.onResize();
  }

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
      this.nodes.push(new MovableNodes(Number(dummyData[i].id),Number(dummyData[i].xPos)*multiplier,Number(dummyData[i].yPos)*multiplier,dummyData[i].userEmail,dummyData[i].active))
    }
  }

  async getNodes(multiplier: number)
  {
    
    var result = await this.service.Get();
    result.subscribe(data => {
      if(data){
        this.nodes = [];
          for(var i =0; i< data.length;i++)
          {
            this.nodes.push(new MovableNodes(Number(data[i].id),Number(data[i].xPos)*multiplier,Number(data[i].yPos)*multiplier,data[i].userEmail,data[i].active))
          }
      }
    });

    
  }


  @HostListener("window:resize", [])
  onResize() {


    this.screenHeight = window.innerHeight;
    this.screenWidth = window.innerWidth;
    //console.log(this.screenHeight, this.screenWidth);

    if(this.screenWidth >= 1700)
    {
      this.getNodes(4);
    }
    else if(this.screenWidth >= 1100)
    {
      this.getNodes(2.5);
    }
    else if(this.screenWidth >= 820)
    {
      this.getNodes(2);
    }
    else if(this.screenWidth >= 720)
    {
      this.getNodes(1.6);
    }
    else if(this.screenWidth >= 540)
    {
      this.getNodes(1.0);
    }
    else
    {
      this.getNodes(0.8);
    }
  }

  onSubmit(){
    console.log("submit");
  }

  async addNode(){
  const nodeObject = this.addNodeForm.value;
  console.log(nodeObject.email);
  var result = await this.service.Post(nodeObject.email,0.0,0.0,false);


  result.subscribe(data => {
      if(data){
        console.log(data)
      }
    });
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

  nodeArray: NodeGetAllRequest[] = [];

  async save()
  {
    this.nodeArray = [];
    this.nodes.forEach(element => {
      
      var singleNode:NodeGetAllRequest =
      {
        id: element.deskNumber,
        userEmail: element.userEmail,
        user: null,
        xPos: element.newPosx,
        yPos: element.newPosy,
        active: element.active,
      } ;

      this.nodeArray.push(singleNode);
    });
      //JSON.stringify(jsonObject);
      //console.log(JSON.stringify({nodes: this.nodeArray}));
      var result = await this.service.Save(this.nodeArray);
        result.subscribe(data => {
            if(data){
              console.log(data)
            }
          });
  }

  
}
