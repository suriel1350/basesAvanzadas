export class Venta{
	constructor(
		public id: string,
		public idmongo: string,
		public cliente: string,
		public totalventa: number,
		public fechaventa: string,
		public categoria: string		
	){}
}
