//
//  PhoneViewController.h
//  WeLinked4
//
//  Created by jonas on 5/19/14.
//  Copyright (c) 2014 jonas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneViewController : UIViewController<UITextFieldDelegate>
{

    IBOutlet UITextField* inputPhone;
    
    NSString* checkedNumber;
    NSString *checkedSecretNumber;
}
@end
