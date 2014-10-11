//
//  Common.h
//  ChatView
//
//  Created by jonas on 12/5/13.
//  Copyright (c) 2013 jonas. All rights reserved.
//com.WeLinked.${PRODUCT_NAME:rfc1034identifier}

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <EGOImageButton.h>
#import "EGOImageView(Extension).h"
#import "UINavigationItemCustom.h"
#import "CustomCellView.h"
#import "MobClick.h"
#import <MBProgressHUD.h>
#define NAVBARCOLOR 0x2485ED
#define DeepRedColor 0xD0246C
#define lightRedColor 0xF88BB5
#define CustomGrayColor 0xD21E66

#define PACKAGERESULT @"packageResult"
#define USERID @"USERID"
#define USERKEY @"USERKEY"
#define FEEDID @"FEEDID"
#define COMMENTID @"COMMENTID"
#define FRIENDNUM @"FRIENDNUM"
#define FEEDS @"feeds"
#define COMMENTS @"comments"
#define VOTES @"votes"
#define FEEDSTARTID @"feedStartId"
#define FEEDEENID @"feedEndId"
#define QUESTIONFEED @"QUESTIONFEED"
#define FEEDCOLLECT @"FEEDCOLLECT"


#define PHONENUMSTR @"phoneNumStr"
#define USERINPUTPW @"userInputPW"

//sina
#define kAppKey         @"3547924220"
#define kWeiboRedirectURL    @"http://api.weibo.com/oauth2/default.html"
#define kWeiboToken     @"weibotoken"
#define kWeiboUid       @"kWeiboUid"
#define kExpirationDate @"expirationDate"
#define LOCATION @"LocationAddress"
#pragma mark - 外网IP
//协议服务器
//#define TCPSERVERIP @"121.14.197.30"
//#define TCPSERVERPORT 12010
//外网图片服务器
//#define IMAGESERVER @"http://121.14.197.30"
//#define DOWNLOADIMAGE @"http://121.14.197.30"
#define IMAGESERVER @"http://www.guimi520.cn"
#define DOWNLOADIMAGE @"http://www.guimi520.cn"
//微博、微信分享服务器
//#define WECHATWEBSHAREURL @"http://121.14.197.30:12015/message/detail?from=wx&id="
//#define WEIBOWEBWEBSHAREURL @"http://121.14.197.30:12015/message/detail?from=wb&id="
//#define WECHATWEBSHAREURL @"http://www.guimi520.cn:12015/message/detail?from=wx&id="
//#define WEIBOWEBWEBSHAREURL @"http://www.guimi520.cn:12015/message/detail?from=wb&id="

#pragma mark - 内网IP
//电脑协议服务器
#define TCPSERVERIP @"10.10.151.238"
#define TCPSERVERPORT 9998
//服务器协议服务器
//#define TCPSERVERIP @"10.10.151.110"
//#define TCPSERVERPORT 12010
//图片服务器
//#define IMAGESERVER @"http://10.10.151.238"
//#define DOWNLOADIMAGE @"http://10.10.151.238"
//微博、微信分享
#define WECHATWEBSHAREURL @"http://10.10.151.110:12015/message/detail?from=wx&id="
#define WEIBOWEBWEBSHAREURL @"http://10.10.151.110:12015/message/detail?from=wb&id="

#pragma mark - other
#define TIMEOUTTIME 30
#define APPVERSION @"1.0"
#define APNSTOKEN @"apnsToken"
#define NavBarColor 0x5B9FEB
#define ALPHA @"+ABCDEFGHIJKLMNOPQRSTUVWXYZ###"
#define ALPHALEN 27
#define APPID @"903777968"
#define NewFriendsNotification @"NewFriendsNotification"
//无图浏览
#define WITHOUTIMAGE @"WithoutImage"
//推送信息
#define PUSHNOTIFICATION @"PushNotification"  //0推送  1 不推送

#define ConnectingServer @"ConnectingServer"
#define connectServerSuccess @"connectServerSuccess"

