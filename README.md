# GoToMeeting API Powershell functions
This script contains functions related to the GoToMeeting API.  The functions are to help create scripts that need information from GoToMeeting.

# Prerequisites
* Powershell v5.1
* <a href url="https://goto-developer.logmeininc.com/content/gotomeeting-api-reference">GoToMeeting API v2</a>

# Instructions
To use the functions in this module, you first need to import them into your script.

Example:
```
Import-Module "C:\GoToMeetingModule.psm1" -Force
```

Functions:
* <b>SMA_GTMLogin</b> - Authenticates your account initally with the API
* <b>SMA_GTMLoginRefresh</b> - Refreshes your API credentials (must be done periodically as the tokens expire)
* <b>SMA_GTMPersonalMeetings</b> - Returns information about your personal scheduled meetings
* <b>SMA_GTMSetup</b> - Used in conjunction with the OpCon API to store your login tokens
* <b>SMA_GTMStartMeeting</b> - Starts a new GoToMeeting session
* <b>SMA_GTMUpcomingMeetings</b> - Returns information about upcoming scheduled meetings (could be shared with a group)

# Disclaimer
No Support and No Warranty are provided by SMA Technologies for this project and related material. The use of this project's files is on your own risk.

SMA Technologies assumes no liability for damage caused by the usage of any of the files offered here via this Github repository.

# License
Copyright 2020 SMA Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing
We love contributions, please read our [Contribution Guide](CONTRIBUTING.md) to get started!

# Code of Conduct
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code-of-conduct.md)
SMA Technologies has adopted the [Contributor Covenant](CODE_OF_CONDUCT.md) as its Code of Conduct, and we expect project participants to adhere to it. Please read the [full text](CODE_OF_CONDUCT.md) so that you can understand what actions will and will not be tolerated.
