*** Settings ***
Library          	Selenium2Library
Library          	ImapLibrary
Suite Teardown	Close Browser

*** Variables ***
${Browser}	chrome
${URL}	https://staging.fastwork.co/search?q

*** Keywords ***
#Action
Open Web
	Open Browser	${URL}	${Browser}
	Wait Until Page Contains Element	//*[@id="normal-popover"]
	Sleep	1s
#	Wait Until Page Contains Element	//*[@id="onesignal-popover-cancel-button"][contains(.,'No Thank')]	60s
#No Ads popup
#	Wait Until Page Contains Element	//*[@id="modal"]/i[@class='close icon' and contains(@style,'color: rgba(0, 0, 0, 0.8)')]
	Click Element	//*[@id="onesignal-popover-cancel-button"][contains(.,'No Thank')]
	Sleep	2s
	Wait Until Page Contains Element	//*[@id="app"]//div[1]//div[2]/div[2]/div[contains(.,"เข้าสู่ระบบ")]
#	Click Element	//*[@id="modal"]/i[@class='close icon' and contains(@style,'color: rgba(0, 0, 0, 0.8)')]

Click เข้าสู่ระบบ Button
	Click Element	//*[@id="app"]//div[1]//div[2]/div[2]/div[contains(.,"เข้าสู่ระบบ")]
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/div[1]/a[contains(.,"เข้าสู่ระบบด้วย Facebook")]

Enter Username On เข้าสู่ระบบ Popup
	[Arguments]	${Username}
	Input Text	//*[@id="modal"]/div[2]/div/form/div[1]/div/input[@name="username" and contains(@aria-required,"true")]	${Username}

Enter Password On เข้าสู่ระบบ Popup
	[Arguments]	${Password}
	Input Text	//*[@id="modal"]/div[2]/div/form/div[2]/div/input[@name="password"]	${Password}

Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Click Element	//*[@id="modal"]/div[2]/div/form/button[contains(.,"เข้าสู่ระบบ")]

Verify Login Successfully
	Wait Until Page Contains Element	//*[@id="app"]/div[2]/div[2]/div[1]/div/div[2]/div[2]/I[contains(@class,'dropdown icon')]	60s
	Click Element	//*[@id="app"]/div[2]/div[1]/div/section/div/i[@class="bio-message-close close icon _zid-1 _cs-pt"]
	Wait Until Page Does Not Contain Element	//*[@id="app"]/div[2]/div[1]/div/section/div/i[@class="bio-message-close close icon _zid-1 _cs-pt"]	60s

Enter Search Field
	[Arguments]	${Search}
	Input Text	//*[@id="desktopNavigationSearch"]	${Search}

Click Search Button
	Click Element	//*[@id="app"]/div[2]/div[2]/div[1]/div/div[1]/div/form/div[2]/strong[contains(.,"ค้นหา")]

Verify Total Search Result
	[Arguments]	${ResultSearch}	${TotalSearch}
	Wait Until Page Contains Element	//*[@id="app-content"]/div[2]/div[1]/div/div/h2[contains(.,'ผลการค้นหา') and contains(.,'${ResultSearch} (${TotalSearch})')]	60s

Verify Search Result
	[Arguments]	${pItem}	${pExpected}
	Wait Until Page Contains Element	//*[@id="app-content"]/div[2]/div[2]/div/div[${pItem}]/div/div[2]/div[1]/a/div[contains(.,'${pExpected}')]	60s

Verify If Blank Search Field
	Element Should Be Disabled	//*[@id="app"]/div[2]/div[2]/div[1]/div/div[1]/div/form/div[2]/strong[contains(.,"ค้นหา")]

*** Test Case ***
#Action
If Search valid without login
	Open Web
	Enter Search Field	test
	Click Search Button
	Verify Total Search Result 	test 	139
	Verify Search Result 	1 	Test product
	Verify Search Result 	2 	Test ladder 3
	Verify Search Result 	3 	Test ladder 1
	Verify Search Result 	4 	Test ladder 2

If Search invalid without login
	Enter Search Field	testhdbdsalmffsmk
	Click Search Button
	Verify Total Search Result 	testhdbdsalmffsmk 	0

If Search valid with login
	Click เข้าสู่ระบบ Button
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Enter Username On เข้าสู่ระบบ Popup 	test50@test.com
	Enter Password On เข้าสู่ระบบ Popup 	testtest
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Verify Login Successfully

	Enter Search Field	test
	Click Search Button
	Verify Total Search Result 	test 	139
	Verify Search Result 	1 	Test product
	Verify Search Result 	2 	Test ladder 3
	Verify Search Result 	3 	Test ladder 1
	Verify Search Result 	4 	Test ladder 2

If Search invalid with login
	Enter Search Field	fghjkljhgfghjk
	Click Search Button
	Verify Total Search Result 	fghjkljhgfghjk 	0