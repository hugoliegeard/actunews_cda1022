import {Component, OnInit} from '@angular/core';
import {CategorySubjectService} from "../services/subjects/category-subject/category-subject.service";
import {Observable} from "rxjs";
import {Category} from "../../shared/interfaces/models/category";

@Component({
  selector: 'app-footer',
  templateUrl: './footer.component.html',
  styleUrls: ['./footer.component.css']
})
export class FooterComponent implements OnInit {

  categories$: Observable<Category[]>;

  constructor(private categorySubjectService: CategorySubjectService) {
  }

  ngOnInit(): void {
    this.categories$ = this.categorySubjectService.categories;
  }
}
