//
//  PJGameOptionViewController.h
//  PJ
//
//  Created by XiaoG on 12-5-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJOption

- (void)SelectedMode:(int)option;

@end

@interface PJGameOptionViewController : UIViewController
{
    id observer;
}
- (IBAction)newGame:(id)sender;
- (IBAction)continueGame:(id)sender;
- (void)setObserver:(id)obj;

@end
