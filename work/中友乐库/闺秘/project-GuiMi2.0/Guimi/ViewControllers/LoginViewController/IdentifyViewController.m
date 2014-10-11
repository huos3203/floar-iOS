//
//  IdentifyViewController.m
//  闺秘
//
//  Created by floar on 14-7-7.
//  Copyright (c) 2014年 jonas. All rights reserved.
//

#import "IdentifyViewController.h"
#import "NetWorkEngine.h"
#import "LogicManager.h"
#import "UserInfo.h"
//#import "MainViewController.h"
#import "PhoneIntroViewController.h"
#import <MBProgressHUD.h>
#import "MobClick.h"

@interface IdentifyViewController ()<MBProgressHUDDelegate>
{
    __weak IBOutlet UILabel *phoneNumLabel;
    
    __weak IBOutlet UIView *identifyInputView;
    
    __weak IBOutlet UITextField *identifyTextField;
    
    __weak IBOutlet UIButton *checkCodeBtn;
    
    __weak IBOutlet UILabel *checkCodeLabel;
    
    UIButton *identifyBtn;
    
    MBProgressHUD *hud;
    
    BOOL identifyOverTime;
    
    dispatch_source_t timer;
}

@end

@implementation IdentifyViewController

@synthesize phoneNum,password,checkPhoneOkorNot;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithHex(BackgroundColor3);
    
    [self identifyInitView];
    
    [identifyTextField becomeFirstResponder];
    [self.navigationItem setTitleString:@"输入验证码"];
    [self.navigationItem setLeftBarButtonItem:[UIImage imageNamed:@"btn_navBack_n"] imageSelected:[UIImage imageNamed:@"btn_navBack_h"] title:nil inset:UIEdgeInsetsMake(0, -15, 0, 15) target:self selector:@selector(IdentifyGoToBack)];
    
    identifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    identifyBtn.frame = CGRectMake(0, 0, 44, 44);
    identifyBtn.enabled = NO;
    [identifyBtn setTitle:@"提交" forState:UIControlStateNormal];
    identifyBtn.titleLabel.font = getFontWith(NO, 16);
    [identifyBtn setTitleColor:colorWithHex(FontColor3) forState:UIControlStateDisabled];
    [identifyBtn addTarget:self action:@selector(identifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:identifyBtn];
    [self.navigationItem setRightBarButtonItem:barBtnItem];

    checkCodeLabel.text = @"获取验证码";
    
    identifyOverTime = YES;
    
    //进入页面马上获取验证码 并开始倒计时
    [self checkCodeBtnAction:nil];
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.delegate = self;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    dispatch_source_cancel(timer);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DLog(@"memoryWarning:%@",NSStringFromClass([self class]));
}

#pragma mark - 获取用户输入验证码并向服务器校验
- (void)identifyCode
{
    
    if (identifyTextField.text == nil || [identifyTextField.text isEqualToString:@""] || [identifyTextField.text length] < 1)
    {
        [hud show:YES];
        hud.labelText = @"验证码不能为空";
        [hud hide:YES afterDelay:1.0];
    }
    else
    {
        int length = [identifyTextField.text length];
        if (length != 4)
        {
            [hud show:YES];
            hud.labelText = @"请输入4位数字验证码";
            [hud hide:YES afterDelay:1.0];
        }
        else
        {
            [MobClick event:ver_code];
            identifyBtn.enabled = NO;
            [identifyTextField resignFirstResponder];
            
            [hud show:YES];
            hud.labelText = @"验证中...";
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (identifyOverTime)
                {
                    identifyBtn.enabled = YES;
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"验证超时";
                    [hud hide:YES afterDelay:1.5];
                }
            });

            
            [[NetWorkEngine shareInstance] registWithAccountType:0x01
                                                     accountName:phoneNum
                                                            setp:0x02
                                                    identifyCode:identifyTextField.text
                                                        password:password
                                                           block:^(int event, id object)
            {
                if(1 == event)
                {
                    identifyBtn.enabled = YES;
                    identifyOverTime = NO;
                    Package *pack = (Package *)object;
                    
                    [[LogicManager sharedInstance] handlePackage:pack block:^(int event, id object) {
                        if (1 == event)
                        {
                            NSDictionary *dict = (NSDictionary *)object;
                            uint32_t result = [[dict objectForKey:PACKAGERESULT] longValue];
                            if (0 == result)
                            {
                                UserInfo *user = [UserInfo myselfInstance];
                                user.userId = [[dict objectForKey:USERID]longLongValue];
                                user.userKey = [dict objectForKey:USERKEY];
                                [user synchronize:nil];
                                
                                //记录下手机号和密码用于后面自动登录
                                [[LogicManager sharedInstance] setPersistenceData:phoneNum withKey:PHONENUMSTR];
                                [[LogicManager sharedInstance] setPersistenceData:password withKey:USERINPUTPW];
                                
                                hud.mode = MBProgressHUDModeIndeterminate;
                                hud.labelText = @"验证成功";
                                PhoneIntroViewController *phoneCtl = [[PhoneIntroViewController alloc] initWithNibName:NSStringFromClass([PhoneIntroViewController class]) bundle:nil];
                                [hud hide:YES afterDelay:2.0 complete:^{
                                    [[LogicManager sharedInstance] setRootViewContrller:phoneCtl];
                                }];
                            }
                            else if (-1010101 == result)
                            {
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"验证码错误";
                                [hud hide:YES afterDelay:1.5];
                            }
                            else if (-1010102 == result)
                            {
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"手机号已被注册";
                                [hud hide:YES afterDelay:1.5];
                            }
                            else if (-1 == result)
                            {
                                hud.mode = MBProgressHUDModeText;
                                hud.labelText = @"服务出错";
                                [hud hide:YES afterDelay:1.5];
                            }
                            else if (-3 == result)
                            {
                                [[LogicManager sharedInstance] makeUserReLoginAuto];
                            }

                        }
                    }];
                }
                else if (0 == event)
                {
                    DLog(@"验证码 error");
                }
            }];
        }
    }
}

