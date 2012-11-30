//
//  FCSplashViewController.h
//  Givair
//
//  Created by Peter Tsoi on 11/27/12.
//  Copyright (c) 2012 Fightclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCSplashViewController : UIViewController <UITextFieldDelegate> {
    UIScrollView * mContent;
    UIImageView * mLogo;
    UIImageView * mFormBack;

    UILabel * mStatusLabel;

    UIButton * mSignupButton;
    UIButton * mSigninButton;
    UIButton * mCancelButton;
    UIButton * mRegisterButton;
    UIButton * mLoginButton;

    UITextField * mFirstName;
    UITextField * mLastName;
    UITextField * mEmail;
    UITextField * mPassword;

    UITextField * mActiveField;

    UIActivityIndicatorView * mSpinner;

    CGSize kbSize;
}

@end
