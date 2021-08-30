import { Component, OnInit } from '@angular/core';
import {CdkDragEnd, CdkDragMove, CdkDragStart, DragDropModule} from '@angular/cdk/drag-drop';

@Component({
  selector: 'app-ai-planner',
  templateUrl: './ai-planner.component.html',
  styleUrls: ['./ai-planner.component.scss']
})
export class AIPlannerComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
    console.log("Starting");
  }

  state = '';
  position = '';
  

  dragStarted(event: CdkDragStart) {
    this.state = 'dragStarted';
  }

  dragEnded(event: CdkDragEnd) {
    this.state = 'dragEnded';
  }

  dragMoved(event: CdkDragMove, x: any, y: any) {
    
    this.position = `> Position X: ${event.pointerPosition.x-x} - Y: ${event.pointerPosition.y-y}`;
  }

}
