# Bisect helper

Automate a `git bisect` run to find the commit that introduced a regression, given a way to reproduce the failure.

For this you should:

1. Ask me for the known-good ref (commit/tag/branch). If I don't give a known-bad ref, assume it's `HEAD`.
1. Ask me how to reproduce the failure (a command, test, or script) and what distinguishes a "good" result from a "bad" one.
1. Ask me whether to run the bisect in-place or in a separate git worktree — default to a worktree if the bisect will take a while and I'd want to keep working in the main tree, or if I ask for it to run in the background.
   - In-place: run `git status` first. If there are uncommitted changes, stop and tell me — `git bisect` checks out different commits and will not run safely on a dirty tree.
   - Worktree: create one with `git worktree add <path> <bad>` so the main working tree is untouched and free for me to keep using, and run the whole bisect from inside `<path>`.
1. Verify the reproduction command actually fails on the bad ref before starting the bisect, so we don't burn a long run chasing an unrelated issue.
1. Start the bisect with `git bisect start <bad> <good>`, then drive it with `git bisect run <script>`, wrapping the reproduction command so it exits `0` for good, `1` for bad, and `125` to skip commits that can't be tested (e.g. the build itself is broken for unrelated reasons).
   - If running in a worktree and I asked for the background, launch the bisect run in the background and let me know when it's done instead of blocking on it.
1. Once `git bisect run` finds the first bad commit, show me its commit message, author, and diff.
1. Clean up:
   - In-place: run `git bisect reset` to restore the original branch/HEAD.
   - Worktree: run `git bisect reset` inside the worktree, then remove it with `git worktree remove <path>` from the main tree.
     Do this even if I stop you partway through.

## Notes

- Never force anything; `git bisect reset` and `git worktree remove` (without `--force`) are sufficient to clean up.
- Never skip the dirty-tree check in step 3 when running in-place.
- If a commit in range can't be tested for reasons unrelated to the regression (e.g. an unrelated build break), prefer `exit 125` (skip) over guessing good/bad.
