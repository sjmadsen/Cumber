#import "driver_helpers/helpers.js"

//automation globals
var target = UIATarget.localTarget();
var frontApp = target.frontMostApp();
var mainWindow = frontApp.mainWindow();
var system = target.host();

UIATarget.onAlert = function(alert) 
{    
    return true;
};

var log = function(message) 
{    
    UIALogger.logMessage(message);
};

var escapeRegExp = function(str) 
{
  return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
};

var replaceAll = function(find, replace, str) 
{
  return str.replace(new RegExp(escapeRegExp(find), 'g'), replace);
};

var convertSpecialChars = function(str) 
{
    str = replaceAll("&91;", "[", str);
    str = replaceAll("&93;", "]", str);
    str = replaceAll("&34;", "\"", str);
    str = replaceAll("&32;", " ", str);
    str = replaceAll("&123;", "{", str);
    str = replaceAll("&125;", "}", str);
    str = replaceAll("&38;", "&", str);

    return str;
};

var requestCommand = function(response)
{
    var command = system.performTaskWithPathArgumentsTimeout("/usr/bin/curl", ["-X", "POST", "-H", "Content-Type: application/json", "-d", response, "http://localhost:8080/device"], 600);

    var commandJson = eval("(" + command.stdout + ")");

    return commandJson.message;
};

var requestFirstCommand = function()
{
    return requestCommand('{"message":"", "status":"connecting"}');
};

var executeCommand = function(command)
{
    var cmd = convertSpecialChars(command);
    log("Executing Command: "+ cmd);

    var response;

    try
    {
       response = eval(cmd);
       response = formatResponse(response, "success");
    }
    catch(err)
    {
       response = formatResponse("", "error");
    }

    return response;
};

var formatResponse = function(response, status)
{
    log("Response: "+ response);
    return '{"message":"' + response + '", "status":"'+ status +'"}';
};

var main = function()
{
    var command = requestFirstCommand();
    var response;

    while (true)
    {
        response = executeCommand(command);
        command = requestCommand(response);
    }
};

log("Instruments listening");
main();
