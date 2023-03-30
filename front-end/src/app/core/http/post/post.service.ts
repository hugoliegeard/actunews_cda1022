import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {ApiPostResponse} from "../../../shared/interfaces/api/api.post.response";
@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private http: HttpClient) { }

  /**
   * Permet de retourner les articles de l'API
   */
  getPosts(): Observable<ApiPostResponse> {
    return this.http.get<ApiPostResponse>(environment.apiEndpoint + '/api/posts');
  }

}
