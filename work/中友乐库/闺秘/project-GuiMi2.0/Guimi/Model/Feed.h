//
//  Feed.h
//  闺秘
//
//  Created by floar on 14-6-24.
//  Copyright (c) 2014年 jonas. All rights reserved.
//

#import "NSObjectExtention.h"
#import "Package.h"
typedef enum
{
    NormalFeedType = 0,
    VoteFeedType
}FeedType;

//2.0版本暂时不用
typedef enum
{
    GeneralFeedKind = 0,
    FriendFeedKind,
    GroundFeedKind
}FeedKind;

@interface Feed : NSObjectExtention

@property (nonatomic, assign) uint64_t DBUid;//区分数据库归属
@property (nonatomic, assign) uint64_t feedId;
@property (nonatomic, strong) NSString *contentJson;
@property (nonatomic, assign) uint32_t likeNum;
@property (nonatomic, assign) uint32_t commentNum;
@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic, assign) uint32_t isOwnZanFeed;
//0x01:可以评论  0x02:不可以评论
@property (nonatomic, assign) uint32_t canComment;
//0x01:可以删除  0x02:不可以删除
@property (nonatomic, assign) uint32_t canDeleteComment;
@property (nonatomic, assign) NSTimeInterval createTime;
//0:普通消息   1投票消息
@property (nonatomic, assign) FeedType feedType;
@property (nonatomic, strong) NSString *voteStr;
//2.0版本这个值需要解析，但是无意义
//0:不限制 1:朋友消息 2:广场消息
@property (nonatomic, assign) FeedKind feedKind;
@property (nonatomic, strong) NSMutableArray *voteArray;

//解析内容Json后结果
@property (nonatomic, strong) NSString *contentStr;
//imageStr和BackgroundColor只能二选一
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, assign) unsigned long backgroundColor;

@property (nonatomic, assign) unsigned long fontColor;

-(void)analyzeMainPagePackageForFeed:(Package *)pack;
-(void)analyzeDetailPagePackageForFeed:(Package *)pack;
-(void)analyzePagePackageForQuestionFeed:(Package *)pack;

//@property (nonatomic, strong) NSString *commentJson;
//@property (nonatomic, strong) NSMutableArray *commentArray;
@end
