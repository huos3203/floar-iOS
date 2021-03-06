//
//  UIControl(AutoScroll).m
//  WeLinked3
//
//  Created by jonas on 2/26/14.
//  Copyright (c) 2014 WeLinked. All rights reserved.
//

#import "AutoScrollUITextField.h"

@implementation AutoScrollUITextField
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self observe];
    return self;
}
-(id)init
{
    self = [super init];
    [self observe];
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self observe];
    return self;
}
-(void)observe
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if(self.editing)
    {
        NSDictionary* info = [aNotification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        oriOffset = self.table.contentOffset;
//        NSLog(@"====%f",self.table.contentOffset.y);
        DLog(@"====%f",self.table.contentOffset.y);
        CGPoint point = [self convertPoint:CGPointMake(0, 0) toView:nil];
        float height = ([UIScreen mainScreen].bounds.size.height - kbSize.height-self.frame.size.height) -(point.y);
        if(height<0)
        {
            [UIView animateWithDuration:duration.doubleValue animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[curve intValue]];
                [self.table setContentOffset:CGPointMake(0, oriOffset.y - height) animated:YES];
            } completion:^(BOOL finished) {
            }];
        }
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if(self.editing)
    {
        NSDictionary* info = [aNotification userInfo];
        NSNumber *duration = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            [self.table setContentOffset:oriOffset animated:YES];
        } completion:^(BOOL finished) {
        }];
    }
}
@end
