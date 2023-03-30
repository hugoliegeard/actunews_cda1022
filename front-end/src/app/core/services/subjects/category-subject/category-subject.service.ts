import { Injectable } from '@angular/core';
import {BehaviorSubject} from "rxjs";
import {Category} from "../../../../shared/interfaces/models/category";

@Injectable({
  providedIn: 'root'
})
export class CategorySubjectService {

  private subject = new BehaviorSubject<Category[]>([]);
  categories = this.subject.asObservable();

  constructor() { }

  updateCategories(categories: Category[]): void {
    this.subject.next(categories);
  }

}
