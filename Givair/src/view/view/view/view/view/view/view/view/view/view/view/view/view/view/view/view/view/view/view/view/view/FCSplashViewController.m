//
//  FCSplashViewController.m
//  Givair
//
//  Created by Peter Tsoi on 11/27/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "FCSplashViewController.h"

#import "FCAppDelegate.h"
#import "FCGraph.h"
#import "FCUser.h"

@implementation UIScrollView (FCExtentions)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.superview touchesEnded:touches withEvent:event];
}

@end

@implementation UITextField (FCExtentions)

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 10 , 8 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 8 );
}

@end

typedef enum {
    kFCFormStateSplash,
    kFCFormStateRegister,
    kFCFormStateLogin,
} FCFormState;

@interface FCSplashViewController (){
    FCFormState mFormState;
}

@end

@implementation FCSplashViewController

- (id)init {
    self = [super init];
    if (self) {
        mFormState = kFCFormStateSplash;
        mContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];

        [self.view addSubview:mContent];
        CAGradientLayer * gradient = [CAGradientLayer layer];
        gradient.frame = self.view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.3686f green:0.6784f blue:0.9098 alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:0.1255f green:0.2941f blue:0.4275 alpha:1.0f] CGColor], nil];
        [self.view.layer insertSublayer:gradient atIndex:0];

        mLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"givairlarge.png"]];
        mLogo.center = CGPointMake(self.view.center.x, self.view.center.y - mLogo.frame.size.height/4);
        [mContent addSubview:mLogo];

        mSignupButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 360, 140, 32)];
        mSigninButton = [[UIButton alloc] initWithFrame:CGRectMake(165, 360, 140, 32)];

        [mSignupButton setBackgroundImage:[[UIImage imageNamed:@"graybutton.png"]
                                          resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                forState:UIControlStateNormal];

        [mSigninButton setBackgroundImage:[[UIImage imageNamed:@"bluebutton.png"]
                                          resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                forState:UIControlStateNormal];

        [mSignupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [mSigninButton setTitle:@"Sign In" forState:UIControlStateNormal];

        [mSignupButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mSignupButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mSignupButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];

        [mSigninButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mSigninButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mSigninButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];

        [mSignupButton addTarget:self action:@selector(presentSignupForm) forControlEvents:UIControlEventTouchUpInside];
        [mSigninButton addTarget:self action:@selector(presentSigninForm) forControlEvents:UIControlEventTouchUpInside];

        mStatusLabel = [[UILabel alloc] init];
        [mStatusLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:14.0f]];
        [mStatusLabel setNumberOfLines:2];
        [mStatusLabel setTextColor:[UIColor colorWithRed:0.9216f green:0.5765f blue:0.5922f alpha:1.0f]];
        [mStatusLabel setTextAlignment:NSTextAlignmentCenter];
        [mStatusLabel setBackgroundColor:[UIColor clearColor]];
        [mStatusLabel setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width*0.5, 30.0f)];

        [mContent addSubview:mSignupButton];
        [mContent addSubview:mSigninButton];

    }
    return self;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void) fadeoutButtons {
    [UIView beginAnimations:@"fadeoutButtons" context:nil];
    [mSigninButton setAlpha:0.0f];
    [mSignupButton setAlpha:0.0f];
    [mLogo setFrame:CGRectMake(mLogo.frame.origin.x, 40.0f,
                               mLogo.frame.size.width, mLogo.frame.size.height)];
    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
}

- (void) fadeinButtons {
    [UIView beginAnimations:@"fadeinButtons" context:nil];
    [mSigninButton setAlpha:1.0f];
    [mSignupButton setAlpha:1.0f];
    mLogo.center = CGPointMake(self.view.center.x, self.view.center.y - mLogo.frame.size.height/4);
    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
}

