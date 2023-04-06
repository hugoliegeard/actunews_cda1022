import {Component, OnInit} from '@angular/core';
import {PostService} from "../../../core/http/post/post.service";
import {ActivatedRoute} from "@angular/router";
import {Post} from "../../../shared/interfaces/models/post";

@Component({
  selector: 'app-category',
  templateUrl: './category.component.html',
  styleUrls: ['./category.component.css']
})
export class CategoryComponent implements OnInit {

  posts: Post[] = [];

  constructor(private postService: PostService,
              private activatedRoute: ActivatedRoute) {
  }

  async ngOnInit(): Promise<void> {
    // Récupération du paramètre dans la route
    //const slug = this.activatedRoute.snapshot.params['slug'];
    this.activatedRoute.params.subscribe(params => {
      // Récupération des articles de la catégorie dans l'API
      this.postService.getPostsFromCategory(params['slug']).subscribe(apiPostResponse => {
        // Affectation des articles de l'API vers Angular
        this.posts = apiPostResponse["hydra:member"];
      });
    });
  }
}
