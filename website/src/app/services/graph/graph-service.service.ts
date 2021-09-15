import { Injectable } from '@angular/core';
import { MovableNodes } from '../ai-planner/movable-nodes';
import { EmailService } from '../email-delivery-service/email.service';
import { AdjacentNode } from './adjacentNode';

@Injectable({
  providedIn: 'root'
})
export class GraphServiceService {
  private AdjacencyList: Array<any> = [];
  private RedEmails : Array<string> = [];
  private OrangeEmails : Array<string> = [];
  private CovidNode!: MovableNodes;
  private RedRadius!: number;
  private OrangeRadius!: number;


  CreateGraph(nodes: any, userEmail : string) {
    //Find the correct node for which the adjacency list will be constructed
    this.CovidNode = nodes.find((x: { userEmail: string; }) => x.userEmail == userEmail);

    console.log(this.CovidNode);
    console.log(nodes);

    nodes.forEach((element: any) => {
      if(element.userEmail != userEmail){
        var distance = Math.sqrt(Math.pow((element.newPosx - this.CovidNode.newPosx), 2)+ Math.pow((element.newPosy - this.CovidNode.newPosy), 2));
        if(element.active == true){
          this.AdjacencyList.push(new AdjacentNode(distance, element.userEmail, element.active));
        }
      }
    });

    this.AdjacencyList.forEach((element: any) => {
      if(element.distance <= this.RedRadius){
        this.RedEmails.push(element.userEmail);
      }
      if(element.distance > this.RedRadius && element.distance <= this.OrangeRadius){
        this.OrangeEmails.push(element.userEmail);
      }
    })

    console.log(this.AdjacencyList);
    console.log(this.RedEmails);

    if(this.RedEmails.length > 0){
    this.emailService.SendEmail("There is a strong likelihood that you have come in contact with someone who has covid. We advise you get tested if you experience any symptoms within the next week.", "Covid Warning!", this.RedEmails);
    }

    if(this.OrangeEmails.length > 0 ){
      this.emailService.SendEmail("There is a small likelihood that you have come in contact with someone who has covid. We advise you get tested if you experience any symptoms within the next week.", "Covid Warning!", this.OrangeEmails);
    }
  }

  //sqrt(square(x2 - x1) + square(y2 - y1))

  constructor(private emailService : EmailService) {
    this.RedRadius = 250;
    this.OrangeRadius = 500;
   }
}

