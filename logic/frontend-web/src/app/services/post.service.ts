import {Injectable} from '@angular/core';
import {RequestService} from "./request.service";


export interface PostModel {
  id: number,
  creatorName: string,
  status: string,
  createdOn: string,
  title: string,
  definition: string,
  type: string,
  postDetails:Array<PostDetailModel>,
  typeInfo:Array<PollAnswer>;
}
export interface PostDetailModel {
  createdOn: Date,
  creatorId: number,
  creatorName: string,
  postDetailsId: number,
  postId: number,
  text: string,
  poll_answerId: number;
}
export interface PollAnswer {
  poll_answerId: number,
  title: string;
}

@Injectable({
  providedIn: 'root'
})
export class PostService {

  allPosts: PostModel[] = [];
  usersPosts: PostModel[] = [];
  friendsPosts: PostModel[] = [];
  ids: number[] = [];

  constructor(private requestService:RequestService) {
  }

  getPosts(): PostModel[] {
    this.allPosts = [];
    this.requestService.getAllPosts().subscribe(ids => {
      ids.forEach((id: number) => {
        this.requestService.getPostById(id).subscribe(post => {
          this.allPosts.push(post);
        });
      });
    });
    return this.allPosts;
  }

  getPostsOfUser(id: number): PostModel[] {
    this.usersPosts = [];
    this.ids = [];
    this.requestService.getUserAndPostsById(id).subscribe(user => {
      this.ids = user.posts;

      this.ids.forEach((id: number) => {
        this.requestService.getPostById(id).subscribe(post => {
          this.usersPosts.push(post);
        });
      });
    });
    return this.usersPosts;
  }

//todo: get posts of friends muss noch gefixed werden.
  getPostsOfFriends(id: number): PostModel[] {
    this.friendsPosts = [];
    this.ids = [];
    this.requestService.getPostsOfFriends(id).subscribe(ids => {
      console.log(ids);
      //todo: ich bekomm keine ids in mein Array | das das problem
      this.ids = ids;

      this.ids.forEach((id: number) => {
        this.requestService.getPostById(id).subscribe(post => {
          this.friendsPosts.push(post);
        });
      });

    });
    return this.friendsPosts;
  }
}
