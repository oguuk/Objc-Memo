//
//  DataManager.h
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (instancetype)sharedInstance;

@property (readonly, strong) NSManagedObjectContext* mainContext;
@property (strong, nonatomic) NSMutableArray* memoList;

- (void)fetchMemo;
- (void)addNewMemo:(NSString*)memo;
- (void)deleteMemo:(Memo*)memo;

@end

NS_ASSUME_NONNULL_END
