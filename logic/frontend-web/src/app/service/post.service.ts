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

//todo: #5 Bestehende Posts werden durch getPosts() abgerufen und angezeigt, wenn .html eingebunden ist. Aber noch keine Optionen einer Wette (Details)
  getPosts(): PostModel[] {
    this.posts = [];
    this.getAllPosts().subscribe(ids => {
      console.log(ids)
      console.log("req all")
      ids.forEach((id: number) => {
        this.getPostById(id).subscribe(post => {
          console.log("req one")
          this.posts.push(post);
        });
      });
    });
    return this.posts;
  }
}
