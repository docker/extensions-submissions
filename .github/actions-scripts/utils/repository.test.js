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
});