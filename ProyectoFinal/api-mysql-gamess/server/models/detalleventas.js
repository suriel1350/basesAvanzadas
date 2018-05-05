module.exports = (sequelize, DataTypes) => {
  const DetalleVentas = sequelize.define('DetalleVentas', {
    cantidad: {
      type: DataTypes.INTEGER,      
    },
    precioventa: {
      type: DataTypes.FLOAT,      
    },
  });

  DetalleVentas.associate = (models) => {
    DetalleVentas.belongsTo(models.Consolas, {
      foreignKey: 'idconsolas',
      onDelete: 'CASCADE',
    });    

    DetalleVentas.belongsTo(models.Ventas, {
      foreignKey: 'idventas',
      onDelete: 'CASCADE',
    });    
  };

  return DetalleVentas;
};