import { Component, HostListener, OnInit } from '@angular/core';
import {MovableNodes} from '../services/ai-planner/movable-nodes';
import dummyData from '../../test_variables/dummy_node_json.json';
import { FormBuilder, Validators } from '@angular/forms';
import { MatSidenav } from '@angular/material/sidenav';
import { BreakpointObserver } from '@angular/cdk/layout';
import { delay, first } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';
import { NodeServiceService } from '../../app/services/ai-planner/node-service.service';
import { NodeGetAllRequest } from '../../app/interfaces/ai-planner-node-interface';
import { Router } from '@angular/router';
import { faRocket, faUsers, faBriefcase, faThList } from '@fortawesome/free-solid-svg-icons';
import { MatDialog } from '@angular/material/dialog';
import { AiPopupComponent } from '../ai-popup/ai-popup.component';

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



  constructor(private fb: FormBuilder, private observer: BreakpointObserver,private http: HttpClient,private service: NodeServiceService, public dialog: MatDialog){
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

  screenRatio: number = 1;

  @HostListener("window:resize", [])
  onResize() {

    this.screenHeight = window.innerHeight;
    this.screenWidth = window.innerWidth;

    if(this.screenWidth >= 1700)
    {
      this.screenRatio = 4
      this.getNodes(this.screenRatio);
    }
    else if(this.screenWidth >= 1100)
    {
      this.screenRatio = 2.5;
      this.getNodes(this.screenRatio);
    }
    else if(this.screenWidth >= 820)
    {
      this.screenRatio = 2;
      this.getNodes(this.screenRatio);
    }
    else if(this.screenWidth >= 720)
    {
      this.screenRatio = 1.6;
      this.getNodes(this.screenRatio);
    }
    else if(this.screenWidth >= 540)
    {
      this.screenRatio = 1.0;
      this.getNodes(this.screenRatio);
    }
    else
    {
      this.screenRatio = 0.8;
      this.getNodes(this.screenRatio);
    }
  }

  onSubmit(){
    console.log("submit");
  }

  async addNode(){
  const nodeObject = this.addNodeForm.value;
  
  var result = await this.service.Post(nodeObject.email,0.0,0.0,false);

  result.subscribe(data => {
      if(data){
        console.log(data)
      }
    });
    
      this.openDialog();
 
    
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
        xPos: element.newPosx/this.screenRatio,
        yPos: element.newPosy/this.screenRatio,
        active: element.active,
      } ;

      this.nodeArray.push(singleNode);
    });
      var result = await this.service.Save(this.nodeArray);
        result.pipe(first()).subscribe(data => {
         
          });

          this.openDialog();
  }

  async delete(deskNumber: number){
    var result = await this.service.Delete(deskNumber);
    result.subscribe(data => {
        if(data){
          console.log(data);
        }
        
      });

      this.openDialog();
  }

  openDialog() {

    this.dialog.open(AiPopupComponent);
    setTimeout(() => {
      this.getNodes(this.screenRatio);
  }, 700);
  }
  
  
}
