# Capital On Tap Coding Test

Congratulations on progressing to the next stage of the interview process and thank you for your time in the process so far. The next stage of the process is our at home coding test. All Capital on Tap Engineers have gone through this test or something similar - it’s how we ensure that we have one of the best engineering teams in the industry!

### Instructions

The test will consist of two user stories that we want you to complete. These stories have been designed to imitate tasks you might be given to work on if you were a member of our team.

Each story should take around 1 hour to complete, although this is not a hard limit.

You will be provided with a codebase that includes some existing functionality. We want you to build upon this, refactoring it appropriately and improving the user interface design. This is not a real system, however, it does contain some sample domain objects and concepts that we commonly use at Capital on Tap.

We host a basic API that you will need to use as part of your submission, documentation for this can be found at https://cot-cards-coding-test-api.azurewebsites.net.

If you have any questions or require clarification, please don’t hesitate to ask us for further information.

### What we’re looking for

- Appropriate architectural decisions
- Application of SOLID principles
- A relevant testing strategy
- Readability
- Consistency
- Maintainability
- An eye for interaction design
- Sensible commits so that we can see your progress

### Submission

Once you have finished your solution, commit the files to the GitHub repository. Make sure you commit your files to a new branch. Raise a pull request. Let us know you have completed this step and we will then conduct a code review.

---

## Story 1

As a customer, I would like to be able to enter my account information and see my account details.

### Description

The application currently allows users to submit their details before being shown some basic account information. The architectural design, code quality and user experience is currently very poor. This must be improved.

### Acceptance Criteria

- A user can enter their account details
  - Appropriate validation messages should be shown, each field is required and AnnualTurnover must be numeric and positive
  - The form should be intuitive
  - Errors originating from from the API should cause an error message to appear
- A user should be able to view the details they just entered
  - The displayed fields should include:
    - First Name
    - Last Name
    - Company Name
    - Annual Turnover
    - Mobile Number
  - The fields should be displayed intuitively and should be visually appealing

---

## Story 2

As a customer, I would like to be able to see my card details so I can change the status of my credit card.

### Description

When a user is created we also create a credit card for them. The details of these cards can be retrieved using the cards endpoint. We would like a new screen to display the details for the user’s card. This should be accessible from the Account Details screen and it should display the card’s number and expiry date. There should be a toggle switch to allow users to change the IsFrozen flag of the card.

### Acceptance Criteria

- A navigation item for Cards is shown on the Account Details screen
  - Tapping this should display the Cards screen
- The Cards screen should show the card’s number and expiry date
- The Cards screen should display a Frozen toggle
  - Changing this toggle should call the update card endpoint to change the IsFrozen property of the card
  - There should be a visual cue to indicate that the card is frozen
- It should be possible to navigate back to the Account Details screen
