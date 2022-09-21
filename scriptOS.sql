-- Criacao do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- Criar tabela cliente
create table cliente(
				idCliente int auto_increment primary key,
                Nome VARCHAR(45),
                Identificacao VARCHAR(45),
                Endereco varchar(45),
                constraint unique_cliente_identificacao unique (Identificacao)
);
     desc client;           
-- Criar tabela produto
create table produto(
				idProduto int auto_increment primary key,
                Pnome varchar(10) not null,
                classificacao_kids bool default false,
				categoria varchar(45),
                descricao varchar(45),
                valor float not null
);

-- terminar e fazer a conexao com as tabelas necessárias, al;em disso reflita essa modificacao no diagrama relacional
-- Criar constraints relacionadas ao pagamento
create table pagamento(
	idCliente int,
	idPagamento int,
	formaPagamento enum('Boleto','Cartao','Dois cartoes'),
	limitAvailable float,
    primary key(idClient, idPagamento)
);

                

-- Criar tabela pedido
create table pedido(
    idPedido int auto_increment primary key,
    statusPedido enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    descricao varchar(45),
    frete float default 10,
    idCliente int not null,
    constraint fk_pedido_cliente foreign key(idCliente) references cliente(idCliente)
    );
    desc orders;
    
-- Criar tabela estoque
create table estoque(
	idEstoque int auto_increment primary key,
    idProduto int not null,
    local varchar(255),
    descricao varchar(255),
    quantidade int default 0,
    constraint fk_produto foreign key (idProduto) references produto(idProduto)
    );

create table entrega(
	idEntrega int auto_increment primary key,
    statusEntrega varchar(45) not null,
    rastreio varchar(45),
    previsaoEntrega DATE,
    idPedido int not null,
    constraint fk_pedido foreign key (idPedido) references pedido(idPedido)
);

-- Criar tabela fornecedor principal
create table fornecedor(
	idFornecedor int auto_increment primary key,
    razaoSocial varchar(255) not null,
    nomeFantasia varchar(255),
    CNPJ char(15),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_fornecedor unique(CNPJ)
    );
    
    -- Criar tabela vendedor terceiro
create table terceiro(
	idTerceiro int auto_increment primary key,
    razaoSocial varchar(255) not null,
    CNPJ char(15) not null,
    nomeFantasia varchar(255),
    contact char(11) not null,
    constraint unique_terceiro unique(CNPJ)
    );

create table pedidoProduto(
	idPedido int not null,
    idProduto int not null,
    quantidade int default 1,
    status enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
     CONSTRAINT fk_pedidoproduto_pedido FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
     CONSTRAINT fk_pedidoproduto_produto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

create table produtoFornecedor(
	idFornecedor int,
    idProduct int,
    quantidade int not null,
    primary key (idFornecedor,idProduto),
    constraint fk_produto_fornecedor_fornecedor foreign key(idFornecedor) references fornecedor(idFornecedor),
	constraint fk_produto_fornecedor_produto foreign key(idProduto) references produto(idProduto)
);

create table produtoTerceiro(
	idTerceiro int,
    idProduct int,
    quantidade int not null,
    primary key (idTerceiro,idProduto),
    constraint fk_produto_terceiro_terceiro foreign key (idTerceiro) references terceiro (idTerceiro),
    constraint fk_product_terceiro_produto foreign key (idPproduto) references produto (idProduto)
);