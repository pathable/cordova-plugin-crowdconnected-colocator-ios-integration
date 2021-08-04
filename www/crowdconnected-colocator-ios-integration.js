function CrowdConnectedColocatoriOSIntegration() {}

CrowdConnectedColocatoriOSIntegration.prototype.start = function(appKey, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'CrowdConnectedColocatoriOSIntegration', 'start', [appKey]);
};

window.CrowdConnectedColocatoriOSIntegration = new CrowdConnectedColocatoriOSIntegration();

if (typeof module != 'undefined' && module.exports) {
    module.exports = new CrowdConnectedColocatoriOSIntegration();
}
