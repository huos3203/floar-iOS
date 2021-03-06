//
//  Common.h
//  ChatView
//
//  Created by jonas on 12/5/13.
//  Copyright (c) 2013 jonas. All rights reserved.
//com.WeLinked.${PRODUCT_NAME:rfc1034identifier}

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WeiboSDK.h>
#import <EGOImageButton.h>
#import "EGOImageView(Extension).h"
#import "UINavigationItem+WMStyle.h"
#import "MobClick.h"
#define NAVBARCOLOR 0x2485ED


#define UMENG_APPKEY @"532ba19056240ba923044d62"



#define SOCIAL1    @"SOCIAL-1"   //,我的人脉查看profile次数,0   OK
#define SOCIAL2    @"SOCIAL-2"   //,招聘人才发出的职位数,0       OK
#define SOCIAL3    @"SOCIAL-3"   //,职位求推荐次数,0
#define SOCIAL4    @"SOCIAL-4"   //,求内推发出的请求数量,0       OK
#define SOCIAL5    @"SOCIAL-5"   //,建立联系发起次数,0           OK
#define SOCIAL6    @"SOCIAL-6"   //,联系他发起次数,0            OK
#define SOCIAL7    @"SOCIAL-7"   //,通过联系他发出的微博数,0      OK
#define SOCIAL8    @"SOCIAL-8"   //,通讯录好友邀请发起次数,0      OK
#define SOCIAL9    @"SOCIAL-9"   //,新浪微博好友邀请发起次数,0    OK
#define JOB1       @"JOB-1"      //,人脉职位点击次数,0           OK
#define JOB2       @"JOB-2"      //,公司职位点击次数,0           OK
#define JOB3       @"JOB-3"      //,筛选功能使用次数,0           OK
#define JOB4       @"JOB-4"      //,通过职位触发建立联系次数,0      OK
#define JOB5       @"JOB-5"      //,通过职位触发发送邮件次数,0      OK
#define JOB6       @"JOB-6"      //,通过公司职位触发求内推次数,0   OK
#define CONTACTS1  @"CONTACTS-1" //,生成赞文章的信息流,0     OK
#define CONTACTS2  @"CONTACTS-2" //,生成评论文章的信息流,0
#define CONTACTS3  @"CONTACTS-3" //,关于Profile的信息流,0
#define CONTACTS4  @"CONTACTS-4" //,分享职位的信息流,0
#define CONTACTS5  @"CONTACTS-5" //,用户自主分享的信息流产生的赞的数量,0
#define CONTACTS6  @"CONTACTS-6" //,用户自主分享的信息流产生的评论的数量,0        OK
#define CONTACTS7  @"CONTACTS-7" //,分享朋友圈次数,0               OK
#define CONTACTS8  @"CONTACTS-8" //,分享新浪微博次数,0             OK
#define CONTACTS9  @"CONTACTS-9" //,用户自主分享的信息流,0        OK
#define CONTACTS10 @"CONTACTS-10"//,朋友圈文章打开数,0
#define CONTACTS11 @"CONTACTS-11"//,朋友圈回流点击数,0
#define CONTACTS12 @"CONTACTS-12"//,新浪微博文章打开数,0
#define CONTACTS13 @"CONTACTS-13"//,新浪微博回流点击数,0
#define ARTICLE1   @"ARTICLE-1"  //,源的订阅数量,0                OK
#define ARTICLE2   @"ARTICLE-2"  //,阅读次数,0                   OK
#define ARTICLE3   @"ARTICLE-3"  //,点赞次数,0                   OK
#define ARTICLE4   @"ARTICLE-4"  //,发表评论次数,0                OK



//linkedin

//API 密钥:
//75din871nwhbu6
//密钥:
//KHw8mNLHWy6Q3GIK

//OAuth 用户令牌:
//94300447-c308-41de-8575-f2d1070ad244
//OAuth 令牌密钥:
//6f990815-ff83-414f-b2d1-6f666edfd11f
//#define LINKEDIN_CLIENT_ID @"75din871nwhbu6"
//#define LINKEDIN_CLIENT_SECRET @"KHw8mNLHWy6Q3GIK"
//#define LINKEDIN_ACCESS_TOKEN @"LINKEDIN_ACCESS_TOKEN"


//sina 
#define kAppKey         @"1854758692"
#define kRedirectURI    @"http://api.weibo.com/oauth2/default.html"
#define kWeiboToken     @"weibotoken"
#define kWeiboUid       @"kWeiboUid"
#define kExpirationDate @"expirationDate"


//#define SERVERROOTURL @"http://10.10.151.248:8081"
#define SERVERROOTURL @"http://m.we-linked.com"
#define WEIBOAPIROOT  @"https://api.weibo.com/2"
#define APPVERSION @"1.1"
#define USERID @"UserID"
#define Postboard @"Postboard"
#define NavBarColor 0x5B9FEB
#define ALPHA @"+ABCDEFGHIJKLMNOPQRSTUVWXYZ###"
#define ALPHALEN 27
#define APPID @"834856698"
#define NewFriendsNotification @"NewFriendsNotification"
//无图浏览
#define WITHOUTIMAGE @"WithoutImage"
//推送信息
#define PUSHNOTIFICATION @"PushNotification"  //0推送  1 不推送

#define MyPublishedJob @"MyPublishedJob"
#define MyRecommendJob @"MyRecommendJob"
#define AllFriendsTable  @"AllFriendsTable"
#define MyFriendsTable  @"MyFriendsTable"
#define FirstDegreeFriend @"FirstDegreeFriend"//一度好友
#define WeiBoFriend @"WeiBoFriend"//在app里的一度好友

#define SecondDegreeFrendTable @"SecondDegreeFrendTable"
#define NewFriendTable @"NewFriendTable"
#define EnableContacts   @"EnableContacts"

#define kDidSelectJobTitle @"kDidSelectJobTitle"

#define FirstInstall @"FirstInstall"
@interface Common : NSObject
typedef enum
{
    Stranger,//陌生人
    RequestSended,//已发送加好友请求
    Friends,//已是好友
} RelationState;

typedef void (^EventCallBack)(int event,id object);
UIFont* getFontWith(BOOL bold,int size);
UIColor* colorWithHex(int value);
NSString* getIdentityKey(NSString* key);

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
@end

@interface UIImage (Resize)
-(UIImage*)resizeWithSize:(CGSize)targetSize;
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
