import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CovidQuestionnaireComponent } from './covid-questionnaire.component';

describe('CovidQuestionnaireComponent', () => {
  let component: CovidQuestionnaireComponent;
  let fixture: ComponentFixture<CovidQuestionnaireComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CovidQuestionnaireComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CovidQuestionnaireComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
