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

  posts:Array<any>
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

  getIdsFromAPI() {
    this.getIds().subscribe((posts) => {
      console.log(posts)

    })
  }

  /*
  public getIds(): Observable<number[]> {
    console.log(this.http.get(this._urlPostIds).pipe());
    return this.http.get<number[]>(this._urlPostIds);
  }
  public getPost(_id:number):Observable<PostModel[]> {
    console.log(this.http.get<PostModel[]>(`${this._urlPost}${_id}`));
    return this.http.get<PostModel[]>(`${this._urlPost}${_id}`);
  }
*/

}
