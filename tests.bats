setup() {
    load 'node_modules/bats-support/load'
    load 'node_modules/bats-assert/load'
}

@test "tos accepted - validation succeeded" {
    run act issues -e test/issues/tos_accepted.json \
        --container-architecture linux/amd64

    assert_line '[TOS Check/tos-accepted                        ]   ✅  Success - Main Render template'
    assert_line '[validate/Extension validation/parse-issue]   ✅  Success - Main Find extension repository'
    assert_line '[validate/Extension validation/validation-succeeded]   ✅  Success - Main Render template'
    assert_line '[validate/Extension validation/validation-succeeded] 🏁  Job succeeded'
    refute_line --partial 'validation-failed'
    refute_line --partial 'validation-error'
    assert_success
}

@test "tos accepted - validation failed" {
    run act issues -e test/issues/tos_accepted.json \
        --env TEST_VALIDATION_FAILED=true \
        --container-architecture linux/amd64

    assert_line '[TOS Check/tos-accepted                        ]   ✅  Success - Main Render template'
    assert_line '[validate/Extension validation/validation-failed   ]   ✅  Success - Main Render template'
    assert_line '[validate/Extension validation/validation-failed   ]   ❌  Failure - Main Mark job as failed'
    refute_line --partial 'validation-succeeded'
    refute_line --partial 'validation-error'
    assert_failure
}

@test "tos accepted - validation errored" {
    run act issues -e test/issues/tos_accepted.json \
        --env TEST_VALIDATION_ERRORED=true \
        --container-architecture linux/amd64

    assert_line '[validate/Extension validation/validation-errored  ]   ✅  Success - Main Render template'
    assert_line '[validate/Extension validation/validation-errored  ]   ❌  Failure - Main Mark job as failed'
    refute_line --partial 'validation-succeeded'
    refute_line --partial 'validation-failed'
    assert_failure
}

@test "tos not accepted - no validation" {
    run act issues -e test/issues/tos_not_accepted.json \
        --container-architecture linux/amd64

    assert_line '[TOS Check/tos-not-accepted                    ]   ✅  Success - Main Render template'
    assert_line '[TOS Check/tos-not-accepted                    ] 🏁  Job succeeded'
    assert_success
}

@test "tos missing - no validation" {
    run act issues -e test/issues/no_tos.json \
        --container-architecture linux/amd64

    assert_line '[TOS Check/Ensure Terms of Service are accepted]   ❌  Failure - Main Validate tos'
    assert_line '[TOS Check/tos-not-found                       ]   ❌  Failure - Main Mark job as failed'
    assert_failure
}

@test "tos accepted - no repository - no validation" {
    run act issues -e test/issues/no_repository.json \
        --container-architecture linux/amd64

    assert_line '[validate/Extension validation/parse-issue]   ❌  Failure - Main Validate repository'
    assert_line '[validate/Extension validation/error             ]   ❌  Failure - Main Mark job as failed'
    assert_failure
}

@test "/validate - validate succeeded" {
    run act issue_comment -e test/issue_comment/with_command.json \
        --container-architecture linux/amd64

    assert_line '[TOS Check/Ensure Terms of Service are accepted]   ✅  Success - Main Run /validate command'
    assert_line '[validate/Extension validation/validation-succeeded] 🏁  Job succeeded'
    refute_line --partial 'validation-failed'
    refute_line --partial 'validation-error'
    assert_success
}

@test "/validate on a closed issue - no tos check - no validation" {
    run act issue_comment -e test/issue_comment/with_command_on_closed_issue.json \
        --container-architecture linux/amd64

    refute_output
    assert_success
}