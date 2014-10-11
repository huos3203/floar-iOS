//
//  PublishSecretViewController.m
//  Guimi
//
//  Created by jonas on 9/13/14.
//  Copyright (c) 2014 jonas. All rights reserved.
//

#import "PublishSecretViewController.h"
#import "LogicManager+ImagePiker.h"
#import <UIImage+Screenshot.h>
#import "ShareBlurView.h"
#import "DetailSecretViewController.h"
#import "NetWorkEngine.h"
#import "NetWorkEngine.h"
#import "Package.h"
#import "UserInfo.h"
#import "BlurView.h"
#import "ActionAlertView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "GIFImageView.h"
@interface PublishSecretViewController ()<CLLocationManagerDelegate,UITextViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
{
    BOOL ownImage;
}

@end
@implementation PublishSecretViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = colorWithHex(BackgroundColor3);
    self.view.bounds = [UIScreen mainScreen].bounds;
    [self.navigationItem setTitleString:@""];
    [self.navigationItem setLeftBarButtonItem:[UIImage imageNamed:@"btn_close_n"]
                                imageSelected:[UIImage imageNamed:@"btn_close_h"]
                                        title:nil
                                        inset:UIEdgeInsetsMake(0, -15, 0, 15)
                                       target:self selector:@selector(back)];
    
    [self.navigationItem setRightBarButtonItem:nil
                                 imageSelected:nil
                                         title:@"发布"
                                         inset:UIEdgeInsetsMake(0, 15, 0, -15)
                                        target:self
                                      selector:@selector(publishSecret)];
    
    tipButton.layer.borderWidth = 1.0;
    tipButton.layer.borderColor = colorWithHex(0x444444).CGColor;
    tipButton.layer.cornerRadius = tipButton.frame.size.height/2;
    if(self.feedType == NormalFeedType)
    {
        [tipButton setTitle:@"谁会看到这个秘密?" forState:UIControlStateNormal];
    }
    else if (self.feedType == VoteFeedType)
    {
        [tipButton setTitle:@"谁会看到这个投票?" forState:UIControlStateNormal];
    }
    
    backImage.image = getNextImage(@"img_secretCell_background_", 11,&index);
    
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAndRightGesture:)];
    leftSwipe.delaysTouchesBegan = YES;
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAndRightGesture:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipe.delaysTouchesBegan = YES;
    [self.view addGestureRecognizer:rightSwipe];
    
    
    fontWhite = YES;
    placeholderTextView.textColor = [UIColor whiteColor];
    placeholderTextView.font = getFontWith(YES, 16);
    
    UIView* back = [tipView viewWithTag:1];
    back.layer.cornerRadius = 12.5;
    back.alpha = 0.4;
    
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    HUD.labelText = @"发送中...";
    [self.view addSubview:HUD];
    
    if(self.feedType == NormalFeedType)
    {
        voteView.hidden = YES;
        placeholderTextView.placeholder = @"匿名发布秘密";
    }
    else if (self.feedType == VoteFeedType)
    {
        normalView.hidden = YES;
        placeholderTextView.placeholder = @"投票的问题写在这里";
        if ([vote1TextField respondsToSelector:@selector(setAttributedPlaceholder:)])
        {
            UIColor *color = [UIColor darkGrayColor];
            vote1TextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:vote1TextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName: color}];
            vote2TextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:vote2TextField.placeholder
                                                                                   attributes:@{NSForegroundColorAttributeName: color}];
        }
    }
    placeholderTextView.placeholderColor = [UIColor whiteColor];
    placeholderTextView.textAlignment = NSTextAlignmentCenter;
    placeholderTextView.contentInset = UIEdgeInsetsMake(placeholderTextView.frame.size.height/3, 0, 0, 0);
    placeholderTextView.positionCenter = YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"img_navBar2"] forBarMetrics:UIBarMetricsDefault];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self setNeedsStatusBarAppearanceUpdate];
    }
    [self.navigationItem setEnable:1 enable:NO];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.6 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        tipView.alpha = 0.0;
    }completion:^(BOOL finished){
        
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"img_navBar"] forBarMetrics:UIBarMetricsDefault];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Actions
-(void)publishSecret
{
    [MobClick event:publish_button];
    //    [self sendImage];
    /*
     1,先发地点，再发内容
     2,地点格式：{"city":"深圳","latitude":22.555664,"longitude":113.948302}
     3,内容格式：{content:"内容",img:"http://,或id:1"}
     */
    
    NSString* addressJsonStr = [[LogicManager sharedInstance] getPersistenceStringWithKey:LOCATION];
    if(addressJsonStr == nil)
    {
        addressJsonStr = @"";
    }
    
    if (placeholderTextView.text != nil && [placeholderTextView.text length] > 0 && ![placeholderTextView.text isEqualToString:@""])
    {
        [placeholderTextView resignFirstResponder];
        [MobClick event:publish];
        //内容数据
        NSString *conentStr = placeholderTextView.text;
        __block NSString *textJsonStr = nil;
        NSMutableDictionary *textDict = [[NSMutableDictionary alloc] init];
        //内容
        [textDict setObject:conentStr forKey:@"content"];
        //组装图片
        [HUD show:YES];
        if (!ownImage)
        {
            NSString* imgStr = [NSString stringWithFormat:@"id:%d",index];
            [textDict setObject:imgStr forKey:@"img"];
            textJsonStr = [[LogicManager sharedInstance] objectToJsonString:textDict];
            [[NetWorkEngine shareInstance] publishSecretWithAddressJsonStr:addressJsonStr contentJsonStr:textJsonStr feedType:0 isOpen:0 block:^(int event, id object)
             {
                 [placeholderTextView resignFirstResponder];
                 if (1 == event)
                 {
                     Package *returnPack = (Package *)object;
                     [[LogicManager sharedInstance] handlePackage:returnPack block:^(int event, id object)
                     {
                         if (1 == event)
                         {
                             NSDictionary *dict = (NSDictionary *)object;
                             uint32_t result = [[dict objectForKey:PACKAGERESULT] longValue];
                             if (0 == result)
                             {
                                 NSArray *array = [dict objectForKey:FEEDS];
                                 if (array.count)
                                 {
                                     Feed *feed = [array firstObject];
                                     feed.contentStr = conentStr;
                                     feed.contentJson = textJsonStr;
                                     feed.imageStr = [NSString stringWithFormat:@"img_secretCell_background_%d",index];
                                     HUD.labelText = @"发布成功!";
                                     [HUD hide:YES afterDelay:1.0 complete:^{
                                         [self.navigationController popViewControllerAnimated:YES];
                                     }];
                                     
                                 }
                             }
                             else if (-4 == result)
                             {
                                 HUD.labelText = @"发送表情,程序错误";
                                 [HUD hide:YES afterDelay:1.0 complete:^{
                                     [self.navigationController popViewControllerAnimated:YES];
                                 }];
                             }
                             else
                             {
                                 HUD.labelText = @"发布失败了,请再试试吧!";
                                 [HUD hide:YES afterDelay:1.0];
                             }

                         }
                     }];
                 }
             }];
        }
        else
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:@"upload_image" forKey:@"operation"];
            NSData *imgData = nil;
            NSString* mimeType = @"image/png";
            if(backImage.frames == nil || [backImage.frames count]<=0)
            {
                [dict setObject:@"png" forKey:@"fileext"];
                imgData = UIImageJPEGRepresentation(backImage.image, 0.5);
            }
            else
            {
                mimeType = @"image/gif";
                [dict setObject:@"gif" forKey:@"fileext"];
                imgData = [NSData dataWithContentsOfFile:backImage.filePath];
                if(imgData != nil)
                {
                    unlink([backImage.filePath UTF8String]);
                }
            }
            
            NSString* path = [[NSURL URLWithString:@"form.cgi" relativeToURL:[NSURL URLWithString:IMAGESERVER]] absoluteString];
            [[NetWorkEngine shareInstance] postWithData:path
                                                   data:imgData
                                                dataKey:@"file"
                                               mimeType:mimeType
                                             parameters:dict
                                                success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSDictionary *dict = (NSDictionary *)responseObject;
                 NSString *imageStr = [dict objectForKey:@"filename"];
                 if (imageStr != nil && imageStr.length > 0)
                 {
                     NSString* imgStr = [NSString stringWithFormat:@"%@/download-image.cgi?%@",DOWNLOADIMAGE,imageStr];
                     if (textDict.count > 0)
                     {
                         [textDict setObject:imgStr forKey:@"img"];
                         textJsonStr = [[LogicManager sharedInstance] objectToJsonString:textDict];
                         
                         //地点数据
                         [[NetWorkEngine shareInstance] publishSecretWithAddressJsonStr:addressJsonStr contentJsonStr:textJsonStr feedType:0 isOpen:0 block:^(int event, id object)
                          {
                              if (1 == event)
                              {
                                  Package *returnPack = (Package *)object;
                                  [[LogicManager sharedInstance] handlePackage:returnPack block:^(int event, id object)
                                  {
                                      if (1 == event)
                                      {
                                          NSDictionary *dict = (NSDictionary *)object;
                                          uint32_t result = [[dict objectForKey:PACKAGERESULT] longValue];
                                          if (0 == result)
                                          {
                                              NSArray *array = [dict objectForKey:FEEDS];
                                              if (array.count)
                                              {
                                                  Feed *feed = [array firstObject];
                                                  feed.contentStr = conentStr;
                                                  feed.contentJson = textJsonStr;
                                                  feed.imageStr = imageStr;
                                                  HUD.labelText = @"发送秘密成功";
                                                  [HUD hide:YES afterDelay:1.0 complete:^{
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }];

                                              }
                                          }
                                          else if (-4 == result)
                                          {
                                              HUD.labelText = @"暂不支持表情";
                                              [HUD hide:YES afterDelay:1.0 complete:^{
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              }];
                                          }
                                      }
                                  }];
                              }
                          }];
                     }
                 }
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 DLog(@"%@",error);
                 HUD.labelText = @"图片发送失败";
                 [HUD hide:YES afterDelay:1.0 complete:^{
                     [self.navigationController popViewControllerAnimated:YES];
                 }];
             }];
        }
    }
    else
    {
        [[LogicManager sharedInstance] showAlertWithTitle:nil message:@"内容不能为空" actionText:@"确定"];
    }
}
-(void)back
{
    [MobClick event:publish_close];
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)click:(id)sender
{
    switch ([(UIButton*)sender tag])
    {
        case 1:
        {
            [self photoAction];
        }
            break;
        case 2:
        {
            backImage.image = getRandomImage(@"img_secretCell_background_",11,&index);
        }
            break;
        case 3:
        {
            UIButton* btn = (UIButton*)sender;
            fontWhite = !fontWhite;
            if(fontWhite)
            {
                [btn setImage:[UIImage imageNamed:@"btn_font_white"] forState:UIControlStateNormal];
                placeholderTextView.textColor = [UIColor whiteColor];
            }
            else
            {
                [btn setImage:[UIImage imageNamed:@"btn_font_black"] forState:UIControlStateNormal];
                placeholderTextView.textColor = [UIColor blackColor];
            }
        }
            break;
        case 4:
        {
            BlurView* blur = [[BlurView alloc]init];
            UIView* view = [[ActionAlertView sharedInstance] loadVisiableActionView:^(int event, id object)
            {
                [blur hide];
            }];
            [blur setActionView:view];
            [blur show];
        }
            break;
            
        default:
            break;
    }
}
-(void)photoAction
{
    [[LogicManager sharedInstance] getImage:self block:^(int event, id object)
     {
         if(event == -1)
         {
             //开始处理Gif
             runOnMainQueueWithoutDeadlocking(^{
                 HUD.labelText = @"处理中...";
                 [HUD show:YES];
             });
         }
         else if (event == -2)
         {
             //正在处理Gif
             runOnMainQueueWithoutDeadlocking(^{
                 NSNumber* number = (NSNumber*)object;
                 NSString* degreeString = [NSString stringWithFormat:@"%.1f%%",[number floatValue]*100.0];
                 HUD.labelText = @"处理中...";
                 HUD.detailsLabelText = degreeString;
             });
         }
         else if (event == -3)
         {
             //处理完成
             runOnMainQueueWithoutDeadlocking(^{
                 [HUD hide:YES];
                 HUD.detailsLabelText = @"";
                 ownImage = YES;
                 backImage.image = nil;
                 backImage = [backImage initWithFile:[(NSURL*)object path]];
                 [backImage play];
             });
         }
         else if (event == -4)
         {
             //出错
             [HUD hide:YES];
         }
         else
         {
             if (object != nil)
             {
                 if (backImage != nil)
                 {
                     ownImage = YES;
                     backImage.image = object;
                 }
             }
         }
     }];
}

