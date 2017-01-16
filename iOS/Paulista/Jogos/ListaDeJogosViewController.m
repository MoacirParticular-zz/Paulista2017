//
//  ListaDeJogosViewController.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//

#import "ListaDeJogosViewController.h"

@interface ListaDeJogosViewController ()

@end

@implementation ListaDeJogosViewController
@synthesize meuSC, arrayFinais, arrayPrimeiroTurno, arraySegundoTurno, tabela, arrayRodadas, jogoCalMetodo, lb_Rodada, nrRodadaFinal, nrRodadaPrimeiroTurno, nrRodadaSegundoTurno, isFirstTime;

@synthesize alturaTabela;



-(void)viewDidAppear:(BOOL)animated {  
    
    alturaTabela = tabela.frame.size.height;
    
 //   NSLog(@"altura dos demonios: %f", self.view.frame.size.height);
 //   NSLog(@"%f", tabela.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isFirstTime = YES;
  	[self.view addSubview:loadingView];
    loadingView.hidden = NO;
    
    // ********************************* Inicio Ego ******************************************
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tabela.bounds.size.height, self.view.frame.size.width, self.tabela.bounds.size.height)];
		view.delegate = self;
		[self.tabela addSubview:view];
		_refreshHeaderView = view;
        //	[view release];
	}
    
    [_refreshHeaderView refreshLastUpdatedDate];
    // ********************************* Fim Ego *********************************************
    
    nrRodadaPrimeiroTurno = 0;
    nrRodadaSegundoTurno = 0;
    nrRodadaFinal = 0;
    
    [self AtualizarLista:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





// ********************************* Inicio Ego *********************************************
- (IBAction)AtualizarLista:(id)sender {
    [self fetchJogos];
    
    jogoCalMetodo = [[JogoCallMethods alloc] initWithDelegate:self];
    [jogoCalMetodo getAllJogos];
}

#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return [self carregandoAlgum]; // should return if data source model is reloading
    return YES;
}
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
    [self AtualizarLista:self];
    checarCarregando=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checarSeEstaCarregando) userInfo:nil repeats:YES];
}
-(void)checarSeEstaCarregando{
    if ([self carregandoAlgum]==NO) {
        [checarCarregando invalidate];
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tabela];
    }
}

-(BOOL)carregandoAlgum{
    BOOL checar=NO;
    //  [self AtualizarLista:self];
    //  checar=YES;
    return checar;
}
// ********************************* Fim Ego *********************************************






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    loadingView.hidden = YES;
    NSLog(@"Erro Jogos: %@", error);
    
}

-(void)jogosObtidosComSucessoComJson:(NSDictionary *)json {
    [DAOJogo parseAndInsertObjectsWithJson:json];
    
    [self fetchJogos];
}

-(void)fetchJogos
{
    NSArray* arrayTurnos = [DAOTurno fetchAllTurno];
    
    
    for (Turno* turno in arrayTurnos) {
        
        //     NSLog(@"TURNO: %@", turno);
        if ([turno.descricao isEqualToString:[VariaveisGlobais const_PrimeiroTurno]]) {
            arrayPrimeiroTurno = [turno.rodadas allObjects];
        }
        else if ([turno.descricao isEqualToString:[VariaveisGlobais const_SegundoTurno]]) {
            arraySegundoTurno = [turno.rodadas allObjects];
        }
        else if ([turno.descricao isEqualToString:[VariaveisGlobais const_Final]]) {
            arrayFinais = [turno.rodadas allObjects];
        }
    }
    
    // NSLog(@"%d", arrayPrimeiroTurno.count);
    
    [self SCMudou:self];
}









#pragma mark - **************************** Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Rodada* rodada;
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            rodada = [arrayRodadas objectAtIndex:nrRodadaPrimeiroTurno];
            break;
            
        case 1:
            rodada = [arrayRodadas objectAtIndex:nrRodadaSegundoTurno];
            break;
            
        case 2:
            rodada = [arrayRodadas objectAtIndex:nrRodadaFinal];
            break;
            
        default:
            break;
    }
    
    return rodada.jogos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCelula = @"idCelulaJogos";
    ListaDeJogos_Celula *celula = [tableView dequeueReusableCellWithIdentifier:idCelula];
    
    if (celula == nil)
    {
        celula = [[ListaDeJogos_Celula alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCelula];
    }
    
    if (indexPath.row %2) {
        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    } else {
        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
    }
    
    
    Rodada* rodada;
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            rodada = [arrayRodadas objectAtIndex:nrRodadaPrimeiroTurno];
            break;
            
        case 1:
            rodada = [arrayRodadas objectAtIndex:nrRodadaSegundoTurno];
            break;
            
        case 2:
            rodada = [arrayRodadas objectAtIndex:nrRodadaFinal];
            break;
            
        default:
            break;
    }
    
    lb_Rodada.text = rodada.descricao;
    
    Jogo* jogo = [[VariaveisGlobais sortedJogosByName:[rodada.jogos allObjects] campoId:@"data"]  objectAtIndex:indexPath.row];
    
    UIImage* img = [UIImage imageNamed:jogo.mandante.escudo];
    celula.nmTimeMandante.text = jogo.mandante.sigla;
    celula.golTimeMandante.text = [jogo.golsMandante stringValue];
    celula.imgTimeMandante.image = img;
    
    img = [UIImage imageNamed:jogo.visitante.escudo];
    celula.nmTimeVisitante.text = jogo.visitante.sigla;
    celula.golTimeVisitante.text = [jogo.golsVisitante stringValue];
    celula.imgTimeVisitante.image = img;
    
    //NSLog(@"%@", [jogo data]);
    celula.data.text =  [NSDateFormatter localizedStringFromDate:jogo.data dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    celula.hora.text =  [NSDateFormatter localizedStringFromDate:jogo.data dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
    
    return celula;
}

-(NSString *) InverterData:(NSString* ) _data {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* data = [dateFormatter dateFromString:_data];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:data];
}

