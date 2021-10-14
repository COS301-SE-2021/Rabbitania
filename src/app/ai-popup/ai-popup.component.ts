import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-ai-popup',
  templateUrl: './ai-popup.component.html',
  styleUrls: ['./ai-popup.component.scss']
})
export class AiPopupComponent implements OnInit {

  constructor(public router: Router) { }

  ngOnInit(): void {
  }

  reload(){
    let currentUrl = this.router.url;
    this.router.navigateByUrl('/', {skipLocationChange: true}).then(() => {
        this.router.navigate([currentUrl]);
    });
  }
}
