function searchWithPredicate(predicate, startElement)
{
    function recursiveSearch(predicate, startElement)
    {
        target.pushTimeout(0);
        var elements = startElement.elements();
        var found = elements.firstWithPredicate(predicate); target.popTimeout();

        if (found.isValid()) return found;

        for (var i = 0; i < elements.length; i++)
        {
            var element = elements[i];
            found = recursiveSearch(predicate, element); if (found) return found;
        }

        return null;
    }

    var timeoutInMillis = target.timeout() * 1000; var start = new Date();

    do
    {
        var now = new Date();
        var found = recursiveSearch(predicate, startElement); target.delay(0.1);

    }
    while(!found && now - start < timeoutInMillis);

    return found;
}