#pragma mark - **************************** Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompartilharJogo_ViewController *CompartilharJogos = [[UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil] instantiateViewControllerWithIdentifier:@"idCompartilharJogo"];
    
    [CompartilharJogos setModalTransitionStyle:2];
    
    
    Rodada* rodada;
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            rodada = [arrayRodadas objectAtIndex:nrRodadaPrimeiroTurno];
            break;
            
        case 1:
            rodada = [arrayRodadas objectAtIndex:nrRodadaSegundoTurno];
            break;
            
        case 2:
            rodada = [arrayRodadas objectAtIndex:nrRodadaFinal];
            break;
            
        default:
            break;
    }
    
    lb_Rodada.text = rodada.descricao;
    
    Jogo* jogo = [[VariaveisGlobais sortedJogosByName:[rodada.jogos allObjects] campoId:@"data"]  objectAtIndex:indexPath.row];
    
    [self presentViewController:CompartilharJogos animated:YES completion:^{
        UIImage* img = [UIImage imageNamed:jogo.mandante.escudo];
        CompartilharJogos.lbNomeMandante.text = jogo.mandante.nome;
        CompartilharJogos.lb_GolsMandante.text = [jogo.golsMandante stringValue];
        CompartilharJogos.imgView_Mandante.image = img;
        
        img = [UIImage imageNamed:jogo.visitante.escudo];
        CompartilharJogos.lb_NomeVisitante.text = jogo.visitante.nome;
        CompartilharJogos.lb_GolsVisitante.text = [jogo.golsVisitante stringValue];
        CompartilharJogos.imgView_Visitante.image = img;
        
        CompartilharJogos.data =  [NSDateFormatter localizedStringFromDate:jogo.data dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
        CompartilharJogos.hora =  [NSDateFormatter localizedStringFromDate:jogo.data dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
        
        if([jogo.golsMandante stringValue] == nil) {
            CompartilharJogos.jogo = [NSString stringWithFormat:@"Jogo do %@ vs. %@ %@ às %@", jogo.mandante.nome, jogo.visitante.nome, CompartilharJogos.data, CompartilharJogos.hora];
        } else {
            CompartilharJogos.jogo = [NSString stringWithFormat:@"%@ %@ x %@ %@", jogo.mandante.nome, jogo.golsMandante, jogo.golsVisitante, jogo.visitante.nome];
        }
        
    }];
    
    [tabela deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)SCMudou:(id)sender {
    lb_Rodada.text = @"";
    
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            arrayRodadas = arrayPrimeiroTurno;
            break;
            
        case 1:
            arrayRodadas = arraySegundoTurno;
            break;
            
        case 2:
            arrayRodadas = arrayFinais;
            break;
            
        default:
            break;
    }
    if (arrayPrimeiroTurno != nil) {
        
        if (isFirstTime) {
            
            isFirstTime = NO;
            
            NSDate *                date;
            NSString *              string, *timestamp;
            NSDateFormatter *       formatter;
            
            timestamp = @"00:00";
            
            formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateFormat: @"yyyy-MM-dd "];
            [formatter setTimeZone: [NSTimeZone localTimeZone]];
            
            string = [formatter stringFromDate: [NSDate date]];
            string = [string stringByAppendingString: timestamp];
            
            [formatter setDateFormat: @"yyyy-MM-dd HH:mm"];
            date = [formatter dateFromString: string];
            
            NSDate *dataAtual =  date;
            
            NSMutableArray *todasAsRodadas = [DAORodada fetchAllRodadasOrderedByDate].mutableCopy;
            
            Rodada *rodadaAnt = [todasAsRodadas objectAtIndex:0];
            
            for (int i =0; i < todasAsRodadas.count; i++) {
                
                
                
                Rodada *rodadaProxima;
                
                if (i == (todasAsRodadas.count-1)) {
                    rodadaProxima = [todasAsRodadas objectAtIndex:i];
                }
                else
                {
                    rodadaProxima = [todasAsRodadas objectAtIndex:i+1];
                }
                
                
                //                NSLog(@"Data atual :            %@", [NSDateFormatter localizedStringFromDate:dataAtual dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
                //                NSLog(@"RodadaAnt.dataFim  :    %@",[NSDateFormatter localizedStringFromDate:rodadaAnt.dataFim dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
                //                NSLog(@"RodadaProxima.dataFim : %@",[NSDateFormatter localizedStringFromDate:rodadaProxima.dataFim dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
                //                NSLog(@"Código Anterior: %@   -  Código Proxima: %@", rodadaAnt.codigo, rodadaProxima.codigo);
                
                if (([rodadaAnt.dataFim timeIntervalSince1970] ) < [dataAtual timeIntervalSince1970] ) {
                    if (([rodadaProxima.dataFim timeIntervalSince1970]) >= [dataAtual timeIntervalSince1970]) {
                        
                        if ([rodadaProxima.turno.descricao isEqualToString:[VariaveisGlobais const_PrimeiroTurno]]) {
                            arrayPrimeiroTurno = [VariaveisGlobais sortedJogosByName:arrayPrimeiroTurno campoId:@"dataInicio" campoId2:@"dataFim"];
                            for (int j =0; j< arrayPrimeiroTurno.count; j++) {
                                
                                
                                Rodada *myRodada;
                                myRodada = [arrayPrimeiroTurno objectAtIndex:j];
                            
                                
                                
                                if ([rodadaProxima.codigo intValue] == [ myRodada.codigo intValue] ) {
                                    nrRodadaPrimeiroTurno = j;
                                    [meuSC setSelectedSegmentIndex:0];
                                    [self SCMudou:self];
                                }
                            }
                            
                        }
                        else if ([rodadaProxima.turno.descricao isEqualToString:[VariaveisGlobais const_SegundoTurno]])
                        {
                            arraySegundoTurno = [VariaveisGlobais sortedJogosByName:arraySegundoTurno campoId:@"dataInicio" campoId2:@"dataFim"];
                            for (int j =0; j< arraySegundoTurno.count; j++) {
                                Rodada *myRodada;
                                myRodada = [arraySegundoTurno objectAtIndex:j];
//                                NSLog(@"myrodada %@", myRodada);
                                
//                                NSLog(@"cod rodada: %@  %@", rodadaProxima.codigo, myRodada.codigo);
                                if ([rodadaProxima.codigo intValue] == [ myRodada.codigo intValue]) {
                                    nrRodadaSegundoTurno = j;
                                    [meuSC setSelectedSegmentIndex:1];
                                    [self SCMudou:self];
                                }
                            }
                        }
                        else if ([rodadaProxima.turno.descricao isEqualToString:[VariaveisGlobais const_Final]])
                        {
                            arrayFinais = [VariaveisGlobais sortedJogosByName:arrayFinais campoId:@"dataInicio" campoId2:@"dataFim"];
                            for (int j =0; j< arrayFinais.count; j++) {
                                Rodada *myRodada;
                                myRodada = [arrayFinais objectAtIndex:j];
                                if ([rodadaProxima.codigo intValue] == [ myRodada.codigo intValue]) {
                                    nrRodadaFinal = j;
                                    [meuSC setSelectedSegmentIndex:2];
                                    [self SCMudou:self];
                                }
                            }
                        }
                    }
                }
                rodadaAnt = rodadaProxima;
            }
            
        }
        
    }
    
    
    arrayRodadas = [VariaveisGlobais sortedJogosByName:arrayRodadas campoId:@"dataInicio" campoId2:@"dataFim"];
    
    loadingView.hidden = YES;
    [tabela reloadData];
}

