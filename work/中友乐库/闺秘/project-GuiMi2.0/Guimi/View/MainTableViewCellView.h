//
//  MainTableViewCell.h
//  Guimi
//
//  Created by jonas on 9/11/14.
//  Copyright (c) 2014 jonas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"
#import "RCLabel.h"
@interface MainTableViewCustomCellView : UIView
{
    IBOutlet UIView* backView;
    IBOutlet UIImageView* avatarImageView;
    EventCallBack block;
    
    
    IBOutlet UIImageView* tipBackImage;
    IBOutlet UILabel* addressLabel;
    
    IBOutlet RCLabel* content;
    
    IBOutlet UIView* bottomView;
    
    IBOutlet UIButton* commentButton;
    IBOutlet UIButton* likeButton;
}
@property(nonatomic,strong)Feed* feed;
-(void)setEventCallBack:(EventCallBack)callback;
@end



@interface MainTableViewContactCellView : UIView
{
    EventCallBack block;
    IBOutlet UIButton* actionButton;
    IBOutlet UILabel* tipLabel;
    IBOutlet UILabel* detailLabel;
    IBOutlet UIImageView* backImage;
}
-(void)setEventCallBack:(EventCallBack)callback;
@end