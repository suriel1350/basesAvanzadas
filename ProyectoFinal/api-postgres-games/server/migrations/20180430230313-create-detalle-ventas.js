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
      idvideojuegos: {
        type: Sequelize.INTEGER,
        onDelete: 'CASCADE',
        references: {
          model: 'Videojuegos',
          key: 'id',
          as: 'idvideojuegos',
        },
      },
      idaccesorios: {
        type: Sequelize.INTEGER,
        onDelete: 'CASCADE',
        references: {
          model: 'Accesorios',
          key: 'id',
          as: 'idaccesorios',
        },
      },
    }),
  down: (queryInterface /* , Sequelize */) =>
    queryInterface.dropTable('DetalleVentas'),
};