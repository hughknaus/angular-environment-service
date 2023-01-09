// default environment

import { IEnvironment } from '../environment-interface';

export const environment: IEnvironment = {
  production: false,
  apiUrl: window['environment']?.apiUrl ?? 'http://lastresort.api.url',
};
