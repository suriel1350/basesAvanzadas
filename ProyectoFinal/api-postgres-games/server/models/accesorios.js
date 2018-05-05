module.exports = (sequelize, DataTypes) => {
  const Accesorios = sequelize.define('Accesorios', {    
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

  Accesorios.associate = (models) => {
    Accesorios.hasMany(models.DetalleVentas, {
      foreignKey: 'idaccesorios',
      as: 'idaccesorios',
    });
  };

  return Accesorios;
};