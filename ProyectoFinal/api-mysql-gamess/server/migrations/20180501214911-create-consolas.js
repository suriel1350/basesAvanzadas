module.exports = {
  up: (queryInterface, Sequelize) =>
    queryInterface.createTable('Consolas', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      nombre: {
        type: Sequelize.STRING,
        allowNull: false,
      },
      descripcion: {
        type: Sequelize.TEXT,
      },
      stock: {
        type: Sequelize.INTEGER,
      },
      precio: {
        type: Sequelize.FLOAT,
      },
      imagen: {
        type: Sequelize.STRING,        
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
  down: (queryInterface /* , Sequelize */) => queryInterface.dropTable('Consolas'),
};