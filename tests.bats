#!/bin/bash
setup() {
    load 'node_modules/bats-support/load'
    load 'node_modules/bats-assert/load'
}


@test "tos accepted - validation succeeded" {
    run act issues -e test/issues/tos_accepted.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN" \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check\/Post a comment to new issues[[:blank:]]*\] 🏁  Job succeeded$'
    assert_line --regexp '^\[TOS Check\/tos-accepted[[:blank:]]*\]   ✅  Success - Main Render template'
    assert_line --regexp '^\[Extension validation\/Extension validation\/parse-issue[[:blank:]]*\]   ✅  Success - Main Find extension repository$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-succeeded[[:blank:]]*\]   ✅  Success - Main Render template$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-succeeded[[:blank:]]*\] 🏁  Job succeeded$'
    refute_line --partial 'validation-failed'
    refute_line --partial 'validation-error'
    assert_success
}

@test "tos accepted - validation succeeded with URL as repository" {
    run act issues -e test/issues/repository_url.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check\/Post a comment to new issues[[:blank:]]*\] 🏁  Job succeeded$'
    assert_line --regexp '^\[TOS Check\/tos-accepted[[:blank:]]*\]   ✅  Success - Main Render template'
    assert_line --regexp '^\[Extension validation\/Extension validation\/parse-issue[[:blank:]]*\]   ✅  Success - Main Find extension repository$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/parse-issue[[:blank:]]*\]   ✅  Success - Main Validate repository$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-succeeded[[:blank:]]*\]   ✅  Success - Main Render template$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-succeeded[[:blank:]]*\] 🏁  Job succeeded$'
    refute_line --partial 'validation-failed'
    refute_line --partial 'validation-error'
    assert_success
}

@test "tos accepted - validation failed" {
    run act issues -e test/issues/tos_accepted.json \
        --env TEST_VALIDATION_FAILED=true \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check\/tos-accepted[[:blank:]]*\]   ✅  Success - Main Render template$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-failed[[:blank:]]*\]   ✅  Success - Main Render template$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-failed[[:blank:]]*\]   ❌  Failure - Main Mark job as failed$'
    refute_line --partial 'validation-succeeded'
    refute_line --partial 'validation-error'
    assert_failure
}

@test "tos accepted - validation errored" {
    run act issues -e test/issues/tos_accepted.json \
        --env TEST_VALIDATION_ERRORED=true \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-errored[[:blank:]]*\]   ✅  Success - Main Render template$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-errored[[:blank:]]*\]   ❌  Failure - Main Mark job as failed$'
    refute_line --partial 'validation-succeeded'
    refute_line --partial 'validation-failed'
    assert_failure
}

@test "tos not accepted - no validation" {
    run act issues -e test/issues/tos_not_accepted.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check\/tos-not-accepted[[:blank:]]*\]   ✅  Success - Main Render template'
    assert_line --regexp '^\[TOS Check\/tos-not-accepted[[:blank:]]*\] 🏁  Job succeeded'
    refute_line --regexp '^\[Extension validation.*'
    assert_success
}

@test "tos missing - no validation" {
    run act issues -e test/issues/no_tos.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check\/Ensure Terms of Service are accepted[[:blank:]]*\]   ❌  Failure - Main Validate tos$'
    assert_line --regexp '^\[TOS Check\/tos-not-found[[:blank:]]*\]   ❌  Failure - Main Mark job as failed'
    assert_failure
}

@test "tos accepted - no repository - no validation" {
    run act issues -e test/issues/no_repository.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[Extension validation\/Extension validation\/parse-issue[[:blank:]]*\]   ❌  Failure - Main Ensure repository is filled$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/error[[:blank:]]*\]   ❌  Failure - Main Mark job as failed$'
    assert_failure
}

@test "/validate - validate succeeded" {
    run act issue_comment -e test/issue_comment/with_command.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    assert_line --regexp '^\[TOS Check.* ✅  Success - Main Run /validate command$'
    assert_line --regexp '^\[Extension validation\/Extension validation\/validation-succeeded[[:blank:]]*\] 🏁  Job succeeded$'
    refute_line --partial 'validation-failed'
    refute_line --partial 'validation-error'
    assert_success
}

@test "/validate on a closed issue - no tos check - no validation" {
    run act issue_comment -e test/issue_comment/with_command_on_closed_issue.json \
        --container-architecture linux/amd64 \
        -s GITHUB_TOKEN="$GITHUB_TOKEN"

    refute_output
    assert_success
}

@test "comment without /validate - no validation" {
    run act issue_comment -e test/issue_comment/without_command.json \
                --container-architecture linux/amd64

    assert_line --regexp '^\[TOS Check.* ❌  Failure - Main Run /validate command$'
    assert_failure
}
