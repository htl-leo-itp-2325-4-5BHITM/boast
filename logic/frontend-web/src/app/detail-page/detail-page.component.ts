import {Component} from '@angular/core';
import {NavbarComponent} from "../navbar/navbar.component";
import {ActivatedRoute, Router, RouterOutlet} from "@angular/router";
import {PostModel, PostService} from "../services/post.service";
import {NgForOf, NgIf, NgOptimizedImage, NgStyle} from "@angular/common";
import {RequestService} from "../services/request.service";

@Component({
  selector: 'app-detail-page',
  standalone: true,
    imports: [
        NavbarComponent,
        RouterOutlet,
        NgForOf,
        NgOptimizedImage,
        NgStyle,
        NgIf
    ],
  templateUrl: './detail-page.component.html',
  styleUrl: './detail-page.component.css'
})
export class DetailPageComponent {

  post: PostModel = {} as PostModel;
  showTextField = false;

  constructor(private router: Router, private route: ActivatedRoute, private requestService: RequestService) {
  }

  ngOnInit(): void {
    const postId: number = parseInt(<string>this.route.snapshot.paramMap.get('id'));
    this.requestService.getPostById(postId).subscribe(post => {
      console.log(post)
      this.post = post;
    })
  }

  joinPost() {
    console.log("Joined post")
    this.showTextField = !this.showTextField;
  }

  ignorePost() {
    this.router.navigate(['/posts']);
  }
}
