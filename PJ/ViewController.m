//
//  ViewController.m
//  PJ
//
//  Created by XiaoG on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "helpViewController.h"

#define KFileName @"data.plist"

@implementation ViewController
@synthesize iZFImage1;
@synthesize iZFImage2;
@synthesize iZBImg1;
@synthesize iZBImage1;
@synthesize ibtnFapai;
@synthesize ibtnKaipai;
@synthesize iZBImage2;
@synthesize iBiaoqing;
@synthesize iInfoLabel;
@synthesize iDesZBLabel;
@synthesize iDesZFLabel;
@synthesize iDesBFLabel;
@synthesize iDesBBLabel;
@synthesize iBFImage1;
@synthesize iBFImage2;
@synthesize iBBImage1;
@synthesize iBBImage2;
@synthesize iBFCheck1;
@synthesize iBBCheck1;
@synthesize iBFCheck2;
@synthesize iBBCheck2;
@synthesize iZJqianshu;
@synthesize iBJXiazhu;
@synthesize iBJqianshu;
@synthesize picNames;
@synthesize items;
@synthesize optionController;
@synthesize navController;

@synthesize fapai;
@synthesize win;
@synthesize lose;
@synthesize nuli;

- (void)didReceiveMemoryWarning
{
    self.optionController = nil;
    self.navController = nil;
    
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self initPJItems];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"fapai" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &fapai);
    
    path = [[NSBundle mainBundle] pathForResource:@"xiao" ofType:@"m4a"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &win);
    
    path = [[NSBundle mainBundle] pathForResource:@"lose" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &lose);
    
    path = [[NSBundle mainBundle] pathForResource:@"nuli" ofType:@"m4a"];
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &nuli);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setIZFImage1:nil];
    [self setIZFImage2:nil];
    [self setIZBImage1:nil];
    [self setIZBImage2:nil];
    [self setIBFImage1:nil];
    [self setIBFImage2:nil];
    [self setIBBImage1:nil];
    [self setIBBImage2:nil];
    [self setIZJqianshu:nil];
    [self setIBJqianshu:nil];
    [self setIBJXiazhu:nil];
    
    self.picNames = nil;
    self.items = nil;

    [self setIZBImg1:nil];
    [self setIbtnKaipai:nil];
    [self setIbtnFapai:nil];
    [self setIBFCheck2:nil];
    [self setIBBCheck2:nil];
    [self setIBFCheck1:nil];
    [self setIBBCheck1:nil];
    [self setIInfoLabel:nil];
    [self setIDesZBLabel:nil];
    [self setIDesZFLabel:nil];
    [self setIDesBFLabel:nil];
    [self setIDesBBLabel:nil];
    [self setIBiaoqing:nil];
    [super viewDidUnload];
    
    if (fapai)
    {
        AudioServicesDisposeSystemSoundID(fapai);
        fapai = 0;
        
        AudioServicesDisposeSystemSoundID(win);
        win = 0;
        
        AudioServicesDisposeSystemSoundID(lose);
        lose = 0;
        
        AudioServicesDisposeSystemSoundID(nuli);
        nuli = 0;
    }
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (optionController == nil)
    {
        optionController = [[PJGameOptionViewController alloc] initWithNibName:@"PJGameOptionViewController" bundle:nil];
        
        [optionController setObserver:self];
        
    }
    
    [self.view addSubview:optionController.view];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self resetState];
    iFapai = false;    
    [self kaishiyouxi:nil];
    [self loadData];
    

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [iZFImage1 release];
    [iZFImage2 release];
    [iZBImage1 release];
    [iZBImage2 release];
    [iBFImage1 release];
    [iBFImage2 release];
    [iBBImage1 release];
    [iBBImage2 release];
    [iZJqianshu release];
    [iBJqianshu release];
    [iBJXiazhu release];
    [picNames release];
    [items release];
    
    [iZBImg1 release];
    [ibtnKaipai release];
    [ibtnFapai release];
    [iBFCheck2 release];
    [iBBCheck2 release];
    [iBFCheck1 release];
    [iBBCheck1 release];
    [iInfoLabel release];
    [iDesZBLabel release];
    [iDesZFLabel release];
    [iDesBFLabel release];
    [iDesBBLabel release];
    [optionController release];
    [navController release];
    
    [iBiaoqing release];
    [super dealloc];
   
    if (fapai)
    {
        AudioServicesDisposeSystemSoundID(fapai);
        fapai = 0;
    
        AudioServicesDisposeSystemSoundID(win);
        win = 0;
    
        AudioServicesDisposeSystemSoundID(lose);
        lose = 0;
        
        AudioServicesDisposeSystemSoundID(nuli);
        nuli = 0;
    }
}


