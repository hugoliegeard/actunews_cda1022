import {Component, OnInit} from '@angular/core';
import {Post} from "../../shared/interfaces/models/post";
import {PostService} from "../http/post/post.service";

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.css']
})
export class SidebarComponent implements OnInit {

  posts: Post[] = [];

  constructor(private postService: PostService) {
  }

  ngOnInit(): void {
    this.postService.getPosts().subscribe(apiPostResponse => {
      this.posts = apiPostResponse["hydra:member"];
    });
  }
}
