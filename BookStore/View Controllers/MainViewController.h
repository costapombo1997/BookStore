//
//  MainViewController.h
//  BookStore
//
//  Created by Pedro Costa on 08/04/2020.
//  Copyright © 2020 Pedro Costa. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : ViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *booksCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *messagesLabel;

@end

NS_ASSUME_NONNULL_END
