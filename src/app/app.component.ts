import {Component} from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {NavbarComponent} from "./navbar/navbar.component";
import {LogInPageComponent} from "./log-in-page/log-in-page.component";
import {PostService} from "./services/post.service";
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
  title = 'Boast';

constructor(private postService:PostService) {
}
}
