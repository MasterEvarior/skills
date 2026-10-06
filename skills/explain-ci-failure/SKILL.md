# Explain CI failure

Explain why a CI run failed, in plain language, pointing at the exact commit/line responsible.

For this you should:

1. Inspect the remotes with `git remote -v` to decide if this is GitHub, GitLab, or something else.
1. Identify which run to look at: if I gave you a PR/run/pipeline, use that; otherwise find the latest failing run for the current branch (e.g. `gh run list --branch <branch> --status failure` or `glab ci list`).
1. Fetch the logs for the failed job(s) only (e.g. `gh run view <id> --log-failed`, or the equivalent for GitLab), not the full log of every successful step.
1. Isolate the actual error from the noise — the stack trace, failing assertion, compiler/linter error — and ignore unrelated setup/teardown output.
1. Correlate the failure against the commit/diff that triggered the run: check whether the failing file/line was touched by that change.
1. Summarize the root cause in plain language: what failed, why, and which commit/line is responsible if that's clear from the logs.
1. Suggest a fix or next debugging step, but don't make any code changes yourself unless I ask you to.

## Notes

- If the logs don't clearly implicate a specific change (e.g. a flaky test, an infra timeout), say so directly instead of forcing a root cause.
