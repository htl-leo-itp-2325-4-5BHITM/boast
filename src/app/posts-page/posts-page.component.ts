import { Component } from '@angular/core';
import {PostComponent} from "../post/post.component";
import {NavbarComponent} from "../navbar/navbar.component";

@Component({
  selector: 'app-posts-page',
  standalone: true,
  imports: [
    PostComponent,
    NavbarComponent
  ],
  templateUrl: './posts-page.component.html',
  styleUrl: './posts-page.component.css'
})
export class PostsPageComponent {

}
