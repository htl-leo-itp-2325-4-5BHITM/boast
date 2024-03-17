import { Component } from '@angular/core';
import {PostService} from "../service/post.service";

@Component({
  selector: 'app-log-in-page',
  standalone: true,
  imports: [],
  templateUrl: './log-in-page.component.html',
  styleUrl: './log-in-page.component.css'
})
export class LogInPageComponent {

  constructor(protected postServic: PostService) {
  }
}