#define NearByFeeds @"NearByFeeds"
#define isOwnLike @"isOwnLike"
#define isOwnComment @"isOwnComment"
#define MyPublishedJob @"MyPublishedJob"
#define MyRecommendJob @"MyRecommendJob"
#define AllFriendsTable  @"AllFriendsTable"
#define MyFriendsTable  @"MyFriendsTable"
#define VisitorFriends @"VisitorFriends"
#define FirstDegreeFriend @"FirstDegreeFriend"//一度好友
#define WeiBoFriend @"WeiBoFriend"//在app里的一度好友

#define SecondDegreeFrendTable @"SecondDegreeFrendTable"
#define NewFriendTable @"NewFriendTable"
#define EnableContacts   @"EnableContacts"

#define kDidSelectJobTitle @"kDidSelectJobTitle"

#define FirstInstall @"FirstInstall"
#define SecretBGImageName @"img_secretCell_background_"

#define PhoneBook @"PhoneBook"
#define FeedLastMessageId @"FeedLastMessageId"
#define ExpFeedLastMessageId @"ExpFeedLastMessageId"
#define FirstLogin @"FirstLogin"
#define ExpFirstLogin @"ExpFirstLogin"
#define QuestionFeedsFirst @"QuestionFeedsFirst"
#define UpdatePhoneBookTime @"UpdatePhoneBookTime"
#define QuestionFeedLastMessageId @"QuestionFeedLastMessageId"
#define FirstFeedFetch @"FirstFeedFetch"
#define FirstQuestionFeedFetch @"FirstQuestionFeedFetch"

#define GET_IMAGE(__NAME__,__TYPE__) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__NAME__ ofType:__TYPE__]]

#define PROJECTID 0x01

//友盟
#define UMENG_APPKEY @"53e1dfecfd98c5ef0e00195f"
#define app_setting                @"app_setting"                  //点击设置按钮
#define cancel_praise              @"cancel_praise"                //取消点赞
#define change_password            @"change_password"              //修改密码
#define change_password_close      @"change_password_close"        //修改密码关闭
#define change_password_request    @"change_password_request"      //修改密码提交
#define clear_traces               @"change_password_request"      //清除痕迹
#define clear_traces_dialog_cancel @"clear_traces_dialog_cancel"   //取消清除痕迹
#define clear_traces_dialog_ok     @"clear_traces_dialog_ok"       //确定清除痕迹
#define click_change_bg            @"click_change_bg"              //发布feed,点击按钮切换背景
#define collect                    @"collect"                      //feed收藏
#define comment_click              @"comment_click"                //点击评论
#define comment_send               @"comment_send"                 //发送评论的次数
#define existing_account           @"existing_account"             //已有账号
#define faq                        @"faq"                          //常见问题
#define feed_back                  @"feed_back"                    //问题反馈
#define feed_back_request          @"feed_back_request"            //问题反馈提交
#define invite_friends             @"invite_friends"               //邀请好友
#define login_id                   @"login_id"                     //登录点击次数
#define Logout                     @"logout"                       //注销
#define logout_dialog_cancel       @"logout_dialog_cancel"         //_取消退出登录
#define logout_dialog_ok           @"logout_dialog_ok"             //确定退出登录
#define menu_click                 @"menu_click"                   //点击菜单按钮
#define move_change_bg             @"move_change_bg"               //发布feed,左右切换背景
#define no_small_tintin            @"no_small_tintin"              //木有小丁丁
#define publish                    @"publish"                      //发布
#define publish_button             @"publish_button"               //发布feed，按钮
#define publish_close              @"publish_close"                //关闭发布feed 按钮
#define Register                   @"register"                     //注册点击按钮
#define remove                     @"remove"                       //移除
#define report                     @"report"                       //举报
#define share                      @"share"                        //分享
#define share_dialog_close         @"share_dialog_close"           //分享框关闭
#define share_friend_circle        @"share_friend_circle"          //分享到朋友圈
#define share_message              @"share_message"                //短信分享
#define share_weibo                @"share_weibo"                  //分享到微博
#define share_weixin               @"share_weixin"                 //分享到微信
#define silently_give_up           @"silently_give_up"             //默默放弃
#define some_praise                @"some_praise"                  //点赞
#define take_photos                @"take_photos"                  //发布feed，拍照次数
#define to_join                    @"to_join"                      //立刻加入次数
#define ver_code                   @"ver_code"                     //验证码验证



