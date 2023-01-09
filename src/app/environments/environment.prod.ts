// prod environment

import { IEnvironment } from '../environment-interface';

export const environment: IEnvironment = {
  production: true,
  apiUrl: window['environment']?.apiUrl,
};
