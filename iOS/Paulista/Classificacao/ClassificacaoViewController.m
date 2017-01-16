//
//  ClassificacaoViewController.m
//  Paulista
//
//  Created by Moacir Lamego on 28/01/13.
//  Copyright (c) 2012 Moacir E Lamego. All rights reserved.
//
#import "ClassificacaoViewController.h"
#import "Clube.h"

@interface ClassificacaoViewController ()

@end

@implementation ClassificacaoViewController

@synthesize classificacaoCallMethods, arrayClassificacao, tabela, scFases ;
@synthesize alturaTabela;



-(void)viewDidAppear:(BOOL)animated {
    
    alturaTabela = tabela.frame.size.height;
    
//    NSLog(@"altura dos demonios: %f", self.view.frame.size.height);
//    NSLog(@"%f", tabela.frame.size.height);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:loadingView];
    
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
    
    [self AtualizarListaEgo:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self AtualizarLista:self];
}


// ********************************* Inicio Ego *********************************************

//-------
- (IBAction)AtualizarListaEgo:(id)sender {
    loadingView.hidden = NO;
    
    [self AtualizarLista:self];
}

- (IBAction)AtualizarLista:(id)sender {
    [self SCMudou:self];
}
//--------


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
    [self AtualizarListaEgo:self];
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


-(void)piratiniObtidoComSucesso:(NSDictionary *)json
{
    loadingView.hidden = YES;
    [DAOPiratini parseAndInsertObjectsWithJson:json];
    
    arrayClassificacao = [[NSMutableArray alloc] init];
    
    for (Piratini * piratini in [DAOPiratini fetchAllPiratini]) {
        [arrayClassificacao addObject:piratini];
    }
    
    //    NSLog(@"Piratini:%@", arrayClassificacao);
    [tabela reloadData];
}

-(void)farroupilhaObtidoComSucesso:(NSDictionary *)json
{
    loadingView.hidden = YES;
    
    arrayClassificacao = [[NSMutableArray alloc] init];
    
    [DAOFarroupilha parseAndInsertObjectsWithJson:json];
    
    //   NSLog(@"qntd farrou: %i", [DAOFarroupilha fetchAllFarroupilha].count);
    
    for (Farroupilha *farroupilha in [DAOFarroupilha fetchAllFarroupilha]) {
        [arrayClassificacao addObject:farroupilha];
    }
    
    //    NSLog(@"Farroupilha:%@", arrayClassificacao);
    [tabela reloadData];
}


-(void)geralObtidoComSucesso:(NSDictionary *)json
{
    loadingView.hidden = YES;
    
    arrayClassificacao = [[NSMutableArray alloc] init];
    
    [DAOGeral parseAndInsertObjectsWithJson:json];
    
    for (Geral *geral in [DAOGeral fetchAllGeral]) {
        [arrayClassificacao addObject:geral];
    }
    
    //     NSLog(@"qntd gerla: %@", arrayClassificacao);
    
    [tabela reloadData];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    loadingView.hidden = YES;
    NSLog(@"Deu Problema %@", error);
}

#pragma mark - **************************** Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (scFases.selectedSegmentIndex == 2) {
    return 1;
    //    }
    //
    //    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (scFases.selectedSegmentIndex == 2) {
    //        return arrayClassificacao.count;
    //    } else if (section == 0) {
    return arrayClassificacao.count;
    //    } else {
    //        return arrayGrupoB.count;
    //    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        NSLog(@"count a: %i", arrayGrupoA.count);
//        return @"Grupo A";
//    } else {
//        NSLog(@"count b: %i", arrayGrupoB.count);
//        return @"Grupo B";
//    }
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 22, 320, 31)];
//    viewSection.backgroundColor = [UIColor colorWithRed:0.00 green:0.48 blue:0.14 alpha:0.85];
//    // Se voce quiser uma imagem na Sub-View Descomente o Código a Baixo.
//    //    UIImage* img = [UIImage imageNamed:@"nomedaimagem.png"];
//    //    UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
//    //    imgView.frame = CGRectMake(0, 22, 320, 31);
//    //    [viewSection addSubview:imgView];
//    // Até a linha a cima
//
//
//    UILabel* titulo = [[UILabel alloc] init];
//
//    titulo.frame = CGRectMake(0, 2, 320, 15);
//    titulo.backgroundColor = [UIColor clearColor];
//    titulo.font = [UIFont boldSystemFontOfSize:15];
//    titulo.textAlignment = 1;
//    titulo.adjustsFontSizeToFitWidth = YES;
//    titulo.textColor = [UIColor colorWithRed:188 green:149 blue:88 alpha:1.0];
//    [viewSection addSubview:titulo];
//
//
//    if (scFases.selectedSegmentIndex < 2) {
//        if (section == 0) {
//            titulo.text =  @"Grupo A";
//        } else {
//            titulo.text =  @"Grupo B";
//        }
//    } else {
//        titulo.text =  @"Classificação Geral";
//    }
//
//    return viewSection;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCelula = @"idCelulaClassificacaoPiratini";
    Classificacao_Celula *celula = [tableView dequeueReusableCellWithIdentifier:idCelula];
    
    if (celula == nil)
    {
        celula = [[Classificacao_Celula alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCelula];
    }
    
    if (indexPath.row %2) {
        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    } else {
        celula.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    }
    
    Piratini* piratini;
    Farroupilha* farroupilha;
    Geral* geral;
    
    if (scFases.selectedSegmentIndex < 2) {
        switch (scFases.selectedSegmentIndex) {
            case 0:
                if (indexPath.section == 0) {
                    piratini = [arrayClassificacao objectAtIndex:indexPath.row];
                    
                    [self setDadosCelulaWithCelula:celula andPiratini:piratini];
                } else if (indexPath.section == 1) {
                    piratini = [arrayClassificacao objectAtIndex:indexPath.row];
                    
                    [self setDadosCelulaWithCelula:celula andPiratini:piratini];
                } else if (indexPath.section == 2) {
                    
                }
                
            case 1:
                if (indexPath.section == 0) {
                    farroupilha = [arrayClassificacao objectAtIndex:indexPath.row];
                    
                    [self setDadosCelulaWithCelula:celula andFarroupilha:farroupilha];
                } else if (indexPath.section == 1) {
                    farroupilha = [arrayClassificacao objectAtIndex:indexPath.row];
                    
                    [self setDadosCelulaWithCelula:celula andFarroupilha:farroupilha];
                } else if (indexPath.section == 2) {
                    
                }
            default:
                break;
        }
    } else {
        geral = [arrayClassificacao objectAtIndex:indexPath.row];
        
        [self setDadosCelulaWithCelula:celula andGeral:geral];
    }
    
    return celula;
}

