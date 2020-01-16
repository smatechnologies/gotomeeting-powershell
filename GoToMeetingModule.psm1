
function SMA_GTMLogin($auth,$token)
{
    $hdr = @{"Authorization" = "Basic " + $auth}
    
    $uripost = "https://api.getgo.com/oauth/v2/token"
    $body = "grant_type=authorization_code&code=" + $token

    try
    {
        $login = (Invoke-RestMethod -Method POST -Uri $uripost -Headers $hdr -Body $body -ContentType "application/x-www-form-urlencoded")
    }
    catch [Exception]
    {
        Write-Host $_
        Write-Host $_.Exception.Message
        Exit 101
    }

    return $login
}

#Generates new access/refresh tokens for new api calls
function SMA_GTMLoginRefresh($refresh_token,$token)
{
    $hdr = @{"Authorization" = "Basic " + $token}
    
    $uripost = "https://api.getgo.com/oauth/v2/token"
    $body = @{"grant_type" = "refresh_token"}
    $body += @{"refresh_token" = $refresh_token}

    try
    {
        $refresh = Invoke-RestMethod -Method POST -Uri $uripost -Headers $hdr -Body $body -ContentType "application/json"
    }
    catch [Exception]
    {
        Write-Host $_
        Write-Host $_.Exception.Message
        Exit 101
    }

    return $refresh
}

#View upcoming meetings
function SMA_GTMUpcomingMeetings($accessToken)
{
    $hdr = @{"Authorization" = "Bearer " + $accessToken}
    
    $uriget = "https://api.getgo.com/G2M/rest/upcomingMeetings"

    try
    {
        $getmeetings = Invoke-RestMethod -Method GET -Uri $uriget -Headers $hdr -ContentType "application/json"
    }
    catch [Exception]
    {
        Write-Host $_
        Write-Host $_.Exception.Message
        Exit 101
    }

    #Only return meetings for today or later
    return $getmeetings
}

#View upcoming meetings
function SMA_GTMPersonalMeeting($accessToken,$user)
{
    $hdr = @{"Authorization" = "Bearer " + $accessToken}
    
    $uriget = "https://api.getgo.com/G2M/rest/upcomingMeetings"

    try
    {
        $getmeetings = Invoke-RestMethod -Method GET -Uri $uriget -Headers $hdr -ContentType "application/json"
    }
    catch [Exception]
    {
        Write-Host $_
        Write-Host $_.Exception.Message
        Exit 101
    }

    #Only return meetings for today or later
	$name = $user.Split(" ")
    return ($getmeetings | Where-Object{ $_.subject -eq ($name[0] + "'s Meeting") })
}

#Returns a url to start the meeting...needs to be run on local machine on a SHOW lsam
function SMA_GTMStartMeeting($accessToken,$meeting)
{
    $hdr = @{"Authorization" = "Bearer " + $accessToken}
    
    $uriget = "https://api.getgo.com/G2M/rest/meetings/" + $meeting + "/start"

    try
    {
        $meeting = (Invoke-RestMethod -Method GET -Uri $uriget -Headers $hdr -ContentType "application/json")
    }
    catch [Exception]
    {
        Write-Host $_
        Write-Host $_.Exception.Message
        Exit 101
    }

    return $meeting
}

#Handles getting/setting Global Properties and GTM tokens each time script is run
function SMA_GTMSetup($url,$token,$user)
{
	SMA_IgnoreSelfSignedCerts
    $refreshToken = (SMA_GetGlobalProperty -url $url -token $token -name ("GTM_" + $user + "_REFRESH")).value
	$encodeToken = (SMA_GetGlobalProperty -url $url -token $token -name ("GTM_" + $user + "_ENCODE")).value
	if($refreshToken -and $encodeToken)
	{
		$gtm = SMA_GTMLoginRefresh -refresh $refreshToken -token $encodeToken
	}
    SMA_SetGlobalProperty -url $url -token $token -name ("GTM_" + $user + "_ACCESS") -value $gtm.access_token
	SMA_SetGlobalProperty -url $url -token $token -name ("GTM_" + $user + "_REFRESH") -value $gtm.refresh_token
	
	return $gtm.access_token
}
