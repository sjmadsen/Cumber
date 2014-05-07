UIAElement.prototype["hit_point"] = function()
{
    return '{:x => "' + this.hitpoint().x + '", :y => "' + this.hitpoint().y + '"}';
};

UIAElement.prototype["frame"] = function()
{
    return '{:origin => {:x => "' + this.rect().origin.x + '", :y => "' + this.rect().origin.y + '"}, :size => {:width => "' + this.rect().size.width + '", :height => "' + this.rect().size.height + '"}}';
};

UIAElement.prototype["type"] = function()
{
    var object = this.toString();
    var type =  object.split(" ")[1];
    return type.substring(0, type.length - 1);
};

UIAElement.prototype["description"] = function()
{
    return '{:type => "' + this.type() + '", :label => "' + this.label() + '", :name => "' + this.name() + '", :value => "' + this.value() + '", :frame => ' + this.frame() + '}';
};

UIAElement.prototype["sub_element_tree"] = function()
{
    var child_elements = this.elements();
    var hashed_elements = [];

    for (var i=0; i < child_elements.length; i++)
    {
        hashed_elements.push(child_elements[i].sub_element_tree());
    }

    var elements = '"null"';
    if (child_elements.length > 0)
    {
        elements = "[" + hashed_elements.join(', ') + "]";
    }

    var frame = '[{"Origin": [{"X": "' + this.rect().origin.x + '"}, {"Y": "' + this.rect().origin.y + '"}]}, {"Size": [{"Width": "' + this.rect().size.width + '"}, {"Height": "' + this.rect().size.height + '"}]}]';
    return '{"' + this.type() + '": [{"Label":"' + this.label() + '"}, {"Name": "' + this.name() + '"}, {"Value": "' + this.value() + '"}, {"Frame": ' + frame + '}, {"Child Elements": '+ elements +'}]}';
};

UIAElement.prototype["element_tree"] = function()
{
    return '[' + this.sub_element_tree() + ']';
};