- (void) cancelSignupForm {
    mFormState = kFCFormStateSplash;
    if (mActiveField)
        [mActiveField resignFirstResponder];
    mStatusLabel.text = @"";
    [self fadeinButtons];
    [UIView beginAnimations:@"cancelSignupForm" context:nil];
    [mFormBack setAlpha:0.0f];
    [mFirstName setAlpha:0.0f];
    [mLastName setAlpha:0.0f];
    [mEmail setAlpha:0.0f];
    [mPassword setAlpha:0.0f];
    [mCancelButton setAlpha:0.0f];
    [mRegisterButton setAlpha:0.0f];
    [mStatusLabel setAlpha:0.0f];

    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
    [mSpinner stopAnimating];
}

- (void) cancelSigninForm {
    mFormState = kFCFormStateSplash;
    if (mActiveField)
        [mActiveField resignFirstResponder];
    mStatusLabel.text = @"";
    [self fadeinButtons];
    [UIView beginAnimations:@"cancelSigninForm" context:nil];
    [mFormBack setAlpha:0.0f];
    [mEmail setAlpha:0.0f];
    [mPassword setAlpha:0.0f];
    [mCancelButton setAlpha:0.0f];
    [mLoginButton setAlpha:0.0f];
    [mStatusLabel setAlpha:0.0f];

    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
    [mSpinner stopAnimating];
}

- (void) tryLogin {
    mStatusLabel.text = @"";
    mSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    mSpinner.center = CGPointMake(mFormBack.center.x, mFormBack.frame.origin.y - mSpinner.frame.size.height - 3.0f);
    [mContent addSubview:mSpinner];
    [mSpinner startAnimating];
    [mLoginButton setEnabled:NO];

    mLoginConnection = [AppDelegate.network dataAtURL:[NSURL URLWithString:
                                                       [NSString stringWithFormat:@"network/a/user/login?email=%@&password=%@", mEmail.text, mPassword.text]
                                                             relativeToURL:[NSURL URLWithString:@"https://fight-club-alpha.herokuapp.com"]] delegate:self];
}

