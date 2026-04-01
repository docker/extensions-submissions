
/**
 * Extract the repository name from a Docker Hub URL.
 * If the URL is not from Docker Hub it throws an error.
 *
 * @param url URL
 * @return string
 */
export function getRepoFromHubURL(url) {
    if (url.host !== "hub.docker.com") {
        throw new Error("URL must be from hub.docker.com domain");
    }

    const match = url.pathname.match(/^\/r\/([^/]+\/[^/]+)\/?$/);
    if (!match) {
        throw new Error("URL must be a repository URL from Docker Hub (e.g., https://hub.docker.com/r/namespace/repo)");
    }

    return match[1];
}