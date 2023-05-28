# 1.1
# Crie as tabelas para suportar as vendas e o sabor dos gelados.
# A criação deverá ser efetuada através de código SQL
#================================================================
# CRIAÇÃO DAS TABELAS/ALTERAÇÃO: sabor, gelado e vendas
# (TABELAS cliente e vendedor com dados padrão)
#================================================================
DROP TABLE IF EXISTS `gelados`.`sabor` ;
CREATE TABLE IF NOT EXISTS `gelados`.`sabor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `preco` DOUBLE NOT NULL,
  PRIMARY KEY (`id`));

DROP TABLE IF EXISTS `gelados`.`gelado` ;
CREATE TABLE IF NOT EXISTS `gelados`.`gelado` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sabor` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX (`sabor` ASC),
  CONSTRAINT `g1`
    FOREIGN KEY (`sabor`)
    REFERENCES `gelados`.`sabor` (`id`));
  
DROP TABLE IF EXISTS `gelados`.`venda` ;
CREATE TABLE IF NOT EXISTS `gelados`.`venda` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `cliente_codigo` INT NOT NULL,
  `vendedor_nipc` INT NOT NULL,
  `gelado_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX (`cliente_codigo` ASC),
  INDEX (`vendedor_nipc` ASC),
  INDEX (`gelado_codigo` ASC),
  CONSTRAINT `v1`
    FOREIGN KEY (`cliente_codigo`)
    REFERENCES `gelados`.`cliente` (`codigo`),
  CONSTRAINT `v2`
    FOREIGN KEY (`vendedor_nipc`)
    REFERENCES `gelados`.`vendedor` (`nipc`),
  CONSTRAINT `v3`
    FOREIGN KEY (`gelado_codigo`)
    REFERENCES `gelados`.`gelado` (`codigo`));

# 2.1.
# Crie um utilizador com o identificador “manutenção” e a senha “321”.
# Este utilizador apenas poderá consultar os gelados quando estiver a 
# aceder a partir de endereços externos e
# consultar todas as tabelas quando aceder a partir de endereços internos à máquina
CREATE USER 'manutencao'@'%' IDENTIFIED BY '321';
CREATE USER 'manutencao'@'localhost' IDENTIFIED BY '321';
GRANT SELECT ON gelados.gelado TO 'manutencao'@'%';
GRANT SELECT ON gelados.* TO 'manutencao'@'localhost';

# 2.2
# Crie outro utilizador com o identificador “gestor_dados”
# que terá permissões para inserir, eliminar e alterar dados,
# quer a partir de endereços internos, quer a partir de endereços externos.
CREATE USER 'gestor_dados'@'%' IDENTIFIED BY '123';
CREATE USER 'gestor_dados'@'localhost' IDENTIFIED BY '123';
GRANT INSERT, UPDATE, DELETE ON gelados.* TO 'gestor_dados'@'%';
GRANT INSERT, UPDATE, DELETE ON gelados.* TO 'gestor_dados'@'localhost';

# 3.1
# Crie uma view o top 10 dos melhores clientes;
CREATE VIEW top10_clientes_view AS
	SELECT C.codigo, C.nome, SUM(S.preco) AS valor_gasto
    FROM cliente C
    INNER JOIN venda V ON C.codigo = V.cliente_codigo
    INNER JOIN gelado G ON V.gelado_codigo = G.codigo
    INNER JOIN sabor S ON G.sabor = S.id
    GROUP BY C.codigo
    ORDER BY valor_gasto DESC
    LIMIT 10;

# 3.2
# Crie uma view com as compras dos dias 15 de cada mês.
CREATE VIEW compras_dia15_view AS
	SELECT venda.codigo, venda.data_hora
    FROM venda
    WHERE day(data_hora) = 15;

# Com o utilizador indicado realize as seguintes tarefas:
#================================================================
# INSERÇÃO DE DADOS (TABELAS cliente e vendedor com dados padrão)
# DADOS ALTERADOS DAS TABELAS sabor E gelado:
INSERT INTO `gelados`.`sabor` (`id`, `descricao`, `preco`) VALUES (1, 'Morango', 1.80);
INSERT INTO `gelados`.`sabor` (`id`, `descricao`, `preco`) VALUES (2, 'Chocolate', 2);

INSERT INTO `gelados`.`gelado` (`codigo`, `nome`, `sabor`) VALUES (1, 'Cone do céu', 1);
INSERT INTO `gelados`.`gelado` (`codigo`, `nome`, `sabor`) VALUES (2, 'Delicia ao Vento', 2);
INSERT INTO `gelados`.`gelado` (`codigo`, `nome`, `sabor`) VALUES (3, 'Toocida sem fim', 1);
#================================================================

# 4.1
# Inserir um novo cliente;
INSERT INTO `gelados`.`cliente` (`codigo`, `nif`, `nome`, `morada`) VALUES (4, 42342342, 'Lara', 'Rua das Flores');

# 4.2
# Insira três vendas;
INSERT INTO `gelados`.`venda` (`codigo`, `data_hora`, `cliente_codigo`, `vendedor_nipc`, `gelado_codigo`) 
	VALUES (1, '2020-12-15 14:15:30', 1, 2, 1),
		   (2, '2020-11-15 14:15:30', 2, 1, 3),
           (3, '2020-10-15 14:15:30', 3, 3, 2);

# 4.3
# Aumente os preços em 8%.
UPDATE sabor
SET preco = preco + (preco * 0.08)
WHERE id > 0;

# 4.4
# Apague o primeiro cliente.
DELETE
FROM venda
WHERE cliente_codigo = 1;
DELETE
FROM cliente
WHERE codigo = 1;
