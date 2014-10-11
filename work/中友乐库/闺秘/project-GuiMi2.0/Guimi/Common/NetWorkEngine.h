//
//  NetWorkEngine.h
//  闺秘
//
//  Created by floar on 14-7-8.
//  Copyright (c) 2014年 jonas. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Package.h"
#import "Feed.h"
#import "Comment.h"
#import "LogicManager.h"
#include "Invocation.h"
#import "UserInfo.h"
#import <AsyncSocket.h>
#import <AFNetworking.h>
@interface NetWorkEngine : NSObject<AsyncSocketDelegate>
{
    AsyncSocket *clientSocket;
    
    AFHTTPRequestOperationManager* server;
    NSTimer* timer;
    BOOL fullPackage;
    int particleSequnce;
}

-(void)sendData:(Package*)package block:(EventCallBack)block;
-(void)connectToServer;
-(BOOL)isConnectToServer;

//图片上传
-(void)postWithData:(NSString *)path
               data:(NSData*)data
            dataKey:(NSString*)dataKey
           mimeType:(NSString*)mimeType
         parameters:(NSDictionary *)parameters
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(void)reconnect;
+(NetWorkEngine *)shareInstance;

#pragma mark - 业务逻辑组装socket发送数据
#pragma --mark 用户注册
-(void)registWithAccountType:(uint32_t)accountType
                 accountName:(NSString *)accountName
                        setp:(uint32_t)step
                identifyCode:(NSString *)code
                    password:(NSString *)password
                       block:(EventCallBack)block;

#pragma --mark 判断当前手机是否能够收到验证码
-(void)canReceiveVerificationCodeByPhoneNum:(NSString *)phoneNum
                                  phoneRegistOrNot:(uint32_t)phoneType
                                      block:(EventCallBack)block;
#pragma --mark 修改密码
-(void)changePasswordWithOldPW:(NSString *)oldPassword
                   newPassword:(NSString *)newPassword
                         block:(EventCallBack)block;

#pragma --mark 重置密码
-(void)resetPasswordWithPhoneNumStr:(NSString *)phoneNum
                       identifyCode:(NSString *)identify
                             passWd:(NSString *)password
                              block:(EventCallBack)block;

#pragma --mark 用户登录
-(void)loginWithAccountType:(uint32_t)accountType
                accountName:(NSString *)accountName
                   password:(NSString *)password
                      block:(EventCallBack)block;

#pragma --mark 用户消息
/*
 feedType:0-普通消息  1-投票
 isOpen:0-不公开 1-公开
 */
-(void)publishSecretWithAddressJsonStr:(NSString *)address
                        contentJsonStr:(NSString *)content
                              feedType:(FeedType)feedType
                                isOpen:(int)isOpen
                                 block:(EventCallBack)block;

/*
 1,删除评论也在这个接口
 2,闺秘2.0之后对feed的评论不采用这个接口commmentFeedWithUserId替代,所以comment写死为@""
    0x01	消息点赞
    0x02	消息取消赞
    0x05	删除评论
    0x06	评论点赞
    0x07	评论取消赞
 */
#pragma --mark 赞或评论
-(void)supportOrCommentWithFeedId:(uint64_t)feedId
                  commentId:(uint64_t)commentId
                  operation:(uint32_t)operation
                    comment:(NSString *)comment
                      block:(EventCallBack)block;

/*
 1,该协议为闺秘2.0后评论专用协议，会比老版本多返回头像Id和楼层数
 2,之前协议supportOrCommentWith也可以用，但是缺少必要的返回值，兼容老版本
 */
#pragma --mark 发表评论
-(void)publishCommmentWithFeedId:(uint64_t)feedId
               commentContentStr:(NSString *)contentStr
                           block:(EventCallBack)block;

#pragma --mark 批量拉取最近feed
/*
 fetchType:
    0x01:最新到最旧拉取
    0x02:最旧到最新拉取
 feedKind:
    0:不限制
    1:朋友消息
    2:广场消息
 */
-(void)lastedFeedsWithFetchType:(uint32_t)type
                        startId:(uint64_t)startId
                          endId:(uint64_t)endId
               limitFetchAmount:(uint32_t)fetchAmount
                       feedKind:(FeedKind)kind
                          block:(EventCallBack)block;

#pragma --mark 拉取feed详细信息
-(void)feedDetailInfoWithFeedId:(uint64_t)feedId
                          block:(EventCallBack)block;

#pragma --mark 上传通讯录
-(void)updateContractList:(NSString *)jsonStr
                    block:(EventCallBack)block;

#pragma --mark 收藏消息
-(void)collectFeedWithFeedId:(uint64_t)feedId
                       block:(EventCallBack)block;

/*
 1,举报消息/评论
 2,举报评论时reason为@""
 3,uniqueCode暂无具体意义，为0
 3,ids为feedId或者commentId
 */
-(void)reportUserMessageWithIds:(uint64_t)ids
                     uniqueCode:(uint32_t)num
                   reportReason:(NSString *)reason
                          block:(EventCallBack)block;

#pragma --mark 拉取收藏的消息
-(void)fetchCollectedFeeds:(EventCallBack)block;

#pragma --mark 移除消息
-(void)deleteFeedInMainViewWithFeedId:(uint64_t)feedId
                                block:(EventCallBack)block;

#pragma --mark 拉取引导问题
-(void)fetchGuideQuestionWithTime:(uint32_t)time
                     preMessageId:(uint64_t)messageId
                        limitsNum:(uint32_t)num
                            block:(EventCallBack)block;

#pragma --mark 拉取用户朋友数
-(void)fetchNumberOfFriends:(EventCallBack)block;

#pragma --mark 意见反馈
-(void)suggestForUsWithContent:(NSString *)content
                         block:(EventCallBack)block;

#pragma --mark 注册APNs Token
-(void)registDeviceToken:(NSString*)token block:(EventCallBack)block;
#pragma --mark 取消注册
-(void)unRegistDeviceToken:(NSString*)token block:(EventCallBack)block;
#pragma --mark 用户投票
-(void)voteWithFeedId:(uint64_t)feedId
        opertionIndex:(uint32_t)index
                block:(EventCallBack)block;
#pragma --mark 拉取投票的赞和评论
-(void)fetchVoteDetailInfo:(uint64_t)feedId
                     block:(EventCallBack)block;


//#pragma mark - 网络数据处理
//-(void)handlePackage:(Package *)pack block:(EventCallBack)block;

@end
