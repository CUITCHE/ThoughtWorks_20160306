//
//  CHItemEntity.m
//  ThoughtWorks_20160306
//
//  Created by hejunqiu on 16/3/6.
//  Copyright © 2016年 hejunqiu. All rights reserved.
//

#import "CHItemEntity.h"

@implementation CHItemEntity

+ (instancetype)itemEntityWithCategory:(NSString *)category
                                  name:(NSString *)name
                                 price:(CGFloat)price
                                  unit:(NSString *)unit
                               barcode:(NSString *)barcode
                      preferentialType:(NSInteger)type
{
    CHItemEntity *item = [[CHItemEntity alloc] init];
    item.category = category;
    item.name = name;
    item.price = price;
    item.unit = unit;
    item.barcode = barcode;
    item.preferentialType = type;
    return item;
}

@end

@implementation CHDatabase

+ (NSDictionary<NSString *, CHItemEntity *> *)itemSetFortest
{
    NSMutableDictionary<NSString *, CHItemEntity *> *data = [NSMutableDictionary dictionary];
#define __text(t) #t
#define magic_create(_ca,_n,_p,_u,_c,_t) { \
        CHItemEntity *item = [CHItemEntity itemEntityWithCategory:@__text(_ca) \
                                                             name:@__text(_n) \
                                                            price:_p \
                                                             unit:@__text(_u) \
                                                          barcode:@__text(_c) \
                                                 preferentialType:(_t)]; \
        [data setObject:item forKey:@__text(_c)]; }
    magic_create(, 面包, 4.5, 个, CHITEM00001, 0);
    magic_create(, 可口可乐, 4, 瓶, CHITEM00002, CHPreferentialType3For2);
    magic_create(, 羽毛球, 1.5, 个, CHITEM00003, CHPreferentialType3For2);
    magic_create(, 苹果, 5.5, 个, CHITEM00004, 0);
    magic_create(, 面条, 5, 把, CHITEM00005, CHPreferentialType5Off);
    magic_create(, 海带, 12.6, 斤, CHITEM00006, 0);
    magic_create(, 面粉, 8.78, 袋, CHITEM00007, CHPreferentialType5Off | CHPreferentialType3For2);
    magic_create(, 牙刷, 3.75, 个, CHITEM00008, CHPreferentialType5Off | CHPreferentialType3For2);
    return data;
}

+ (BOOL)barcodeIsVaild:(NSString *)barcode
{
    NSArray<NSString *> *keys = @[@"CHITEM00001", @"CHITEM00002", @"CHITEM00003",
                                         @"CHITEM00004", @"CHITEM00005", @"CHITEM00006",
                                         @"CHITEM00007", @"CHITEM00008"];
    return [keys indexOfObject:barcode] != NSNotFound;
}
@end

@implementation CHSettlementEntity

@end