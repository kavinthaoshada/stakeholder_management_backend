import ballerina/email;
import ballerina/io;

// Function to send an email
public function sendEmailSetOfStakeholders(EmailDetails emailDetails) returns error? {

    // Configure SMTP settings
    email:SmtpConfiguration smtpConfig = {
        port: 587, // Specify the port number
        security: email:START_TLS_AUTO // Specify security type
    };

    // Create the SMTP client
    email:SmtpClient smtpClient = check new email:SmtpClient(
        host = "smtp.gmail.com", // Use Gmail's SMTP server
        username = "from@gmail.com", // Your email
        password = "abcc cccc cccc cccc", // Your email password (consider using an app password)
        clientConfig = smtpConfig
    );

    // Create the email message
    email:Message emailMessage = {
        'from: "from@gmail.com", // Your email address
        to: [emailDetails.recipient],
        subject: emailDetails.subject,
        body: emailDetails.body
    };

    // Send the email
    check smtpClient->sendMessage(emailMessage);
}

// Main function to send emails to multiple recipients
public function main() returns error? {
    // Define a list of email details
    EmailDetails[] emailList = [
        {recipient: "manula1@gmail.com", subject: "Subject 1", body: "Body of the first email."},
        {recipient: "manula2@gmail.com", subject: "Subject 2", body: "Body of the second email."},
        {recipient: "manula3@gmail.com", subject: "Subject 3", body: "Body of the third email."}
    ];
    
    // Send each email
    foreach EmailDetails email in emailList {
        // Send email and capture any error
        error? result = sendEmailSetOfStakeholders(email);
        if (result is error) {
            io:println("Failed to send email to ", email.recipient, ": ", result.message());
        } else {
            io:println("Email sent successfully to ", email.recipient);
        }
    }
}


// Function to send an email
function sendEmailToStakeholder(string recipientEmail, string subject, string messageBody) returns error? {
    // Create an SMTP client with the configuration
    email:SmtpClient smtpClient = check new (host = "smtp.gmail.com",
        port = 465,
        username = "your@gmail.com", // Your email
        password = "cccc cccc cccc cccc",    // App password or SMTP server password
        security = email:SSL
        // auth = true,
    );

    // Define the email message
    email:Message emailMessage = {
        'from: "your@gmail.com",
        to: recipientEmail,
        subject: subject,
        body: messageBody
    };

    // Send the email
    check smtpClient->sendMessage(emailMessage);
    log:printInfo("Email sent successfully to " + recipientEmail);
}

// Example usage
// public function main() returns error? {
//     string stakeholderEmail = "manula@gmail.com"; // Replace with the stakeholder's email
//     string subject = "Survey Reminder";
//     string messageBody = "Dear Stakeholder, please complete the survey using the provided link.";

//     // Send the email
//     check sendEmailToStakeholder(stakeholderEmail, subject, messageBody);
// }