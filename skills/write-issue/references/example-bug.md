# Bug: Modal Buttons are Unstyled

Source: https://github.com/puzzle/pcts/issues/814

**Describe the bug**
The buttons on any modal are styled wrong.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to staging
2. Click on any member
3. Click on "Add Degree", "Add Experience", ...
4. See error

**Expected behavior**
The buttons follow the required styling.

**Screenshots**
<img width="843" height="865" alt="Image" src="https://github.com/user-attachments/assets/b54ada7b-1960-4476-82f5-a89b70252503" />

**System**
 - OS: NixOS
 - Browser: Firefox
 
**Additional context**
This was probably introduced in the merge of #774, as there was a last minute refactoring for the modals there. Ask @lcanobbio for more information if necessary.
