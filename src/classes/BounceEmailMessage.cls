public class BounceEmailMessage {
	
    @future
    public static void sendBounceEmail(String fromAddress){
        System.debug('From Address : ' + fromAddress);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                    
        mail.setToaddresses(new string[]{fromAddress});
        mail.setHtmlBody('Please reply with the registered email id');
        mail.setSubject('Cannot reply with this email id');
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        System.debug('success value : '+results.get(0).isSuccess());
        if (!results.get(0).isSuccess()) {
            System.StatusCode statusCode = results.get(0).getErrors()[0].getStatusCode();
            String errorMessage = results.get(0).getErrors()[0].getMessage();
            System.debug('StatusCode : ' + statusCode + '---' + 'Error Message : ' + errorMessage);
        }
    }
}