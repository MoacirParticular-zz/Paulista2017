//
//  MainViewController.h
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ClubeCallMethods.h"
#import "DAOClube.h"
#import "DAOJogo.h"
#import "JogoCallMethods.h"


@interface MainViewController : UIViewController<ClubeMethodsDelegate, FutebasMethodsDelegate, JogoMethodsDelegate>{
    
}

@property (nonatomic, strong) ClubeCallMethods *clubeCallMethods;
@property (nonatomic, strong) JogoCallMethods *jogoCallMethods;

@end
