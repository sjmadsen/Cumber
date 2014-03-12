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
};

function log(message)
{
    if (verboseLogging == '')
    {
        UIALogger.logDebug(message);
    }
}

function escapeRegExp(str)
{
  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
}

function replaceAll(find, replace, str)
{
  return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
}

function requestCommand(response)
{
    var command = system.performTaskWithPathArgumentsTimeout("/usr/bin/curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", response, "http://localhost:8080/device"], Number.MAX_VALUE);

    var commandJson = eval("(" + command.stdout + ")");

    return commandJson.message;
}

function requestFirstCommand()
{
    return requestCommand('{"message":"", "status":"connecting"}');
}

function executeCommand(command)
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

function formatResponse(response, status)
{
    var res = replaceAll("'", "\\'", ""+response);
    res = replaceAll('"', '\\"', res);

    res = '{"message":"' + res + '", "status":"'+ status +'"}           ';
    log("Response: "+ res);
    return res;
}

function main()
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
