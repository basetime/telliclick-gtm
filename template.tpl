___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Telliclick Tag",
  "categories": [
    "MARKETING",
    "ANALYTICS",
    "PERSONALIZATION"
  ],
  "brand": {
    "id": "",
    "displayName": "Avagate"
  },
  "description": "Log custom events, purchases, and more with Telliclick.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "tag.hostname",
    "displayName": "Host URL",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "tag.id",
    "displayName": "Tag Code ID",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "tag.sid",
    "displayName": "Subscriber ID",
    "simpleValueType": true
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "tag.params",
    "displayName": "Custom Data Parameters",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "Key",
        "name": "key",
        "type": "TEXT"
      },
      {
        "defaultValue": "",
        "displayName": "Value",
        "name": "value",
        "type": "TEXT"
      }
    ],
    "newRowButtonText": "Add Element"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const queryPermission = require('queryPermission');
const sendPixel = require('sendPixel');
const encodeUriComponent = require('encodeUriComponent');

let tagId = data['tag.id'];
let domain = data['tag.hostname'];
let sid = data['tag.sid'];
let customParameters = data['tag.params'] || [];

if (tagId.indexOf("tic") !== 0){
  data.gtmOnFailure();
  return;
}

let l = 'https://' + domain + '/v1/' + tagId;
if (sid) l += "/" + sid;
const e = [];
customParameters.forEach(function(row) {
  if (row.key && row.value) {
     e.push('@'+ row.key + '=' + encodeUriComponent(row.value));
  }
});

if (e.length > 0) {
  l += '/' + e.join(",");
}

if (queryPermission('send_pixel', l)) {
  sendPixel(l);
  data.gtmOnSuccess();
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 12/16/2023, 5:59:58 AM


