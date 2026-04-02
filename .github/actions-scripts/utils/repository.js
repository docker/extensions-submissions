/**
 * Returns the namespace/repository (e.g. docker/disk-usage-extension) from a
 * repository string.
 *
 * @param repository string
 * @returns string
 */
// Canonical Docker image path-component from distribution/reference:
//   [a-z0-9]+(?:(?:[._]|__|-+)[a-z0-9]+)*
// Separators ([._], __, -+) must sit between alphanumeric runs.
// See: https://github.com/distribution/reference/blob/main/regexp.go
const PATH_COMPONENT = '[a-z0-9]+(?:(?:[._]|__|-+)[a-z0-9]+)*';
const VALID_REPOSITORY_RE = new RegExp(`^${PATH_COMPONENT}/${PATH_COMPONENT}$`);
const MAX_NAME_LENGTH = 255;

export function sanitize(repository) {
    if (repository.indexOf(' ') !== -1) {
        throw new Error(`Invalid repository name "${repository}"`);
    }

    if (repository.length > MAX_NAME_LENGTH) {
        throw new Error(`Invalid repository name "${repository}"`);
    }

    const parts = repository.split('/');
    if (parts.length !== 2) {
        throw new Error(`Invalid repository name "${repository}"`);
    }

    const [name, _] = parts[1].split(':');

    const result = `${parts[0]}/${name}`;

    if (!VALID_REPOSITORY_RE.test(result)) {
        throw new Error(`Invalid repository name "${repository}"`);
    }

    return result;
}