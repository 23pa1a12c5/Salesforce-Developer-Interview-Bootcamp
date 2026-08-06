# Salesforce Interview Readiness Bootcamp – Day 4

## My First Lightning Web Component (LWC)

### Introduction

Today I learned the basics of Lightning Web Components (LWC), which are used to build modern user interfaces in Salesforce. I understood the structure of an LWC and then created a simple Placement Management System interface by completing the hands-on activities.

---

# What is LWC?

Lightning Web Components (LWC) is a modern programming model in Salesforce used to build fast, reusable, and interactive user interfaces. Every LWC is mainly made up of three files:

- HTML – Defines the user interface.
- JavaScript – Handles the component logic and events.
- Meta XML – Makes the component available inside Salesforce.

---

# What did I build?

I created a **Placement Management System** using Lightning Web Components.

The project was built step by step:

- Created my first Lightning Web Component named **placementHome**.
- Displayed a welcome message for the Placement Portal.
- Added student details such as Name, Roll Number, and Department.
- Created a button to display a welcome message.
- Added another button to apply for placement.
- Updated the application status dynamically.
- Enhanced the component into a simple Placement Portal dashboard showing:
  - Today's Date
  - Number of Companies
  - Number of Jobs
  - Applications Submitted

---

# Which file contains HTML?

The HTML code is written in:

```
placementHome.html
```

This file is responsible for creating the user interface displayed on the screen.

---

# Which file contains JavaScript?

The JavaScript code is written in:

```
placementHome.js
```

This file handles:

- Variables
- Button click events
- Dynamic data updates
- Component logic

---

# Project Structure

```
placementHome
│
├── placementHome.html
├── placementHome.js
└── placementHome.js-meta.xml
```

---

# What did I learn today?

During today's session, I learned:

- What Lightning Web Components (LWC) are.
- The purpose of HTML, JavaScript, and Meta XML files.
- How to create an LWC using Salesforce DX.
- How to deploy an LWC to Salesforce.
- How to display dynamic information using JavaScript.
- How to handle button click events.
- How data binding works in LWC.
- How to build a simple user interface for a Salesforce application.

---

# Tools Used

- Salesforce Developer Edition
- Salesforce CLI
- Visual Studio Code
- Lightning Web Components (LWC)

---

# Conclusion

This activity helped me understand the basic structure of Lightning Web Components and how different files work together to build a Salesforce application. I also learned how to deploy components, handle user interactions, and create a simple Placement Portal interface using LWC.

---



