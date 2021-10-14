import { TestBed } from '@angular/core/testing';

import { IsemployeeGuardGuard } from './isemployee-guard.guard';

describe('IsemployeeGuardGuard', () => {
  let guard: IsemployeeGuardGuard;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    guard = TestBed.inject(IsemployeeGuardGuard);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });
});