- (IBAction)RodadaAnterior:(id)sender {
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            nrRodadaPrimeiroTurno--;
            break;
            
        case 1:
            nrRodadaSegundoTurno--;
            break;
            
        case 2:
            nrRodadaFinal--;
            break;
            
        default:
            break;
    }
    
    if (nrRodadaPrimeiroTurno<0) {
        nrRodadaPrimeiroTurno=arrayPrimeiroTurno.count-1;
    }
    if (nrRodadaSegundoTurno<0) {
        nrRodadaSegundoTurno=arraySegundoTurno.count-1;
    }
    if (nrRodadaFinal<0) {
        nrRodadaFinal=arrayFinais.count-1;
    }
    
    [self SCMudou:self];
}

- (IBAction)ProximaRodada:(id)sender {
    switch (meuSC.selectedSegmentIndex) {
        case 0:
            nrRodadaPrimeiroTurno++;
            break;
            
        case 1:
            nrRodadaSegundoTurno++;
            break;
            
        case 2:
            nrRodadaFinal++;
            break;
            
        default:
            break;
    }
    
    if (nrRodadaPrimeiroTurno==arrayPrimeiroTurno.count) {
        nrRodadaPrimeiroTurno=0;
    }
    if (nrRodadaSegundoTurno==arraySegundoTurno.count) {
        nrRodadaSegundoTurno=0;
    }
    if (nrRodadaFinal==arrayFinais.count) {
        nrRodadaFinal=0;
    }
    
    [self SCMudou:self];
}
@end
