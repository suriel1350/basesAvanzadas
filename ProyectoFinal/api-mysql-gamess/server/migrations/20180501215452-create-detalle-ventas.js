module.exports = {
  up: (queryInterface, Sequelize) =>
    queryInterface.createTable('DetalleVentas', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      cantidad: {
        type: Sequelize.INTEGER,
      },
      precioventa: {
        type: Sequelize.FLOAT,
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },      
      idventas: {
        type: Sequelize.INTEGER,
        onDelete: 'CASCADE',
        references: {
          model: 'Ventas',
          key: 'id',
          as: 'idventas',
        },
      },
      idconsolas: {
        type: Sequelize.INTEGER,
        onDelete: 'CASCADE',
        references: {
          model: 'Consolas',
          key: 'id',
          as: 'idconsolas',
        },
      },      
    }),
  down: (queryInterface /* , Sequelize */) =>
    queryInterface.dropTable('DetalleVentas'),
};