import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AiPopupComponent } from './ai-popup.component';

describe('AiPopupComponent', () => {
  let component: AiPopupComponent;
  let fixture: ComponentFixture<AiPopupComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AiPopupComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AiPopupComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
