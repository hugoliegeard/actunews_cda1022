import {ApiResponse} from "../api/api.response";
import {Category} from "./category";
import {Comment} from "./comment";
import {User} from "./user";

export interface Post {
  "@id"?: string;
  readonly title: string;
  readonly slug?: string;
  readonly content: string;
  readonly image: string;
  readonly author: User;
  readonly active?: boolean;
  readonly category: Category;
  readonly comments?: Comment[];
  readonly createdAt?: Date;
  readonly updatedAt?: Date;
  readonly deleted?: boolean;
}
