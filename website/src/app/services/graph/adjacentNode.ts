import { MovableNodes } from "../ai-planner/movable-nodes";

export class AdjacentNode{
  private distance!: number;
  private userEmail!: string;
  private active!: boolean;

  constructor(distance: number, userEmail: string, active : boolean){
    this.distance = distance;
    this.userEmail = userEmail;
    this.active = active;
  }

  get Distance(){
    return this.distance;
  }

  set Distance(distance : number){
    this.distance = distance;
  }

  get UserEmail(){
    return this.userEmail;
  }

  set UserEmail(userEmail : string){
    this.userEmail = userEmail;
  }

  get Active(){
    return this.active;
  }

  set Active(active : boolean){
    this.active = active;
  }


}
