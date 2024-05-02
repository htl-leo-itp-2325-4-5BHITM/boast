import { Component } from '@angular/core';
import {PostComponent} from "../post/post.component";
import {NavbarComponent} from "../navbar/navbar.component";
import {Router} from "@angular/router";

@Component({
  selector: 'app-posts-page',
  standalone: true,
  imports: [
    PostComponent,
    NavbarComponent
  ],
  templateUrl: './posts-page.component.html',
  styleUrl: './posts-page.component.css'
})
export class PostsPageComponent {

  forYou: String = 'underline';
  friends: String = 'none';
  friendsPosts: String = 'none';
  allPosts: String = 'block';

  constructor(private router: Router) {
  }

  listing(list: string) {
    if(list == 'forYou') {
      this.forYou = 'underline';
      this.friends = 'none';
      this.allPosts = 'block';
      this.friendsPosts = 'none';
    } else {
      this.isLoggedIn();
      this.forYou = 'none';
      this.friends = 'underline';
      this.allPosts = 'none';
      this.friendsPosts = 'block';
    }
  }

  isLoggedIn() {
    if(sessionStorage.getItem('userId') == null && sessionStorage.getItem('userName') == null) {
      this.router.navigateByUrl("login");
    }
  }
}
