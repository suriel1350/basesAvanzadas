module.exports = {
  up: (queryInterface, Sequelize) =>
    queryInterface.createTable('Ventas', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      idusuario: { //mongo
        type: Sequelize.STRING,
        allowNull: false,
      },
      cliente: { 
        type: Sequelize.STRING,        
      },
      totalventa: {
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
    }),
  down: (queryInterface /* , Sequelize */) =>
    queryInterface.dropTable('Ventas'),
};