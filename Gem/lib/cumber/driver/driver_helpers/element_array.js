UIAElementArray.prototype["description"] = function()
{
    var elementArray = this.toArray();
    var hashedElements = "[" + elementArray[0].description();

    for ( var i=1; i < elementArray.length; i++)
    {
        hashedElements = hashedElements + ", " + elementArray[i].description();
    }

    return hashedElements + "]";
};
