//
//  NetworkManager.h
//  Cats
//
//  Created by Pierre Binon on 2017-01-25.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Photo.h"



@interface NetworkManager : NSObject

- (void) getPicturesWithCompletion: (void (^)(NSMutableArray *))completion;
- (void) downloadImagesFromURL: (NSURL *)url completion: (void (^)(UIImage *))completion;

@end
