import {ApiResponse} from "./api.response";
import {User} from "../models/user";

export interface ApiUserResponse extends ApiResponse {
  'hydra:member': User[]
}