#pragma mark - 倒计时+重新获取验证码
- (IBAction)checkCodeBtnAction:(id)sender
{
    __block int timeout = 59;
    
    [MobClick event:ver_code];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        if(timeout <= 0)
        {
            //倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                checkCodeLabel.text = @"重新获取验证码";
                [checkCodeBtn setImage:[UIImage imageNamed:@"btn_checkout_yes"] forState:UIControlStateNormal];
                checkCodeBtn.enabled = YES;
                checkPhoneOkorNot = NO;
            });
        }
        else
        {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                checkCodeLabel.text = [NSString stringWithFormat:@"%@秒后重发",strTime];
                checkCodeBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
    
    if (checkPhoneOkorNot != YES)
    {
        [[NetWorkEngine shareInstance] canReceiveVerificationCodeByPhoneNum:phoneNum phoneRegistOrNot:0x01 block:^(int event, id object) {
            if (1 == event)
            {
                Package *pack = (Package *)object;
                
                [[LogicManager sharedInstance] handlePackage:pack block:^(int event, id object) {
                    if (1 == event)
                    {
                        NSDictionary *dict = (NSDictionary *)object;
                        uint32_t result = [[dict objectForKey:PACKAGERESULT] longValue];
                        if (0 == result)
                        {
                            /*
                             1,如果判断能够发送验证码，则直接发送验证码，不用再手动调用发送验证码接口
                             2,如果再调用发送验证码接口，验证码重复发送，后面步骤验证码肯定验证不成功
                             */
                            DLog(@"获取验证码成功");
                        }
                        else if (-1030101 == result)
                        {
                            [hud show:YES];
                            dispatch_source_cancel(timer);
                            checkCodeLabel.text = @"手机号已注册";
                            [checkCodeBtn setImage:[UIImage imageNamed:@"btn_checkout_no"] forState:UIControlStateNormal];
                            checkCodeBtn.enabled = NO;
                            hud.mode = MBProgressHUDModeText;
                            hud.labelText = @"手机号已注册";
                            [hud hide:YES afterDelay:2.0];
                        }
                    }
                }];
            }
        }];
    }
    else
    {
        
    }
}

#pragma mark - Actions
-(void)IdentifyGoToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)identifyInitView
{
    NSString *phoneLabelStr = [NSString stringWithFormat:@"输入发送至%@的短信验证码",phoneNum];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:phoneLabelStr];
    
    [attributeStr addAttribute:NSForegroundColorAttributeName
                         value:colorWithHex(FontColor3)
                         range:NSMakeRange(0,[phoneLabelStr length])];
    
    [attributeStr addAttribute:NSFontAttributeName
                         value:getFontWith(NO, 12)
                         range:NSMakeRange(0,[phoneLabelStr length])];
    
    NSRange range = [phoneLabelStr rangeOfString:@"1"];
    if (range.location != NSNotFound)
    {
        [attributeStr addAttribute:NSForegroundColorAttributeName value:colorWithHex(BackgroundColor5) range:NSMakeRange(range.location, 11)];
    }
    [phoneNumLabel setAttributedText:attributeStr];
    
    
    identifyInputView.backgroundColor = colorWithHex(BackgroundColor2);
    identifyInputView.layer.cornerRadius = 5;

}

@end
