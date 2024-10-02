*** Settings ***
Documentation     Test to verify if the user can log in and see the "Title IX Case Management" app.
Library           SeleniumLibrary  # For browser interactions
Suite Setup       Open Browser to Salesforce Login Page  # Setup step to open the login page
Suite Teardown    Close Browser  # Cleanup step to close the browser after tests
Test Teardown     Capture Page Screenshot  # Capture screenshot in case of failure

*** Variables ***
${BROWSER}        chrome  # Specify browser type
${LOGIN_URL}      https://grinnell--ccitestsit.sandbox.my.salesforce.com  # URL of the Salesforce login page (sandbox)
${USERNAME}       brownpau@grinnell.edu.ccitestsit  # Replace with valid Salesforce username
${PASSWORD}       pamama108  # Replace with valid Salesforce password
${APP_NAME}       Title IX Case Management  # Name of the app to check after login

*** Test Cases ***
Login And Verify Title IX App
    [Documentation]  Test to ensure that user can login and see the Title IX Case Management app
    Login to Salesforce  ${USERNAME}  ${PASSWORD}
    Verify Title IX Case Management App Is Visible

*** Keywords ***
Open Browser to Salesforce Login Page
    [Documentation]  Open browser and navigate to the Salesforce login page
    Open Browser  ${LOGIN_URL}  ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element  id:supportHeader  15s  # Wait until the login page is fully loaded

Login to Salesforce
    [Documentation]  Log in to Salesforce using the given username and password
    Input Text  id:username  ${USERNAME}  # Enter the username
    Input Text  id:password  ${PASSWORD}  # Enter the password
    Click Button  id:Login  # Click the login button
    Wait Until Page Contains  Lightning Experience  20s  # Wait for login to complete and Lightning Experience to load

Verify Title IX Case Management App Is Visible
    [Documentation]  Verify that the Title IX Case Management app is available after login
    Wait Until Element Is Visible  xpath://span[text()="${APP_NAME}"]  20s
    Element Should Be Visible  xpath://span[text()="${APP_NAME}"]