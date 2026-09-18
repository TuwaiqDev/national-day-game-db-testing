# National Day Game — Database Testing Procedure

## 1. Purpose

This document defines the standard procedure for testing the National Day Game database.

The purpose of the testing process is to verify:

* Database structure and relationships.
* Foreign key behavior.
* Data integrity and constraints.
* Game session behavior.
* Gameplay-related records.
* Event and answer tracking.
* Expected database behavior under defined test scenarios.

All testers must follow this procedure to ensure that test results are consistent, reproducible, and suitable for the final database testing report.

---

## 2. Testing Environment

All testers use the same Supabase database.

The database contains the shared testing environment and must not be replaced, reset, or structurally modified by individual testers unless explicitly authorized.

The repository contains:

```text
schema/
test-data/
testers/
documentation/
reports/
```

The database schema used for testing is documented in:

```text
schema/database_schema.sql
```

---

## 3. Test Data Isolation

Although all testers use the same database, each tester receives a separate set of synthetic test data.

Testers must use only the data assigned to them.

A tester must not:

* Modify another tester's test data.
* Delete another tester's records.
* Reuse another tester's test identifiers.
* Use production data.
* Introduce personal information into the database.

Where possible, test records must contain identifiable synthetic values such as:

```text
TESTER01
TESTER02
TESTER03
```

or another identifier specified in the tester's assigned SQL file.

This allows test results to be distinguished when multiple testers are working simultaneously.

---

## 4. Test Assignment

Each tester receives an individual SQL test file containing:

1. Test objective.
2. Test data.
3. Preconditions.
4. SQL statements required to prepare the test.
5. Test actions or queries.
6. Expected results.
7. Required result fields.
8. Cleanup instructions, when applicable.

Testers must execute only the tests assigned to them.

---

## 5. Test Execution

Tests must be executed through the Supabase SQL Editor unless another execution method is explicitly specified.

Before starting:

1. Open the assigned test file.
2. Read the complete test instructions.
3. Confirm that the required test data exists.
4. Confirm that the test identifiers belong to the assigned tester.
5. Review the expected result.

Execute the SQL statements in the order provided.

Do not modify the test SQL unless the assignment explicitly permits modification.

If a test cannot be executed because of a missing prerequisite, database error, or unexpected existing data, mark the test as:

```text
BLOCKED
```

and document the reason.

---

## 6. Expected vs Actual Results

For every test case, the tester must compare the actual database behavior with the expected result.

Each test must receive exactly one status:

* `PASS` — Actual result matches the expected result.
* `FAIL` — Actual result does not match the expected result.
* `BLOCKED` — The test could not be completed because of an external condition or missing prerequisite.

Testers must not mark a test as PASS based on assumption.

---

## 7. Existing Data

Because all testers share the same database, existing records may affect test results.

Before executing a test, check whether existing data can influence the expected result.

If existing data may affect the test:

1. Record the condition.
2. Do not delete another tester's data.
3. Follow the cleanup or isolation instructions in the assigned test.
4. If the test cannot be reliably executed, mark it as `BLOCKED`.

---

## 8. Evidence

Where applicable, testers should preserve evidence of the test result, such as:

* SQL query used.
* Returned result.
* PostgreSQL error message.
* Relevant record IDs.
* Screenshot when specifically requested.

Evidence must not contain:

* Passwords.
* Database credentials.
* API keys.
* Access tokens.
* Personal information.
* Production data.

---

## 9. Cleanup

Testers must follow the cleanup instructions included in their assigned test file.

Cleanup must only affect records created by the tester.

Never delete or modify records belonging to another tester.

If cleanup cannot safely be performed, report the condition instead of deleting shared data.

---

## 10. Completion Criteria

A test assignment is considered complete only when:

* All assigned test cases have been executed.
* Every test case has `PASS`, `FAIL`, or `BLOCKED` status.
* Failures are documented.
* Blocked tests include a reason.
* Required evidence is recorded.
* The reporting file is complete.
* Changes are committed to the tester's Git branch.
* A Pull Request has been opened.

The tester must not directly modify the `main` branch.