- (IBAction)kaiPai:(id)sender 
{
    //检查是不是前面的点大
    NSMutableString* BF;
    [self calculatePoint:(PJItem*)[items objectAtIndex:4+iRand*8] andItem:(PJItem*)[items objectAtIndex:5+iRand*8] toResult:&BF];
    
    
    NSMutableString* BB;
    [self calculatePoint:(PJItem*)[items objectAtIndex:6+iRand*8] andItem:(PJItem*)[items objectAtIndex:7+iRand*8] toResult:&BB];
    
    NSComparisonResult order = [BF compare:BB];
    [BF release];
    [BB release];
    
    if (order == NSOrderedDescending)
    {
        //Display alert view to user and return;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"不符合配牌规则" message:@"点数小的在前面，请检查。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    
    iFapai = false;
    
    [self adjustZhuangjia];
    
    NSString* picn = ((PJItem*)[items objectAtIndex:0+iRand*8]).picName;
    NSString* path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    
    UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
    //[iZBImg1 setImage:pic forState:UIControlStateNormal];
    [iZBImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:1+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZBImage2 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:2+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:3+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage2 setImage:pic];
    [pic release];
    
    [iBJXiazhu setEnabled:true];
    [ibtnFapai setEnabled:true];
    [ibtnKaipai setEnabled:false];

    [self compareResult];
}

- (void)compareResult
{
    // calculate zhuangjia point
    NSMutableString* ZF;
    [self calculatePoint:(PJItem*)[items objectAtIndex:2+iRand*8] andItem:(PJItem*)[items objectAtIndex:3+iRand*8] toResult:&ZF];
    [self displayDescription:iDesZFLabel forResult:ZF];
    
    NSMutableString* ZB;
    [self calculatePoint:(PJItem*)[items objectAtIndex:0+iRand*8] andItem:(PJItem*)[items objectAtIndex:1+iRand*8] toResult:&ZB];
    [self displayDescription:iDesZBLabel forResult:ZB];
    
    
    NSMutableString* BF;
    [self calculatePoint:(PJItem*)[items objectAtIndex:4+iRand*8] andItem:(PJItem*)[items objectAtIndex:5+iRand*8] toResult:&BF];
    [self displayDescription:iDesBFLabel forResult:BF];
    
    
    NSMutableString* BB;
    [self calculatePoint:(PJItem*)[items objectAtIndex:6+iRand*8] andItem:(PJItem*)[items objectAtIndex:7+iRand*8] toResult:&BB];
    [self displayDescription:iDesBBLabel forResult:BB];
    

    int score = 0;
    
    if ([BF compare:ZF] == NSOrderedDescending)
    {
        score += 1;
    }
    else
    {
        score -= 1;
    }
    
    if ([BB compare:ZB] == NSOrderedDescending)
    {
        score += 1;
    }
    else
    {
        score -= 1;
    }
    
    if ( score == 0 )
    {
        AudioServicesPlaySystemSound(nuli);
        [iInfoLabel setText:@"平局,再来一局."];
    }
    else if ( score > 0 )
    {
        AudioServicesPlaySystemSound(win);
        
        [iInfoLabel setText:@"玩家赢,再来一局."];
        [self setBiaoqing:1];
        
        int iZ = [[iZJqianshu text] intValue];
        int iB = [[iBJqianshu text] intValue];
        int xiazhu = [[iBJXiazhu text] intValue];
        
        iB += xiazhu;
        iZ -= xiazhu;
        
        NSString* str = [NSString stringWithFormat:@"%i", iZ];
        [iZJqianshu setText:str];
        str = [NSString stringWithFormat:@"%i", iB];
        [iBJqianshu setText:str];
    }
    else
    {
        AudioServicesPlaySystemSound(lose);
        
        [iInfoLabel setText:@"庄家赢,再来一局."];
        [self setBiaoqing:2];
        int iZ = [[iZJqianshu text] intValue];
        int iB = [[iBJqianshu text] intValue];
        int xiazhu = [[iBJXiazhu text] intValue];
        
        iB -= xiazhu;
        iZ += xiazhu;
        
        NSString* str = [NSString stringWithFormat:@"%i", iZ];
        [iZJqianshu setText:str];
        str = [NSString stringWithFormat:@"%i", iB];
        [iBJqianshu setText:str];

    }
    
    [ZF release];
    [ZB release];
    [BF release];
    [BB release];
    
    [self saveData];
}

- (IBAction)faPai:(id)sender 
{
    AudioServicesPlaySystemSound(fapai);
    
    [self xiPai];
    [self resetDescription];
    
    iFapai = true;
    NSString* picn = ((PJItem*)[items objectAtIndex:32]).picName;
    NSString* path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    
    UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
    //[iZBImg1 setImage:pic forState:UIControlStateNormal];
    [iZBImage1 setImage:pic];
    [pic release];

    picn = ((PJItem*)[items objectAtIndex:32]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZBImage2 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:32]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:32]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage2 setImage:pic];
    [pic release];
    
   /* NSString* picn = ((PJItem*)[items objectAtIndex:0+iRand*8]).picName;
    NSString* path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    
    UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
    //[iZBImg1 setImage:pic forState:UIControlStateNormal];
    [iZBImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:1+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZBImage2 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:2+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:3+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iZFImage2 setImage:pic];
    [pic release];*/

    
    picn = ((PJItem*)[items objectAtIndex:4+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBFImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:5+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBFImage2 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:6+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBBImage1 setImage:pic];
    [pic release];
    
    picn = ((PJItem*)[items objectAtIndex:7+iRand*8]).picName;
    path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
    pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBBImage2 setImage:pic];
    [pic release];
    
    [iBJXiazhu setEnabled:false];
    [ibtnFapai setEnabled:false];
    [ibtnKaipai setEnabled:true];
    
    // calculate wanjia point
    NSMutableString* ZF;
    [self calculatePoint:(PJItem*)[items objectAtIndex:4+iRand*8] andItem:(PJItem*)[items objectAtIndex:5+iRand*8] toResult:&ZF];
    [self displayDescription:iDesBFLabel forResult:ZF];
    
    NSMutableString* ZB;
    [self calculatePoint:(PJItem*)[items objectAtIndex:6+iRand*8] andItem:(PJItem*)[items objectAtIndex:7+iRand*8] toResult:&ZB];
    [self displayDescription:iDesBBLabel forResult:ZB];
    
    [ZF release];
    [ZB release];
    
    [iInfoLabel setText:@"配好后开牌见输赢."];
}

