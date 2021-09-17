import { TestBed } from '@angular/core/testing';

import { PlannerIsadminGuard } from './planner-isadmin.guard';

describe('PlannerIsadminGuard', () => {
  let guard: PlannerIsadminGuard;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    guard = TestBed.inject(PlannerIsadminGuard);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });
});
