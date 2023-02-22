//
//  Memo.h
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Memo : NSObject

@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSDate* insertDate;

- (instancetype)initWithContent:(NSString*)content;

//+ (NSMutableArray*)dummyMemoList;
@property (strong, nonatomic, readonly, class) NSMutableArray* dummyMemoList;

@end

NS_ASSUME_NONNULL_END
