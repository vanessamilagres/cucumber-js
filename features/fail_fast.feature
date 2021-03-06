Feature: Fail fast

  Using the `--fail-fast` flag ends the suite after the first failure

  Scenario: --fail-fast
    Given a file named "features/a.feature" with:
      """
      Feature:
        Scenario: Failing
          Given a failing step

        Scenario: Passing
          Given a passing step
      """
    Given a file named "features/step_definitions/cucumber_steps.js" with:
      """
      import {Given} from 'cucumber'

      Given(/^a failing step$/, function() { throw 'fail' })
      Given(/^a passing step$/, function() {})
      """
    When I run cucumber.js with `--fail-fast`
    Then the step "a passing step" has status "skipped"
    And it fails
