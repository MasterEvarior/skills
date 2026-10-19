# Writing Feedback

## 1. Clarify context

Before doing anything, clarify the following questions:

- What is the stage of the current project? Is it finished or in progress?
- What exactly should be reviewed? A specific file, the last commit, everything?
- What is the expected type of text and how should it be worded? A blog post, a scientifc paper?

You may ask the user if you are not sure by exploring the project or from the initial prompt.

## 2. Confirm your assumed context is correct

Ask the user if your gathered context is correct. If not, return to step 1.

## 3. Inspect the text

Inspect the text. Pay attention to the following:

- **Clarity and Tone:** Is the message clear, concise, and appropriate for the intended audience and medium?
- **Grammar and Mechanics:** Check for spelling, punctuation, syntax errors, and consistent styling or formatting.
- **Structure and Flow:** Evaluate logical organization, transitions between paragraphs or sections, and pacing.
- **Technical Accuracy (if applicable):** Verify accuracy of terminology, facts, code snippets, or references.
- **TODOs (if applicable):** Open TODOs (only if the text is finished)

## 4. Present Results

Present the findings in this specific format:

### 📊 Review Summary

| File + Line| Urgency | Primary Concern |
| :--- | :--- | :--- |
| `filename.ext` - `Line 29` | 🔴 High / 🟡 Med / 🟢 Low | Short description |

### 🔍 Detailed Findings

**[File Name]**

- **Issue:** [Describe the specific issue]
- **Why it matters:** [Explain the impact]
- **Suggestion:** [Provide the fix]
