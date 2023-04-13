import {Component, OnInit} from '@angular/core';
import {PostService} from "../../../core/http/post/post.service";
import {Post} from "../../../shared/interfaces/models/post";
import {OwlOptions} from "ngx-owl-carousel-o";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  posts: Post[] = [];
  featuredPosts: Post[] = [];

  customOptions: OwlOptions = {
    loop: true,
    nav: false,
    items: 1,
    mouseDrag: true,
    navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"]
  }

  constructor(private postService: PostService) {
  }

  ngOnInit(): void {
    this.postService.getPosts().subscribe(apiPostResponse => {

      /**
       * On met en avant les 2 premiers articles de l'API.
       * Le reste s'affichera normalement.
       * TODO : Mettre en place une option featured sur l'API
       */
      this.posts = apiPostResponse["hydra:member"];
      this.featuredPosts = this.posts.splice(0,2);

      //console.log(this.posts);
      //console.log(this.featuredPosts);
    });
  }
}
