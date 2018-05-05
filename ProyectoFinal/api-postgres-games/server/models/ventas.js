module.exports = (sequelize, DataTypes) => {
  const Ventas = sequelize.define('Ventas', {        
    idusuario: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    cliente: {
      type: DataTypes.STRING,      
    },
    totalventa: {
      type: DataTypes.FLOAT,      
    },
  });

  Ventas.associate = (models) => {
    Ventas.hasMany(models.DetalleVentas, {
      foreignKey: 'idventas',
      as: 'idventas',
    });
  };

  return Ventas;
};