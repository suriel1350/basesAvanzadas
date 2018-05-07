export class Videojuego{
	constructor(
		public id: string,
		public nombre: string,
		public descripcion: string,
		public stock: number,
		public precio: number,
		public imagen: string
	){}
}