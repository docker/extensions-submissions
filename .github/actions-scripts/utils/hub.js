
/**
 * Extract the repository name from a Docker Hub URL.
 * If the URL is not from Docker Hub it throws an error.
 *
 * @param url URL
 * @return string
 */
export function getRepoFromHubURL(url) {
    if (url.host !== "hub.docker.com") {
        throw "URL must be from hub.docker.com domain";
    }

    if (url.pathname.indexOf('/r/') === -1) {
        throw "URL must be a repository URL from Docker Hub";
    }

    return url.pathname.replace('/r/', '');
}