-(void)leftAndRightGesture:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        backImage.image = getNextImage(@"img_secretCell_background_",11,&index);
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        backImage.image = getPrevImage(@"img_secretCell_background_",11,&index);
    }
}
#pragma mark - KeyboardShowOrHidden
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    if(activeTextFiled == vote1TextField || activeTextFiled == vote2TextField)
    {
        float height = 0 ;
        if(isSystemVersionIOS7())
        {
            height = ([UIScreen mainScreen].bounds.size.height - kbSize.height)-(voteView.frame.origin.y + voteView.frame.size.height);
        }
        else
        {
            height = ([UIScreen mainScreen].bounds.size.height - kbSize.height)-(voteView.frame.origin.y + voteView.frame.size.height+44);
        }
        
        if(height<0)
        {
            CGPoint center = self.view.center;
            center.y += height;
            [UIView animateWithDuration:duration.doubleValue animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[curve intValue]];
                self.view.center = center;
            } completion:^(BOOL finished) {
            }];
        }
    }
    else
    {
        if([UIScreen mainScreen].bounds.size.height <= 480)
        {
            CGPoint center = self.view.center;
            center.y -= 44;
            [UIView animateWithDuration:duration.doubleValue animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[curve intValue]];
                self.view.center = center;
            } completion:^(BOOL finished) {
            }];
        }
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    CGPoint center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    NSDictionary* info = [aNotification userInfo];
    NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        self.view.center = center;
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - UITextFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField.text length] + string.length > 14)
    {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeTextFiled = textField;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeTextFiled = nil;
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length  + text.length> 200)
    {
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    textView.selectedRange = NSMakeRange(textView.text.length, 0);
    if (textView.text.length > 0 && ![textView.text isEqualToString:@""] && textView.text != nil)
    {
        [self.navigationItem setEnable:1 enable:YES];
    }
    else
    {
        [self.navigationItem setEnable:1 enable:NO];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.selectedRange = NSMakeRange(50, 50);
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
}
#pragma --mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
