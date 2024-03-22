import {Component} from '@angular/core';
import {PostModel, PostService} from "../services/post.service";
import {NgForOf} from "@angular/common";
import {NavbarComponent} from "../navbar/navbar.component";

@Component({
  selector: 'app-post',
  standalone: true,
  imports: [
    NgForOf,
    NavbarComponent
  ],
  templateUrl: './post.component.html',
  styleUrl: './post.component.css'
})
export class PostComponent {

  private _posts: PostModel[]

  constructor(public postService: PostService) {
    this._posts = postService.getPosts();
    console.log(this._posts)
    console.log(sessionStorage)
  }

  get posts(): PostModel[] {
    return this._posts;
  }
}
