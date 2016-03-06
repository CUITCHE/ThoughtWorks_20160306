//
//  CHCashRegister.m
//  ThoughtWorks_20160306
//
//  Created by hejunqiu on 16/3/6.
//  Copyright © 2016年 hejunqiu. All rights reserved.
//

#import "CHCashRegister.h"
#import "CHItemEntity.h"

@interface CHCashRegister ()

@property (nonatomic, strong) NSDictionary<NSString *, CHItemEntity *> *data;
@property (nonatomic, strong) NSMutableDictionary<NSString *, CHSettlementEntity *> *perchase;

@end

@implementation CHCashRegister

- (instancetype)init
{
    self = [super init];
    if (self) {
        _data = [CHDatabase itemSetFortest];
        _perchase = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSUInteger)countOfPerchased
{
    __block NSUInteger count = 0;
    [_perchase enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, CHSettlementEntity * _Nonnull obj, BOOL * _Nonnull stop) {
        count += obj.count;
    }];
    return count;
}

- (void)addItemWithBarCode:(NSString *)barcode
{
    NSArray<NSString *> *value = [barcode componentsSeparatedByString:@"-"];
    NSInteger number = 1;
    NSString *key = barcode;
    if (value.count == 2) {
        key = value.firstObject;
        number = value.lastObject.integerValue;
    }
    if (![CHDatabase barcodeIsVaild:key]) {
        return;
    }
    CHSettlementEntity *entity = [_perchase objectForKey:key];
    if (entity) {
        entity.count += number;
    } else {
        entity = [[CHSettlementEntity alloc] init];
        entity.barcode = key;
        entity.count = number;
        [_perchase setObject:entity forKey:key];
    }
}

- (void)print
{
    NSArray<CHSettlementEntity *> *result = [self calculate];
    NSLog(@"******CHE超市******");
    CHItemEntity *item;
    CHSettlementEntity *entity;
    NSUInteger count = result.count;
    NSMutableArray<NSNumber *> *has3For2 = [NSMutableArray array];
    CGFloat free = 0;
    CGFloat total = 0;
    for (NSUInteger i=0; i<count; ++i) {
        entity = [result objectAtIndex:i];
        item = [_data objectForKey:entity.barcode];
        assert(item);
        entity = [result objectAtIndex:i];
        // Be formating same like SAMPLE.
        NSString *logString = [NSString stringWithFormat:@"名称：%@, 数量：%ld%@，单价：%.2f(元)，小计：%.2f(元)",
                               item.name, entity.count, item.unit, item.price, entity.subtotal];
        if (entity.free > 0 && entity.freeCount == 0) {
            logString = [NSString stringWithFormat:@"%@ 节省：%.2f(元)", logString, entity.free];
        }
        if (entity.free > 0 && entity.freeCount > 0) {
            [has3For2 addObject:@(i)];
        }
        free += entity.free;
        total += entity.subtotal;
        NSLog(@"%@", logString);
    }
    if (has3For2.count > 0) {
        NSLog(@"----------------------");
        NSLog(@"买二赠一商品：");
        for (NSNumber *number in has3For2) {
            entity = [result objectAtIndex:number.unsignedIntegerValue];
            item = [_data objectForKey:entity.barcode];
            assert(item);
            NSLog(@"名称：%@，数量：%ld%@", item.name, entity.freeCount,
                  item.unit);
        }
    }
    NSLog(@"----------------------");
    NSLog(@"总计：%.2f(元)", total);
    NSLog(@"节省：%.2f(元)", free);
    NSLog(@"*******************");
}

- (NSArray<CHSettlementEntity *> *)calculate
{
    NSArray<CHSettlementEntity *> *itemsOfPerchase = _perchase.allValues;
    CHItemEntity *item;
    for (CHSettlementEntity *entity in itemsOfPerchase) {
        item = [_data objectForKey:entity.barcode];
        assert(item);
        entity.subtotal = entity.count * item.price;
       if (item.preferentialType == CHPreferentialType3For2 && entity.count >= 3) {
           entity.freeCount = entity.count / 3;
           entity.free = item.price * entity.freeCount;
        } else if (item.preferentialType == CHPreferentialType5Off) {
            entity.free = entity.subtotal * 0.05;
        }
         entity.subtotal -= entity.free;
    }
    return itemsOfPerchase;
}

+ (void)justForTest
{
    CHCashRegister *cashRegister = [[CHCashRegister alloc] init];
    int i = 5;
    while ( i --> 0) {
        [cashRegister addItemWithBarCode:@"CHITEM00001"];
        [cashRegister addItemWithBarCode:@"CHITEM00002"];
        [cashRegister addItemWithBarCode:@"CHITEM00003"];
        [cashRegister addItemWithBarCode:@"CHITEM00004"];
        [cashRegister addItemWithBarCode:@"CHITEM00005"];
        [cashRegister addItemWithBarCode:@"CHITEM00006"];
        [cashRegister addItemWithBarCode:@"CHITEM00007"];
        [cashRegister addItemWithBarCode:@"CHITEM00008"];
    }
    [cashRegister print];
}
@end
