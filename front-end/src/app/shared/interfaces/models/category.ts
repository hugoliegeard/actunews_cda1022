import {ApiResponse} from "../api/api.response";

export interface Category {
  "@id"?: string;
  name: string;
  parent?: string;
  categories?: string[];
  posts?: string[];
  createdAt?: Date;
  updatedAt?: Date;
  deletedAt?: Date;
  readonly slug: string;
  readonly deleted?: boolean;
}