- (IBAction)kaishiyouxi:(id)sender 
{
    [iBJXiazhu setEnabled:true];
    [ibtnFapai setEnabled:true];
    [ibtnKaipai setEnabled:false];
}

- (void)initPJItems
{
    self.picNames = nil;
    self.items = [[NSMutableArray alloc] init];

    self.picNames = [NSArray arrayWithObjects:@"laoqian",@"huzi",@"hongshi",@"heishi",@"hongjiu",@"heijiu",@"hongba",@"heiba1",@"heiba2",@"menqi",@"zaqi1",@"zaqi2",@"chuiliu",@"xieliu",@"zaliu",@"hongwu",@"heiwu",@"esi",@"bansi",@"zasan",@"eguo",@"weizhi", nil];
    
    [self createItem:PJItemLaoqian];
    [self createItem:PJItemLaoqian];
    [self createItem:PJItemHuzi];
    [self createItem:PJItemHuzi];
    [self createItem:PJItemHongshi];
    [self createItem:PJItemHongshi];
    [self createItem:PJItemHeishi];
    [self createItem:PJItemHeishi];
    [self createItem:PJItemHongjiu];
    [self createItem:PJItemHeijiu];
    [self createItem:PJItemHongba];
    [self createItem:PJItemHongba];
    [self createItem:PJItemHeiba1];
    [self createItem:PJItemHeiba2];
    [self createItem:PJItemMenqi];
    [self createItem:PJItemMenqi];
    [self createItem:PJItemZaqi1];
    [self createItem:PJItemZaqi2];
    [self createItem:PJItemChuiliu];
    [self createItem:PJItemChuiliu];
    [self createItem:PJItemXieliu];
    [self createItem:PJItemXieliu];
    [self createItem:PJItemZaliu];
    [self createItem:PJItemHongwu];
    [self createItem:PJItemHeiwu];
    [self createItem:PJItemEsi];
    [self createItem:PJItemEsi];
    [self createItem:PJItemBansi];
    [self createItem:PJItemBansi];
    [self createItem:PJItemZasan];
    [self createItem:PJItemEguo];
    [self createItem:PJItemEguo];
    [self createItem:PJItemWeizhi];

}