//Math
#define MATH_RANDOM_0_1()           ((float)rand()/RAND_MAX)
//颜色定义
#define BackgroundColor1 0xF7F7F7
#define BackgroundColor2 0x414146
#define BackgroundColor3 0x323237
#define BackgroundColor4 0x252528
#define BackgroundColor5 0xEA5BA3

#define FontColor1 0xFFFFFF
#define FontColor2 0xB4B4B4
#define FontColor3 0x999999
#define FontColor4 0x5F5F5F
#define FontColor5 0xFFFF93



typedef enum
{
    UserBasicInfoSubSys = 0x01,
    UserMessageSubsys = 0x02,
    IndentifySubsys = 0x03,
    SensitiveWordSubsys = 0x04,
    FAQSubSys = 0x05,
    SystemOperSubsys = 0x06,
    AddressManagerSubsys = 0x07,
    PushNotification = 0x08
}SubSystem;


@interface Common : NSObject

typedef void (^EventCallBack)(int event,id object);

void runOnMainQueueWithoutDeadlocking(void (^block)(void));
void runOnAsynQueue(void (^block)(void));

UIColor* getRandomColor();
UIColor* getPrevColor();
UIColor* getNextColor();

UIImage* getRandomImage(NSString* prefix,int max,int* index);
UIImage* getPrevImage(NSString* prefix,int max,int* index);
UIImage* getNextImage(NSString* prefix,int max,int* index);

UIFont* getFontWith(BOOL bold,int size);

UIColor* colorWithHex(int value);

UIColor* colorWithHexAlpha(int value,float alpha);

NSString* getIdentityKey(NSString* key);

//将16进制颜色字符串（"#414146、0x414146"）转成colorWithHex函数可用的参数
unsigned long hexColorFromString(NSString *string);
//将colorWithHex函数可用的参数转成16进制颜色字符串
NSString * hexColorToString(UIColor *color);

NSTimeInterval getDateTimeIntervalWithYearMonth(int year,int month);
NSTimeInterval getDateTimeIntervalWithYearMonthDay(int year,int month,int day);
NSString* formatDateMonth(NSDate* dateTime);
NSString* formatDateShort(NSDate* dateTime);
NSString* formatDateWith(NSDate* dateTime,BOOL word);
NSString* formatDate(NSDate* dateTime);

+ (void)setNavigationBarWMStyle;
+(NSString *)timeIntervalStringFromTime:(NSTimeInterval)timeInterval;

//float getMargin();
BOOL isSystemVersionIOS7();
@end
@interface UILabel(Flexible)
-(UILabel*)FlexibleWidthWith:(NSString*)text height:(float)height;
-(UILabel*)FlexibleHeightWith:(NSString*)text width:(float)width;
+(float)calculateHeightWith:(NSString*)text font:(UIFont*)font width:(float)width lineBreakeMode:(NSLineBreakMode)mode;
+(float)calculateWidthWith:(NSString*)text font:(UIFont*)font height:(float)height lineBreakeMode:(NSLineBreakMode)mode;
+(CGSize)calculateCGSizeWith:(NSString *)text
                      height:(float)height
                       width:(float)width
                        font:(UIFont *)font;
@end

@interface UIImage (Resize)
-(UIImage*)resizeWithSize:(CGSize)targetSize;
@end

@interface UIImageView (AnimationBetweenLeftAndRight)

-(void)AnimationLeftAndRight:(int)originalX;
- (void)pauseLayer;
- (void)resumeLayer;
- (void)stopLayer;
@end


@interface UIView (Animate)
-(void)beginRotate:(CGFloat)duration block:(EventCallBack)block;
-(void)endRotate:(CGFloat)duration block:(EventCallBack)block;
@end
@interface NSString (URL)
- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;
- (BOOL)startWithHTTP;
@end

@interface UIView (Feed)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, readonly) CGFloat right;
@property (nonatomic, readonly) CGFloat bottom;

@property (nonatomic, retain) id userObject;

@end


CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);
@interface UIImage (Rotate)
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
@end
@interface MBProgressHUD (Extension)
- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay complete:(MBProgressHUDCompletionBlock)complete;
@end

@interface NSString (Extension)
-(NSString*)cleanup:(NSArray*)arr;
@end