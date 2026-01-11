# Project Overview

Dart library for simulating dice rolls

## General Instructions & Workflow

The AI agent operates under the following standing instructions to ensure code quality, consistency, and adherence to Dart best practices.

### Quality Assurance ✅

Before finalizing any feature or publishing a new version, the agent must perform the following checks:

1.  **Analyze Code:** Run the static analyzer to identify issues with `dart analyze`.
1.  **Run Tests:** Execute all unit and integration tests with `dart test` and ensure they all pass.
1.  **Verify README:** Confirm that any mentioned functionality or instructions are up to date and accurate in the `README.md` file.
1.  **Verify LICENSE:** Confirm existence of valid `LICENSE` file.
1.  **Verify CHANGELOG:** Confirm changes are represented in the `CHANGELOG.md` file.
1.  **Check Pub Points:** Carefully use `pana` to calculate pub points of the package. The agent must report the results and address any suggestions or failures.
    1. Copy the directory holding the package to a temporary one because `pana` will make modifications to it, e.g.
    ```bash
    cp ~/dev/mypkg ~/tmp/mypkg
    ```
    2. `pana` changes frequently so make sure it's updated, e.g.
    ```bash
    dart pub global activate pana
    ```
    3. Run `pana` on the copied directory
    ```bash
    dart pub global run pana ~/tmp/mypkg
    ```
1.  **Verify Version:** Ensure the version in `pubspec.yaml` has been updated appropriately for the changes being published. Confirm that the latest version in the `CHANGELOG.md` file matches the version in `pubspec.yaml`.

### Code Generation

All generated code must adhere to code lint rules detailed in `analysis_options.yaml`

### Commit Message Structure Guidelines

1. The general structure of the first line should conform to `<type>: <description>` while the body and footer have no predetermined format and are up to the personal preference of the author.
2. Currently there are 3 types to be used that are governed by their impact on the functionality of the project and their visibility to the end user.
    1. feat - introduction of new or updated feature
    2. fix - address a bug or issue by correcting or restoring functionality
    3. chore - doesn't affect the functionality and is typically invisible to the end user