//
//  DataManager.m
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import "DataManager.h"
#import "Memo+CoreDataProperties.h"

@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        sharedInstance.memoList = [[NSMutableArray alloc] init];
    });
    
    return  sharedInstance;
}

- (void)fetchMemo {
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Memo"];
    NSSortDescriptor* sortByDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"insertDate" ascending:NO];
    request.sortDescriptors = @[sortByDateDesc];
    
    NSError* error = nil;
    NSArray* result = [self.mainContext executeFetchRequest:request error:&error];
    [self.memoList setArray:result];
}

- (void)addNewMemo:(NSString*)memo {
    Memo* newMemo  = [[Memo alloc] initWithContext: self.mainContext];
    newMemo.content = memo;
    newMemo.insertDate = [NSDate date];
    
    [self saveContext];
}

- (void)deleteMemo:(Memo*)memo {
    if (memo != nil) {
        [self.mainContext deleteObject:memo];
        [self saveContext];
    }
}

- (NSManagedObjectContext*)mainContext {
    return  self.persistentContainer.viewContext;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MemoApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
