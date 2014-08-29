//
//  PJItem.m
//  PJ
//
//  Created by XiaoG on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PJItem.h"

@implementation PJItem

@synthesize identifier;
@synthesize dianshu;
@synthesize type;
@synthesize picName;

-(void)dealloc
{
    [picName release];
    [super dealloc];
}

- (void)checkPoint:(NSString*)point
{
    switch (identifier) {
        case PJItemLaoqian:
            [self checkLaoqian:point];
            break;
            
        case PJItemHuzi:
            [self checkHuzi:point];
            break;
        case PJItemHongshi:
            [self checkHongshi:point];
            break;
        case PJItemHeishi:
            [self checkHeishi:point];
            break;
        case PJItemHongjiu:
        case PJItemHeijiu:
            [self checkHongjiu:point];
            break;
        case PJItemHongba:
            [self checkHongba:point];
            break;
        case PJItemHeiba1:
        case PJItemHeiba2:
            [self checkHeiba:point];
            break;
        case PJItemMenqi:
            [self checkMenqi:point];
            break;
        case PJItemChuiliu:
            [self checkChuiliu:point];
            break;
        case PJItemXieliu:
            [self checkXieliu:point];
            break;        
        case PJItemZaliu:
            [self checkZaliu:point];
            break;
        case PJItemHongwu:
        case PJItemHeiwu:
            [self checkZawu:point];
            break;
        case PJItemEsi:
            [self checkEsi:point];
            break;
        case PJItemBansi:
            [self checkBansi:point];
            break;
        case PJItemZasan:
            [self checkZasan:point];
            break;
        case PJItemEguo:
            [self checkEguo:point];
            break;
            
        default:
            break;
    }
}

- (void)checkLaoqian:(NSString*)point
{
    //return;
    
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        rang = NSMakeRange(1, 1);
        [point deleteCharactersInRange:rang];
        [point insertString:KTian atIndex:1];
        
        /*if ( Kch0 == [str characterAtIndex:0])
         {
         NSRange rang = NSMakeRange(0, 1);
         [str deleteCharactersInRange:rang];
         [str insertString:KDuizi atIndex:0];
         }*/
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
                [point insertString:KTian atIndex:1];
                rang = NSMakeRange(2, 1);
                [point deleteCharactersInRange:rang];
                break;
            case 1:
                [point insertString:KTianjiu atIndex:0];
                rang = NSMakeRange(1, 1);
                [point deleteCharactersInRange:rang];
                break;
            case 0:
                [point insertString:KGangzi atIndex:0];                
                rang = NSMakeRange(1, 1);
                [point deleteCharactersInRange:rang];
                
                [point insertString:KTian atIndex:1];
                rang = NSMakeRange(2, 1);
                [point deleteCharactersInRange:rang];
                break;
                
            default:
                break;
        }
    }
}

- (void)checkHuzi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KDuan atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KDuan] == NSOrderedAscending )
                {
                    [point insertString:KDuan atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;
            case 0:
                [point insertString:KGuizi atIndex:0];                
                rang = NSMakeRange(1, 1);
                [point deleteCharactersInRange:rang];
                break;
                
            default:
                break;
        }
    }
    
}


- (void)checkHongshi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KDuan atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KDuan] == NSOrderedAscending )
                {
                    [point insertString:KDuan atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                
                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
    
}


- (void)checkHeishi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KChang atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KChang] == NSOrderedAscending )
                {
                    [point insertString:KChang atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }

                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
    
}


- (void)checkHongjiu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KZa atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
}


- (void)checkHeijiu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KZa atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
}


- (void)checkHongba:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KRen atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                [point insertString:KRen atIndex:1];
                rang = NSMakeRange(2, 1);
                [point deleteCharactersInRange:rang];

                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkHeiba:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KZa atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
}


- (void)checkMenqi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KDuan atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KDuan] == NSOrderedAscending )
                {
                    [point insertString:KDuan atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkZaqi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KZa atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
}


- (void)checkChuiliu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KDuan atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KDuan] == NSOrderedAscending )
                {
                    [point insertString:KDuan atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkXieliu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KChang atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            //case 8:
            case 7:
            case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KChang] == NSOrderedAscending )
                {
                    [point insertString:KChang atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkZaliu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;

    int val = [tmp intValue];
    switch (val) {
        case 9:
            [point insertString:KHuangshan atIndex:0];
            rang = NSMakeRange(1, 1);
            [point deleteCharactersInRange:rang];
            break;
                
        default:
            break;
    }
}


- (void)checkZawu:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KZa atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
}


- (void)checkEsi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KHe atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            //case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KHe] == NSOrderedAscending )
                {
                    [point insertString:KHe atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;
            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkBansi:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSString* tmp2 = [NSString stringWithString:[point substringFromIndex:1]];    
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KChang atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            //case 8:
            case 7:
            //case 6:
            case 5:
            case 4:
            case 3:
            case 2:
            case 1:
                if ( [tmp2 compare:KChang] == NSOrderedAscending )
                {
                    [point insertString:KChang atIndex:1];
                    rang = NSMakeRange(2, 1);
                    [point deleteCharactersInRange:rang];
                }
                break;

            case 0:
                break;
                
            default:
                break;
        }
    }
}


- (void)checkZasan:(NSString*)point
{
    return;
}


- (void)checkEguo:(NSString*)point
{
    //return;
    NSString* tmp = [NSString stringWithString:[point substringToIndex:1]];
    NSRange rang;
    
    if ( [tmp isEqualToString:KDuizi] )
    {
        [point insertString:KDi atIndex:1];
        rang = NSMakeRange(2, 1);
        [point deleteCharactersInRange:rang];
    }
    else
    {
        int val = [tmp intValue];
        switch (val) {
            case 9:
            case 8:
            case 7:
            case 6:
            case 5:
            //case 4:
            case 3:
            case 2:
            case 1:
                [point insertString:KDi atIndex:1];
                rang = NSMakeRange(2, 1);
                [point deleteCharactersInRange:rang];
                break;
            case 0:
                [point insertString:KGangzi atIndex:0];                
                rang = NSMakeRange(1, 1);
                [point deleteCharactersInRange:rang];
                
                [point insertString:KDi atIndex:1];
                rang = NSMakeRange(2, 1);
                [point deleteCharactersInRange:rang];
                break;
                
            default:
                break;
        }
    }
}


@end
