//
//  OldUserLoginViewController.m
//  闺秘
//
//  Created by floar on 14-7-7.
//  Copyright (c) 2014年 jonas. All rights reserved.
//

#import "OldUserLoginViewController.h"
#import "NetWorkEngine.h"
#import "UserInfo.h"
#import "Package.h"
#import "LogicManager.h"
#import "MainViewController.h"
#import "SplashViewController.h"
#import "ForgetPWViewController.h"

#import <MBProgressHUD.h>

@interface OldUserLoginViewController ()<MBProgressHUDDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *phoneNum;
    
    __weak IBOutlet UITextField *secretNum;
    
    __weak IBOutlet UIButton *forgetPWBtn;
    
    __weak IBOutlet UIView *oldUserInputView;
    
    UIButton *loginBtn;
    
    NSString *rightPhoneNum;
    NSString *rightPassword;
    
    MBProgressHUD *hub;
//    NSTimer *oldUserLoginTimer;
    
}

@end

@implementation OldUserLoginViewController

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
    
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = colorWithHex(BackgroundColor3);
    [self.navigationItem setTitleString:@"已有账号登陆"];
    [self.navigationItem setLeftBarButtonItem:[UIImage imageNamed:@"btn_navBack_n"] imageSelected:[UIImage imageNamed:@"btn_navBack_h"] title:nil inset:UIEdgeInsetsMake(0, -15, 0, 15) target:self selector:@selector(oldGoToBack)];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, 44, 44);
    loginBtn.enabled = NO;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = getFontWith(NO, 16);
    [loginBtn setTitleColor:colorWithHex(FontColor3) forState:UIControlStateDisabled];
    [loginBtn addTarget:self action:@selector(oldUserLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:loginBtn];
    [self.navigationItem setRightBarButtonItem:barBtnItem];
    
    [self oldUserCustomInputView];
    

    [forgetPWBtn setTitleColor:colorWithHex(lightRedColor) forState:UIControlStateNormal];
    
    [phoneNum becomeFirstResponder];
    
    hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.delegate = self;
    [self.view addSubview:hub];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldInChanging:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 检查用户输入
-(BOOL)checkPhoneNumber
{
    NSString *str = [self deCodePhoneNumStr:phoneNum.text];
    if(str ==nil || [str length]<=0)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"手机号码不能为空,请输入手机号码"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        
        [alert show];
//        hub.labelText = @"手机号码不能为空";
//        [hub hide:YES afterDelay:1.0];
        return NO;
    }
    else
    {
        if(![[LogicManager sharedInstance] isMobileNumber:[self deCodePhoneNumStr:phoneNum.text]])
        {
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                           message:@"手机号码格式不正确,请输入真实的手机号码"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            
            [alert show];
//            [hub show:YES];
//            hub.labelText = @"请输入正确手机号码";
//            [hub hide:YES afterDelay:1.0];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}

-(BOOL)checkSecretNumber
{
    if(secretNum.text==nil || [secretNum.text length]<=0)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"密码不能为空,请输入秘密"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
    }
    else
    {
        if(![self isSecretNum])
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    return YES;
}

-(BOOL)isSecretNum
{
    int secretLength = [secretNum.text length];
    if( secretLength != 6 )
    {
        [[LogicManager sharedInstance] showAlertWithTitle:nil message:@"密码位数不对，请重新输入6位数字密码" actionText:@"确定"];
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark - phoneNum增加/删除间隔
-(NSString *)enCodePhoneNumStr:(NSString *)newPhoneNum
{
    NSMutableString *enCodeStr = [[NSMutableString alloc] initWithString:newPhoneNum];
    if (newPhoneNum.length > 2)
    {
        [enCodeStr insertString:@" " atIndex:3];
        if (newPhoneNum.length > 7)
        {
            [enCodeStr insertString:@" " atIndex:8];
        }
    }
    NSString *str = (NSString *)enCodeStr;
    
    return str;
}

-(NSString *)deCodePhoneNumStr:(NSString *)newPhoneNum
{
    NSString *deCodeStr = [[NSString alloc] init];
    NSArray *arr = [newPhoneNum componentsSeparatedByString:@" "];
    if (arr != nil && arr.count > 0)
    {
        for (NSString *str in arr)
        {
            deCodeStr = [deCodeStr stringByAppendingString:str];
        }
        return deCodeStr;
    }
    else
    {
        return newPhoneNum;
    }
}


#pragma mark - 登陆
//校验输入并登陆
- (void)oldUserLogin
{
    [MobClick event:login_id];
    [phoneNum resignFirstResponder];
    [secretNum resignFirstResponder];
    if([self checkPhoneNumber] && [self checkSecretNumber])
    {
        rightPhoneNum = [self deCodePhoneNumStr:phoneNum.text];
        rightPassword = [self deCodePhoneNumStr:secretNum.text];
        [self checkForLogin];
    }
}
//登陆
-(void)checkForLogin
{
    [hub show:YES];
    hub.mode = MBProgressHUDModeIndeterminate;
    hub.labelText = @"登录中...";
    loginBtn.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        loginBtn.enabled = YES;
        hub.labelText = @"登陆超时，请重新登陆";
        [hub hide:YES afterDelay:1.0];
    });
    
    [[NetWorkEngine shareInstance] loginWithAccountType:0x01 accountName:rightPhoneNum password:rightPassword block:^(int event, id object)
    {
        if (1 == event)
        {
            loginBtn.enabled = YES;
            Package *pack = (Package *)object;
            
            [[LogicManager sharedInstance] handlePackage:pack block:^(int event, id object) {
                if (1 == event)
                {
                    NSDictionary *dict = (NSDictionary *)object;
                    uint32_t result = [[dict objectForKey:PACKAGERESULT] integerValue];
                    if (0 == result)
                    {
                        UserInfo *user = [UserInfo myselfInstance];
                        user.userId = [[dict objectForKey:USERID] longLongValue];
                        user.userKey = [dict objectForKey:USERKEY];
                        [user synchronize:nil];
                        
                        //记录下手机号和密码用于后面自动登录
                        [[LogicManager sharedInstance] setPersistenceData:rightPhoneNum withKey:PHONENUMSTR];
                        [[LogicManager sharedInstance] setPersistenceData:rightPassword withKey:USERINPUTPW];
                        
                        [hub show:YES];
                        hub.labelText = @"登陆成功";
                        [hub hide:YES afterDelay:0.7 complete:^{
                            [[LogicManager sharedInstance] setRootViewContrllerWithNavigationBar:[MainViewController sharedInstance]];
                        }];
                    }
                    else if (-1010201 == result)
                    {
                        [hub show:YES];
                        hub.labelText = @"密码错误";
                        [hub hide:YES afterDelay:1.0];
                    }
                    else if (-1010202 == result)
                    {
                        [hub show:YES];
                        hub.labelText = @"用户状态不可用";
                        [hub hide:YES afterDelay:1.0];
                    }
                    else if (-1010203 == result)
                    {
                        [hub show:YES];
                        hub.labelText = @"用户未注册";
                        [hub hide:YES afterDelay:1.0];
                    }
                    else if (-1 == result)
                    {
                        [hub show:YES];
                        hub.labelText = @"登陆错误";
                        [hub hide:YES afterDelay:1.0];
                    }
                }
            
            }];
        }
    }];
}


#pragma mark - Actions
- (IBAction)forgetPWBtnAction:(id)sender
{
    ForgetPWViewController *forgetCtl = [[ForgetPWViewController alloc] initWithNibName:NSStringFromClass([ForgetPWViewController class]) bundle:nil];
    [self.navigationController pushViewController:forgetCtl animated:YES];
}

-(void)oldUserCustomInputView
{
    oldUserInputView.backgroundColor = colorWithHex(BackgroundColor2);
    oldUserInputView.layer.cornerRadius = 5;
}

-(void)oldGoToBack
{
    [[LogicManager sharedInstance] setRootViewContrller:[SplashViewController sharedInstance]];
}

#pragma mark - TextFiledDelegate
-(void)textFieldInChanging:(NSNotification *)note
{
    UITextField *textField = (UITextField *)[note object];
    if (textField == phoneNum)
    {
        NSString *str = [self deCodePhoneNumStr:phoneNum.text];
        if (str.length == 11)
        {
            if ([[LogicManager sharedInstance] isMobileNumber:str])
            {
                textField.text = [self enCodePhoneNumStr:str];
            }
        }
    }
}

@end
