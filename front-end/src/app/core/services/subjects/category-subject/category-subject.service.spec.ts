import { TestBed } from '@angular/core/testing';

import { CategorySubjectService } from './category-subject.service';

describe('CategorySubjectService', () => {
  let service: CategorySubjectService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CategorySubjectService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
