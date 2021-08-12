var exec = require("cordova/exec");

var MODULE_NAME = "CrowdConnectedColocatoriOSIntegration";

var EMPTY_CALLBACK = function() {}

module.exports = {
    start: function(appKey, successCallback, errorCallback) {
        if (typeof(appKey) !== 'string') {
            throw "[" + MODULE_NAME + "] start error: The 1st argument must be a String appKey";
        }

        onSuccess = successCallback || EMPTY_CALLBACK;
        onError = errorCallback || EMPTY_CALLBACK;
        exec(onSuccess, onError, MODULE_NAME, 'start', [appKey]);
    }
};
