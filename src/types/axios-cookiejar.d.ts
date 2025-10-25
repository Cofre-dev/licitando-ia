import 'axios';
import { CookieJar } from 'tough-cookie';

declare module 'axios' {
  // habilita `jar` en la config de requests y en create()
  interface AxiosRequestConfig {
    jar?: CookieJar;
  }
}
