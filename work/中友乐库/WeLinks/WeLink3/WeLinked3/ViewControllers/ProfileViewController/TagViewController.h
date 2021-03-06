//
//  TagViewController.h
//  WeLinked3
//
//  Created by jonas on 4/8/14.
//  Copyright (c) 2014 WeLinked. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface StateButton:UIButton
{
    UIImageView* selectedStateView;
    EventCallBack callBack;
}
@property(nonatomic,strong)NSString* data;
@property(nonatomic,assign)BOOL selectedState;
@end

@interface TagViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    UIView* listView;
    IBOutlet UIButton* confirmButton;
    NSMutableArray* dataSource;
    NSMutableArray* updateSource;
}
@end
