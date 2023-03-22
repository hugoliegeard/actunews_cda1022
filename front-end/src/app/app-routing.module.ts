import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {HomeComponent} from "./modules/pages/home/home.component";
import {CategoryComponent} from "./modules/pages/category/category.component";
import {PostComponent} from "./modules/pages/post/post.component";

const routes: Routes = [
  {
    // http://localhost:4200
    path: '',
    component: HomeComponent
  },
  {
    // http://localhost:4200/politique
    path: ':alias',
    component: CategoryComponent,
  },
  {
    // http://localhost:4200/category/politique
    path: 'category/:alias',
    redirectTo: '/:alias',
    pathMatch: 'full'
  },
  {
    // http://localhost:4200/politique/alias-de-mon-article
    path: ':category/:alias',
    component: PostComponent,
  },
  {
    path: '**',
    component: HomeComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
