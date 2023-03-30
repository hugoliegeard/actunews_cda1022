import {ApiResponse} from "../api/api.response";

export interface Comment {
  "@id"?: string;
  content?: string;
  post?: string;
  user?: string;
  likes?: string[];
  createdAt?: Date;
  updatedAt?: Date;
  deletedAt?: Date;
  readonly deleted?: boolean;
}
