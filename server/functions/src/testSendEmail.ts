import nodemailer from "nodemailer";
import { google } from "googleapis";
import * as dotenv from "dotenv";

// the code in this file can be used to test the nodemailer function seperately which is used to send the custom email
// to send the custom email you need to create a project on google cloud console 
// then use the gmail API and enable it 
// create credentials for using the gmail API
// use this credentials in the website: https://developers.google.com/oauthplayground/
// here you can generate the refresh token for providing the oauth2client
// the refresh token does not expire usually but can expire due to long periods of inactivity or issuing too many refresh tokens which can cause older ones to expire

dotenv.config();
// the env variables wont be accessible here as it is placed in the functions root directory but not within the src

console.log("Client ID:", process.env.GOOGLE_CLOUD_CLIENT_ID);
console.log("Client Secret:", process.env.GOOGLE_CLOUD_CLIENT_SECRET);
console.log("Refresh Token:", process.env.GMAIL_REFRESH_TOKEN);
const OAuth2 = google.auth.OAuth2;

// 
const oauth2Client = new OAuth2(
  process.env.GOOGLE_CLOUD_CLIENT_ID, // Replace with your own Client ID
  process.env.GOOGLE_CLOUD_CLIENT_SECRET, // Replace with your own Client Secret
  process.env.GOOGLE_CLOUD_REDIRECT_URI // Redirect URL
);


oauth2Client.setCredentials({
  refresh_token: process.env.GMAIL_REFRESH_TOKEN, // Replace with your own Refresh Token
});

async function sendCustomVerificationEmail(_email: string, _link: string) {
  const accessToken = await oauth2Client.getAccessToken();

  const transporter = nodemailer.createTransport({
    service: "gmail",
    port: 587,
    secure: false,
    auth: {
      type: "OAuth2",
      // Replace with your email address
      // the email address which you have added in the google cloud project test users for project
      user: process.env.USER_GMAILID,
      clientId: process.env.GOOGLE_CLOUD_CLIENT_ID, // Replace with your own Client ID
      clientSecret: process.env.GOOGLE_CLOUD_CLIENT_SECRET, // Replace with your own Client Secret
      refreshToken: process.env.GMAIL_REFRESH_TOKEN, // Replace with your own Refresh Token
      accessToken: accessToken.token as string,
    },
  });

  const mailOptions = {
    from: process.env.USER_GMAILID, 
    to: _email,
    subject: "Email Verification",
    text: `Please verify your email by clicking the following link: ${_link}`,
    html: `<b>Please verify your email by clicking the following link: <a href="${_link}">Verify Email</a></b>`,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log("Verification email sent to:", _email);
  } catch (error) {
    console.error("Error sending verification email:", error);
    throw new Error("Error sending verification email");
  }
}

async function testSendEmail() {
  // Replace with a test email address
  // the test email address should be an existing one 
  const testEmail = "yourtestgmail@gmail.com";
  const testLink = "https://example.com/verify"; 

  try {
    await sendCustomVerificationEmail(testEmail, testLink);
    console.log("Test email sent successfully");
  } catch (error) {
    console.error("Test email failed", error);
  }
}

testSendEmail();

// to run this code you have to use the dev dependency ts-node 
// run the command : ts-node testSendEmail.ts 
// this command should be run in the directory src present in the functions