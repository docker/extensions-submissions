import {sanitize} from "./repository.js";

describe('repository utils', () => {
    it('should sanitize a repository name', () => {
        expect(sanitize('docker/disk-usage-extension')).toBe('docker/disk-usage-extension');
        expect(sanitize('docker/disk-usage-extension:0.0.0')).toBe('docker/disk-usage-extension');
    });

    it('should throw when sanitizing an invalid repository name', () => {
        expect(() => sanitize('invalid repository name')).toThrow();
        expect(() => sanitize('invalid/repository/name')).toThrow();
    });

    it('should accept valid names with hyphens, underscores and dots', () => {
        expect(sanitize('my-namespace/my_repo')).toBe('my-namespace/my_repo');
        expect(sanitize('my_namespace/my-repo.name')).toBe('my_namespace/my-repo.name');
    });

    it('should match canonical Docker Hub naming rules', () => {
        // Dots in namespace (canonical allows)
        expect(sanitize('ns.test/repo')).toBe('ns.test/repo');
        // Consecutive hyphens (valid separator)
        expect(sanitize('ns/repo--name')).toBe('ns/repo--name');
        // Double underscore (valid separator)
        expect(sanitize('ns/repo__name')).toBe('ns/repo__name');
        // Single char components
        expect(sanitize('a/b')).toBe('a/b');
    });

    it('should reject names that violate canonical Docker rules', () => {
        // Trailing separators
        expect(() => sanitize('ns-/repo')).toThrow();
        expect(() => sanitize('ns/repo-')).toThrow();
        expect(() => sanitize('ns/repo.')).toThrow();
        expect(() => sanitize('ns/repo_')).toThrow();
        // Triple underscore (not a valid separator — only _ or __)
        expect(() => sanitize('ns/repo___name')).toThrow();
        // Consecutive dots (not a valid separator)
        expect(() => sanitize('ns/repo..name')).toThrow();
        // Exceeds max length (255)
        expect(() => sanitize('a'.repeat(128) + '/' + 'b'.repeat(128))).toThrow();
    });

    it('should reject shell metacharacters in namespace or repository name', () => {
        expect(() => sanitize('ns$(cmd)/repo')).toThrow();
        expect(() => sanitize('ns/repo;malicious')).toThrow();
        expect(() => sanitize('ns/repo&&cmd')).toThrow();
        expect(() => sanitize('ns/repo|cmd')).toThrow();
        expect(() => sanitize('--flag/repo')).toThrow();
        expect(() => sanitize('-invalid/repo')).toThrow();
        expect(() => sanitize('_invalid/repo')).toThrow();
        expect(() => sanitize('ns/repo`cmd`')).toThrow();
        expect(() => sanitize('ns/UPPERCASE')).toThrow();
    });
});