- (void)createItem:(PJItemIdentifier)iden
{
    PJItem* item = [[PJItem alloc] init];
    item.identifier = iden;
    item.picName = [picNames objectAtIndex:iden];
    
    switch (iden)
    {
        case PJItemLaoqian:
            item.dianshu = 12;
            item.type = PJItemTian;
            break;
        case PJItemHuzi:
            item.dianshu = 11;
            item.type = PJItemDuan;
            break;
        case PJItemHongshi:
            item.dianshu = 10;
            item.type = PJItemDuan;
            break;
        case PJItemHeishi:
            item.dianshu = 10;
            item.type = PJItemChang;
            break;
        case PJItemHongjiu:
            item.dianshu = 9;
            item.type = PJItemZa;
            break;
        case PJItemHeijiu:
            item.dianshu = 9;
            item.type = PJItemZa;
            break;
        case PJItemHongba:
            item.dianshu = 8;
            item.type = PJItemRen;
            break;
        case PJItemHeiba1:
            item.dianshu = 8;
            item.type = PJItemZa;
            break;
        case PJItemHeiba2:
            item.dianshu = 8;
            item.type = PJItemZa;
            break;
        case PJItemMenqi:
            item.dianshu = 7;
            item.type = PJItemDuan;
            break;
        case PJItemZaqi1:
            item.dianshu = 7;
            item.type = PJItemZa;
            break;
        case PJItemZaqi2:
            item.dianshu = 7;
            item.type = PJItemZa;
            break;
        case PJItemChuiliu:
            item.dianshu = 6;
            item.type = PJItemDuan;
            break;
        case PJItemXieliu:
            item.dianshu = 6;
            item.type = PJItemChang;
            break;
        case PJItemZaliu:
            item.dianshu = 6;
            item.type = PJItemZa;
            break;
        case PJItemHongwu:
            item.dianshu = 5;
            item.type = PJItemZa;
            break;
        case PJItemHeiwu:
            item.dianshu = 5;
            item.type = PJItemZa;
            break;
        case PJItemEsi:
            item.dianshu = 4;
            item.type = PJItemHe;
            break;
        case PJItemBansi:
            item.dianshu = 4;
            item.type = PJItemChang;
            break;
        case PJItemZasan:
            item.dianshu = 3;
            item.type = PJItemZa;
            break;
        case PJItemEguo:
            item.dianshu = 2;
            item.type = PJItemDi;
            break;
        case PJItemWeizhi:
            item.dianshu = 0;
            item.type = PJitemUnknown;
            break;
        case PJItemCount:
            break;
        defaut:
            break;
    }
    
    [self.items addObject:item];
    [item release];
}

