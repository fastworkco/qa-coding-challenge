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

Click สมัครสมาชิก button
	Click Element	//*[@id="modal"]/div[2]/div/div[4]/a[contains(.,'สมัครสมาชิก')]
	Sleep	2s

Enter Email To Register
	[Arguments]	${RegisterEmail}
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div[3]/form/button[contains(.,"ดำเนินการต่อ")]
	Input Text	//*[@id="modal"]/div[2]/div[3]/form/div/div/input[@placeholder="หมายเลขโทรศัพท์มือถือหรืออีเมล"]	${RegisterEmail}
	Click Element	//*[@id="modal"]/div[2]/div[3]/form/button[contains(.,"ดำเนินการต่อ")]

Verify หมายเลขโทรศัพท์มือถือหรืออีเมล Error Message If Blank On เข้าสู่ระบบ Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[1]/small[contains(.,"กรุณากรอกข้อมูล")]

Verify รหัสผ่าน Error Message If Blank On เข้าสู่ระบบ Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[2]/small[contains(.,"กรุณากรอกข้อมูล")]

Verify Duplicate Register Email Error Message
	Wait Until Page Contains Element	//div/span[@class="noty_text"]
	Wait Until Element Does Not Contain 	//div/span[@class="noty_text"]	120s

Verify Error Message When Enter Invalid Email
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div[3]/form/div/small[contains(.,"ใส่หมายเลขโทรศัพท์มือถือหรืออีเมลเท่านั้น")]

Clear หมายเลขโทรศัพท์มือถือหรืออีเมล Field
	Input Text	//*[@id="modal"]/div[2]/div[3]/form/div/div/input[@placeholder="หมายเลขโทรศัพท์มือถือหรืออีเมล"]	${empty}

Verify Message If Email Is Valid
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[1]/label[contains(.,'คุณสามารถใช้ล็อกอินนี้ได้')]
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[1]/label/i[@class="check green circle icon"]

Verify Error Message If Enter รหัสผ่าน Less Than 8 Characters
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[3]/small[contains(.,"ห้ามต่ำกว่า 8 ตัวอักษร")]

Enter รหัสผ่าน On สมัครสมาชิก Popup
	[Arguments]	${RegisterPassword}
	Input Text 		//*[@id="modal"]/div[2]/div/form/div[3]/div/input[@placeholder="รหัสผ่าน"]	${RegisterPassword}

Enter ยืนยันรหัสผ่าน On สมัครสมาชิก Popup
	[Arguments]	${ConfirmPassword}
	Input Text 		//*[@id="modal"]/div[2]/div/form/div[4]/div/input[@name="confirmPassword"]	${ConfirmPassword}

Verify Error Message If Enter Incorrect ยืนยันรหัสผ่าน
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[4]/small[contains(.,"รหัสผ่านไม่ตรงกัน")]

Verify Error Message If Blank รหัสผ่าน On สมัครสมาชิก Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[3]/small[contains(.,"กรุณากรอกข้อมูล")]

Verify Error Message If Blank ยืนยันรหัสผ่าน On สมัครสมาชิก Popup
	Wait Until Page Contains Element	//*[@id="modal"]/div[2]/div/form/div[4]/small[contains(.,"กรุณากรอกข้อมูล")]

Click สมัครสมาชิก Button On สมัครสมาชิก Page
	Wait Until Element Is Enabled	//*[@id="modal"]/div[2]/div/form/div[contains(.,"สมัครสมาชิก")]
	Click Element	//*[@id="modal"]/div[2]/div/form/div[contains(.,"สมัครสมาชิก")]

Clear รหัสผ่าน Field On สมัครสมาชิก Popup
	Input Text	//*[@id="modal"]/div[2]/div/form/div[3]/div/input[@name="password"]	${empty}

Clear ยืนยันรหัสผ่าน Field On สมัครสมาชิก Popup
	Input Text	//*[@id="modal"]/div[2]/div/form/div[4]/div/input[@name="confirmPassword"]	${empty}

Verify Message If Register Successfully
	[Arguments]	${RegisterEmailSuccess}
	Wait Until Page Contains Element	//*[@id="app"]/div[2]/div[1]/div/section/div/p[contains(.,"กรุณายืนยันอีเมลของคุณ จากอีเมลที่เราส่งไปที่ ${RegisterEmailSuccess}")]

*** Test Case ***
#Action
Verify If click on เข้าสู่ระบบ button
	Open Web
	Click เข้าสู่ระบบ Button

Verify if click on สมัครสมาชิก button
	Click สมัครสมาชิก button
	Verify หมายเลขโทรศัพท์มือถือหรืออีเมล Error Message If Blank On เข้าสู่ระบบ Popup
	Click สมัครสมาชิก button

Verify if enter invalid email by enter duplicated email on สมัครสมาชิก popup
	Enter Email To Register 	test@test.com
	Verify Duplicate Register Email Error Message

Verify if enter invalid email on สมัครสมาชิก popup
	Clear หมายเลขโทรศัพท์มือถือหรืออีเมล Field
	Enter Email To Register 	test@te#st.com
	Verify Error Message When Enter Invalid Email

Verify if enter valid email and click on ดำเนินการต่อ button on สมัครสมาชิก popup
	Clear หมายเลขโทรศัพท์มือถือหรืออีเมล Field
	Enter Email To Register 	test78@test.com
	Verify Message If Email Is Valid

Verify If Blank รหัสผ่าน and ยืนยันรหัสผ่าน fields
	Click สมัครสมาชิก Button On สมัครสมาชิก Page
	Verify Error Message If Blank รหัสผ่าน On สมัครสมาชิก Popup
	Verify Error Message If Blank ยืนยันรหัสผ่าน On สมัครสมาชิก Popup

Verify if enter invalid รหัสผ่าน on สมัครสมาชิก popup by enter less than 8 characters
	Enter รหัสผ่าน On สมัครสมาชิก Popup 	34
	Verify Error Message If Enter รหัสผ่าน Less Than 8 Characters

Verify if enter valid รหัสผ่าน but enter invalid ยืนยัน รหัสผ่าน on สมัครสมาชิก popup
	Enter รหัสผ่าน On สมัครสมาชิก Popup 	testtest
	Enter ยืนยันรหัสผ่าน On สมัครสมาชิก Popup 	testtestja
	Verify Error Message If Enter Incorrect ยืนยันรหัสผ่าน

Verify if enter valid email, รหัสผ่าน and ยืนยัน รหัสผ่าน on สมัครสมาชิก popup
	Clear ยืนยันรหัสผ่าน Field On สมัครสมาชิก Popup
	Enter ยืนยันรหัสผ่าน On สมัครสมาชิก Popup 	testtest
	Click สมัครสมาชิก Button On สมัครสมาชิก Page
	Verify Message If Register Successfully	test78@test.com