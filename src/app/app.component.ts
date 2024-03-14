import {Component, OnInit, Output} from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {NavbarComponent} from "./navbar/navbar.component";
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostModel, PostService} from "./service/post.service";
import {Observable} from "rxjs";
import {HttpClient, HttpClientModule, HttpHandler} from "@angular/common/http";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent, LogInPageComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
  providers: [PostService]
})
export class AppComponent implements OnInit{
  title = 'Webpage';

  //Service function tests
  postIds: Observable<number[]> | undefined;
  post: Observable<PostModel[]> | undefined;

constructor(private postService:PostService) {
    /*
    this.postIds = postService.getIds();
    this.post = postService.getPost(1);

    console.log(this.postIds);
    console.log(this.post);
*/
}
  ngOnInit() {
    this.post = this.postService.getPost(1);
    this.postIds = this.postService.getIds();
  }
}
