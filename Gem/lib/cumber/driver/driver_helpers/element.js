UIAElement.prototype["hit_point"] = function()
{
    return "{:x => '" + this.hitpoint().x + "', :y => '" + this.hitpoint().y + "'}";
}

UIAElement.prototype["frame"] = function()
{
    return "{:origin => {:x => '" + this.rect().origin.x + "', :y => '" + this.rect().origin.y + "'}, :size => {:width => '" + this.rect().size.width + "', :height => '" + this.rect().size.height + "'}}";
}

UIAElement.prototype["type"] = function()
{
    var object = this.toString();
    var type =  object.split(" ")[1];
    return type.substring(0, type.length - 1);
}

UIAElement.prototype["description"] = function()
{
    return "{:type => '" + this.type() + "', :label => '" + this.label() + "', :name => '" + this.name() + "', :value => '" + this.value() + "',  :frame => " + this.frame() + "}";
}



