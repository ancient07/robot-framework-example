*** Settings ***
Documentation       Just a smoke tests example
Library             RequestsLibrary
Test Setup          Create Connection
Test Teardown       Close All Connections
Test Template       Smoke-testing

*** Variables ***
${base_url}         https://en.wikipedia.org/wiki

*** Test Cases ***
Check the avaibility Michael_DeBakey page
    [Tags]              DeBakey
    /Michael_DeBakey    1908

Check the avaibility Denton_Cooley Page
    [Tags]              Cooley
    /Denton_Cooley      1920

Check the avaibility Hawking Page
    [Tags]              Hawking
    /Stephen_Hawking    1942

Check the avaibility non existed page (just example of an error)
    [Tags]              Numbers
    /123456789          1899

Check the avaibility non existed page (just demonstration non critical(skipped) errors)
    [Tags]              Letters    Known
    /sdfsdfeqr          1799

*** Keywords ***
Create Connection
    Create session     conn     ${base_url}    disable_warnings=1

Close All Connections
    Delete all sessions

Smoke-testing
    [Arguments]     ${url}    ${expected_word}
    ${response}     GET On Session        conn     ${url}
                    Should be equal    ${response.status_code}    ${200}
    ...                 msg=During the GET Request ${url} recieved non 200 response code.
                    Check word on the page    ${response.text}    ${expected_word}

Check word on the page
    [Arguments]     ${text}    ${expected_word}
                    Should contain    ${text}    ${expected_word}    msg=Cannot find the word ${expected_word}!