//
//  PJItem.h
//  PJ
//
//  Created by XiaoG on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KHuangshan @"E" //皇上
#define KGuizi     @"D" //鬼子
#define KTianjiu   @"C" //天九王
#define KDuizi     @"B" //对子
#define KGangzi    @"A" //杠子
#define K9         @"9" //9点
#define K8         @"8" //8点
#define K7         @"7" //7点
#define K6         @"6" //6点
#define K5         @"5" //5点
#define K4         @"4" //4点
#define K3         @"3" //3点
#define K2         @"2" //2点
#define K1         @"1" //1点
#define K0         @"0" //憋十

#define KTian      @"6" //天牌
#define KDi        @"5" //地牌
#define KRen       @"4" //人
#define KHe        @"3" //和
#define KChang     @"2" //长牌
#define KDuan      @"1" //短牌
#define KZa        @"0" //杂牌

#define KDesHuangshan @"皇上" //皇上
#define KDesGuizi     @"鬼子" //鬼子
#define KDesTianWang  @"天九王" //天九王
#define KDesDuizi     @"对子" //对子
#define KDesTianGang  @"天杠" //天杠
#define KDesDiGang    @"地杠" //地杠
#define KDesTianjiu   @"天九" //天9
#define KDesDiJiu     @"地九" //地9
#define KDesJiuDian   @"九点" //9点
#define KDesBaDian    @"八点" //8点
#define KDesQiDian    @"七点" //7点
#define KDesLiuDian   @"六点" //6点
#define KDesWuDian    @"五点" //5点
#define KDesSiDian    @"四点" //4点
#define KDesSanDian   @"三点" //3点
#define KDesLiangDian @"两点" //2点
#define KDesYiDian    @"一点" //1点
#define KDesBieShi    @"憋十" //憋十

#define Kch0       0x0030
#define Kch1       0x0031
#define Kch2       0x0032
#define Kch3       0x0033
#define Kch4       0x0034
#define Kch5       0x0035
#define Kch6       0x0036
#define Kch7       0x0037
#define Kch8       0x0038
#define Kch9       0x0039
#define KchB       0x0042

typedef enum {
    PJItemLaoqian = 0,
    PJItemHuzi,
    PJItemHongshi,
    PJItemHeishi,
    PJItemHongjiu,
    PJItemHeijiu,
    PJItemHongba,
    PJItemHeiba1,
    PJItemHeiba2,
    PJItemMenqi,
    PJItemZaqi1,
    PJItemZaqi2,
    PJItemChuiliu,
    PJItemXieliu,
    PJItemZaliu,
    PJItemHongwu,
    PJItemHeiwu,
    PJItemEsi,
    PJItemBansi,
    PJItemZasan,
    PJItemEguo,
    PJItemWeizhi,
    PJItemCount
} PJItemIdentifier;

typedef enum {
    PJItemTian = 0,
    PJItemDi,
    PJItemRen,
    PJItemHe,
    PJItemChang,
    PJItemDuan,
    PJItemZa,
    PJitemUnknown
} PJItemType;

@interface PJItem : NSObject

@property PJItemIdentifier  identifier;
@property int               dianshu;
@property PJItemType        type;
@property (nonatomic, retain) NSString* picName;

- (void)checkPoint:(NSString*)point;

- (void)checkLaoqian:(NSString*)point;
- (void)checkHuzi:(NSString*)point;
- (void)checkHongshi:(NSString*)point;
- (void)checkHeishi:(NSString*)point;
- (void)checkHongjiu:(NSString*)point;
- (void)checkHeijiu:(NSString*)point;
- (void)checkHongba:(NSString*)point;
- (void)checkHeiba:(NSString*)point;
- (void)checkMenqi:(NSString*)point;
- (void)checkZaqi:(NSString*)point;
- (void)checkChuiliu:(NSString*)point;
- (void)checkXieliu:(NSString*)point;
- (void)checkZaliu:(NSString*)point;
- (void)checkZawu:(NSString*)point;
- (void)checkEsi:(NSString*)point;
- (void)checkBansi:(NSString*)point;
- (void)checkZasan:(NSString*)point;
- (void)checkEguo:(NSString*)point;

@end
