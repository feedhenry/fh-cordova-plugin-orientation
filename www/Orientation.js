function DeviceOrientation(){

}

DeviceOrientation.prototype.setOrientation = function(newOrientation, success, fail){
  this.success = success;
  this.fail = fail;
  cordova.exec(success, fail, "Orientation", "setOrientation", [newOrientation]);
}

DeviceOrientation.prototype.success = function(currentOri){
  if(this.success){
    this.success(currentOri);
  }
}

cordova.addConstructor(function() {
                        
    if(!window.plugins)        {
        window.plugins = {};
    }
        
    window.plugins.deviceOrientation = new DeviceOrientation();
});



