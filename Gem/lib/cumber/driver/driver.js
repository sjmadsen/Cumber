#import "driver_helpers/helpers.js"

//automation globals
var target = UIATarget.localTarget();
var frontApp = target.frontMostApp();
var mainWindow = frontApp.mainWindow();
var system = target.host();
var verboseLogging = system.performTaskWithPathArgumentsTimeout("/usr/bin/defaults", ["read", "com.apple.dt.InstrumentsCLI", "UIAVerboseLogging"], 600).stdout;

UIATarget.onAlert = function(alert) 
{    
    return true;
}

var log = function(message)
{
    if (verboseLogging == '')
    {
        UIALogger.logDebug(message);
    }
}

var escapeRegExp = function(str) 
{
  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
}

var replaceAll = function(find, replace, str) 
{
  return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}

var requestCommand = function(response)
{
    var command = system.performTaskWithPathArgumentsTimeout("/usr/bin/curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", response, "http://localhost:8080/device"], Number.MAX_VALUE);

    var commandJson = eval("(" + command.stdout + ")");

    return commandJson.message;
}

var requestFirstCommand = function()
{
    return requestCommand('{"message":"", "status":"connecting"}');
}

var executeCommand = function(command)
{
    log("Executing Command: "+ command);

    var response;

    try
    {
       response = eval(command);
       response = formatResponse(response, "success");
    }
    catch(err)
    {
       response = formatResponse("", "error");
    }

    return response;
}

var formatResponse = function(response, status)
{
    var res = replaceAll("'", "\\'", ""+response);
    res = replaceAll('"', '\\"', res);
    log("Response: "+ res);
    return '{"message":"' + res + '", "status":"'+ status +'"}';
}

var main = function()
{
    var command = requestFirstCommand();
    var response;

    while (true)
    {
        response = executeCommand(command);
        command = requestCommand(response);
    }
}

log("Instruments listening");
main();
