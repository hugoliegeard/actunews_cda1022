import {Component, OnInit} from '@angular/core';
import {Post} from "../../../shared/interfaces/models/post";
import {PostService} from "../../../core/http/post/post.service";
import {ActivatedRoute} from "@angular/router";

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css']
})
export class PostComponent implements OnInit {

  post: Post;

  constructor(private postService: PostService,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit(): void {
    // Récupération du paramètre dans la route
    //const slug = this.activatedRoute.snapshot.params['slug'];
    this.activatedRoute.params.subscribe(params => {
      // Récupération des articles de la catégorie dans l'API
      this.postService.getPostBySlug(params['slug']).subscribe(apiPostResponse => {
        // Affectation des articles de l'API vers Angular
        this.post = apiPostResponse["hydra:member"][0];
      });
    });
  }
}
