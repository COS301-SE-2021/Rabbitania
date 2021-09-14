import { CdkDragEnd, CdkDragMove, CdkDragStart } from "@angular/cdk/drag-drop";

export class MovableNodes {

    private _state: string;
    private _position: string;
    private _deskNumber: number;
    private _savedX: number;
    private _savedY: number;
     //private _userEmail: string;
     //private _active: boolean;
  
    constructor(deskNumber: number, x: number, y: number) 
    {
      this._state = "";
      this._position = "";
      this._deskNumber = deskNumber;
      this._savedX = x;
      this._savedY = y;
    }
  
    //   getMovableNodes(): MovableNodesService[]
    //   {
    //     //return obj from API
    //     let newMN1 = new MovableNodesService(1,0,0);
    //     let newMN2 = new MovableNodesService(2,977,0);
    //     let newMN3 = new MovableNodesService(3,0,777);
    //     let newMN4 = new MovableNodesService(4,977,777);
    //     let newMN5 = new MovableNodesService(5,472,372);

    //     this.nodes1 = [
    //         newMN1,
    //         newMN2,
    //         newMN3,
    //         newMN4,
    //         newMN5,
    //       ];
    //     return this.nodes1;
    //   }

    public get savedY(): number {
      return this._savedY;
    }
    public set savedY(value: number) {
      this._savedY = value;
    }
    public get savedX(): number {
      return this._savedX;
    }
    public set savedX(value: number) {
      this._savedX = value;
    }
    public get state() {
      return this._state;
    }
    public set state(value) {
      this._state = value;
    }
    public get position() {
      return this._position;
    }
    public set position(value) {
      this._position = value;
    }
    public get deskNumber() {
      return this._deskNumber;
    }
    public set deskNumber(value) {
      this._deskNumber = value;
    }
  
    dragStarted(event: CdkDragStart) {
      this.state = 'dragStarted';
    }
  
    dragEnded(event: CdkDragEnd) {
      this.state = 'dragEnded';
    }
  
    dragMoved(event: CdkDragMove) {
      // var boarder = document.getElementById(this._deskNumber.toString());
      // var leftOffset = boarder!.offsetLeft;
      // var toptOffset = boarder!.offsetTop;
      //this.position = `> Position X: ${event.pointerPosition.x-leftOffset-30} - Y: ${event.pointerPosition.y-toptOffset-30}`;
      var pixelCorrection = 1.5999;
      var xPosition =event.source.getFreeDragPosition().x + pixelCorrection;
      var yPosition =event.source.getFreeDragPosition().y + pixelCorrection;
      var screenHeight = window.innerHeight;
      var screenWidth = window.innerWidth;

      //this.position = `> Position X: ${event.source.getFreeDragPosition().x+1.59} - Y: ${event.source.getFreeDragPosition().y+1.59}`;

    if(screenWidth >= 1700)
    {
      this.position = 'Position X: '+xPosition/4+'cm - Y: '+yPosition/4+'cm';
    }
    else if(screenWidth >= 1100)
    {
      this.position = 'Position X: '+xPosition/2.5+'cm - Y: '+yPosition/2.5+'cm';
    }
    else if(screenWidth >= 820)
    {
      this.position = 'Position X: '+xPosition/2+'cm - Y: '+yPosition/2+'cm';
    }
    else if(screenWidth >= 720)
    {
      this.position = 'Position X: '+xPosition/1.6+'cm - Y: '+yPosition/1.6+'cm';
    }
    else if(screenWidth >= 540)
    {
      this.position = 'Position X: '+xPosition/1.0+'cm - Y: '+yPosition/1.0+'cm';
    }
    else
    { 
      this.position = 'Position X: '+xPosition/0.8+'cm - Y: '+yPosition/0.8+'cm';
    }
  
    }
  
}