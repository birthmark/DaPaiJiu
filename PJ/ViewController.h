//
//  ViewController.h
//  PJ
//
//  Created by XiaoG on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJItem.h"
#import "PJGameOptionViewController.h"
#import "onHelpViewController.h"
#import "helpViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController<PJOption, PJBackToView>
{
    NSArray* picNames;
    NSMutableArray* items;
    int iRand;
    int iFapai;
    bool clickAbout;
}

@property (retain, nonatomic) IBOutlet UIImageView *iZFImage1;
@property (retain, nonatomic) IBOutlet UIImageView *iZFImage2;
@property (retain, nonatomic) IBOutlet UIButton *iZBImg1;
@property (retain, nonatomic) IBOutlet UIImageView *iZBImage1;
@property (retain, nonatomic) IBOutlet UIButton *ibtnFapai;
@property (retain, nonatomic) IBOutlet UIButton *ibtnKaipai;
@property (retain, nonatomic) IBOutlet UIImageView *iZBImage2;
- (IBAction)backgroundTap:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *iBiaoqing;
@property (retain, nonatomic) IBOutlet UILabel *iInfoLabel;
- (IBAction)onAbout:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *iDesZBLabel;
@property (retain, nonatomic) IBOutlet UILabel *iDesZFLabel;
@property (retain, nonatomic) IBOutlet UILabel *iDesBFLabel;

@property (retain, nonatomic) IBOutlet UILabel *iDesBBLabel;
@property (retain, nonatomic) IBOutlet UIImageView *iBFImage1;
@property (retain, nonatomic) IBOutlet UIImageView *iBFImage2;
@property (retain, nonatomic) IBOutlet UIImageView *iBBImage1;
@property (retain, nonatomic) IBOutlet UIImageView *iBBImage2;
- (IBAction)BackgroundTaped:(id)sender forEvent:(UIEvent *)event;
- (IBAction)onHelp:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *iBFCheck1;
@property (retain, nonatomic) IBOutlet UIImageView *iBBCheck1;
- (IBAction)TouchDown:(id)sender forEvent:(UIEvent *)event;

@property (retain, nonatomic) IBOutlet UIImageView *iBFCheck2;
@property (retain, nonatomic) IBOutlet UIImageView *iBBCheck2;

@property (retain, nonatomic) IBOutlet UILabel *iZJqianshu;
@property (retain, nonatomic) IBOutlet UITextField *iBJXiazhu;
@property (retain, nonatomic) IBOutlet UILabel *iBJqianshu;
@property (retain, nonatomic) NSArray* picNames;
@property (retain, nonatomic) NSMutableArray* items;
@property (retain, nonatomic) PJGameOptionViewController* optionController;
@property (retain, nonatomic) onHelpViewController* navController;

@property (nonatomic) SystemSoundID fapai;
@property (nonatomic) SystemSoundID win;
@property (nonatomic) SystemSoundID lose;
@property (nonatomic) SystemSoundID nuli;

- (IBAction)kaiPai:(id)sender;
- (IBAction)faPai:(id)sender;
- (IBAction)kaishiyouxi:(id)sender;

- (void)initPJItems;
- (void)createItem:(PJItemIdentifier)iden;
- (void)xiPai;
- (void)calculatePoint:(PJItem*)item1 andItem:(PJItem*)item2 toResult:(NSString**)result;
- (void)adjustZhuangjia;
- (void)resetState;
- (void)resetLayout;
- (void)compareResult;
- (void)displayDescription:(UILabel*)label forResult:(NSString*)result;
- (void)resetDescription;
- (void)loadData;
- (void)saveData;
- (void)setBiaoqing:(int)mode;
@end
