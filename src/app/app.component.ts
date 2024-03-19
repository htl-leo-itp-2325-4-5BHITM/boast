import {Component} from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {NavbarComponent} from "./navbar/navbar.component";
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostModel, PostService} from "./service/post.service";
import {Observable} from "rxjs";
import {PostComponent} from "./post/post.component";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent, LogInPageComponent, PostComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
  providers: [PostService]
})
export class AppComponent{
  title = 'Webpage';

  postIds: Observable<number[]> | undefined;
  post: Observable<PostModel[]> | undefined;

constructor(private postService:PostService) {
}
}
