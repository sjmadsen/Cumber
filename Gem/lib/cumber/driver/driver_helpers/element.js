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

UIAElement.prototype["element_tree"] = function()
{
    var child_elements = this.elements();
    var hashed_elements = [];

    for (var i=0; i < child_elements.length; i++)
    {
        hashed_elements.push(child_elements[i].element_tree());
    }

    return '{:type => "' + this.type() + '", :label => "' + this.label() + '", :name => "' + this.name() + '", :value => "' + this.value() + '", :frame => ' + this.frame() + ', :child_elements => [' + hashed_elements.join(", ") + ']}';
};