- (void)xiPai
{  
    [iInfoLabel setText:@"洗牌."];
    iRand = arc4random() % 4;
    //return;
    
    for ( int i = 0; i < 32; i++ )
    {
        int rand = arc4random() % 32;
        [items exchangeObjectAtIndex:i withObjectAtIndex:rand];
    }
    
    for ( int i = 0; i < 16; i++ )
    {
        [items exchangeObjectAtIndex:i withObjectAtIndex:31-i];
    }
    
    for ( int i = 31; i >= 0; i-- )
    {
        int rand = arc4random() % 32;
        [items exchangeObjectAtIndex:i withObjectAtIndex:rand];
    }
    
}

- (IBAction)BackgroundTaped:(id)sender forEvent:(UIEvent *)event 
{
    if (!iFapai)
        return;
    
    NSSet* touchs = [event touchesForView:self.view];
    
    if ([touchs count] == 1)
    {
        UITouch* touch = (UITouch*)[touchs anyObject]; 
        CGPoint pt = [touch locationInView:self.view];
        
        /////////////
        CGRect rect = [iBFImage1 frame];
        if ( CGRectContainsPoint(rect, pt))
        {
            [ibtnKaipai setEnabled:false];
            
            if ([iBFImage1 isHighlighted])
            {
                [self resetState];
            }
            else if ([iBFImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:4+iRand*8 withObjectAtIndex:5+iRand*8];
                [self resetState];
            }
            else if ([iBBImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:4+iRand*8 withObjectAtIndex:6+iRand*8];
                [self resetState];
            }
            else if ([iBBImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:4+iRand*8 withObjectAtIndex:7+iRand*8];
                [self resetState];
            }
            else
            {
                [iBFCheck1 setHidden:false];
                [iBFImage1 setHighlighted:true];
            }
            AudioServicesPlaySystemSound(fapai);
        }
        
        ////////////
        rect = [iBFImage2 frame];
        if ( CGRectContainsPoint(rect, pt))
        {
            [ibtnKaipai setEnabled:false];
            
            if ([iBFImage2 isHighlighted])
            {
                [self resetState];
            }
            else if ([iBFImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:5+iRand*8 withObjectAtIndex:4+iRand*8];
                [self resetState];
            }
            else if ([iBBImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:5+iRand*8 withObjectAtIndex:6+iRand*8];
                [self resetState];
            }
            else if ([iBBImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:5+iRand*8 withObjectAtIndex:7+iRand*8];
                [self resetState];
            }
            else
            {
                [iBFCheck2 setHidden:false];
                [iBFImage2 setHighlighted:true];
            }
            AudioServicesPlaySystemSound(fapai);
        }

        ////////////
        rect = [iBBImage1 frame];
        if ( CGRectContainsPoint(rect, pt))
        {
            [ibtnKaipai setEnabled:false];
            
            if ([iBBImage1 isHighlighted])
            {
                [self resetState];
            }
            else if ([iBFImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:6+iRand*8 withObjectAtIndex:4+iRand*8];
                [self resetState];
            }
            else if ([iBFImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:6+iRand*8 withObjectAtIndex:5+iRand*8];
                [self resetState];
            }
            else if ([iBBImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:6+iRand*8 withObjectAtIndex:7+iRand*8];
                [self resetState];
            }
            else
            {
                [iBBCheck1 setHidden:false];
                [iBBImage1 setHighlighted:true];
            }
            AudioServicesPlaySystemSound(fapai);
        }

        /////////////
        rect = [iBBImage2 frame];
        if ( CGRectContainsPoint(rect, pt))
        {
            [ibtnKaipai setEnabled:false];
            
            if ([iBBImage2 isHighlighted])
            {
                [self resetState];
            }
            else if ([iBFImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:7+iRand*8 withObjectAtIndex:4+iRand*8];
                [self resetState];
            }
            else if ([iBFImage2 isHighlighted])
            {
                [items exchangeObjectAtIndex:7+iRand*8 withObjectAtIndex:5+iRand*8];
                [self resetState];
            }
            else if ([iBBImage1 isHighlighted])
            {
                [items exchangeObjectAtIndex:7+iRand*8 withObjectAtIndex:6+iRand*8];
                [self resetState];
            }
            else
            {
                [iBBCheck2 setHidden:false];
                [iBBImage2 setHighlighted:true];
            }
            AudioServicesPlaySystemSound(fapai);
        }
        
        NSString* picn = ((PJItem*)[items objectAtIndex:4+iRand*8]).picName;
        NSString* path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
        UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
        [iBFImage1 setImage:pic];
        [pic release];
        
        picn = ((PJItem*)[items objectAtIndex:5+iRand*8]).picName;
        path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
        pic = [[UIImage alloc] initWithContentsOfFile:path];
        [iBFImage2 setImage:pic];
        [pic release];
        
        picn = ((PJItem*)[items objectAtIndex:6+iRand*8]).picName;
        path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
        pic = [[UIImage alloc] initWithContentsOfFile:path];
        [iBBImage1 setImage:pic];
        [pic release];
        
        picn = ((PJItem*)[items objectAtIndex:7+iRand*8]).picName;
        path = [[NSBundle mainBundle] pathForResource:picn ofType:@"png"];
        pic = [[UIImage alloc] initWithContentsOfFile:path];
        [iBBImage2 setImage:pic];
        [pic release];

        // calculate wanjia point
        NSMutableString* ZF;
        [self calculatePoint:(PJItem*)[items objectAtIndex:4+iRand*8] andItem:(PJItem*)[items objectAtIndex:5+iRand*8] toResult:&ZF];
        [self displayDescription:iDesBFLabel forResult:ZF];
        
        NSMutableString* ZB;
        [self calculatePoint:(PJItem*)[items objectAtIndex:6+iRand*8] andItem:(PJItem*)[items objectAtIndex:7+iRand*8] toResult:&ZB];
        [self displayDescription:iDesBBLabel forResult:ZB];
        
        [ZF release];
        [ZB release];
    }
}


