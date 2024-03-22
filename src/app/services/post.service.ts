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

  posts: PostModel[] = [];

  constructor(private requestService:RequestService) {
  }

  getPosts(): PostModel[] {
    this.posts = [];
    this.requestService.getAllPosts().subscribe(ids => {
      ids.forEach((id: number) => {
        this.requestService.getPostById(id).subscribe(post => {
          this.posts.push(post);
          console.log(post.typeInfo.title);
        });
      });
    });
    return this.posts;
  }
}
