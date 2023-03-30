import {ApiResponse} from "./api.response";
import {Post} from "../models/post";

export interface ApiPostResponse extends ApiResponse {
  'hydra:member': Post[]
}
