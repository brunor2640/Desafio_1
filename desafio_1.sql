CREATE DATABASE desafio_1;

USE desafio_1;

-- Informações dos itens do menu.
CREATE TABLE MenuItems (
    menuItemId BIGINT PRIMARY KEY, -- Identificador único do item do menu
    miNum INT, -- Número do item do menu
    modFlag BOOLEAN, -- Indicador se o item é uma modificação
    inclTax DECIMAL(10, 2), -- Taxa incluída no preço
    activeTaxes VARCHAR(255), -- Impostos ativos
    prcLvl INT -- Nível de preço
);

--  informações gerais dos pedidos.
CREATE TABLE GuestChecks ( 
	guestCheckId BIGINT PRIMARY KEY, -- Identificador único do pedido 
    chkNum INT, -- Número do cheque 
    opnBusDt DATE, -- Data de abertura do pedido  
    opnUTC DATETIME, -- Hora de abertura em UTC  
    opnLcl DATETIME, -- Hora de abertura local 
    clsdBusDt DATE, -- Data de fechamento do pedido 
    clsdUTC DATETIME, -- Hora de fechamento em UTC 
    clsdLcl DATETIME, -- Hora de fechamento local 
    lastTransUTC DATETIME, -- Hora da última transação em UTC  
    lastTransLcl DATETIME, -- Hora da última transação local 
    lastUpdatedUTC DATETIME, -- Hora da última atualização em UTC 
    lastUpdatedLcl DATETIME, -- Hora da última atualização local 
    clsdFlag BOOLEAN, -- Indicador de pedido fechado  
    gstCnt INT, -- Contagem de convidados 
    subTtl DECIMAL(10, 2), -- Subtotal 
    nonTxblSlsTtl DECIMAL(10, 2), -- Total de vendas não tributáveis 
    chkTtl DECIMAL(10, 2), -- Total do cheque  
    dscTtl DECIMAL(10, 2), -- Total de descontos 
    payTtl DECIMAL(10, 2), -- Total pago 
    balDueTtl DECIMAL(10, 2), -- Saldo devido 
    rvcNum INT, -- Número do serviço  
    otNum INT, -- Número do terminal de operação 
    ocNum INT, -- Número do terminal de caixa 
    tblNum INT, -- Número da mesa 
    tblName VARCHAR(50), -- Nome da mesa 
    empNum INT, -- Número do empregado 
	numSrvcRd INT, -- Número de rodadas de serviço 
    numChkPrntd INT -- Número de cheques impressos 
);
--  Informações detalhadas sobre cada linha de pedido,
CREATE TABLE DetailLines ( 
	guestCheckLineItemId BIGINT PRIMARY KEY, -- Identificador único da linha do pedido 
    guestCheckId BIGINT, -- Referência ao pedido (GuestChecks) 
    rvcNum INT, -- Número do serviço 
    dtlOtNum INT, -- Número do terminal de operação 
    dtlOcNum INT, -- Número do terminal de caixa 
    lineNum INT, -- Número da linha do pedido 
    dtlId INT, -- Identificador do detalhe da linha 
    detailUTC DATETIME, -- Hora do detalhe em UTC 
    detailLcl DATETIME, -- Hora do detalhe local 
    lastUpdateUTC DATETIME, -- Última atualização em UTC 
    lastUpdateLcl DATETIME, -- Última atualização local 
    busDt DATE, -- Data do negócio 
    wsNum INT, -- Número do terminal de ponto de venda 
    dspTtl DECIMAL(10, 2), -- Total exibido 
    dspQty INT, -- Quantidade exibida 
    aggTtl DECIMAL(10, 2), -- Total agregado
    aggQty INT, -- Quantidade agregada 
    chkEmpId BIGINT, -- Referência ao empregado relacionado ao cheque 
    chkEmpNum INT, -- Número do empregado relacionado ao cheque 
    svcRndNum INT, -- Número da rodada de serviço 
    seatNum INT, -- Número do assento 
    menuItemId BIGINT, -- Referência ao item do menu (MenuItems) 
    discountId INT, -- Referência ao desconto (Discounts) 
    serviceChargeId INT, -- Referência à cobrança de serviço (ServiceCharges) 
    tenderMediaId INT, -- Referência ao meio de pagamento (TenderMedia) 
    errorCodeId INT, -- Referência ao código de erro (ErrorCodes) 
    FOREIGN KEY (guestCheckId) REFERENCES GuestChecks(guestCheckId),
    FOREIGN KEY (menuItemId) REFERENCES MenuItems(menuItemId)
);

-- Informações sobre descontos aplicados.
CREATE TABLE Discounts ( 
	discountId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único do desconto 
    guestCheckLineItemId BIGINT, -- Referência à linha do pedido (DetailLines) 
    description VARCHAR(255), -- Descrição do desconto 
    amount DECIMAL(10, 2), -- Quantia do desconto 
    FOREIGN KEY (guestCheckLineItemId) REFERENCES DetailLines(guestCheckLineItemId) 
);

-- Detalha as cobranças de serviço.
CREATE TABLE ServiceCharges (
	serviceChargeId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único da cobrança de serviço 
	guestCheckLineItemId BIGINT, -- Referência à linha do pedido (DetailLines) 
    description VARCHAR(255), -- Descrição da cobrança de serviço  
    amount DECIMAL(10, 2), -- Quantia da cobrança de serviço 
    FOREIGN KEY (guestCheckLineItemId) REFERENCES DetailLines(guestCheckLineItemId)
);

-- Informações sobre os meios de pagamento.
CREATE TABLE TenderMedia ( 
	tenderMediaId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único do meio de pagamento 
    guestCheckLineItemId BIGINT, -- Referência à linha do pedido (DetailLines) 
    description VARCHAR(255), -- Descrição do meio de pagamento 
    amount DECIMAL(10, 2), -- Quantia do meio de pagamento 
    FOREIGN KEY (guestCheckLineItemId) REFERENCES DetailLines(guestCheckLineItemId)
);

-- Códigos de erro associados aos pedidos.
CREATE TABLE ErrorCodes (
	errorCodeId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único do código de erro 
    guestCheckLineItemId BIGINT, -- Referência à linha do pedido (DetailLines) 
    description VARCHAR(255), -- Descrição do código de erro 
    FOREIGN KEY (guestCheckLineItemId) REFERENCES DetailLines(guestCheckLineItemId) 
);

/* Escolhi a esturura do banco de dados relacional para garantir a integridade,
organização e escalabilidade dos dados As chaves primárias e estrangeiras
 são utilizadas para manter a consistência dos dados, 
e a ordem de criação das tabelas é planejada para evitar erros de referência. */

