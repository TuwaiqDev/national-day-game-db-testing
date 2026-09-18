# National Day Game — Reporting Guidelines

## 1. Purpose

This document defines the standard format for recording and reporting database testing results.

The reporting process ensures that individual tester results can be combined into a final database testing report for the Data Administration Manager.

---

## 2. Tester Report

Each tester must maintain an individual result file.

Recommended location:

```text
testers/<tester-name>/
```

Example:

```text
testers/reema/
    test-results.md
```

The result file must contain the results of all tests assigned to that tester.

---

## 3. Required Test Information

Every test result must contain:

* Test ID.
* Test name.
* Testing area.
* Tester name.
* Test date.
* Test data identifier.
* Expected result.
* Actual result.
* Status.
* Evidence or relevant record IDs.
* Notes or findings.

---

## 4. Test Status

Only the following statuses are permitted:

### PASS

Use when the actual result matches the expected result.

### FAIL

Use when the actual result differs from the expected result.

A FAIL result must include enough information for another person to reproduce the issue.

### BLOCKED

Use when the test cannot be completed because of a condition outside the test itself.

The reason must be documented.

---

## 5. Result Format

Each test should follow this format:

```text
Test ID:
Test Name:
Testing Area:
Tester:
Test Date:
Test Data ID:

Expected Result:
[Expected database behavior]

Actual Result:
[Observed database behavior]

Status:
PASS / FAIL / BLOCKED

Evidence:
[Query, returned value, error message, or record ID]

Notes:
[Additional information]
```

---

## 6. FAIL Reporting

A failed test must clearly describe the difference between expected and actual behavior.

The report should include:

1. What was expected.
2. What actually happened.
3. SQL used to reproduce the result.
4. Relevant record IDs.
5. PostgreSQL error message, if applicable.
6. Any condition that may have affected the result.

Do not change the database simply to make a failed test pass.

The original result must be reported accurately.

---

## 7. BLOCKED Reporting

A test should be marked `BLOCKED` when it cannot be reliably executed.

Examples include:

* Required test data is missing.
* A required prerequisite cannot be created.
* Another tester's data prevents safe execution.
* The database is unavailable.
* Required access is unavailable.

The tester must document the blocking condition.

---

## 8. Test Data Identification

Each tester must identify their assigned test data.

Example:

```text
Tester: reema
Test Data ID: TESTER01
```

This identifier should be used consistently throughout the tester's SQL files and result reports.

This allows the final report to distinguish results from multiple testers using the same database.

---

## 9. Evidence

Evidence should be concise and reproducible.

Acceptable evidence includes:

* SQL statements.
* Query output.
* Relevant UUIDs.
* PostgreSQL error messages.
* Screenshots when required.

Never include:

* Passwords.
* API keys.
* Access tokens.
* Database connection strings.
* Personal information.
* Production data.

---

## 10. Final Reporting Data

The following information must be available for consolidation into the final report:

```text
Tester
Testing Area
Test ID
Test Name
Expected Result
Actual Result
Status
Evidence
Finding
Date
Commit
Pull Request
```

The final report should allow the Data Administration Manager to determine:

* Which tests were performed.
* Who performed each test.
* Which tests passed.
* Which tests failed.
* Which tests were blocked.
* What issues were identified.
* What evidence supports each result.
* Which GitHub commit contains the submitted results.
* Which Pull Request contains the reviewed work.

---

## 11. Reporting Accuracy

Testers must report the actual observed result.

Do not:

* Guess a result.
* Mark a test PASS without execution.
* Remove failed results.
* Modify evidence to match the expected result.
* Hide database errors.
* Delete failed test records solely to obtain a PASS result.

The testing repository is an audit trail. Accuracy takes priority over obtaining a successful test result.

---

## 12. Submission Requirements

Before opening a Pull Request, the tester must verify that:

* All assigned tests are documented.
* Every test has a valid status.
* FAIL results contain sufficient details.
* BLOCKED results contain a reason.
* Required evidence is included.
* No sensitive information is included.
* The result file is saved in the correct tester directory.
* Changes are committed to the tester's personal branch.

The Pull Request is the formal submission of the tester's completed work.