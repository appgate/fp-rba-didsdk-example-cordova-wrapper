//
// Disclaimer
//MIT License

//Copyright (c) 2021 Appgate Cybersecurity, Inc. 

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//


var exec = require('cordova/exec');

var DetectIDCordovaPlugin = {
    didInit: function (success, fail) {
        exec(success, fail, "DIDPlugRegistrationApi", "didInit", []);
    },
    didRegistration: function (success, fail, url) {
        exec(success, fail, "DIDPlugRegistrationApi", "didRegistration", [{"url": url}]);
    },
    didRegistrationByQRCode: function (success, fail, data) {
        exec(success, fail, "DIDPlugRegistrationApi", "didRegistrationByQRCode", [{"data": data}]);
    },
    setPushTransactionViewProperties: function (success, fail, pushTransactionViewProperties) {
        exec(success, fail, "DIDPlugPushApi", "setPushTransactionViewProperties", ["" + JSON.stringify(pushTransactionViewProperties)]);
    },
    setPushQuickActionServerResponseListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushTransactionServerResponseListener", []);
    },
    setPushTransactionReceiveListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushTransactionReceiveListener", []);
    },
    setPushTransactionOpenListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushTransactionOpenListener", []);
    },
    setPushTransactionActionListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushTransactionActionListener", []);
    },
    setPushAlertViewProperties: function (success, fail, setPushAlertViewProperties) {
        exec(success, fail, "DIDPlugPushApi", "setPushAlertViewProperties", [setPushAlertViewProperties]);
    },
    confirmPushTransactionAction: function (success, fail, transactionJson) {
        exec(success, fail, "DIDPlugPushApi", "confirmPushTransactionAction", [transactionJson]);
    },
    declinePushTransactionAction: function (success, fail, transactionJson) {
        exec(success, fail, "DIDPlugPushApi", "declinePushTransactionAction", [transactionJson]);
    },
    setPushAlertReceiveListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushAlertReceiveListener", []);
    },
    setPushAlertOpenListener: function (success, fail) {
        exec(success, fail, "DIDPlugPushApi", "setPushAlertOpenListener", []);
    },
    approvePushAlert: function (success, fail, transactionJson) {
        exec(success, fail, "DIDPlugPushApi", "approvePushAlertAction", [transactionJson]);
    },
    setPushAuthenticationResponseAdditionalInfo: function (success, fail, additionalInfoJson) {
        exec(success, fail, "DIDPlugPushApi", "setPushAuthenticationResponseAdditionalInfo", [additionalInfoJson]);
    },
    updateGlobalConfig: function (success, fail, account) {
        exec(success, fail, "DIDPlugOtpApi", "updateGlobalConfig", [account]);
    },
    getAccounts: function (success) {
        exec(success, null, "DIDPlugAccountsApi", "getAccounts", [{}]);
    },
    getChallengeTokenValue: function (success, fail, account, answer) {
        exec(success, fail, "DIDPlugOtpApi", "getChallengeTokenValue", [{
            "answer": answer,
            "account": account
        }]);
    },
    getTokenValue: function (success, fail, account) {
        exec(success, fail, "DIDPlugOtpApi", "getTokenValue", [account]);
    },
    getTokenTimeStepValue: function (success, fail, account) {
        exec(success, fail, "DIDPlugOtpApi", "getTokenTimeStepValue", [account]);
    },
    
    /* Manage account */
    
    removeAccount: function (success, fail, account) {
        exec(success, fail, "DIDPlugAccountsApi", "removeAccount", [{"currentAccount": account}]);
    },
    setAccountUsername: function (success, fail, username, account) {
        exec(success, fail, "DIDPlugAccountsApi", "setAccountUsername", [{
            "username": username,
            "currentAccount": account
        }]);
    },

    /* QR Authentication */
    
    qrAuthenticationProcess: function (success, fail, account, qrContent) {
        exec(success, fail, "DIDPlugQRAuthenticationApi", "qrAuthenticationProcess", [{
            "account": account,
            "data": qrContent,
        }]);
    },
    onConfirmQRCodeTransaction: function (success, fail, transaction) {
        exec(success, fail, "DIDPlugQRAuthenticationApi", "confirmQRCodeTransaction", [transaction]);
    },
    onDeclineQRCodeTransaction: function (success, fail, transaction) {
        exec(success, fail, "DIDPlugQRAuthenticationApi", "declineQRCodeTransaction", [transaction]);
    },

};

module.exports = DetectIDCordovaPlugin;