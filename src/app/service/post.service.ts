import {Injectable} from '@angular/core';
import {Observable} from "rxjs";
import {HttpClient} from '@angular/common/http';

export interface PostModel {
  id: number,
  creatorName: string,
  status: string,
  createdOn: string,
  title: string,
  definition: string;
  postDetails:Array<PostDetailModel>;
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

@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private http: HttpClient) {
  }

  posts: PostModel[] = [];


  getAllPosts(): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/');
  }

  getPostById(id: number): Observable<any> {
    return this.http.get<any>('https://www.boast.social/api/posts/' + id);
  }

  getPosts(): PostModel[] {
    this.posts = [];
    this.getAllPosts().subscribe(ids => {
      ids.forEach((id: number) => {
        this.getPostById(id).subscribe(post => {
          this.posts.push(post);
        });
      });
    });
    return this.posts;
  }
}
