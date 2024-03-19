import {Injectable} from '@angular/core';
import {Observable} from "rxjs";
import {HttpClient} from '@angular/common/http';


//todo: den get request umwandeln in ein PostModel, damit das weitergeleitet werden kann und angezeigt werden kann.
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

  posts:PostModel [];
  ids:Array<any>

  constructor(private http: HttpClient) {
    this.posts = new Array<any>();
    this.ids = new Array<any>();
  }

  getIds(): Observable<any> {
    const url = 'https://www.boast.social/api/posts/';
    return this.http.get<any>(url)
  }

  getPost(id: number): Observable<any> {
    const url = 'https://www.boast.social/api/posts/' + id;
    return this.http.get<any>(url)
  }

  getPosts() {
    this.getIds().subscribe((ids) => {
      this.ids = ids;

      let createdPost:PostModel;
      for(let i = 0; i < this.ids.length; i++) {
        this.getPost(i+1).subscribe((post) => {
          let createdPost: PostModel = {
            creatorName: post.creatorName,
            id: post.id,
            status: post.status,
            createdOn: post.createdOn,
            title: post.title,
            definition: post.definition
          };
          this.posts[i] = createdPost;
        })
      }

    })
    console.log(this.posts);
    return this.posts;
  }
}
