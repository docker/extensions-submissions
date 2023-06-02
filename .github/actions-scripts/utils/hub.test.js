import { getRepoFromHubURL } from './hub';

describe('hub utils', () => {
   it('should find the repository name from a hub url', () => {
      const url = new URL('https://hub.docker.com/r/username/repository');
      const name = getRepoFromHubURL(url);
      expect(name).toBe('username/repository');
   });

   it('should throw if the URL is not a repository url', () => {
      const url = new URL('https://hub.docker.com/invalid-url');
      expect(() => getRepoFromHubURL(url)).toThrow();
   });

   it('should throw if the URL is not from Docker Hub', () => {
      const url = new URL('https://hub.elsewhere.com/r/username/repository');
      expect(() => getRepoFromHubURL(url)).toThrow();
   });
});