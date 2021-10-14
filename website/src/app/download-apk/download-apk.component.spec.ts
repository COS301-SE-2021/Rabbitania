import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DownloadApkComponent } from './download-apk.component';

describe('DownloadApkComponent', () => {
  let component: DownloadApkComponent;
  let fixture: ComponentFixture<DownloadApkComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DownloadApkComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DownloadApkComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
