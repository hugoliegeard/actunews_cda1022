import {Component, OnInit} from '@angular/core';
import {CategoryService} from "../http/category/category.service";
import {Category} from "../../shared/interfaces/models/category";
import {CategorySubjectService} from "../services/subjects/category-subject/category-subject.service";

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  categories: Category[] = [];

  constructor(private categoryService: CategoryService,
              private categorySubjectService: CategorySubjectService) {
  }

  ngOnInit(): void {
    this.categoryService.getCategories().subscribe(apiCategoryResponse => {
      this.categories = apiCategoryResponse["hydra:member"];
      this.categorySubjectService.updateCategories(this.categories);
    });
  }

}
