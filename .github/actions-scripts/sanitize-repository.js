import {setFailed, setOutput} from '@actions/core';
import { getRepoFromHubURL } from './utils/hub.js';
import { sanitize } from './utils/repository.js';

function run() {
    let { REPOSITORY: repository } = process.env
    if (!repository) throw new Error('REPOSITORY env var is not set')

    if (repository.includes('http')) {
        try {
            // When parsed the url will be like <https://hub.docker.com>
            const url = new URL(repository.replace(/[<>]/g, ''));
            repository = getRepoFromHubURL(url);
        } catch (e) {
            setFailed(e);

            return;
        }
    }

    try {
        repository = sanitize(repository)
    } catch (e) {
        setFailed(e);

        return;
    }

    setOutput('repository', repository);
}

run();

