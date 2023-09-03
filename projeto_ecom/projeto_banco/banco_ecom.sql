-- criação do banco de dados para o cenário E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    fName VARCHAR(10),
    mInit CHAR(3),
    lName VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    adress VARCHAR(15),
    houseNumber INT,
    district VARCHAR(15),
    city VARCHAR(10),
    state VARCHAR(2),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
    );

-- criar tabela produto
-- size = dimensão do produto
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(10),
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos,', 'Alimentos', 'Móveis') NOT NULL,
    avaliação FLOAT DEFAULT 0,
    size VARCHAR(10)
    );

-- criar tabela pedido
CREATE TABLE request(
	idRequest INT AUTO_INCREMENT PRIMARY KEY,
    idRequestClient INT,
    requestStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
	requestDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_request_client FOREIGN KEY(idRequestClient) REFERENCES clients(idClient)
				ON UPDATE CASCADE
    );
    
-- criar tabela pagamentos
-- para ser continuado no desafio: termine de implementar a tablea e crie a conhexão com as tabelas necessárias
-- além disso, reflita essa modificação no esquema relacional
-- criar constraints relacionadas ao pagamento
CREATE TABLE payments(
	idPClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Pix'),
    limitAvaible FLOAT,
    PRIMARY KEY(idPClient, idPayment),
    CONSTRAINT fk_payment_client FOREIGN KEY(idPClient) REFERENCES clients(idClient),
    CONSTRAINT fk_payment_resquest FOREIGN KEY(idPayment) REFERENCES request(idRequest)
);
    
-- criar tabela estoque
CREATE TABLE productsStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
	storageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

-- cria tabela fornecedor 
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact VARCHAR(11) DEFAULT 0,
    CONSTRAINT unique_suplier UNIQUE(CNPJ)
);


-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CNPJ CHAR(15) NOT NULL,
    CPF CHAR(9),
    sellerLocation VARCHAR(255),
    contact VARCHAR(11) DEFAULT 0,
    CONSTRAINT unique_scnpj_seller UNIQUE(CNPJ),
    CONSTRAINT unique_scpf_seller UNIQUE(CPF)
);


CREATE TABLE productSeller (
	idPSeller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY(idPSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_seller_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

CREATE TABLE productSupplier (
	idPSupplier INT,
    idProduct INT,
    quantity INT,
    PRIMARY KEY (idPSupplier, idProduct),
    CONSTRAINT fk_product_supplier FOREIGN KEY(idPSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

CREATE TABLE productRequest (
	idPRproduct INT,
    idPResquest INT,
    prQuantity INT DEFAULT 0,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPRproduct, idPResquest),
    CONSTRAINT fk_product_request FOREIGN KEY (idPRproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_request_product FOREIGN KEY (idPResquest) REFERENCES request(idRequest)
);


CREATE TABLE locationStorage (
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_product_storage FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_locationStorage_product FOREIGN KEY (idLstorage) REFERENCES productsStorage(idProdStorage)
);




