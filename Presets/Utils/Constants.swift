import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    static let appLaunchCount: String           = "appLaunchCount"
    static let favouritePresets: String         = "favouritePresets"
}

enum AmplitudeEvents {
    static let subscription: String             = "subscribe"
    static let firstTimeLaunch: String          = "launch_first_time"
    static let appLaunch: String                = "app_launch"
    static let watchAd: String                  = "ad_watch"
    static let onboarding: String               = "onboardingView"
    static let subscriptionButtonTap: String    = "subscription_tap"
    static let paywallClose: String             = "paywall_closed"
    static let ratingRequest: String            = "rating_request"
    static let subscribtion: String             = "subscribe"
    static let afterSubscriptionAd: String      = "ad_after_subscription_watch"
}

enum Keys {
    
    static let appleAppId: String               = "1581576260"
    
    // RevenueCat
    internal enum RevenueCat {
//        static let apiKey: String               = "tRLwqURoAceMzyFpDyjwjsOVimeAajBy" // DEBUG
        static let apiKey: String               = "AOyerJDdXCsOPBzfUledPlrOYXJvkhzX" // RELEASE
        static let entitlementId: String        = "premium"
    }
    
    // Amplitude
    internal enum Amplitude {
        static let apiKey: String               = "57daf38d4f5529a9d79bfc46d341ad31"
    }
    
    // OneSignal
    internal enum OneSignal {
        static let appId: String                = "53aa320e-7a1c-4d28-ab0e-926440c12058"
    }
    
    // AdMob
    internal enum AdmMod {
        static let appId: String                = "ca-app-pub-9686541093041732~7231766062"
//        static let unitId: String               = "ca-app-pub-3940256099942544/4411468910" // DEBUG
        static let unitId: String               = "ca-app-pub-9686541093041732~7231766062" // RELEASE
    }
    
    // AppsFlyer
    internal enum AppsFlyer {
//        static let devKey: String               = "HC375dSqjhViQMeSB8miEN" // DEBUG
        static let devKey: String               = "5VCYcU4KGxS56mN9DjpnoN" // RELEASE
    }
    
    internal enum Prodinfire {
        static let apiKey: String               = "!G245JF7fh9s4tnFSwd83rJDKn"
    }
    
    internal enum AppMetrika {
        static let apiKey: String               = "6d534592368c4f1c93479f7e67a5b08e"
    }
    
}

public func hapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}

