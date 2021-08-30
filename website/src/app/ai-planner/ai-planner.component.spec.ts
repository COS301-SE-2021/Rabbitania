import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AIPlannerComponent } from './ai-planner.component';

describe('AIPlannerComponent', () => {
  let component: AIPlannerComponent;
  let fixture: ComponentFixture<AIPlannerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AIPlannerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AIPlannerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
