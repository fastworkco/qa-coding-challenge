*** Settings ***
Library          	Selenium2Library
Library          	ImapLibrary
Suite Teardown	Close Browser

*** Variables ***
${Browser}	chrome
${URL}	https://staging.fastwork.co/

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

Verify หมายเลขโทรศัพท์มือถือหรืออีเมล Error Message If Blank On เข้าสู่ระบบ Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[1]/small[contains(.,"กรุณากรอกข้อมูล")]

Verify รหัสผ่าน Error Message If Blank On เข้าสู่ระบบ Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[2]/small[contains(.,"กรุณากรอกข้อมูล")]

Enter Username On เข้าสู่ระบบ Popup
	[Arguments]	${Username}
	Input Text	//*[@id="modal"]/div[2]/div/form/div[1]/div/input[@name="username" and contains(@aria-required,"true")]	${Username}

Enter Password On เข้าสู่ระบบ Popup
	[Arguments]	${Password}
	Input Text	//*[@id="modal"]/div[2]/div/form/div[2]/div/input[@name="password"]	${Password}

Verify Error Message If Enter Incorrect Username
	Wait Until Page Contains Element	//div/span[@class='noty_text' and contains(.,"คุณใส่ Username ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง")]
	Wait Until Page Does Not Contain Element	//div/span[@class='noty_text' and contains(.,"คุณใส่ Username ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง")]	120s

Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Click Element	//*[@id="modal"]/div[2]/div/form/button[contains(.,"เข้าสู่ระบบ")]

Clear Username Field
	Input Text	//*[@id="modal"]/div[2]/div/form/div[1]/div/input[@name="username" and contains(@aria-required,"true")]	${empty}

Clear Password Field
	Input Text	//*[@id="modal"]/div[2]/div/form/div[2]/div/input[@name="password"]	${empty}

Verify Error Message If Enter Incorrect Password
	Wait Until Page Contains Element	//div/span[@class='noty_text' and contains(.,"คุณใส่ Password ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง")]
	Wait Until Page Does Not Contain Element	//div/span[@class='noty_text' and contains(.,"คุณใส่ Password ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง")]	120S

Verify Login Successfully
	Wait Until Page Contains Element	//*[@id="app"]/div[2]/div[2]/div[1]/div/div[2]/div[2]/I[contains(@class,'dropdown icon')]	60s

*** Test Case ***
#Action
Verify if leave blank both หมายเลขโทรศัพท์หรืออีเมล์ and password field on เข้าสู่ระบบ popup
	Open Web
	Click เข้าสู่ระบบ Button
	Clear Username Field
	Clear Password Field
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Verify หมายเลขโทรศัพท์มือถือหรืออีเมล Error Message If Blank On เข้าสู่ระบบ Popup

Verify if enter incorrect หมายเลขโทรศัพท์หรืออีเมล์ field on เข้าสู่ระบบ popup
	Enter Username On เข้าสู่ระบบ Popup 	testtesttet@test.com
	Enter Password On เข้าสู่ระบบ Popup 	testtest
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Verify Error Message If Enter Incorrect Username

Verify if enter incorrect password field on เข้าสู่ระบบ popup
	Clear Username Field
	Enter Username On เข้าสู่ระบบ Popup 	test50@test.com
	Clear Password Field
	Enter Password On เข้าสู่ระบบ Popup 	ghjklll
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Verify Error Message If Enter Incorrect Password

Verify if enter valid หมายเลขโทรศัพท์หรืออีเมล์ and password on เข้าสู่ระบบ popup
	Clear Username Field
	Enter Username On เข้าสู่ระบบ Popup 	test50@test.com
	Clear Password Field
	Enter Password On เข้าสู่ระบบ Popup 	testtest
	Click เข้าสู่ระบบ On เข้าสู่ระบบ Popup
	Verify Login Successfully