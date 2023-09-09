-- criação do banco de dados para o cenário E-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela pessoa física
CREATE TABLE naturalPerson
(
	idNaturalPerson INT AUTO_INCREMENT PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    fName CHAR(10) NOT NULL,
    mName CHAR(15),
    lName CHAR(15) NOT NULL,
    birthDay DATE NOT NULL
);

-- criar a tabela pessoa jurídica
CREATE TABLE legalPerson
(
	idLegalPerson INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ CHAR(15) NOT NULL UNIQUE,
    corporateName VARCHAR(255)
);

-- criar tabela usuário
CREATE TABLE users
(
	idUser INT AUTO_INCREMENT PRIMARY KEY,
    idUserNaturalPerson INT,
    idUserLegalPerson INT,
    email VARCHAR(20) NOT NULL UNIQUE,
    userName VARCHAR(20) NOT NULL UNIQUE,
    userPassword VARCHAR(10) NOT NULL,
    registrationDate DATETIME NOT NULL,
    userType ENUM('Cliente', 'Fornecedor', 'Vendedor') NOT NULL,
    personType ENUM('Pessoa Juridica', 'Pessoa Física'),
    CONSTRAINT fk_user_naturalPerson FOREIGN KEY(idUserNaturalPerson) REFERENCES naturalPerson(idNaturalPerson),
    CONSTRAINT fk_user_legalPerson FOREIGN KEY(idUserLegalPerson) REFERENCES legalPerson(idLegalPerson)
	ON UPDATE CASCADE
);

-- criar tabela endereços
CREATE TABLE adress
(
	idAdress INT AUTO_INCREMENT PRIMARY KEY,
    idAdressUser INT,
    publicPlace ENUM('Alameda', 'Avenida', 'Condomínio', 'Conjunto', 'Distrito', 'Estrada', 'Ladeira', 'Rua', 'Travessa', 'Vila', 'Outro') NOT NULL,
    location VARCHAR(30) NOT NULL,
    numberLocation CHAR(5) DEFAULT 'S/N',
    adressComplement VARCHAR(20),
    district VARCHAR(20) NOT NULL,
    city VARCHAR(15) NOT NULL,
    CONSTRAINT fk_adress_user FOREIGN KEY(idAdressUser) REFERENCES users(idUser)
    ON UPDATE CASCADE
);

-- criar tabela cliente
CREATE TABLE clients
(
	idClient INT AUTO_INCREMENT PRIMARY KEY
);
-- criar tabela fornecedor
CREATE TABLE supplier
(
	idClient INT AUTO_INCREMENT PRIMARY KEY
);
-- criar tabela vendedor
CREATE TABLE seller
(
	idSeller INT AUTO_INCREMENT PRIMARY KEY
);
-- criar tabela produto
CREATE TABLE product 
(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(45) NOT NULL,
    kidsProduct BOOL DEFAULT FALSE,
    category ENUM('Móveis', 'Eletrodomesticos', 'Eletrônico', 'Roupas', 'Alimentos') NOT NULL,
    rating FLOAT(5) DEFAULT 0,
    size VARCHAR(10)
);
-- criar tabela tipo de pagamento
CREATE TABLE payment 
(
	idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idPixPayment INT,
    idCardPayment INT,
    idSlipPayment INT,
    paymentData DATETIME NOT NULL,
    paymentType ENUM('PIX', 'Cartão', 'Boleto'),
    CONSTRAINT fk_pix_payment FOREIGN KEY(idPixPayment) REFERENCES pixPayment(idPix),
    CONSTRAINT fk_card_payment FOREIGN KEY(idCardPayment) REFERENCES cardPayment(idCard),
    CONSTRAINT fk_slip_payment FOREIGN KEY(idSlipPayment) REFERENCES slipPayment(idSlip)
    ON UPDATE CASCADE
);
-- criar tabela PIX
CREATE TABLE pixPayment 
(
	idPix INT AUTO_INCREMENT PRIMARY KEY,
    pixCod VARCHAR(32) NOT NULL UNIQUE,
    validity DATE NOT NULL
);
-- criar tabela cartão
CREATE TABLE cardPayment 
(
	idCard INT AUTO_INCREMENT PRIMARY KEY,
    paymentNumber INT(16) NOT NULL,
    nameCard CHAR(15) NOT NULL,
    expirationDateCard DATE NOT NULL,
    cvv INT(3) NOT NULL
);
-- criar tabela boleto
CREATE TABLE slipPayment 
(
	idSlip INT AUTO_INCREMENT PRIMARY KEY,
    slipNumber INT(48) NOT NULL,
    expirationDateSlip DATE NOT NULL
);
-- criar tabela pedido
CREATE TABLE request 
(
	idRequest INT AUTO_INCREMENT PRIMARY KEY,
    idRequestClient INT,
    idRequestPayment INT,
    requestStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL,
    requestDescription VARCHAR(255),
    orderShipping FLOAT DEFAULT 10,
    requestPayment BOOL DEFAULT FALSE,
    CONSTRAINT fk_request_client FOREIGN KEY(idRequestClient) REFERENCES clients(idClient),
    CONSTRAINT fk_request_payment FOREIGN KEY(idRequestPayment) REFERENCES payment(idPayment)
    ON UPDATE CASCADE
);
-- criar table estoque
CREATE TABLE storages 
(
	idStorage INT AUTO_INCREMENT PRIMARY KEY,
    idStorageAdress INT,
    quantity INT NOT NULL,
	CONSTRAINT fk_storage_adress FOREIGN KEY(idStorageAdress) REFERENCES adress(idAdress)
);
-- criar tabela vendedor/produto
CREATE TABLE sellerProduct 
(
	idSellerProduct INT,
    idProductSeller INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idSellerProduct, idProductSeller),
    CONSTRAINT fk_product_seller FOREIGN KEY(idSellerProduct) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_seller_product FOREIGN KEY (idProductSeller) REFERENCES product(idProduct)
);
-- criar tabela fornecedor/produto
CREATE TABLE supplierProduct 
(
	idProductSupplier INT,
    idSuplierProduct INT,
    quantity INT,
    PRIMARY KEY (idProductSupplier, idSupllierProduct),
    CONSTRAINT fk_product_supplier FOREIGN KEY(idProductSupplier) REFERENCES supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idSupplierProduct) REFERENCES product(idProduct)
);
-- criar tabela pedido/produto
CREATE TABLE requestProduct 
(
	idRequestProduct INT,
    idProductRequest INT,
    prQuantity INT DEFAULT 0,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idRequestProduct, idProductRequest),
    CONSTRAINT fk_product_request FOREIGN KEY (idRequestProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_request_product FOREIGN KEY (idProductRequest) REFERENCES request(idRequest)
);
-- criar tabela estoque/produto
CREATE TABLE storageProduct 
(
	idStorageProduct INT,
    idProductStorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idStorageProduct, idProductStorage),
    CONSTRAINT fk_product_storage FOREIGN KEY (idStorageProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_locationStorage_product FOREIGN KEY (idProductStorage) REFERENCES storages(idStorage)
);

