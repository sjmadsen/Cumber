UIAElement.prototype["hit_point"] = function()
{
    return "{:x => '" + this.hitpoint().x + "', :y => '" + this.hitpoint().y + "'}";
};

UIAElement.prototype["frame"] = function()
{
    return "{:origin => {:x => '" + this.rect().origin.x + "', :y => '" + this.rect().origin.y + "'}, :size => {:width => '" + this.rect().size.width + "', :height => '" + this.rect().size.height + "'}}";
};