- (void) loginSucceeded {
    [mSpinner stopAnimating];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loginFailedWithErrorMessage:(NSString*)message {
    [mSpinner stopAnimating];
    mStatusLabel.center = mSpinner.center;
    mStatusLabel.text = message;
    [mContent addSubview:mStatusLabel];
    [mLoginButton setEnabled:YES];
}

- (void) tryRegister {
    mStatusLabel.text = @"";
    mSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    mSpinner.center = CGPointMake(mFormBack.center.x, mFormBack.frame.origin.y - mSpinner.frame.size.height - 3.0f);
    [mContent addSubview:mSpinner];
    [mSpinner startAnimating];
    [mRegisterButton setEnabled:NO];

    mRegistrationConnection = [AppDelegate.network dataAtURL:[NSURL URLWithString:
                                                              [NSString stringWithFormat:@"network/a/user/new?email=%@&first=%@&last=%@&password=%@", mEmail.text, mFirstName.text, mLastName.text, mPassword.text]
                                                                    relativeToURL:[NSURL URLWithString:@"https://fight-club-alpha.herokuapp.com"]] delegate:self];


}

- (void) registrationSucceeded {
    [mSpinner stopAnimating];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) registrationFailedWithErrorMessage:(NSString*)message {
    [mSpinner stopAnimating];
    mStatusLabel.center = mSpinner.center;
    mStatusLabel.text = message;
    [mContent addSubview:mStatusLabel];
    [mRegisterButton setEnabled:YES];
}

- (void) presentSignupForm {
    mFormState = kFCFormStateRegister;
    [self registerForKeyboardNotifications];
    [self fadeoutButtons];
    mFormBack = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 250.0f, 280.0f, 96.0f)];
    [mFormBack setImage:[[UIImage imageNamed:@"textboxbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 4.5f, 4.0f, 5.0f)]];
    [mFormBack setAlpha:0.0f];
    [mContent addSubview:mFormBack];

    //if (!mRegisterButton) {
        mFirstName = [[UITextField alloc] initWithFrame:CGRectMake(mFormBack.frame.origin.x, mFormBack.frame.origin.y,
                                                                   140.0f, 32.0f)];
        CALayer *rightBorder = [CALayer layer];
        rightBorder.frame = CGRectMake(mFirstName.frame.size.width-1.0f, 1.0f, 1.0f, mFirstName.frame.size.height);
        rightBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                        alpha:1.0f].CGColor;
        [mFirstName.layer addSublayer:rightBorder];

        mLastName = [[UITextField alloc] initWithFrame:CGRectMake(mFormBack.frame.origin.x + mFirstName.frame.size.width, mFormBack.frame.origin.y,
                                                                  140.0f, 32.0f)];


        mEmail = [[UITextField alloc] initWithFrame:CGRectMake(mFirstName.frame.origin.x, mFirstName.frame.origin.y+mFirstName.frame.size.height,
                                                               mFormBack.frame.size.width, mFirstName.frame.size.height)];
        [mEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];


        CALayer *emailBorder = [CALayer layer];
        emailBorder.frame = CGRectMake(1.0f, 0.0f, mEmail.frame.size.width-2.0f, 1.0f);
        emailBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                        alpha:1.0f].CGColor;
        [mEmail.layer addSublayer:emailBorder];
        [mEmail setKeyboardType:UIKeyboardTypeEmailAddress];

        mPassword = [[UITextField alloc] initWithFrame:CGRectMake(mEmail.frame.origin.x, mEmail.frame.origin.y+mEmail.frame.size.height,
                                                                  mFormBack.frame.size.width, mEmail.frame.size.height)];
        [mPassword setSecureTextEntry:YES];

        CALayer *passwordBorder = [CALayer layer];
        passwordBorder.frame = CGRectMake(1.0f, 0.0f, mPassword.frame.size.width-2.0f, 1.0f);
        passwordBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                           alpha:1.0f].CGColor;
        [mPassword.layer addSublayer:passwordBorder];

        mEmail.text = @"";
        mPassword.text = @"";
        mFirstName.text = @"";
        mLastName.text = @"";

        mFirstName.delegate = self;
        mLastName.delegate = self;
        mEmail.delegate = self;
        mPassword.delegate = self;

        [mFirstName setBackgroundColor:[UIColor clearColor]];
        [mLastName setBackgroundColor:[UIColor clearColor]];
        [mEmail setBackgroundColor:[UIColor clearColor]];
        [mPassword setBackgroundColor:[UIColor clearColor]];

        [mFirstName setAlpha:0.0f];
        [mLastName setAlpha:0.0f];
        [mEmail setAlpha:0.0f];
        [mPassword setAlpha:0.0f];

        [mFirstName setPlaceholder:@"First Name"];
        [mLastName setPlaceholder:@"Last Name"];
        [mEmail setPlaceholder:@"Email"];
        [mPassword setPlaceholder:@"Password"];

        [mFirstName setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];
        [mLastName setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];
        [mEmail setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];
        [mPassword setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];

        [mFirstName setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mLastName setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mEmail setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mPassword setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];

        mCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 360, 135, 32)];
        [mCancelButton setBackgroundImage:[[UIImage imageNamed:@"graybutton.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                 forState:UIControlStateNormal];
        [mCancelButton addTarget:self action:@selector(cancelSignupForm) forControlEvents:UIControlEventTouchUpInside];

        mRegisterButton = [[UIButton alloc] initWithFrame:CGRectMake(165, 360, 135, 32)];
        [mRegisterButton setBackgroundImage:[[UIImage imageNamed:@"bluebutton.png"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                   forState:UIControlStateNormal];
        [mRegisterButton addTarget:self action:@selector(tryRegister) forControlEvents:UIControlEventTouchUpInside];

        [mCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [mRegisterButton setTitle:@"Register" forState:UIControlStateNormal];

        [mCancelButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mCancelButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mCancelButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
        
        [mRegisterButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mRegisterButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mRegisterButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
        
        [mCancelButton setAlpha:0.0f];
        [mRegisterButton setAlpha:0.0f];
    //}
    
    [mContent addSubview:mFirstName];
    [mContent addSubview:mLastName];
    [mContent addSubview:mEmail];
    [mContent addSubview:mPassword];
    [mContent addSubview:mCancelButton];
    [mContent addSubview:mRegisterButton];

    [UIView beginAnimations:@"presentSignupForm" context:nil];
    mLogo.center = CGPointMake(mLogo.center.x, mLogo.center.y - 30.0f);
    [mFormBack setAlpha:1.0f];
    [mFirstName setAlpha:1.0f];
    [mLastName setAlpha:1.0f];
    [mEmail setAlpha:1.0f];
    [mPassword setAlpha:1.0f];
    [mCancelButton setAlpha:1.0f];
    [mRegisterButton setAlpha:1.0f];
    [mStatusLabel setAlpha:1.0f];

    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
}

- (void) presentSigninForm {
    mFormState = kFCFormStateLogin;
    [self registerForKeyboardNotifications];
    [self fadeoutButtons];

    if (!mFormBack) {
        mFormBack = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 282.0f, 280.0f, 64.0f)];
        [mFormBack setImage:[[UIImage imageNamed:@"textboxbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5.0, 4.5f, 4.0f, 5.0f)]];
        [mContent addSubview:mFormBack];
    } else {
        [mFormBack setFrame:CGRectMake(20.0f, 282.0f, 280.0f, 64.0f)];
    }

    [mFormBack setAlpha:0.0f];
    

    //if (!mLoginButton) {
        mEmail = [[UITextField alloc] initWithFrame:CGRectMake(mFormBack.frame.origin.x, mFormBack.frame.origin.y,
                                                               mFormBack.frame.size.width, 32.0f)];
        [mEmail setAutocapitalizationType:UITextAutocapitalizationTypeNone];

        [mEmail setKeyboardType:UIKeyboardTypeEmailAddress];

        mPassword = [[UITextField alloc] initWithFrame:CGRectMake(mEmail.frame.origin.x, mEmail.frame.origin.y+mEmail.frame.size.height,
                                                                  mFormBack.frame.size.width, mEmail.frame.size.height)];
        [mPassword setSecureTextEntry:YES];

        CALayer *passwordBorder = [CALayer layer];
        passwordBorder.frame = CGRectMake(1.0f, 0.0f, mPassword.frame.size.width-2.0f, 1.0f);
        passwordBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                           alpha:1.0f].CGColor;
        [mPassword.layer addSublayer:passwordBorder];

        mEmail.delegate = self;
        mPassword.delegate = self;
        
        [mEmail setBackgroundColor:[UIColor clearColor]];
        [mPassword setBackgroundColor:[UIColor clearColor]];

        [mEmail setAlpha:0.0f];
        [mPassword setAlpha:0.0f];

        [mEmail setPlaceholder:@"Email"];
        [mPassword setPlaceholder:@"Password"];

        [mEmail setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];
        [mPassword setFont:[UIFont fontWithName:@"MyriadApple-Semibold" size:16.0f]];

        [mFirstName setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mLastName setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mEmail setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
        [mPassword setTextColor:[UIColor colorWithWhite:0.35 alpha:1.0]];

        mCancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 360, 135, 32)];
        [mCancelButton setBackgroundImage:[[UIImage imageNamed:@"graybutton.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                 forState:UIControlStateNormal];
        [mCancelButton addTarget:self action:@selector(cancelSigninForm) forControlEvents:UIControlEventTouchUpInside];

        mLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(165, 360, 135, 32)];
        [mLoginButton setBackgroundImage:[[UIImage imageNamed:@"bluebutton.png"]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f)]
                                   forState:UIControlStateNormal];
        [mLoginButton addTarget:self action:@selector(tryLogin) forControlEvents:UIControlEventTouchUpInside];

        [mCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [mLoginButton setTitle:@"Log in" forState:UIControlStateNormal];

        [mCancelButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mCancelButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mCancelButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];

        [mLoginButton.titleLabel setFont:[UIFont fontWithName:@"MyriadApple-Bold" size:16.0f]];
        [mLoginButton.titleLabel setShadowColor:[UIColor grayColor]];
        [mLoginButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];

        [mCancelButton setAlpha:0.0f];
        [mLoginButton setAlpha:0.0f];
    //}

    [mContent addSubview:mEmail];
    [mContent addSubview:mPassword];
    [mContent addSubview:mCancelButton];
    [mContent addSubview:mLoginButton];

    [UIView beginAnimations:@"presentSigninForm" context:nil];
    [mFormBack setAlpha:1.0f];
    [mEmail setAlpha:1.0f];
    [mPassword setAlpha:1.0f];
    [mCancelButton setAlpha:1.0f];
    [mLoginButton setAlpha:1.0f];
    [mStatusLabel setAlpha:1.0f];
    
    [UIView setAnimationDuration:2.0f];
    [UIView commitAnimations];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    mActiveField = textField;
    if (kbSize.height != 0.0) {
        [self keyboardWasShown:nil];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    mActiveField = nil;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (aNotification) {
        NSDictionary* info = [aNotification userInfo];
        kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    }

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    mContent.contentInset = contentInsets;
    mContent.scrollIndicatorInsets = contentInsets;

    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, CGPointMake(mActiveField.frame.origin.x, mActiveField.frame.origin.y + mActiveField.frame.size.height)) ) {
        CGPoint scrollPoint = CGPointMake(0.0, mActiveField.frame.origin.y-kbSize.height + 96);
        [mContent setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    mContent.contentInset = contentInsets;
    mContent.scrollIndicatorInsets = contentInsets;
}

- (void) connection:(FCConnection *)connection failedWithError:(NSError *)error {
    if (connection == mLoginConnection) {
        [self loginFailedWithErrorMessage:@"Connection failed"];
    } else if (connection == mRegistrationConnection) {
        [self registrationFailedWithErrorMessage:@"Connection failed"];
    }
}

- (void) connection:(FCConnection *)connection finishedDownloadingData:(NSData *)data {
    NSMutableDictionary * info = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
    if (connection == mLoginConnection) {
        if ([info objectForKey:@"error"]) {
            [self loginFailedWithErrorMessage:[info objectForKey:@"error"]];
        } else {
            FCUser * thisUser = [[FCUser alloc] initWithID:[[info objectForKey:@"id"] integerValue] 
                                                     Email:[info objectForKey:@"email"]
                                                     first:[info objectForKey:@"first"]
                                                      last:[info objectForKey:@"last"]
                                                    APIKey:[info objectForKey:@"apikey"]
                                                   FBEmail:[info objectForKey:@"fbemail"]];
            [AppDelegate.graph addUser:thisUser];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"apikey"] forKey:@"apikey"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"first"] forKey:@"first"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"last"] forKey:@"last"];
            [[NSUserDefaults standardUserDefaults] setInteger:[[info objectForKey:@"id"] integerValue] forKey:@"id"];
            [self loginSucceeded];
        }
    } else if (connection == mRegistrationConnection) {
        if ([info objectForKey:@"error"]) {
            [self registrationFailedWithErrorMessage:[info objectForKey:@"error"]];
        } else {
            FCUser * thisUser = [[FCUser alloc] initWithID:[[info objectForKey:@"id"] integerValue]
                                                     Email:[info objectForKey:@"email"]
                                                     first:[info objectForKey:@"first"]
                                                      last:[info objectForKey:@"last"]
                                                    APIKey:[info objectForKey:@"apikey"]
                                                   FBEmail:[info objectForKey:@"fbemail"]];
            [AppDelegate.graph addUser:thisUser];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"apikey"] forKey:@"apikey"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"first"] forKey:@"first"];
            [[NSUserDefaults standardUserDefaults] setObject:[info objectForKey:@"last"] forKey:@"last"];
            [[NSUserDefaults standardUserDefaults] setInteger:[[info objectForKey:@"id"] integerValue] forKey:@"id"];
            [self registrationSucceeded];
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (mActiveField && [mActiveField isFirstResponder] && [touch view] != mActiveField) {
        [mActiveField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
