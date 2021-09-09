import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AiPlannerComponent } from './ai-planner.component';

describe('AiPlannerComponent', () => {
  let component: AiPlannerComponent;
  let fixture: ComponentFixture<AiPlannerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AiPlannerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AiPlannerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
