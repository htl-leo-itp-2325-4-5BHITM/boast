import {Component} from '@angular/core';
import {NavbarComponent} from "../navbar/navbar.component";
import {ActivatedRoute, RouterOutlet} from "@angular/router";
import {PostService} from "../services/post.service";
import {NgForOf, NgOptimizedImage, NgStyle} from "@angular/common";

@Component({
  selector: 'app-detail-page',
  standalone: true,
  imports: [
    NavbarComponent,
    RouterOutlet,
    NgForOf,
    NgOptimizedImage,
    NgStyle
  ],
  templateUrl: './detail-page.component.html',
  styleUrl: './detail-page.component.css'
})
export class DetailPageComponent {

  private _id: number = 0

  constructor(private postService: PostService, private route: ActivatedRoute) {
    this.route.params.subscribe( params => console.log(params));
  }

  ngOnInit(){

  }
}