- (IBAction)textFieldDoneEditing:(id)sender 
{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender 
{    
    [iBJXiazhu resignFirstResponder];
}

- (void)adjustZhuangjia
{
    // calculate zhuangjia point
    NSMutableString* point1;
    [self calculatePoint:(PJItem*)[items objectAtIndex:0+iRand*8] andItem:(PJItem*)[items objectAtIndex:1+iRand*8] toResult:&point1];
    
    
    NSMutableString* point2;
    [self calculatePoint:(PJItem*)[items objectAtIndex:0+iRand*8] andItem:(PJItem*)[items objectAtIndex:2+iRand*8] toResult:&point2];
    
    
    NSMutableString* point3;
    [self calculatePoint:(PJItem*)[items objectAtIndex:0+iRand*8] andItem:(PJItem*)[items objectAtIndex:3+iRand*8] toResult:&point3];
    
    
    NSMutableString* point4;
    [self calculatePoint:(PJItem*)[items objectAtIndex:1+iRand*8] andItem:(PJItem*)[items objectAtIndex:2+iRand*8] toResult:&point4];
    
    NSMutableString* point5;
    [self calculatePoint:(PJItem*)[items objectAtIndex:1+iRand*8] andItem:(PJItem*)[items objectAtIndex:3+iRand*8] toResult:&point5];
    
    
    NSMutableString* point6;
    [self calculatePoint:(PJItem*)[items objectAtIndex:2+iRand*8] andItem:(PJItem*)[items objectAtIndex:3+iRand*8] toResult:&point6];
    
    //find max value string
    NSMutableString* max = point1;
    
    if ( [max compare:point2] == NSOrderedAscending )
    {
        max = point2;
    }
    
    if ( [max compare:point3] == NSOrderedAscending )
    {
        max = point3;
    }
    
    if ( [max compare:point4] == NSOrderedAscending )
    {
        max = point4;
    }
    
    if ( [max compare:point5] == NSOrderedAscending )
    {
        max = point5;
    }
    
    if ( [max compare:point6] == NSOrderedAscending )
    {
        max = point6;
    }

    if ( max == point1 )
    {
        
    }
    else if (max == point2)
    {
        [items exchangeObjectAtIndex:1+iRand*8 withObjectAtIndex:2+iRand*8];
    }
    else if (max == point3)
    {
        [items exchangeObjectAtIndex:1+iRand*8 withObjectAtIndex:3+iRand*8];
    }
    else if (max == point4)
    {
        [items exchangeObjectAtIndex:0+iRand*8 withObjectAtIndex:2+iRand*8];
    }
    else if (max == point5)
    {
        [items exchangeObjectAtIndex:0+iRand*8 withObjectAtIndex:3+iRand*8];
    }
    else if (max == point6)
    {
        [items exchangeObjectAtIndex:1+iRand*8 withObjectAtIndex:2+iRand*8];
        [items exchangeObjectAtIndex:0+iRand*8 withObjectAtIndex:3+iRand*8];
    }
    
    [point1 release];
    [point2 release];
    [point3 release];
    [point4 release];
    [point5 release];
    [point6 release];
}

- (void)calculatePoint:(PJItem*)item1 andItem:(PJItem*)item2 toResult:(NSString**)result
{
    if (item1.identifier == item2.identifier)
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%@0", KDuizi];
    }
    else if ((item1.identifier == PJItemHongjiu && item2.identifier == PJItemHeijiu) || (item1.identifier == PJItemHeijiu && item2.identifier == PJItemHongjiu))
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%@0", KDuizi];
    }
    else if ((item1.identifier == PJItemHeiba1 && item2.identifier == PJItemHeiba2) || (item1.identifier == PJItemHeiba2 && item2.identifier == PJItemHeiba1))
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%@0", KDuizi];
    }
    else if ((item1.identifier == PJItemZaqi1 && item2.identifier == PJItemZaqi2) || (item1.identifier == PJItemZaqi2 && item2.identifier == PJItemZaqi1))
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%@0", KDuizi];
    }
    else if ((item1.identifier == PJItemHongwu && item2.identifier == PJItemHeiwu) || (item1.identifier == PJItemHeiwu && item2.identifier == PJItemHongwu))
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%@0", KDuizi];
    }
    else
    {
        *result = [[NSMutableString alloc] initWithFormat:@"%i0", (item1.dianshu + item2.dianshu) % 10 ];
    }
    
    [item1 checkPoint:*result];
    [item2 checkPoint:*result];
}

