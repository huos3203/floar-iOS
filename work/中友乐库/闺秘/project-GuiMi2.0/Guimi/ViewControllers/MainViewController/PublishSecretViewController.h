//
//  PublishSecretViewController.h
//  Guimi
//
//  Created by jonas on 9/13/14.
//  Copyright (c) 2014 jonas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"
#import "UIPlaceHolderTextView.h"
#import <MBProgressHUD.h>
@interface PublishSecretViewController : UIViewController
{
    IBOutlet UIButton* takePhotoButton;
    IBOutlet UIButton* exchangeButton;
    IBOutlet UIButton* fontButton;
    IBOutlet UIButton* tipButton;
    IBOutlet GIFImageView* backImage;
    IBOutlet UIPlaceHolderTextView* placeholderTextView;
    IBOutlet UIView* tipView;
    IBOutlet UIView* normalView;
    IBOutlet UIView* voteView;
    IBOutlet UITextField* vote1TextField;
    IBOutlet UITextField* vote2TextField;
    
    int index;
    MBProgressHUD* HUD;
    BOOL fontWhite;
    
    UITextField* activeTextFiled;
}
@property (nonatomic, assign) FeedType feedType;
@end
