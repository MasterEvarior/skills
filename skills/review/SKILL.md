# Review

## 1. Fetch Latest Changes

Run the following command to ensure we have the latest history from the remote repository:
`git fetch origin`

## 2. Identify and Compare

1. Determine the name of the current branch.
1. Determine if the default branch is `main` or `master`.
1. Run a git diff command to compare the **current branch** against the **origin default branch**.
   - *Tip: Use `git diff origin/main...HEAD` (or master) to see only changes introduced in this branch.*

## 3. Analyze Changes

Read the output of the git diff. If the diff is empty, stop and inform the user that the branches are identical.
If there are changes, perform a **Deep Code Review** based on these criteria:

1. **Logic & Correctness:** Are there potential bugs, infinite loops, or off-by-one errors?
1. **Security:** Check for hardcoded secrets, SQL injection risks, or unvalidated inputs.
1. **Performance:** Identify inefficient queries, heavy computations inside loops, or memory leaks.
1. **Style & Standards:** Is the code readable? Are variable names clear? (Ignore minor formatting nitpicks).

## 4. Present Results

Present the findings in this specific format:

### 📊 Review Summary

| File | Risk Level | Primary Concern |
| :--- | :--- | :--- |
| `filename.ext` | 🔴 High / 🟡 Med / 🟢 Low | Short description |

### 🔍 Detailed Findings

**[File Name]**

- **Issue:** [Describe the specific issue]
- **Why it matters:** [Explain the impact]
- **Suggestion:** [Provide the fix]

### 🛠️ Refactoring Suggestions

Only if critical issues are found, provide specific code blocks showing the "Before" vs "After" implementation.
