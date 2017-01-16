//
//  sobreApp_ViewController.h
//
//  Created by Moacir Ezequiel Lamego on 27/10/12.
//  Copyright (c) 2012 br.com.mobilesapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sobre_ViewController : UIViewController <UIWebViewDelegate> {
    
}

@property (strong, nonatomic) NSString *conteudo;
@property (strong, nonatomic) IBOutlet UIWebView *meuWebView;


- (IBAction) Iniciar: (id)sender _pathForResource:(NSString*) _pathForResource _ofType:(NSString*) _ofType;


@end
