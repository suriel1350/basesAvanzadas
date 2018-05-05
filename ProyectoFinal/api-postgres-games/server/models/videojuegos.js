module.exports = (sequelize, DataTypes) => {
  const Videojuegos = sequelize.define('Videojuegos', {    
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

  Videojuegos.associate = (models) => {
    Videojuegos.hasMany(models.DetalleVentas, {
      foreignKey: 'idvideojuegos',
      as: 'idvideojuegos',
    });
  };

  return Videojuegos;
};