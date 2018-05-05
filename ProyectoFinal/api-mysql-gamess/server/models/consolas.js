module.exports = (sequelize, DataTypes) => {
  const Consolas = sequelize.define('Consolas', {
    nombre: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    descripcion: {
      type: DataTypes.TEXT,      
    },
    stock: {
      type: DataTypes.INTEGER,      
    },
    precio: {
      type: DataTypes.FLOAT,      
    },
    imagen: {
      type: DataTypes.STRING,      
    },
  });

  Consolas.associate = (models) => {
    Consolas.hasMany(models.DetalleVentas, {
      foreignKey: 'idconsolas',
      as: 'idconsolas',
    });
  };

  return Consolas;
};