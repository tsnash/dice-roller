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

### Code Generation

* All generated code must adhere to code lint rules detailed in `analysis_options.yaml`