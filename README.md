# typeform-ios
A little iOS app for creating and managing TypeForms via TypeForm.io and Parse

##Setup

Download the project files
Install cocoapods
`pod install`
Open workspace

Head over to Parse and create an account, grab your `app_id` and `secret`
Ask the dudes and Typeform for an API key. 

Create a new header file called `Defines.h`
Add the following to it:

#define PARSE_APP_ID @"PARSE_APP_ID_KEY_HERE"
#define PARSE_SECRET @"PARSE_SECRET_KEY_HERE"
#define TYPEFORM_API_KEY @"TYPEFORM_API_KEY_HERE"

Build, run and it "should" work...

It's just an prototype. 
