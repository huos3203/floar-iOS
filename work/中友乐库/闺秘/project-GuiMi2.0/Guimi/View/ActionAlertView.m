//
//  ActionAlertView.m
//  Guimi
//
//  Created by jonas on 9/13/14.
//  Copyright (c) 2014 jonas. All rights reserved.
//

#import "ActionAlertView.h"

@implementation  PublishActionView
-(void)awakeFromNib
{
    [super awakeFromNib];
}
-(IBAction)click:(id)sender
{
    if([(UIButton*)sender tag] == 1)
    {
        if(block)
        {
            block(1,nil);
        }
    }
    else if([(UIButton*)sender tag] == 2)
    {
        if(block)
        {
            block(2,nil);
        }
    }
}
-(void)setEventBlock:(EventCallBack)callback
{
    block = callback;
}
@end




@implementation LogoutActionView
-(void)awakeFromNib
{
    [super awakeFromNib];
    leftButton.layer.cornerRadius = 3.0;
    rightButton.layer.cornerRadius = 3.0;
    backView.layer.borderWidth = 3.0;
    backView.layer.borderColor = [[UIColor blackColor] CGColor];
    backView.layer.cornerRadius = 5.0;
}
-(IBAction)click:(id)sender
{
    if([(UIButton*)sender tag] == 1)
    {
        if(block)
        {
            block(1,nil);
        }
    }
    else if([(UIButton*)sender tag] == 2)
    {
        if(block)
        {
            block(2,nil);
        }
    }
}
-(void)setEventBlock:(EventCallBack)callback
{
    block = callback;
}
@end



@implementation VisiableActionView
-(void)awakeFromNib
{
    [super awakeFromNib];
    rightButton.layer.cornerRadius = 3.0;
    backView.layer.borderWidth = 3.0;
    backView.layer.borderColor = [[UIColor blackColor] CGColor];
    backView.layer.cornerRadius = 5.0;
}
-(IBAction)click:(id)sender
{
    if([(UIButton*)sender tag] == 1)
    {
        if(block)
        {
            block(1,nil);
        }
    }
    else if([(UIButton*)sender tag] == 2)
    {
        if(block)
        {
            block(2,nil);
        }
    }
}
-(void)setEventBlock:(EventCallBack)callback
{
    block = callback;
}
@end

@implementation SexActionView
-(void)awakeFromNib
{
    [super awakeFromNib];
    rightButton.layer.cornerRadius = 3.0;
    NSString* str = detailLabel.text;
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor yellowColor]
                   range:NSMakeRange([str length] - 5,5)];
    [detailLabel setAttributedText:string];
    backView.layer.borderWidth = 3.0;
    backView.layer.borderColor = [[UIColor blackColor] CGColor];
    backView.layer.cornerRadius = 5.0;
    
    leftButton.layer.cornerRadius = 3.0;
    rightButton.layer.cornerRadius = 3.0;
}
-(IBAction)click:(id)sender
{
    if([(UIButton*)sender tag] == 1)
    {
        if(block)
        {
            block(1,nil);
        }
    }
    else if([(UIButton*)sender tag] == 2)
    {
        if(block)
        {
            block(2,nil);
        }
    }
}
-(void)setEventBlock:(EventCallBack)callback
{
    block = callback;
}
@end
@implementation ContactBookActionView
-(void)awakeFromNib
{
    [super awakeFromNib];
    leftButton.layer.cornerRadius = 3.0;
    detailLabel.text = @"1.进入「设置」\n2.选择「隐私」-「通讯录」\n3.找到「闺秘」并打开";
    backView.layer.borderWidth = 2.0;
    backView.layer.borderColor = [[UIColor blackColor] CGColor];
    backView.layer.cornerRadius = 3;
}
-(IBAction)click:(id)sender
{
    if([(UIButton*)sender tag] == 1)
    {
        if(block)
        {
            block(1,nil);
        }
    }
}
-(void)setEventBlock:(EventCallBack)callback
{
    block = callback;
}
@end










@implementation ActionAlertView
@synthesize viewArray;
-(id)init
{
    self = [super init];
    if(self)
    {
        viewArray = nil;
    }
    return self;
}
#pragma --mark 单例
+(ActionAlertView*)sharedInstance
{
    static ActionAlertView* m_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_instance = [[[self class] alloc]init];
    });
    return m_instance;
}

-(UIView*)loadLogoutActionView:(EventCallBack)block
{
    if(viewArray == nil)
    {
        viewArray = [[NSBundle mainBundle] loadNibNamed:@"ActionAlertView" owner:self options:nil];
    }
    LogoutActionView* logoutView = (LogoutActionView*)[viewArray objectAtIndex:0];
    if(logoutView != nil)
    {
        [logoutView setEventBlock:block];
    }
    return (UIView*)logoutView;
}
-(UIView*)loadPublishActionView:(EventCallBack)block
{
    if(viewArray == nil)
    {
        viewArray = [[NSBundle mainBundle] loadNibNamed:@"ActionAlertView" owner:self options:nil];
    }
    LogoutActionView* logoutView = (LogoutActionView*)[viewArray objectAtIndex:1];
    if(logoutView != nil)
    {
        [logoutView setEventBlock:block];
    }
    return (UIView*)logoutView;
}
-(UIView*)loadVisiableActionView:(EventCallBack)block
{
    if(viewArray == nil)
    {
        viewArray = [[NSBundle mainBundle] loadNibNamed:@"ActionAlertView" owner:self options:nil];
    }
    LogoutActionView* visiableView = (LogoutActionView*)[viewArray objectAtIndex:2];
    if(visiableView != nil)
    {
        [visiableView setEventBlock:block];
    }
    return (UIView*)visiableView;
}
-(UIView*)loadSexActionView:(EventCallBack)block
{
    if(viewArray == nil)
    {
        viewArray = [[NSBundle mainBundle] loadNibNamed:@"ActionAlertView" owner:self options:nil];
    }
    SexActionView* sexActionView = (SexActionView*)[viewArray objectAtIndex:3];
    if(sexActionView != nil)
    {
        [sexActionView setEventBlock:block];
    }
    return (UIView*)sexActionView;
}
-(UIView*)loadContactBookActionView:(EventCallBack)block
{
    if(viewArray == nil)
    {
        viewArray = [[NSBundle mainBundle] loadNibNamed:@"ActionAlertView" owner:self options:nil];
    }
    ContactBookActionView* sexActionView = (ContactBookActionView*)[viewArray objectAtIndex:4];
    if(sexActionView != nil)
    {
        [sexActionView setEventBlock:block];
    }
    return (UIView*)sexActionView;
}
@end