internal let FullPrivacyPolicy = """
    1. Responsible unit/contact
    If you have any questions or suggestions regarding data protection, please do not hesitate to contact us at info@artpoldev.com
    
    2. Subject of data protection
    The subject of data protection is personal data. Under Section 3(1) of the BDSG such data include individual information on personal or factual circumstances of a certain or determinable private individual. This includes, for instance, details such as the name, e-mail address or telephone number, or usage data, if applicable. Usage data are such data that are required or created in order to use the our app, such as details on the start, end and scope of the usage of our app.
    
    3. Collection and use of data
    Our APP is a non-obligatory log network. ARTPOLDEV SP. Z O.O. are not available for the information related to the personal information of users, including but not limited to names (subscriber names, user names and screen names), addresses (including mailing addresses, residential address, business addresses) and telephones, unless the data you provide depending on the context of your interactions with us and the choices you make, including your privacy settings, and the products and features you use for the purpose of administering your subscription and for the purpose to enjoy our APP services. Except for the limited exceptions, we don't automatically collect any Personal Information from you. When you open the APP seeking for our APP services, the APP assigns a unique identifier to you for the service (such unique identifier just binds up with your device identification code, but does not tie to any other personal information of users). When you use the APP services, we will check your account information through this unique identifier to determine the level of service you have signed up for before establishing your APP connection. With some forms of payment, certain Mac version of our APP services may redirect you to the website of a third-party payment processor (namely PayPal) to complete the transaction. To understand what personal information the processor collects and stores, please refer to the respective processor's terms and privacy policy. Therefore, except for the limited exception above, we do not know any means or source of user's detailed payment for APP services (including any credit card or bank account number) or any billing records either. If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide. We may also receive a confirmation when you open an email from us. ARTPOLDEV SP. Z O.O. uses your email address (if any depending on your choice) for the following reasons:
    
    To communicate with you about your APP services or respond to your communications.
    To send you updates and announcements.
    To send marketing information, such as ARTPOLDEV SP. Z O.O. offers, surveys, invitations, and content about other matters in connection with ARTPOLDEV SP. Z O.O. ("Marketing emails"). You may choose to not receive Marketing emails by following the opt-out procedure described in these emails.
    ARTPOLDEV SP. Z O.O. uses your personal information only for the purposes listed in this Privacy Policy, and we don't sell your personal information to third parties without your prior consent.
    
    4. App permissions
    
    App use the following permissions:
    
    Access to the microphone: The App requires access to the microphone in order to enable voice translation.
    
    Permission for calendar: If you want to use calendar based proposals for smart naming you can optionally allow this permission.
    
    Permissions for contacts: If you would like to use your contacts for sending translation you can optionally allow this permission.
    
    Permission for location: If you want to use location based proposals for smart naming you can optionally allow this permission.
    
    Permission for Push Notifications: Optional you can allow the app to send push notifications, e.g. for reminders.
    
    Mobile Data: Optional permission to use the mobile data network for uploading your files to the cloud storage service of your choice.
    
    Your translations are your creation – your transcripts are stored locally on your device.
    
    5. Data provided by the user
    Subject to applicable laws and for the avoidance to infringe any internet service provider, any browsing information, traffic destination, data content, IP addresses, DNS queries or other similar information relating to your online activities transmitted by you to our servers is encrypted and cleared after the APP "session" is closed. That said, we don't collect any information regarding the websites you visit or any data stored on or transmitted from your device, including any data that applications on your device may transmit through the APP network. More specifically, ARTPOLDEV SP. Z O.O. has NO documents/information below under the situations of the limited connecting with your personal information and the non-collection of the websites you visit or any data stored on or transmitted from your device:
    
    We do not know which user ever accessed a particular website or service.
    We do not know which user was connected to the APP at a specific time.
    We do not know the set of original IP addresses of a user's computer or the temporarily assigned network addresses.
    If anyone would like to access to or try to compel ARTPOLDEV SP. Z O.O. to release user information based on any of the above, we cannot supply this information because the data don't exist.
    
    For the purpose to fulfill our contractual obligations in good faith and to make you enjoy excellent APP services, we collect the following information related to your APP usage: Information related to Apps and Apps versions We collect information related to which Apps and Apps version(s) you have activated. It makes our Support Team efficiently find out and eliminate technical issues for you. Information related to Connection We collect information about whether a APP connection is successful on a particular day (but not a specific time of the day), to which APP location (but not your assigned outgoing IP address), and from which country/ISP (but not your source IP address). The minimal information allows us to provide efficient technical support to you, such as identifying connection problems, providing country-specific advice about how to use our APP services, and to enable our engineers to identify and fix network issues.
    
    6. Disclosure of data
    We do not disclose your personal data to third parties without having informed you in advance and having obtained your consent. Only in the following exceptions we may disclose your personal data to third parties without having notified you in advance:
    
    Insofar as it serves to determine any illegal use of our website or the app or criminal prosecution, personal data may be disclosed to law-enforcement authorities and, in the event of specific indications of the existence of legal violations, to damaged third parties, if applicable. The disclosure of data may also occur if it serves to enforce general terms and conditions or other agreements. Furthermore, we are legally obligated to disclose information to certain public offices on their request, including law enforcement bodies, authorities which may impose fines and fiscal authorities.
    
    Occasionally, we require external agencies and service providers for the provision of services. In such cases, the information is disclosed to these companies or persons for further processing. These external service providers are carefully selected by us and regularly assessed in order to ensure that your privacy is protected. The service providers may use personal data exclusively for the purposes stated by us in observance with this data protection declaration.
    
    Within the framework of the development of our business, the structure of ARTPOLDEV SP. Z O.O. may change. The legal form may be changed and subsidiaries or holdings established, purchased or sold. For such transactions, customer data are disclosed along with the part of the company that is to be transferred. Whenever personal data are disclosed to third parties, in the above scope, we will ensure that the transmission takes place in accordance with this data protection declaration and the relevant data protection laws.
    
    7. Deletion of your data
    Insofar as your data is no longer required for the above purposes, it is deleted. In the event that data needs to be stored for legal reasons, it is blocked instead. The data will then no longer be available for further use.
    
    8. Right of information and correction
    You have the right to receive information on the data stored by ARTPOLDEV SP. Z O.O. relating to you. You also have the right to correct, block and have deleted incorrect data. To this end, please contact info@artpoldev.com or write a letter to the above address.
    
    9 . Amendment to this data protection declaration
    ARTPOLDEV SP. Z O.O. reserves the right to amend this data protection declaration. The current version of the data protection declaration can be accessed at any time at https://artpoldev.com/privacy.html.
    """

