/**
 * Returns the namespace/repository (e.g. docker/disk-usage-extension) from a
 * repository string.
 *
 * @param repository string
 * @returns string
 */
export function sanitize(repository) {
    if (repository.indexOf(' ') !== -1) {
        throw `Invalid repository name "${repository}"`;
    }

    const parts = repository.split('/');
    if (parts.length !== 2) {
        throw `Invalid repository name "${repository}"`;
    }

    const [name, _] = parts[1].split(':');

    return `${parts[0]}/${name}`;
}