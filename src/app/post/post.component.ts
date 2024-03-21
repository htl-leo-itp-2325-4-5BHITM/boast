import {Component} from '@angular/core';
import {PostModel, PostService} from "../service/post.service";
import {NgFor, NgForOf} from "@angular/common";
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

  constructor(public postservice: PostService) {
    this._posts = postservice.getPosts();
  }


  get posts(): PostModel[] {
    return this._posts;
  }
}
