# Crowd Connected Colocator iOS integration

An iOS Cordova plugin that handles all the specific settings of iOS for the [Crowd Connected Colocator Cordova plugin](https://developers.colocator.net/mobile/getting-started/cordova/).

## Usage

The core plugin module is exposed via the global `window.CrowdConnectedColocatoriOSIntegration` object.

### Example usage

```javascript
window.CrowdConnectedColocatoriOSIntegration.start(<appKey>, <successCallback>, <errorCallback>);
```
