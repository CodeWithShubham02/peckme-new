📌 Bizipac API Documentation

Base URL:

https://fms.bizipac.com/apinew/ws_new/

🔑 Authentication
1. User Verification (Step 1: OTP request)

Method: POST
URL:

https://fms.bizipac.com/ws/userverification.php?mobile={mobile}&password={password}


Response: Returns OTP (e.g., 1234)

2. User Authentication (Step 2: Full login)

Method: POST
URL:

https://fms.bizipac.com/ws/userauth.php?mobile={mobile}&password={password}&userToken={token}&teamho={otp}&imeiNumber={imei}


Response: Returns user authorization and login success.

📋 Lead Management
3. Get All Leads

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/new_lead.php?uid={uid}&start={start}&end={end}&branch_id={branchId}&app_version={appVersion}&app_type={appType}

4. Get Lead Details

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/new_lead_detail.php?lead_id={leadId}

5. Get Child Executives

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/childlist.php?parentid={parentId}


👉 parentId means User ID of parent executive.

6. Refix Lead

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/refixlead.php?loginid={loginId}&leadid={leadId}&newdate={newDate}&location={location}&reason={reason}&newtime={newTime}&remark={remark}

7. Postpone Lead

Method: POST
URL:

https://fms.bizipac.com/apinew/ws_new/postponedlead.php


Body Params:

{
  "loginid": "{loginId}",
  "leadid": "{leadId}",
  "remark": "{remark}",
  "location": "{location}",
  "reason": "{reason}",
  "newdate": "{newDate}",
  "newtime": "{newTime}"
}

8. Get Transferred Leads (Single)

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/todaystransfered.php?uid={uid}

9. Transfer Multiple Leads

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/multipleLeadTransfer.php?leaddata={payload}

10. Completed Lead Count

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/today_completed_lead.php?uid={uid}&branch_id={branchId}

🔐 Forgot Password
11. Request Forgot Password OTP

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/forgotPassword.php?mobile={mobile}


👉 Checks if mobile exists, sends OTP.

12. Reset Password with OTP

Method: POST
URL:

https://fms.bizipac.com/apinew/ws_new/userForgotPassword.php


👉 Requires OTP + new password.

📂 Documents
13. Get All Documents

Method: GET
URL:

https://fms.bizipac.com/apinew/display/document.php

14. Upload Document

Method: POST
URL:

https://fms.bizipac.com/apinew/ws_new/add_doc_simple.php

📞 Calls
15. Get Exotel Call Number

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/exotel_getnumber.php?lead_id={leadId}

⏰ Time & Reason
16. Get Time Slots

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/time_slot.php

17. Get Reasons

Method: GET
URL:

https://fms.bizipac.com/apinew/ws_new/reason.php?leadid={leadId}
