//
//  ComposeViewController.h
//  MemoApp
//
//  Created by 오국원 on 2023/02/22.
//

#import <UIKit/UIKit.h>
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController

@property (strong, nonatomic) Memo* editTarget;

@end

NS_ASSUME_NONNULL_END
