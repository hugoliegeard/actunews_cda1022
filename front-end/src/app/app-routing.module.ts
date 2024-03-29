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
    path: ':slug',
    component: CategoryComponent,
  },
  {
    // http://localhost:4200/category/politique
    path: 'category/:slug',
    redirectTo: '/:slug',
    pathMatch: 'full'
  },
  {
    // http://localhost:4200/politique/slug-de-mon-article
    path: ':category/:slug',
    component: PostComponent,
  },
  {
    path: '**',
    redirectTo: '/',
    pathMatch: 'full'
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
