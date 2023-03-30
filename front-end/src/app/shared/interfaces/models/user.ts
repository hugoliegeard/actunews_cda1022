import {ApiResponse} from "../api/api.response";

export interface User {
  "@id"?: string;
  email: string;
  roles?: any;
  password: string;
  firstname: string;
  lastname: string;
  posts?: string[];
  comments?: string[];
  commentLike?: string;
  createdAt?: Date;
  updatedAt?: Date;
  deletedAt?: Date;
  readonly userIdentifier?: string;
  readonly fullname?: string;
  readonly deleted?: boolean;
}
