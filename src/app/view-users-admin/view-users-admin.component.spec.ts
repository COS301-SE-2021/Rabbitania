import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewUsersAdminComponent } from './view-users-admin.component';

describe('ViewUsersAdminComponent', () => {
  let component: ViewUsersAdminComponent;
  let fixture: ComponentFixture<ViewUsersAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ViewUsersAdminComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ViewUsersAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
