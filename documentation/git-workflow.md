# National Day Game — Git Workflow

## 1. Purpose

This document defines the required Git and GitHub workflow for all database testers.

The purpose is to ensure that every tester's work is traceable through their GitHub profile and that testing changes can be reviewed before becoming part of the official testing record.

---

## 2. Repository

Official repository:

```text
https://github.com/TuwaiqDev/national-day-game-db-testing
```

The repository is public.

Only synthetic test data, documentation, test results, and other approved non-sensitive testing materials may be committed.

---

## 3. Main Branch

The `main` branch represents the approved shared testing repository.

Testers must never push testing work directly to `main`.

All tester work must be performed on a personal testing branch.

---

## 4. Branch Naming

Each tester must create a personal branch using:

```text
test/<tester-name>
```

Example:

```text
test/reema
```

The branch must be created from the latest `main` branch.

---

## 5. Start of Testing

Before creating the branch, update the local repository:

```bash
git checkout main
git pull origin main
```

Create the tester branch:

```bash
git checkout -b test/<tester-name>
```

Example:

```bash
git checkout -b test/reema
```

Confirm the current branch:

```bash
git branch
```

The active branch must be the tester's personal branch before making changes.

---

## 6. What Testers May Commit

Testers may commit:

* Assigned test SQL files.
* Synthetic test data.
* Test result files.
* Testing documentation updates.
* Approved evidence.
* Other files explicitly requested by the testing lead.

Testers must never commit:

* Passwords.
* Supabase database credentials.
* API keys.
* Access tokens.
* `.env` files containing secrets.
* Production data.
* Personal information.
* Private credentials or authentication files.

---

## 7. Commit Workflow

After completing testing:

Check the working tree:

```bash
git status
```

Review the changes:

```bash
git diff
```

Stage the required files:

```bash
git add <file>
```

or:

```bash
git add testers/<tester-name>
git add test-data/<tester-name>
```

Create a descriptive commit:

```bash
git commit -m "Add <tester-name> database test results"
```

Example:

```bash
git commit -m "Add reema database test results"
```

---

## 8. Push the Branch

Push the tester branch to GitHub:

```bash
git push -u origin test/<tester-name>
```

Example:

```bash
git push -u origin test/reema
```

The branch and its commits will then be visible in the organization's GitHub repository.

---

## 9. Pull Request

After pushing the branch, open a Pull Request from:

```text
test/<tester-name>
```

into:

```text
main
```

The Pull Request should contain:

* Tester name.
* Testing area.
* Summary of tests performed.
* Number of PASS results.
* Number of FAIL results.
* Number of BLOCKED results.
* Important findings.
* Link or reference to the result file.

---

## 10. Review

The reviewer checks:

* Correct branch usage.
* Correct test assignment.
* Test execution results.
* Expected vs actual results.
* Evidence where required.
* Correct handling of shared test data.
* No credentials or sensitive information.
* Correct file structure.

The reviewer may request changes before approving the Pull Request.

---

## 11. Merge

Only approved Pull Requests may be merged into `main`.

The tester must not merge their own Pull Request unless explicitly authorized.

After the Pull Request is merged, the tester's work becomes part of the official testing history of the repository.

---

## 12. Updating a Testing Branch

If `main` has changed while testing is in progress, the tester may update their branch as instructed by the testing lead.

Do not overwrite another tester's branch or work.

---

## 13. Git History and Attribution

Every tester must use their own GitHub account.

Testers must not commit using another person's account.

The Git history must accurately identify the person who performed and documented the testing work.

This provides an auditable record of:

* Who performed the test.
* When the work was committed.
* What files were changed.
* What results were submitted.
* When the Pull Request was opened.
* What review occurred before merging.