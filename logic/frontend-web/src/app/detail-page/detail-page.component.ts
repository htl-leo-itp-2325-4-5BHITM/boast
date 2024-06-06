import {Component, Input} from '@angular/core';
import {NavbarComponent} from "../navbar/navbar.component";
import {ActivatedRoute, Router, RouterOutlet} from "@angular/router";
import {PostModel, PostService} from "../services/post.service";
import {NgForOf, NgIf, NgOptimizedImage, NgStyle} from "@angular/common";
import {RequestService} from "../services/request.service";
import {FormsModule} from "@angular/forms";

@Component({
  selector: 'app-detail-page',
  standalone: true,
  imports: [
    NavbarComponent,
    RouterOutlet,
    NgForOf,
    NgOptimizedImage,
    NgStyle,
    NgIf,
    FormsModule
  ],
  templateUrl: './detail-page.component.html',
  styleUrl: './detail-page.component.css'
})
export class DetailPageComponent {

  userTextAnswer: String = '';

  post: PostModel = {} as PostModel;
  showTextField: boolean = false;
  showErrorNoValidInput: boolean = false;

  constructor(private router: Router,
              private route: ActivatedRoute,
              private requestService: RequestService,
              private postService: PostService) {
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
    if (sessionStorage.getItem('userId') !== null) {
      this.showTextField = !this.showTextField;
    } else {
      this.router.navigateByUrl("login");
    }
  }

  ignorePost() {
    this.router.navigate(['/posts']);
  }

  submitAnswer() {
    if (sessionStorage.getItem('userId') !== null && sessionStorage.getItem('userName') !== null && this.userTextAnswer !== '') {
      this.showErrorNoValidInput = false;
      //userId: number, postId: number, userName: String, answer: String
      this.postService.createNewTextAnswer(
        // @ts-ignore
        sessionStorage.getItem('userId'),
        this.post.postId,
        this.userTextAnswer)
    } else {
      this.showErrorNoValidInput = true;
    }
  }
}
