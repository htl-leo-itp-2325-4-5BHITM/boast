import { Component } from '@angular/core';
import {NavbarComponent} from "../navbar/navbar.component";
import {PostComponent} from "../post/post.component";
import {ProfileModel, UserService} from "../services/user.service";
import {UserComponent} from "../user/user.component";

@Component({
  selector: 'app-profile-page',
  standalone: true,
  imports: [
    NavbarComponent,
    PostComponent,
    UserComponent
  ],
  templateUrl: './profile-page.component.html',
  styleUrl: './profile-page.component.css'
})
export class ProfilePageComponent {
  following: String = 'following';
  follower: String = 'follower';
  posts: String = 'posts';
  userId: number = 0;
  username: String = '';
  postsD: String = 'block';
  followingD: String = 'none';
  followerD: String = 'none';

  constructor(public userService: UserService) {
    this.username = String(sessionStorage.getItem('userName'));
    this.userId = Number(sessionStorage.getItem('userId'));
  }

  listing(list: string) {
    if(list == 'following') {
      this.following = 'underline';
      this.follower = 'none';
      this.posts = 'none';
      this.followingD = 'block';
      this.followerD = 'none';
      this.postsD = 'none';
    } else if(list == 'follower') {
      this.following = 'none';
      this.follower = 'underline';
      this.posts = 'none';
      this.followingD = 'none';
      this.followerD = 'block';
      this.postsD = 'none';
    } else {
      this.following = 'none';
      this.follower = 'none';
      this.posts = 'underline';
      this.followingD = 'none';
      this.followerD = 'none';
      this.postsD = 'block';
    }
  }
}
