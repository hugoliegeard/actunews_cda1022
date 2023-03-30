import { Injectable } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import { environment } from '../../../../environments/environment';
import {ApiCategoryResponse} from "../../../shared/interfaces/api/api.category.response";
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http: HttpClient) { }

  /**
   * Permet de retourner les catégories de l'API
   */
  getCategories(): Observable<ApiCategoryResponse> {
    return this.http.get<ApiCategoryResponse>(environment.apiEndpoint + '/api/categories');
  }

}