internal let FullTermsOfUse = """
A. AGREEMENT:
This End-User License Agreement (including the Supplemental Terms, as applicable) (“EULA”) is a legal agreement between you and ARTPOLDEV SP. Z O.O., a Russianregistered company,(“ARTPOLDEV SP. Z O.O.”, “we”, “us” or “our”) which governs your use of the our app. By installing or otherwise using the our app, you: (a) agree to be bound by the terms and conditions of this EULA, (b) you represent and warrant that you own or control the mobile device in which the our app will be installed, and (c) you represent and warrant that you have the right, authority and capacity to enter into this EULA and to abide by all its terms and conditions, just as if you had signed it. The terms and conditions of this EULA also apply to any our app updates, supplements, and services that are not provided under a separate license or other agreement with us. If you do not agree to the terms and conditions of this EULA, do not install or use any our app. We may amend these terms and conditions from time to time. If the changes include material changes that affect your rights or obligations, we will notify you of the changes by reasonable means. You acknowledge that an in-app message which notifies you of such changes when you open up the our app shall constitute reasonable means. Your continued use of the our app after we post any amendments to this EULA will signify your acceptance of such amendments. If you do not agree with any amendment, you must discontinue using the our app. If you have any questions or concerns regarding the terms or conditions herein, please email us at info@artpoldev.com. Do not use the our app until your questions and concerns have been answered to your satisfaction and you agree to abide by the EULA.

Notice to consumers: Depending on the laws of the jurisdiction where you live, you may have certain rights that cannot be waived through this EULA and that are in addition to the terms of this EULA, and certain provisions of this EULA may be unenforceable as to you. To the extent that any term or condition of this EULA is unenforceable, the remainder of the EULA shall remain in full force and effect.

Use of the our app is subject to our https://artpoldev.com/privacy.html., which is hereby incorporated into this EULA by reference. This EULA also includes any additional payment terms and other requirements set forth on the download or purchase page through which you purchase or download the our app. The our app may be available through marketplaces that distribute mobile applications and that may have additional terms, conditions and usage rules that govern your use of the our app if you download or install the our app through such marketplaces.

B. AGE REQUIREMENT:
You must be 13 years of age or older to install or to use the our app. If you are at least 13 but not yet 18 years of age, please have your parent or legal guardian review this EULA with you, discuss any questions you might have, and install the our app for you.

NOTICE TO PARENTS AND GUARDIANS: By granting your child permission to download and access a our app, you agree to the terms and conditions of this EULA on behalf of your child. You are responsible for exercising supervision over your children’s online activities. If you do not agree to this EULA, do not let your child use the our app or associated features. If you are the parent or guardian of a child under 13 and believe that he or she is using the our app, please contact us at info@artpoldev.com.

C. GRANT OF LICENSE:
Subject to your compliance with the terms and conditions of this EULA, ARTPOLDEV SP. Z O.O. grants you a limited, non-exclusive, revocable, non-sublicensable, non-transferable license, to access, download and install the most current generally available version of the our app on a single, authorized mobile device that you own or control solely for your lawful, personal, and non-commercial entertainment use.

D. DESCRIPTION OF OTHER RIGHTS AND LIMITATIONS:
1. Restricted Use
You may not rent, sell, lease, sublicense, distribute, assign, copy (other than a single copy for your own backup purposes), or in any way transfer or grant any rights to the our app or use the our app for the benefit of any third party. Unless expressly authorized by ARTPOLDEV SP. Z O.O. or permitted under the applicable mobile platform terms, you are prohibited from making the our app available over a network where it could be downloaded or used by multiple users. You agree that you will not use any robot, spider, other automatic or manual device or process to interfere or attempt to interfere with the proper working of the our app, except to remove our our app from a mobile device which you own or control. You may not violate or attempt to violate the security of our services. You may not modify, reverse-engineer, decompile, disassemble, or otherwise tamper with any our app, or attempt to do so for any reason or by any means. You may not access, create or modify the source code of any our app in any way. You do not have the right to and may not create derivative works of any our app or any portions thereof. All modifications or enhancements to the our app remain the sole property of ARTPOLDEV SP. Z O.O.

2. our app Updates.
We reserve the right to add or remove features or functions to existing our app. When installed on your mobile device, the our app periodically communicate with our servers. We may require the updating of the our app on your mobile device when we release a new version of the our app, or when we make new features available. This update may occur automatically or upon prior notice to you, and may occur all at once or over multiple sessions. You understand that we may require your review and acceptance of our then-current EULA before you will be permitted to use any subsequent versions of the our app. You acknowledge and agree that any obligation we may have to support previous versions of the our app may be ended upon the availability of updates, supplements or subsequent versions of the our app. You acknowledge and agree that we have no obligation to make available to you any updates, supplements or subsequent versions of the our app.

3. Access.
You must provide at your own expense the equipment, Internet connections, devices and service plans to access and use the our app. If you access a our app through a mobile network, your network or roaming provider’s messaging, data and other rates and fees may apply. You are solely responsible for any costs you incur to access the our app from your device. Downloading, installing or using certain our app may be prohibited or restricted by your network provider and not all our app may work with your network provider or device. ARTPOLDEV SP. Z O.O. makes no representation that the our app can be accessed on all devices or wireless service plans. ARTPOLDEV SP. Z O.O. makes no representation that the our app are available in all languages or that the our app are appropriate or available for use in any particular location.

4. Purchases & Cancellation Rights.
Where you purchase from a third party: Certain our app are available for purchase from a mobile platform owner (e.g. Apple) and/or will allow you to make an in-application purchase. Payment for such purchases may be processed by third parties who act on our behalf or directly by the mobile platform owner. European Union residents normally have a right to cancel online purchases within 14 days of making them. Please note and acknowledge: if you are resident in the European Union and download a our app from a mobile platform owner (e.g. Apple), you may not be able to cancel your order or obtain a refund. Please review the mobile platform owner’s terms in this regard before purchase. This may also apply to subscriptions and in-app purchases. You can find further information on cancelling orders and any associated refunds on the website of the third party re-seller from whom you purchased the app (for example, the Apple App Store).

5. Subscription Services.
Certain our app on the Apple App Store will allow you to obtain the benefit of the application on a subscription basis. Payment for such a subscription (which may be for example daily, weekly, monthly, tri-monthly or yearly) may be processed in the application, by third parties who act on our behalf or directly by the mobile platform owner (e.g. Apple). Free trial subscriptions may be cancelled at any point up to 24 hours before the expiry of the free trial (Apple). See below in paragraph 6 (“Trial Periods”) for further information. You can cancel a subscription service at any time during the subscription period via the subscription settings in your iTunes account. The cancellation will take effect after the last day in the relevant subscription period. See above in paragraph 4 (“Purchases & Cancellation Rights”) for further information.

6. Trial Periods.
Certain of our subscription services on the Apple App Store may from time to time be offered for a fixed period of time on a free-trial basis. You are free to cancel a free-trial subscription at any time via the subscription setting in your iTunes account. Please note: your free-trial subscription will automatically renew as a paid subscription unless auto-renew is turned off at least 24 hours before the end of the free-trial subscription period (Apple).

7. Online Dispute Resolution.
If you reside in the European Union, you can find information about online dispute resolution here: https://webgate.ec.europa.eu/odr/main/index.cfm?event=main.home.show&lng=EN. Please note that we reserve the right not to participate in forms of alternative dispute resolution. For further information, please contact: info@artpoldev.com.

E. THIRD-PARTY PARTNERS:
1. Third-Party Services and Content.
The our app may integrate, be integrated into, bundled, or be provided in connection with third-party services, advertising, feeds, and/or content. If you are installing a our app that includes third party services and third party content, such services and content are subject to such third party’s terms of services and privacy policies, which may be found on the relevant Third Party Partner’s website. our app may provide access or links to Third Party Partner websites or resources. ARTPOLDEV SP. Z O.O. has no control over such websites and resources, and you acknowledge and agree that ARTPOLDEV SP. Z O.O. is not responsible for the availability of such external websites or resources, and does not endorse nor is responsible or liable for any content, advertising, products, or other materials on or available from such websites or resources. You further acknowledge and agree that ARTPOLDEV SP. Z O.O. shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with use of or reliance on any such Content (as defined below), goods or services available on or through any such website or resource. ARTPOLDEV SP. Z O.O. will not be a party to or in any way be responsible for monitoring any transaction between you and Third Party Partners.

2. Access to Third-Party Services and Content through our app.
All services, advertising, feeds and content, including without limitation, all data, links, articles, graphic or video messages and all information, text, software, music, sound, graphics or other materials (“Content”) made available or accessible through a our app, whether publicly available or privately transmitted, is the sole responsibility of the entity or person from whom it originated. You hereby acknowledge and agree that by using a our app you may be exposed to Content that may be offensive, indecent or objectionable in your community. You agree to accept all risks associated with the use of any Content, including any reliance on the accuracy or completeness of such Content. Under no circumstances will ARTPOLDEV SP. Z O.O. be liable in any way for any Content created by or originating with entities other the ARTPOLDEV SP. Z O.O., including, but not limited to, any errors or omissions in any such Content, or for loss or damage of any kind incurred as a result of the transmission or posting of such Content by means of a our app.

F. SECURITY:
Our app, like other consumer technologies, may not be 100% secure. By accepting this EULA you acknowledge and accept that the our app and any information you download or offer to share by means of a our app, may be exposed to unauthorized access, interception, corruption, damage or misuse, and cannot be regarded as 100% secure. You accept all responsibility for such security risks and any damage resulting therefrom. Further, you are solely responsible for securing your mobile device from unauthorized access, including by such means as using complex password protection. You agree that ARTPOLDEV SP. Z O.O. shall not be liable for any unauthorized access to your mobile device or the app data thereon.

G. REGISTRATION/PASSWORDS:
1. Registration.
Most our app will not require a registration: however, some our app may permit or require you to create an account to participate or access additional features or functionalities (“Registration”). If such Registration is required, it will be made known to you when you attempt to participate or access such additional features or functionalities. Any registration required by a Third Party Partner is not governed by this EULA and you should refer to the relevant Third Party Partner’s website for their policies.

2. Passwords.
You are the sole and exclusive guardian of any password and ID combination issued or chosen by to you. Maintaining the confidentiality and security of your password(s) and ID(s) is solely your responsibility. You are fully responsible for all transactions undertaken by means of any account opened, held, accessed or used via your password and ID. You shall notify us immediately and confirm in writing any unauthorized use of accounts or any breach of security, including without limitation any loss, theft or unauthorized use of your password(s), and/or ID(s) or any related account. If we have reasonable grounds to suspect that the security of your password and/or ID has been compromised, we may suspend or terminate your account, refuse any and all current or future use of the services, and pursue any appropriate legal remedies. We shall not be responsible for any losses incurred in connection with any misuse of any password or ID.

3. Provided Information.
If you provide any information in connection with a Registration, you must provide and maintain accurate, complete and current information. If we have reasonable grounds to suspect that your information is inaccurate, not current or not complete, we may suspend or terminate your use of the our app, and pursue any appropriate legal remedies. You agree that we shall have the right to use the information you provide to us for the purposes described in this EULA and in furtherance of your use of the our app our services, in accordance with the Privacy Policy located here https://artpoldev.com/privacy.html.

H. UNINSTALL/REMOVAL OF a our app:
To uninstall and remove the our app, please use the application manager provided with your device or consult your device manual for reference.

I. CONSENT TO USE OF DATA:
You agree that we may collect and use technical data and related information, including but not limited to technical information about your device, system and application software, and peripherals, that is gathered periodically to facilitate the provision of software updates, product support and other services to you (if any) related to the our app. We may use this information in accordance with the Privacy Policy located here https://artpoldev.com/privacy.html.

J. INTELLECTUAL PROPERTY:
The our app, including all design, text, images, photographs, illustrations, audio-clips, video-clips, artwork, graphic material, code, content, protocols, software, and documentation provided to you by ARTPOLDEV SP. Z O.O. are ARTPOLDEV SP. Z O.O.’s property or the property of ARTPOLDEV SP. Z O.O.’s licensors, and are protected by U.S. and international copyright, trademarks, patents and other proprietary rights and laws relating to Intellectual Property Rights. “Intellectual Property Rights” means, collectively, rights under patent, trademark, copyright and trade secret laws, and any other intellectual property or proprietary rights recognized in any country or jurisdiction worldwide, including, without limitation, moral or similar rights. You may not delete, alter, or remove any copyright, trademark, or other proprietary rights notice we or Third Party Partners have placed on or within the our app. All rights not expressly granted hereunder are expressly reserved to ARTPOLDEV SP. Z O.O. and its licensors.

The ARTPOLDEV SP. Z O.O. and ARTPOLDEV SP. Z O.O. names, logos and affiliated properties, are the exclusive property of ARTPOLDEV SP. Z O.O. or its affiliates. All other trademarks appearing on any our app are trademarks of their respective owners, and the use of such trademarks shall inure to the benefit of the trademark owner. Our partners or service providers may also have additional proprietary rights in the content which they make available through a our app. The trade names, trademarks and service marks owned by us, whether registered or unregistered, may not be used in connection with any product or service that is not ours, in any manner that is likely to cause confusion. Nothing contained in herein should be construed as granting, by implication, estoppel or otherwise, any license or right to use any of our trade names, trademarks or service marks without our express prior written consent.

K. COPYRIGHT/SUBMISSIONS:
You are solely responsible for any Content you contribute, submit or display on or through your use of the our app(s). It is your obligation to ensure that such Content, including photos, text, video and music files, does not violate any copyright or other Intellectual Property Rights. You must either own or have a license to use any Content that you contribute, submit or display.2. ARTPOLDEV SP. Z O.O. respects and expects its users to respect the rights of copyright holders. On notice, ARTPOLDEV SP. Z O.O. will act appropriately to remove content that infringes the copyright rights of others. ARTPOLDEV SP. Z O.O. reserves the right to disable the access to our app or other services by anyone who uses them to repeatedly infringe the Intellectual Property Rights of others. If you believe a our app, or elements, infringe your copyright rights, Please contact: info@artpoldev.com. Please ensure your communication includes the following:

an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright interest;
a description of the copyrighted work that you claim has been infringed;
a description of where the material that you claim is infringing is located on the our app;
your address, telephone number, and email address;
a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law;
a statement by you that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf.
3. Objectionable Content. ARTPOLDEV SP. Z O.O. may also act to remove Objectionable Content. The decision to remove Objectionable Content shall be made at ARTPOLDEV SP. Z O.O.’s sole discretion. “Objectionable Content” includes, but is not limited to:

Content that is unlawful, harmful, threatening, abusive, harassing, tortuous, defamatory, or libelous,
Content that is hateful, or advocates hate crimes, harm or violence against a person or group,
Content that may harm minors in any way;
Content that has the goal or effect of “stalking” or otherwise harassing another
Private information about any individual such as phone numbers, addresses,
Social Security numbers or any other information that is invasive of another’s privacy;
Content that is vulgar, offensive, obscene or pornographic,
Unsolicited or unauthorized advertising, promotional materials, “junk mail,” “spam,” “chain letters,” “pyramid schemes,” or any other form of solicitation;
Material that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment.
4. Content Screening and Disclosure. We do not, and cannot, pre-screen or monitor all Content. However, our representatives may monitor Content submission through the our app, and you hereby provide your irrevocable consent to such monitoring. You acknowledge and agree that you have no expectation of privacy concerning the submission of any Content. We have the right, but not the obligation, in our sole discretion to edit, refuse to post, or remove any Content.We may access, preserve or disclose any of your information or Content (including without limitation chat text) if we are required to do so by law, or if we believe in good faith that it is reasonably necessary to (i) respond to claims asserted against us or to comply with legal process (for example, subpoenas or warrants), including those issued by courts having jurisdiction over us or you; (ii) enforce or administer our agreements with users, such as this EULA; (iii) for fraud prevention, risk assessment, investigation, customer support, providing the app services or engineering support; (iv) protect the rights, property or safety of ARTPOLDEV SP. Z O.O., its users, or members of the public or (v) to report a crime or other offensive behaviour.

5. Ownership of Content You Submit. Unless otherwise set forth at the point of submission, you retain ownership of all rights in any Content that you submit, through your use of the our app. However, you grant us permission to use such Content in any way we see fit, for instance for the purposes of promotion of the our app. If, at our request, you send submissions (such as contest submissions, polling questions) or you send us creative suggestions, ideas, notes, drawings, or other information (collectively, the “Submissions”), such Submissions shall be deemed, and shall remain, the property of ARTPOLDEV SP. Z O.O.. None of the Submissions shall be subject to any obligation of confidence on the part of ARTPOLDEV SP. Z O.O., and ARTPOLDEV SP. Z O.O. shall not be liable for any use or disclosure of any Submissions. Without limitation of the foregoing, ARTPOLDEV SP. Z O.O. shall exclusively own all now known or hereafter existing rights to the Submissions of every kind and nature throughout the universe and shall be entitled to unrestricted use of the Submissions for any purpose whatsoever, commercial or otherwise, without compensation to the provider of the Submissions. You hereby assign to ARTPOLDEV SP. Z O.O. all right, title and interest in and to the Submissions and you hereby waive any moral rights (and any rights of the same or similar effect anywhere in the world existing now or in the future created) relating to the Submissions in favour of ARTPOLDEV SP. Z O.O. and its assignees, licensees and designees.

6. Repeat Infringer Policy. ARTPOLDEV SP. Z O.O. may terminate a user’s access to the our app(s) if, under appropriate circumstances, the user is determined to be a repeat infringer.

7. No Intended Third Party Beneficiaries. Except as otherwise set forth herein, no third party is an intended beneficiary of this EULA.

L. TERMINATION:
Your rights under this EULA will terminate immediately and automatically without any notice from ARTPOLDEV SP. Z O.O. if you fail to comply with any of the terms and conditions of this EULA. You understand that ARTPOLDEV SP. Z O.O., in its sole discretion, may modify or discontinue or suspend your right to access any of our services or use of any our app at any time. Further, ARTPOLDEV SP. Z O.O., with or without any reason, may at any time suspend or terminate any license hereunder and disable the our app or any of its component features. You agree that ARTPOLDEV SP. Z O.O. shall not be liable to you or any third-party for any termination or disabling of the our app. Promptly upon expiration or termination of this EULA, you must cease all use of the our app and destroy all copies of our app in your possession or control. Termination will not limit any of ARTPOLDEV SP. Z O.O.’s other rights or remedies at law or in equity. Sections J-S, and any Supplemental Terms of this EULA shall survive termination or expiration of this EULA for any reason.

M. DISCLAIMER OF WARRANTY:
TO THE EXTENT THIS IS PERMITTED BY APPLICABLE LAW, ALL our app ARE PROVIDED ON AN “AS IS,” “WITH ALL FAULTS,” AND “AS AVAILABLE” BASIS, AND YOU USE THEM AT YOUR SOLE RISK. SUBJECT TO APPLICABLE LAW, ARTPOLDEV SP. Z O.O., ON BEHALF OF ITSELF, AND ITS AFFILIATES, LICENSORS, DISTRIBUTORS, VENDORS, AGENTS AND SUPPLIERS, EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND ANY OTHER WARRANTY ARISING UNDER THE SALE OF GOODS ACTS 1893 AND 1980, USAGE OF TRADE, COURSE OF CONDUCT OR OTHERWISE. WITHOUT LIMITATION, ARTPOLDEV SP. Z O.O. MAKES NO WARRANTY THAT THE our app WILL MEET YOUR REQUIREMENTS, THAT THEY WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, THAT THE RESULTS OBTAINED FROM THE USE OF THE ARTPOLDEV SP. Z O.O. PRODUCTS WILL BE ACCURATE OR RELIABLE, OR THAT THE QUALITY OF THE our app WILL MEET YOUR EXPECTATIONS. ARTPOLDEV SP. Z O.O. ASSUMES NO LIABILITY OR RESPONSIBILITY FOR ANY PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO AND USE OF OUR our app; ANY UNAUTHORIZED ACCESS TO OR USE OF OUR SECURE SERVERS AND/OR ANY AND ALL PERSONAL INFORMATION AND/OR FINANCIAL INFORMATION STORED THEREIN; ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM our app OR SERVERS; ANY BUGS, VIRUSES, TROJAN HORSES, OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH our app BY ANY THIRD PARTY; OR ANY ERRORS OR OMISSIONS IN ANY CONTENT OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY CONTENT POSTED, EMAILED, TRANSMITTED, OR OTHERWISE MADE AVAILABLE VIA THE our app.

THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE OF THE our app REMAINS SOLELY WITH YOU.

ARTPOLDEV SP. Z O.O. EXPRESSLY DISCLAIMS ALL WARRANTIES RELATING TO PRODUCTS AND/OR SERVICES PROVIDED BY THIRD PARTY PARTNERS.

SOME JURISDICTIONS DO NOT ALLOW THE DISCLAIMER OF IMPLIED WARRANTIES. IN SUCH JURISDICTIONS, THE FOREGOING DISCLAIMERS MAY NOT APPLY TO YOU INSOFAR AS THEY RELATE TO IMPLIED WARRANTIES.

THIS DISCLAIMER OF WARRANTY CONSTITUTES AN ESSENTIAL PART OF THIS AGREEMENT.NOTICE REGARDING CALL RECORDING FEATURE: Certain our app may allow you to record phone conversations on your iOS device. Some local, state, federal or international laws prohibit the recording of third-party audio without all parties’ consent to such recording. You are solely responsible for compliance with all local, state, federal or international laws regarding call recording and obtaining any necessary consent. IN NO EVENT SHALL ARTPOLDEV SP. Z O.O. BE RESPONSIBLE TO YOU OR ANY THIRD PARTY FOR YOUR FAILURE TO COMPLY WITH LOCAL, STATE, FEDERAL OR INTERNATIONAL LAWS REGARDING THIRD-PARTY AUDIO RECORDING. The data about recordings (and recordings themselves) might be removed from ARTPOLDEV SP. Z O.O. servers at any time without notice.

N. LIMITATION OF LIABILITY:
TO THE EXTENT PERMITTED BY APPLICABLE LAWS, YOU EXPRESSLY UNDERSTAND AND AGREE THAT ARTPOLDEV SP. Z O.O. SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES, INCLUDING BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA OR OTHER INTANGIBLE LOSSES (EVEN IF ARTPOLDEV SP. Z O.O. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES), RESULTING FROM: (I) THE USE OR THE INABILITY TO USE THE our app; (II) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (III) STATEMENTS OR CONDUCT OF ANY THIRD PARTY; OR (IV) ANY OTHER MATTER RELATING TO THE our app. IN NO EVENT SHALL ARTPOLDEV SP. Z O.O.’s TOTAL LIABILITY TO YOU FOR ALL DAMAGES, LOSSES, AND CAUSES OF ACTION (WHETHER IN CONTRACT, TORT (INCLUDING, BUT NOT LIMITED TO, NEGLIGENCE), OR OTHERWISE) EXCEED THE AMOUNT PAID BY YOU, IF ANY, FOR ACCESSING THE our app. THE FOREGOING LIMITATIONS WILL APPLY EVEN IF THE ABOVE STATED REMEDY FAILS OF ITS ESSENTIAL PURPOSE.

IF ANY OF THE EXCLUSIONS SET FORTH IN THIS SECTION IS DETERMINED BY A COURT OF COMPETENT JURISDICTION TO BE UNENFORCEABLE, THEN ALL SUCH EXPRESS, IMPLIED AND STATUTORY WARRANTIES SHALL BE LIMITED IN DURATION FOR A PERIOD OF THIRTY (30) DAYS AFTER THE DATE ON WHICH YOU FIRST ACCESS THE our app, AND NO WARRANTIES SHALL APPLY AFTER SUCH PERIOD.

O. INDEMNIFICATION:
YOU AGREE TO INDEMNIFY, DEFEND AND HOLD HARMLESS ARTPOLDEV SP. Z O.O., ITS PARENTS, AFFILIATE AND SUBSIDIARY COMPANIES, OFFICERS, DIRECTORS, EMPLOYEES, CONSULTANTS AND AGENTS FROM ANY AND ALL THIRD PARTY CLAIMS, LIABILITY, DAMAGES AND/OR COSTS (INCLUDING, BUT NOT LIMITED TO, ATTORNEYS’ FEES) ARISING FROM YOUR USE OF THE our app, YOUR VIOLATION OF THE EULA OR YOUR INFRINGEMENT, OR INFRINGEMENT BY ANY OTHER USER OF YOUR ACCOUNT, OF ANY INTELLECTUAL PROPERTY OR OTHER RIGHT OF ANY PERSON OR ENTITY. YOU AGREE TO IMMEDIATELY NOTIFY ARTPOLDEV SP. Z O.O. OF ANY UNAUTHORIZED USE OF YOUR ACCOUNT OR ANY OTHER BREACH OF SECURITY KNOWN TO YOU.

P. EXPORT CONTROLS:
The our app and the underlying information and technology are subject to US and international laws, restrictions and regulations that may govern the import, export, downloading and use of the App. You agree to comply with these laws, restrictions and regulations when downloading or using the App.

Q. NOTICE TO US GOVERNMENT END USERS:
Any our app installed for or on behalf of the United States of America, its agencies and/or instrumentalities (“U.S. Government”), is provided with Restricted Rights as “commercial Items,” as that terms is defined at 48 C.F.R. §2.101, consisting of “Commercial Computer Software” and “Commercial Computer Software Documentation,” as such terms are used in 48 C.F.R. §12.212 or 48 C.F.R. §227.7202, as applicable. Pursuant to Federal Acquisition Regulation 12.212 (48 C.F.R. §12.212), the U.S. Government shall have only those rights specified in the license contained herein. The U.S. Government shall not be entitled to (i) technical information that is not customarily provided to the public or to (ii) use, modify, reproduce, release, perform, display, or disclose commercial computer software or commercial computer software documentation except as specified herein. Use, duplication, or disclosure by the U.S. Government is subject to restrictions as set forth in subparagraph (c)(1)(ii) of the Rights in Technical Data and Computer Software clause at DFARS 252.227-7013 or subparagraphs (c)(1) and (2) of the Commercial Computer Software – Restricted Rights at 48 C.F.R. 52.227-19, as applicable.

R. JURISDICTIONAL ISSUES AND OTHER MISCELLANEOUS TERMS:
ARTPOLDEV SP. Z O.O. does not represent or warrant that the our app or any part thereof is appropriate or available for use in any particular jurisdiction. We may limit the availability of the our app, in whole or in part, to any person, geographic area or jurisdiction we choose, at any time and in our sole discretion. The laws of Lithuania, without regard to conflict of laws principles, shall govern all matters relating to or arising from this EULA, and the use (or inability to use) the our app. You hereby submit to the exclusive jurisdiction and venue of the appropriate courts of Lithuania, with respect to all matters arising out of or relating to this EULA.

No failure or delay by ARTPOLDEV SP. Z O.O. in exercising any right, power or privilege under this EULA will operate as a waiver thereof, nor will any single or partial exercise of any right, power or privilege preclude any other or further exercise thereof or the exercise of any other right, power, or privilege under this EULA. If any provision of this EULA shall be found unlawful, void, or for any reason unenforceable, then that provision shall be deemed severable from these terms and shall not affect the validity and enforceability of any remaining provisions.

YOU AGREE THAT ANY CAUSE OF ACTION ARISING OUT OF OR RELATED TO THE our app MUST COMMENCE WITHIN THREE (3) YEARS AFTER THE CAUSE OF ACTION ACCRUES. OTHERWISE, SUCH CAUSE OF ACTION IS PERMANENTLY BARRED.

SUPPLEMENTAL TERMS
To the extent permitted by applicable law (and without limiting the above rights, remedies and obligations except the extent expressly in conflict with additional terms below), the following additional terms shall apply to your use of our app, as applicable:

Apple App Store: By accessing the our app through a device made by Apple, Inc. (“Apple”), you specifically acknowledge and agree that:

1. This EULA is between ARTPOLDEV SP. Z O.O. and you; Apple is not a party to this EULA.
2. The license granted to you hereunder is limited to a personal, limited, non-exclusive, non-transferable right to install the our app on the Apple device(s) authorized by Apple that you own or control for personal, non-commercial use, subject to the Usage Rules set forth in Apple’s App Store Terms of Service.
3. Apple is not responsible for our app or the content thereof and has no obligation whatsoever to furnish any maintenance or support services with respect to the our app.
4. In the event of any failure of the our app to conform to any applicable warranty, you may notify Apple, and Apple will refund the purchase price for the our app, if any, to you. To the maximum extent permitted by applicable law, Apple will have no other warranty obligation whatsoever with respect to the our app.
5. Apple is not responsible for addressing any claims by you or a third party relating to the our app or your possession or use of the our app, including without limitation (a) product liability claims; (b) any claim that the our app fails to conform to any applicable legal or regulatory requirement; and (c) claims arising under consumer protection or similar legislation.
6. In the event of any third party claim that the our app or your possession and use of the our app infringes such third party’s intellectual property rights, Apple is not responsible for the investigation, defense, settlement or discharge of such intellectual property infringement claim.
7. You represent and warrant that (a) you are not located in a country that is subject to a U.S. Government embargo, or that has been designated by the U.S. Government as a “terrorist supporting” country; and (b) you are not listed on any U.S. Government list of prohibited or restricted parties.
8. Apple and its subsidiaries are third party beneficiaries of this EULA and upon your acceptance of the terms and conditions of this EULA, Apple will have the right (and will be deemed to have accepted the right) to enforce this EULA against you as a third party beneficiary hereof.
9. ARTPOLDEV SP. Z O.O. expressly authorizes use of the our app by multiple users through the Family Sharing or any similar functionality provided by Apple.
PROHIBITED USE
We reserve the right (but are not obligated) to investigate and take appropriate legal action against anyone who, in our sole discretion, violates this provision, by submitting or posting any of the following:

material that is offensive and/or promotes racism, bigotry, hatred or physical harm of any kind against any group or individual;
material that threatens, harasses or advocates harassment of another person;
material that exploits people in a sexual or violent manner;
material that contains nudity, violence, or offensive subject matter or contains a link to an adult Website;
material that solicits personal information from anyone under the age of 18;
material that furthers or promotes any criminal activity or enterprise or provides instructional information about illegal activities including, but not limited to making or buying illegal weapons, violating someone's privacy, or providing or creating computer viruses.
"""
