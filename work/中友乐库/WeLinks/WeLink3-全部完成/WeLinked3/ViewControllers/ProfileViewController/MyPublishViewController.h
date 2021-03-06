//
//  MyPublishViewController.h
//  WeLinked3
//
//  Created by jonas on 2/26/14.
//  Copyright (c) 2014 WeLinked. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobInfo.h"
#import "RecommendInfo.h"
#import "CustomCellView.h"
#import "RCLabel.h"
#import "LogicManager.h"
#import "MMPagingScrollView.h"
@interface MyPublishViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MMPagingScrollViewDelegate>
{
    IBOutlet UITableView* postTable;
    IBOutlet UITableView* recomandTable;
    NSMutableArray* jobDataSource;
    NSMutableArray* recommendDataSource;
    int type;
    IBOutlet UIView* segmentNav;
    IBOutlet UIImageView* segementBackground;
    IBOutlet UIButton* leftButton;
    IBOutlet UIButton* rightButton;
    
    MMPagingScrollView *scrollView;
    
    UILabel* nullLabel;
}
@end
