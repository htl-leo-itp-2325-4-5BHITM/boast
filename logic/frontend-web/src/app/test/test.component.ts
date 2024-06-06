import {Component} from '@angular/core';
import {NgIf, NgStyle} from "@angular/common";
import {NavbarComponent} from "../navbar/navbar.component";
import {ActivatedRoute, Router, RouterOutlet} from "@angular/router";
import {PostModel, PostService} from "../services/post.service";

@Component({
  selector: 'app-test',
  standalone: true,
  imports: [
    NgStyle,
    NavbarComponent,
    RouterOutlet,
    NgIf
  ],
  templateUrl: './test.component.html',
  styleUrl: './test.component.css'
})
export class TestComponent {

  post: PostModel = {} as PostModel;
  showTextField = false;

  constructor(private router: Router, private route: ActivatedRoute, private postService: PostService) {
  }

  ngOnInit(): void {
    const postId: number = parseInt(<string>this.route.snapshot.paramMap.get('id'));
    this.post = this.postService.getSinglePost(postId);
  }

  joinPost() {
    console.log("Joined post")
    this.showTextField = !this.showTextField;
  }

  ignorePost() {
    this.router.navigate(['/posts']);
  }


}
