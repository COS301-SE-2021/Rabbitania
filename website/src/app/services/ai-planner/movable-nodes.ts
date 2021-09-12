import { CdkDragEnd, CdkDragMove, CdkDragStart } from "@angular/cdk/drag-drop";

export class MovableNodes {

    private _state: string;
    private _position: string;
    private _deskNumber: number;
    private _savedX: number;
    private _savedY: number;
    private _userEmail: string;
    private _active: boolean;
    private _newPosx: number;
  public get newPosx(): number {
    return this._newPosx;
  }
  public set newPosx(value: number) {
    this._newPosx = value;
  }
    private _newPosy: number;
  public get newPosy(): number {
    return this._newPosy;
  }
  public set newPosy(value: number) {
    this._newPosy = value;
  }

    constructor(deskNumber: number, x: number, y: number, userEmail: string, active: boolean) 
    {
      this._state = "";
      this._position = "";
      this._deskNumber = deskNumber;
      this._savedX = x;
      this._savedY = y;
      this._userEmail = userEmail;
      this._active = active;
      this._newPosx = x;
      this._newPosy = y;

    }

    public get active(): boolean {
      return this._active;
    }
    public set active(value: boolean) {
      this._active = value;
    }
    
    public get userEmail(): string {
      return this._userEmail;
    }
    public set userEmail(value: string) {
      this._userEmail = value;
    }

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
      
      var pixelCorrection = 1.5999;
      var xPosition =event.source.getFreeDragPosition().x + pixelCorrection;
      var yPosition =event.source.getFreeDragPosition().y + pixelCorrection;
      var screenHeight = window.innerHeight;
      var screenWidth = window.innerWidth;

    if(screenWidth >= 1700)
    {
      this.position = 'Position X: '+xPosition/4+'cm - Y: '+yPosition/4+'cm';
      this._newPosx = this._savedX/4 + xPosition/4;
      this._newPosy= this._savedY/4 + yPosition/4;
    }
    else if(screenWidth >= 1100)
    {
      this.position = 'Position X: '+xPosition/2.5+'cm - Y: '+yPosition/2.5+'cm';
      this._newPosx = this._savedX + xPosition/2.5;
      this._newPosy= this._savedY + yPosition/2.5;
    }
    else if(screenWidth >= 820)
    {
      this.position = 'Position X: '+xPosition/2+'cm - Y: '+yPosition/2+'cm';
      this._newPosx = this._savedX + xPosition/2;
      this._newPosy= this._savedY + yPosition/2;
    }
    else if(screenWidth >= 720)
    {
      this.position = 'Position X: '+xPosition/1.6+'cm - Y: '+yPosition/1.6+'cm';
      this._newPosx = this._savedX + xPosition/1.6;
      this._newPosy= this._savedY + yPosition/1.6;
    }
    else if(screenWidth >= 540)
    {
      this.position = 'Position X: '+xPosition/1.0+'cm - Y: '+yPosition/1.0+'cm';
      this._newPosx = this._savedX + xPosition/1.0;
      this._newPosy= this._savedY + yPosition/1.0;
    }
    else
    { 
      this.position = 'Position X: '+xPosition/0.8+'cm - Y: '+yPosition/0.8+'cm';
      this._newPosx = this._savedX + xPosition/0.8;
      this._newPosy= this._savedY + yPosition/0.8;
    }
  
    }
  
}