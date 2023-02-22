//
//  DetailViewController.h
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import <UIKit/UIKit.h>
#import "Memo.h"
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Memo* memo;

@end

NS_ASSUME_NONNULL_END