- (IBAction)TouchDown:(id)sender forEvent:(UIEvent *)event {
}

- (void)resetState
{
    [iBFCheck1 setHidden:true];
    [iBFImage1 setHighlighted:false];
    
    [iBFCheck2 setHidden:true];
    [iBFImage2 setHighlighted:false];

    [iBBCheck1 setHidden:true];
    [iBBImage1 setHighlighted:false];

    [iBBCheck2 setHidden:true];
    [iBBImage2 setHighlighted:false];

    [ibtnKaipai setEnabled:true];
}

- (void)displayDescription:(UILabel*)label forResult:(NSString*)result
{
    NSString* tmp = [NSString stringWithString:[result substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[result substringFromIndex:1]];
    
    if ([tmp compare:KHuangshan] == NSOrderedSame)
    {
        [label setText:KDesHuangshan];
    }
    else if ([tmp compare:KGuizi] == NSOrderedSame)
    {
        [label setText:KDesGuizi];
    }
    else if ([tmp compare:KTianjiu] == NSOrderedSame)
    {
        [label setText:KDesTianWang];
    }
    else if ([tmp compare:KDuizi] == NSOrderedSame)
    {
        [label setText:KDesDuizi];
    }
    else if ([tmp compare:KGangzi] == NSOrderedSame)
    {
        if ([tmp2 compare:KTian] == NSOrderedSame)
        {
            [label setText:KDesTianGang];
        }
        else
        {
            [label setText:KDesDiGang];
        }
    }
    else if ([tmp compare:K9] == NSOrderedSame)
    {
        [label setText:KDesJiuDian];
        /*if ([tmp2 compare:KTian] == NSOrderedSame)
        {
            [label setText:KDesTianjiu];
        }
        else if ([tmp2 compare:KDi] == NSOrderedSame)
        {
            [label setText:KDesDiJiu];
        }
        else
        {
            [label setText:KDesJiuDian];
        }*/
    }
    else if ([tmp compare:K8] == NSOrderedSame)
    {
        [label setText:KDesBaDian];
    }
    else if ([tmp compare:K7] == NSOrderedSame)
    {
        [label setText:KDesQiDian];
    }
    else if ([tmp compare:K6] == NSOrderedSame)
    {
        [label setText:KDesLiuDian];
    }
    else if ([tmp compare:K5] == NSOrderedSame)
    {
        [label setText:KDesWuDian];
    }
    else if ([tmp compare:K4] == NSOrderedSame)
    {
        [label setText:KDesSiDian];
    }
    else if ([tmp compare:K3] == NSOrderedSame)
    {
        [label setText:KDesSanDian];
    }
    else if ([tmp compare:K2] == NSOrderedSame)
    {
        [label setText:KDesLiangDian];
    }
    else if ([tmp compare:K1] == NSOrderedSame)
    {
        [label setText:KDesYiDian];
    }
    else if ([tmp compare:K0] == NSOrderedSame)
    {
        [label setText:KDesBieShi];
    }    
}

- (void)resetDescription
{
    [iDesBBLabel setText:@""];
    [iDesBFLabel setText:@""];
    [iDesZBLabel setText:@""];
    [iDesZFLabel setText:@""];
    [self setBiaoqing:0];
}

- (void)loadData
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:KFileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray* array = [[NSArray alloc] initWithContentsOfFile:filePath];
        [iZJqianshu setText:[array objectAtIndex:0]];
        [iBJqianshu setText:[array objectAtIndex:1]];
        [iBJXiazhu setText:[array objectAtIndex:2]];
        [array release];
    }
}

