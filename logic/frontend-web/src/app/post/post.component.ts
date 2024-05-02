import {Component, Input} from '@angular/core';
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

  private _posts: PostModel[] = [];
  private _id: number = 0;
  @Input() modifier: string = '';

  constructor(public postService: PostService) {
  }

  ngOnInit(): void {
    this._id = Number(sessionStorage.getItem('userId'));

    if(this.modifier == 'own') {
      this._posts = this.postService.getPostsOfUser(this._id);
    } else if(this.modifier == 'friends') {
      this._posts = this.postService.getPostsOfFriends(this._id);
    } else {
      this._posts = this.postService.getPosts();
    }
  }

  get posts(): PostModel[] {
    return this._posts;
  }
}
