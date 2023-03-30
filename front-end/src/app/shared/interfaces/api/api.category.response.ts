import {ApiResponse} from "./api.response";
import {Category} from "../models/category";

export interface ApiCategoryResponse extends ApiResponse {
  'hydra:member': Category[]
}
