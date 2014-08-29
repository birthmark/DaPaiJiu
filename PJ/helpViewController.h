//
//  helpViewController.h
//  PJ
//
//  Created by XiaoG on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PJBackToView

- (void)backToView;

@end

@interface helpViewController : UITableViewController
{
    id observer;
}
@property (retain, nonatomic) NSArray* items;

- (IBAction)back:(id)sender;
- (void)setObeserver:(id)obj;
@end