- (void)saveData
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:KFileName];
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:[iZJqianshu text]];
    [array addObject:[iBJqianshu text]];
    [array addObject:[iBJXiazhu text]];
    [array writeToFile:filePath atomically:YES];
    [array release];
}

- (void)SelectedMode:(int)option
{
    if ( option == 0 )
    {
        iFapai = false;
        [ibtnFapai setEnabled:true];
        [iBJXiazhu setEnabled:true];
        
        [self resetDescription];
        [self resetState];
        [self resetLayout];
        
        [ibtnKaipai setEnabled:false];
        
        [iZJqianshu setText:@"10000"];
        [iBJqianshu setText:@"10000"];
        [iBJXiazhu setText:@"50"];
    }
    else
    {
        [self loadData];
        
        if (clickAbout != true)
        {
            [self resetDescription];
            [self resetLayout];
        }
    }
    
    clickAbout = false;
}

- (IBAction)onHelp:(id)sender 
{
    if (navController == nil)
    {
        helpViewController* controller = [[helpViewController alloc] initWithStyle:UITableViewStylePlain];
        [controller setObeserver:self];
        navController = [[onHelpViewController alloc] initWithRootViewController:controller];
    }
    
    //加到window子视图
    [self.view.superview addSubview:navController.view];
}

- (IBAction)onAbout:(id)sender 
{
    clickAbout = true;
    
    if (optionController == nil)
    {
        
        optionController = [[PJGameOptionViewController alloc] initWithNibName:@"PJGameOptionViewController" bundle:nil];
    }
    [self.view addSubview:optionController.view];
}

- (void)backToView
{
    [navController.view removeFromSuperview];
    self.navController = nil;
}

- (void)resetLayout
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"weizhi" ofType:@"png"];
    UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBFImage1 setImage:pic];
    [iBFImage2 setImage:pic];
    [iBBImage1 setImage:pic];
    [iBBImage2 setImage:pic];
    [iZFImage1 setImage:pic];
    [iZFImage2 setImage:pic];
    [iZBImage1 setImage:pic];
    [iZBImage2 setImage:pic];
    [pic release];

    [iInfoLabel setText:@"请下注后发牌。"];
}

- (void)setBiaoqing:(int)mode
{
    NSString* picName;
        
    switch (mode) {
        case 0://normal
            picName = @"strive";
            break;
        case 1://fun
            picName = @"glad";
            break;
        case 2://cry
            picName = @"cry";
            break;
        default:
            break;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:picName ofType:@"png"];
    UIImage* pic = [[UIImage alloc] initWithContentsOfFile:path];
    [iBiaoqing setImage:pic];
    [pic release];
}
@end