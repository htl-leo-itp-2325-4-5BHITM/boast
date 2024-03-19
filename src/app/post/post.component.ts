import { Component } from '@angular/core';
import {PostService} from "../service/post.service";

@Component({
  selector: 'app-post',
  standalone: true,
  imports: [],
  templateUrl: './post.component.html',
  styleUrl: './post.component.css'
})
export class PostComponent {

  constructor(public postService: PostService) {
  }
}
