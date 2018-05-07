export class Cart{
	constructor(
		public _id: string,
		public nombre: string,
		public descripcion: string,
		public cantidad: number,
		public precio: number,
		public subtotal: number,
		public imagen: string,
		public userId: string
	){}
}