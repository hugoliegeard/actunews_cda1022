import {ApiResponse} from "./api.response";

export interface ApiCommentResponse extends ApiResponse {
  'hydra:member': Comment[]
}
