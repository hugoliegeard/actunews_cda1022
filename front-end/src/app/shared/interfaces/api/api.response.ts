export interface ApiResponse {
  'hydra:member': any
  'hydra:totalItems': number,
  'hydra:view': {
    'hydra:first': string,
    'hydra:last': string,
    'hydra:next': string,
  },
}