-(void)setDadosCelulaWithCelula:(Classificacao_Celula*)celula andPiratini:(Piratini*)piratini
{
    UIImage * img = [UIImage imageNamed:piratini.clube.escudo];
    celula.imgViewTime.image = img;
    celula.posicao.text = [NSString stringWithFormat:@"%@º",  [piratini.posicao stringValue]];
    celula.pontosGanhos.text = [piratini.pontosGanhos stringValue];
    celula.jogos.text = [piratini.jogos stringValue];
    celula.vitorias.text = [piratini.nrVitorias stringValue];
    celula.empates.text = [piratini.empates stringValue];
    celula.derrotas.text = [piratini.derrotas stringValue];
    celula.golsPro.text = [piratini.nrGolsMarcados stringValue];
    celula.golsContra.text = [piratini.nrGolsContra stringValue];
    celula.saldoGols.text = [piratini.saldoGols stringValue];
    celula.nmTime.text = piratini.clube.nome;
}

-(void)setDadosCelulaWithCelula:(Classificacao_Celula*)celula andFarroupilha:(Farroupilha*)farroupilha
{
    UIImage * img = [UIImage imageNamed:farroupilha.clube.escudo];
    celula.imgViewTime.image = img;
    celula.posicao.text = [NSString stringWithFormat:@"%@º",  [farroupilha.posicao stringValue]];
    celula.pontosGanhos.text = [farroupilha.pontosGanhos stringValue];
    celula.jogos.text = [farroupilha.jogos stringValue];
    celula.vitorias.text = [farroupilha.nrVitorias stringValue];
    celula.empates.text = [farroupilha.empates stringValue];
    celula.derrotas.text = [farroupilha.derrotas stringValue];
    celula.golsPro.text = [farroupilha.nrGolsMarcados stringValue];
    celula.golsContra.text = [farroupilha.nrGolsContra stringValue];
    celula.saldoGols.text = [farroupilha.saldoGols stringValue];
    celula.nmTime.text = farroupilha.clube.nome;
}

-(void)setDadosCelulaWithCelula:(Classificacao_Celula*)celula andGeral:(Geral*)geral
{
    UIImage * img = [UIImage imageNamed:geral.clube.escudo];
    celula.imgViewTime.image = img;
    celula.posicao.text = [NSString stringWithFormat:@"%@º",  [geral.posicao stringValue]];
    celula.pontosGanhos.text = [geral.pontosGanhos stringValue];
    celula.jogos.text = [geral.jogos stringValue];
    celula.vitorias.text = [geral.nrVitorias stringValue];
    celula.empates.text = [geral.empates stringValue];
    celula.derrotas.text = [geral.derrotas stringValue];
    celula.golsPro.text = [geral.nrGolsMarcados stringValue];
    celula.golsContra.text = [geral.nrGolsContra stringValue];
    celula.saldoGols.text = [geral.saldoGols stringValue];
    celula.nmTime.text = geral.clube.nome;
}


- (IBAction)SCMudou:(id)sender {
    loadingView.hidden = NO;
    
    switch (scFases.selectedSegmentIndex) {
        case 0:
            arrayClassificacao = [[NSMutableArray alloc] init];
            
            for (Piratini * piratini in [DAOPiratini fetchAllPiratini]) {
                [arrayClassificacao addObject:piratini];
            }
            
            classificacaoCallMethods = [[ClassificacaoCallMethods alloc] initWithDelegate:self];
            
            [classificacaoCallMethods getClassificacaoPiratini];
            
            break;
            
        case 1:
            arrayClassificacao = [[NSMutableArray alloc] init];
            
            for (Farroupilha *farroupilha in [DAOFarroupilha fetchAllFarroupilha]) {
                [arrayClassificacao addObject:farroupilha];
            }
            
            classificacaoCallMethods = [[ClassificacaoCallMethods alloc] initWithDelegate:self];
            [classificacaoCallMethods getClassificacaoFarroupilha];
            
            break;
            
        case 2:
            arrayClassificacao = [[NSMutableArray alloc] init];
            
            for (Geral *geral in [DAOGeral fetchAllGeral]) {
                [arrayClassificacao addObject:geral];
            }
            
            classificacaoCallMethods = [[ClassificacaoCallMethods alloc] initWithDelegate:self];
            [classificacaoCallMethods getClassificacaoGeral];
            break;
            
        default:
            break;
    }
    
    
    [tabela reloadData];
}


@end
